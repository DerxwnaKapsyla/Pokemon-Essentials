alias cs_setBattleRule setBattleRule
def setBattleRule(*args)
  r = nil
  extra_args = []
  args.each do |arg|
    if r
      $game_temp.add_battle_rule(r, arg)
      r = nil
    else
      case arg.downcase
      when "setpkmnprefix", "setswapouttext", "setswitchtext", "setswitchintext", "setvictorytext", "setfaintedtext"
        r = arg
        next
      else
        extra_args.push(arg)
        next
      end
    end
  end
  raise _INTL("Argument {1} expected a variable after it but didn't have one.", r) if r
  if extra_args.length > 0
    cs_setBattleRule(*extra_args)
  end
end

class Game_Temp
  alias cs_add_battle_rule add_battle_rule
  def add_battle_rule(rule, var = nil)
    rules = self.battle_rules
    case rule.to_s.downcase
    when "setpkmnprefix"      then rules["prefixText"]    = var
    when "setswapouttext"     then rules["swapOutText"]   = var
    when "setswitchtext"      then rules["switchText"]    = var
    when "setswitchintext"    then rules["switchInText"]  = var
    when "setvictorytext"     then rules["victoryText"]   = var
    when "setfaintedtext"        then rules["faintedText"]   = var
    else
      cs_add_battle_rule(rule, var)
    end
  end
end

class Battle::Battler
  alias cs_pbThis pbThis
  def pbThis(lowerCase = false)
    if opposes? && wild? && @battle.prefixtext
      custom_prefix = @battle.prefixtext
      if custom_prefix.is_a?(Array)
        prefix = lowerCase ? custom_prefix[0] : custom_prefix[1]
      else
        prefix = custom_prefix
      end
      return _INTL("{1} {2}", prefix, name)
    end
    return cs_pbThis(lowerCase)
  end
  
  alias cs_pbFaint pbFaint
  def pbFaint(showMessage = true)
    if !fainted?
      PBDebug.log("!!!***Can't faint with HP greater than 0")
      return
    end
    return if @fainted   # Has already fainted properly
    if @battle.faintedtext # Make further edits to this so it can distinguish between player-side and enemy
      fainted_text = @battle.faintedtext
    else
      fainted_text = "{1} fainted!"
    end
    @battle.pbDisplayBrief(_INTL(fainted_text, pbThis)) if showMessage
    PBDebug.log("[Pokémon fainted] #{pbThis} (#{@index})") if !showMessage
    @battle.scene.pbFaintBattler(self)
    @battle.pbSetDefeated(self) if opposes?
    pbInitEffects(false)
    # Reset status
    self.status      = :NONE
    self.statusCount = 0
    # Lose happiness
    if @pokemon && @battle.internalBattle
      badLoss = @battle.allOtherSideBattlers(@index).any? { |b| b.level >= self.level + 30 }
      @pokemon.changeHappiness((badLoss) ? "faintbad" : "faint")
    end
    # Reset form
    @battle.peer.pbOnLeavingBattle(@battle, @pokemon, @battle.usedInBattle[idxOwnSide][@index / 2])
    @pokemon.makeUnmega if mega?
    @pokemon.makeUnprimal if primal?
    # Do other things
    @battle.pbClearChoice(@index)   # Reset choice
    pbOwnSide.effects[PBEffects::LastRoundFainted] = @battle.turnCount
    if $game_temp.party_direct_damage_taken &&
       $game_temp.party_direct_damage_taken[@pokemonIndex] &&
       pbOwnedByPlayer?
      $game_temp.party_direct_damage_taken[@pokemonIndex] = 0
    end
    # Check other battlers' abilities that trigger upon a battler fainting
    pbAbilitiesOnFainting
    # Check for end of primordial weather
    @battle.pbEndPrimordialWeather
  end
  
end

module BattleCreationHelperMethods
  module_function
  
  BattleCreationHelperMethods.singleton_class.alias_method :cs_prepare_battle, :prepare_battle
  def prepare_battle(battle)
    return BattleCreationHelperMethods.cs_prepare_battle(battle) if pbInSafari?
    battleRules = $game_temp.battle_rules
    battle.prefixtext         = battleRules["prefixText"]    if !battleRules["prefixText"].nil?
    battle.swapouttext        = battleRules["swapOutText"]   if !battleRules["swapOutText"].nil?
    battle.switchtext         = battleRules["switchText"]    if !battleRules["switchText"].nil?
    battle.switchintext       = battleRules["switchInText"]  if !battleRules["switchInText"].nil?
    battle.victorytext        = battleRules["victoryText"]   if !battleRules["victoryText"].nil?
    battle.faintedtext        = battleRules["faintedText"]   if !battleRules["faintedText"].nil?
    BattleCreationHelperMethods.cs_prepare_battle(battle)
  end
end

class Battle
  attr_accessor :prefixtext, :swapouttext, :switchtext, :switchintext, :victorytext, :faintedtext
  
  alias cs_initialize initialize
  def initialize(*args)
    cs_initialize(*args)
    @prefixtext      = nil
    @swapouttext     = nil
    @switchtext      = nil
    @switchintext    = nil
    @victorytext     = nil
    @faintedtext     = nil
  end
  
  alias cs_pbThisEx pbThisEx
  def pbThisEx(idxBattler, idxParty)
    party = pbParty(idxBattler)
    if @prefixtext && opposes?(idxBattler) && !trainerBattle?
      if @prefixtext.is_a?(Array)
        prefix = @prefixtext[1]  # Always use uppercase for pbThisEx
      else
        prefix = @prefixtext
      end
      return _INTL("{1} {2}", prefix, party[idxParty].name)
    end
    return cs_pbThisEx(idxBattler, idxParty)
  end

  alias cs_pbEORSwitch pbEORSwitch
  def pbEORSwitch(favorDraws = false)
    return if @decision > 0 && !favorDraws
    return if @decision == 5 && favorDraws
    pbJudge
    return if @decision > 0
    # Check through each fainted battler to see if that spot can be filled.
    switched = []
    loop do
      switched.clear
      @battlers.each do |b|
        next if !b || !b.fainted?
        idxBattler = b.index
        next if !pbCanChooseNonActive?(idxBattler)
        if !pbOwnedByPlayer?(idxBattler)   # Opponent/ally is switching in
          next if b.wild?   # Wild Pokémon can't switch
          idxPartyNew = pbSwitchInBetween(idxBattler)
          opponent = pbGetOwnerFromBattlerIndex(idxBattler)
          # NOTE: The player is only offered the chance to switch their own
          #       Pokémon when an opponent replaces a fainted Pokémon in single
          #       battles. In double battles, etc. there is no such offer.
          if @internalBattle && @switchStyle && trainerBattle? && pbSideSize(0) == 1 &&
             opposes?(idxBattler) && !@battlers[0].fainted? && !switched.include?(0) &&
             pbCanChooseNonActive?(0) && @battlers[0].effects[PBEffects::Outrage] == 0
            idxPartyForName = idxPartyNew
            enemyParty = pbParty(idxBattler)
            if enemyParty[idxPartyNew].ability == :ILLUSION && !pbCheckGlobalAbility(:NEUTRALIZINGGAS)
              new_index = pbLastInTeam(idxBattler)
              idxPartyForName = new_index if new_index >= 0 && new_index != idxPartyNew
            end
            # Adjusted this section to accept a custom line of text for if the player wants to swap out.
            if @switchtext != nil
              switch_text = @switchtext
            else
              switch_text = "{1} is about to send out {2}. Will you switch your Pokémon?"
            end
            if pbDisplayConfirm(_INTL(switch_text, opponent.full_name, enemyParty[idxPartyForName].name))
              idxPlayerPartyNew = pbSwitchInBetween(0, false, true) # Adjusted this line to utilize "switch_text"
              if idxPlayerPartyNew >= 0
                pbMessageOnRecall(@battlers[0])
                pbRecallAndReplace(0, idxPlayerPartyNew)
                switched.push(0)
              end
            end
          end
          pbRecallAndReplace(idxBattler, idxPartyNew)
          switched.push(idxBattler)
        elsif trainerBattle?   # Player switches in in a trainer battle
          idxPlayerPartyNew = pbGetReplacementPokemonIndex(idxBattler)   # Owner chooses
          pbRecallAndReplace(idxBattler, idxPlayerPartyNew)
          switched.push(idxBattler)
        else   # Player's Pokémon has fainted in a wild battle
          switch = false
          if pbDisplayConfirm(_INTL("Use next Pokémon?"))
            switch = true
          else
            switch = (pbRun(idxBattler, true) <= 0)
          end
          if switch
            idxPlayerPartyNew = pbGetReplacementPokemonIndex(idxBattler)   # Owner chooses
            pbRecallAndReplace(idxBattler, idxPlayerPartyNew)
            switched.push(idxBattler)
          end
        end
      end
      break if switched.length == 0
      pbOnBattlerEnteringBattle(switched)
    end
  end

  alias cs_pbMessageOnRecall pbMessageOnRecall
  def pbMessageOnRecall(battler)
    if battler.pbOwnedByPlayer?
      cs_pbMessageOnRecall(battler)
    else
      if @swapouttext
        swapout_text = @swapouttext
      else
        swapout_text = "{1} withdrew {2}!"
      end
      owner = pbGetOwnerName(battler.index)
      pbDisplayBrief(_INTL(swapout_text, owner, battler.name))
    end
  end
  
  alias cs_pbMessagesOnReplace pbMessagesOnReplace
  def pbMessagesOnReplace(idxBattler, idxParty)
    if pbOwnedByPlayer?(idxBattler)
      cs_pbMessagesOnReplace(idxBattler, idxParty)
    else
      party = pbParty(idxBattler)
      newPkmnName = party[idxParty].name
      if party[idxParty].ability == :ILLUSION && !pbCheckGlobalAbility(:NEUTRALIZINGGAS)
        new_index = pbLastInTeam(idxBattler)
        newPkmnName = party[new_index].name if new_index >= 0 && new_index != idxParty
      end
      if @switchintext
        switchin_text = @switchintext
      else
        switchin_text = "{1} sent out {2}!"
      end
      owner = pbGetOwnerFromBattlerIndex(idxBattler)
      pbDisplayBrief(_INTL(switchin_text, owner.full_name, newPkmnName))
      # owner_name = @switchintext ? owner.name : owner.full_name
      # pbDisplayBrief(_INTL(switchin_text, owner_name, newPkmnName))
    end
  end
  
  alias cs_pbEndOfBattle pbEndOfBattle
  def pbEndOfBattle
    oldDecision = @decision
    @decision = 4 if @decision == 1 && wildBattle? && @caughtPokemon.length > 0
    case oldDecision
    ##### WIN #####
    when 1
      PBDebug.log("")
      PBDebug.log_header("===== Player won =====")
      PBDebug.log("")
      if trainerBattle?
        @scene.pbTrainerBattleSuccess
        case @opponent.length
        when 1
          victory_text = @victorytext || "You defeated {1}!"
          pbDisplayPaused(_INTL(victory_text, @opponent[0].full_name))
        when 2
          victory_text = @victorytext || "You defeated {1} and {2}!"
          pbDisplayPaused(_INTL(victory_text, @opponent[0].full_name,
                                @opponent[1].full_name))    
        when 3
          victory_text = @victorytext || "You defeated {1}, {2} and {3}!"
          pbDisplayPaused(_INTL(victory_text, @opponent[0].full_name,
                                @opponent[1].full_name, @opponent[2].full_name))
        end
        @opponent.each_with_index do |trainer, i|
          @scene.pbShowOpponent(i)
          msg = trainer.lose_text
          msg = "..." if !msg || msg.empty?
          pbDisplayPaused(msg.gsub(/\\[Pp][Nn]/, pbPlayer.name))
        end
        PBDebug.log("")
      end
      # Gain money from winning a trainer battle, and from Pay Day
      pbGainMoney if @decision != 4
      # Hide remaining trainer
      @scene.pbShowOpponent(@opponent.length) if trainerBattle? && @caughtPokemon.length > 0
    ##### LOSE, DRAW #####
    when 2, 5
      return cs_pbEndOfBattle
    ##### CAUGHT WILD POKÉMON #####
    when 4
      return cs_pbEndOfBattle
    end
    # Register captured Pokémon in the Pokédex, and store them
    pbRecordAndStoreCaughtPokemon
    # Collect Pay Day money in a wild battle that ended in a capture
    pbGainMoney if @decision == 4
    # Pass on Pokérus within the party
    if @internalBattle
      infected = []
      $player.party.each_with_index do |pkmn, i|
        infected.push(i) if pkmn.pokerusStage == 1
      end
      infected.each do |idxParty|
        strain = $player.party[idxParty].pokerusStrain
        if idxParty > 0 && $player.party[idxParty - 1].pokerusStage == 0 && rand(3) == 0   # 33%
          $player.party[idxParty - 1].givePokerus(strain)
        end
        if idxParty < $player.party.length - 1 && $player.party[idxParty + 1].pokerusStage == 0 && rand(3) == 0   # 33%
          $player.party[idxParty + 1].givePokerus(strain)
        end
      end
    end
    # Clean up battle stuff
    @scene.pbEndBattle(@decision)
    @battlers.each do |b|
      next if !b
      pbCancelChoice(b.index)   # Restore unused items to Bag
      Battle::AbilityEffects.triggerOnSwitchOut(b.ability, b, true) if b.abilityActive?
    end
    pbParty(0).each_with_index do |pkmn, i|
      next if !pkmn
      @peer.pbOnLeavingBattle(self, pkmn, @usedInBattle[0][i], true)   # Reset form
      pkmn.item = @initialItems[0][i]
    end
    return @decision
  end
end

#------------------------------------------
# Deluxe Battle Kit - Debug Menu Handlers
#------------------------------------------
MenuHandlers.add(:battle_rules_menu, :prefixText, {
  "name"        => "Prefix text: [{1}]",
  "rule"        => "prefixText",
  "order"       => 900,
  "parent"      => :set_battle_rules,
  "description" => _INTL("Determines the text displayed before a Pokemon's name (e.g., The wild)."),
  "effect"      => proc { |menu|
    next pbApplyBattleRule("prefixText", :String, nil, 
      _INTL("Set the displayed Pokemon prefix text."))
  }
})

MenuHandlers.add(:battle_rules_menu, :swapOutText, {
  "name"        => "Swap Out Text: [{1}]",
  "rule"        => "swapOutText",
  "order"       => 901,
  "parent"      => :set_battle_rules,
  "description" => _INTL("Determines the text displayed when an NPC trainer recalls a Pokemon."),
  "effect"      => proc { |menu|
    next pbApplyBattleRule("swapOutText", :String, nil, 
      _INTL("Set the displayed NPC recall text."))
  }
})

MenuHandlers.add(:battle_rules_menu, :switchText, {
  "name"        => "Switch text: [{1}]",
  "rule"        => "switchText",
  "order"       => 902,
  "parent"      => :set_battle_rules,
  "description" => _INTL("Determines the text displayed before an opponent swaps in a new Pokemon."),
  "effect"      => proc { |menu|
    next pbApplyBattleRule("switchText", :String, nil, 
      _INTL("Set the opponent pre-swap text."))
  }
})

MenuHandlers.add(:battle_rules_menu, :switchInText, {
  "name"        => "Switch in text: [{1}]",
  "rule"        => "switchInText",
  "order"       => 903,
  "parent"      => :set_battle_rules,
  "description" => _INTL("Determines the text displayed when an opponent sends in a new Pokemon."),
  "effect"      => proc { |menu|
    next pbApplyBattleRule("switchInText", :String, nil, 
      _INTL("Set the opponent swap-in text."))
  }
})

MenuHandlers.add(:battle_rules_menu, :victoryText, {
  "name"        => "Victory text: [{1}]",
  "rule"        => "victoryText",
  "order"       => 904,
  "parent"      => :set_battle_rules,
  "description" => _INTL("Determines the text displayed when you defeat a trainer."),
  "effect"      => proc { |menu|
    next pbApplyBattleRule("victoryText", :String, nil, 
      _INTL("Set the victory text."))
  }
})

MenuHandlers.add(:battle_rules_menu, :faintedText, {
  "name"        => "Fainted text: [{1}]",
  "rule"        => "faintedText",
  "order"       => 905,
  "parent"      => :set_battle_rules,
  "description" => _INTL("Determines the text displayed when a Pokemon faints."),
  "effect"      => proc { |menu|
    next pbApplyBattleRule("faintedText", :String, nil, 
      _INTL("Set the Pokemon fainting text."))
  }
})

