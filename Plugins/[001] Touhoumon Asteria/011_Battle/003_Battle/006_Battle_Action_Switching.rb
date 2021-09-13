#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Removing explicit references to Pokemon as an individual species
#==============================================================================#
class PokeBattle_Battle
  def pbCanSwitchLax?(idxBattler,idxParty,partyScene=nil)
    return true if idxParty<0
    party = pbParty(idxBattler)
    return false if idxParty>=party.length
    return false if !party[idxParty]
    if party[idxParty].egg?
      partyScene.pbDisplay(_INTL("An Egg can't battle!")) if partyScene
      return false
    end
    if !pbIsOwner?(idxBattler,idxParty)
      owner = pbGetOwnerFromPartyIndex(idxBattler,idxParty)
      partyScene.pbDisplay(_INTL("You can't switch {1}'s active party member with one of yours!",
        owner.name)) if partyScene
      return false
    end
    if party[idxParty].fainted?
      partyScene.pbDisplay(_INTL("{1} has no energy left to battle!",
         party[idxParty].name)) if partyScene
      return false
    end
    if pbFindBattler(idxParty,idxBattler)
      partyScene.pbDisplay(_INTL("{1} is already in battle!",
         party[idxParty].name)) if partyScene
      return false
    end
    return true
  end

#==============================================================================#
# Changes in this section include the following:
#	* Made it so Touhoumon Ghost Types can switch out regardless of conditions
#==============================================================================#  
  def pbCanSwitch?(idxBattler,idxParty=-1,partyScene=nil)
    # Check whether party Pokémon can switch in
    return false if !pbCanSwitchLax?(idxBattler,idxParty,partyScene)
    # Make sure another battler isn't already choosing to switch to the party
    # Pokémon
    eachSameSideBattler(idxBattler) do |b|
      next if choices[b.index][0]!=:SwitchOut || choices[b.index][1]!=idxParty
      partyScene.pbDisplay(_INTL("{1} has already been selected.",
         pbParty(idxBattler)[idxParty].name)) if partyScene
      return false
    end
    # Check whether battler can switch out
    battler = @battlers[idxBattler]
    return true if battler.fainted?
    # Ability/item effects that allow switching no matter what
    if battler.abilityActive?
      if BattleHandlers.triggerCertainSwitchingUserAbility(battler.ability,battler,self)
        return true
      end
    end
    if battler.itemActive?
      if BattleHandlers.triggerCertainSwitchingUserItem(battler.item,battler,self)
        return true
      end
    end
    # Other certain switching effects
    return true if Settings::MORE_TYPE_EFFECTS && (battler.pbHasType?(:GHOST) || 
												   battler.pbHasType?(:GHOST18))
    # Other certain trapping effects
    if battler.effects[PBEffects::Trapping]>0 ||
       battler.effects[PBEffects::MeanLook]>=0 ||
       battler.effects[PBEffects::Ingrain] ||
       @field.effects[PBEffects::FairyLock]>0
      partyScene.pbDisplay(_INTL("{1} can't be switched out!",battler.pbThis)) if partyScene
      return false
    end
    # Trapping abilities/items
    eachOtherSideBattler(idxBattler) do |b|
      next if !b.abilityActive?
      if BattleHandlers.triggerTrappingTargetAbility(b.ability,battler,b,self)
        partyScene.pbDisplay(_INTL("{1}'s {2} prevents switching!",
           b.pbThis,b.abilityName)) if partyScene
        return false
      end
    end
    eachOtherSideBattler(idxBattler) do |b|
      next if !b.itemActive?
      if BattleHandlers.triggerTrappingTargetItem(b.item,battler,b,self)
        partyScene.pbDisplay(_INTL("{1}'s {2} prevents switching!",
           b.pbThis,b.itemName)) if partyScene
        return false
      end
    end
    return true
  end
  
#==============================================================================#
# Changes in this section include the following:
#	* Removing explicit references to Pokemon as an individual species
#==============================================================================#  
  def pbEORSwitch(favorDraws=false)
    return if @decision>0 && !favorDraws
    return if @decision==5 && favorDraws
    pbJudge
    return if @decision>0
    # Check through each fainted battler to see if that spot can be filled.
    switched = []
    loop do
      switched.clear
      @battlers.each do |b|
        next if !b || !b.fainted?
        idxBattler = b.index
        next if !pbCanChooseNonActive?(idxBattler)
        if !pbOwnedByPlayer?(idxBattler)   # Opponent/ally is switching in
          next if wildBattle? && opposes?(idxBattler)   # Wild Pokémon can't switch
          idxPartyNew = pbSwitchInBetween(idxBattler)
          opponent = pbGetOwnerFromBattlerIndex(idxBattler)
          # NOTE: The player is only offered the chance to switch their own
          #       Pokémon when an opponent replaces a fainted Pokémon in single
          #       battles. In double battles, etc. there is no such offer.
          if @internalBattle && @switchStyle && trainerBattle? && pbSideSize(0)==1 &&
             opposes?(idxBattler) && !@battlers[0].fainted? && !switched.include?(0) &&
             pbCanChooseNonActive?(0) && @battlers[0].effects[PBEffects::Outrage]==0
            idxPartyForName = idxPartyNew
            enemyParty = pbParty(idxBattler)
            if enemyParty[idxPartyNew].ability == :ILLUSION
              new_index = pbLastInTeam(idxBattler)
              idxPartyForName = new_index if new_index >= 0 && new_index != idxPartyNew
            end
            if pbDisplayConfirm(_INTL("{1} is about to send in {2}. Will you switch your active party member?",
               opponent.full_name, enemyParty[idxPartyForName].name))
              idxPlayerPartyNew = pbSwitchInBetween(0,false,true)
              if idxPlayerPartyNew>=0
                pbMessageOnRecall(@battlers[0])
                pbRecallAndReplace(0,idxPlayerPartyNew)
                switched.push(0)
              end
            end
          end
          pbRecallAndReplace(idxBattler,idxPartyNew)
          switched.push(idxBattler)
        elsif trainerBattle?   # Player switches in in a trainer battle
          idxPlayerPartyNew = pbGetReplacementPokemonIndex(idxBattler)   # Owner chooses
          pbRecallAndReplace(idxBattler,idxPlayerPartyNew)
          switched.push(idxBattler)
        else   # Player's Pokémon has fainted in a wild battle
          switch = false
          if !pbDisplayConfirm(_INTL("Continue battling?"))
            switch = (pbRun(idxBattler,true)<=0)
          else
            switch = true
          end
          if switch
            idxPlayerPartyNew = pbGetReplacementPokemonIndex(idxBattler)   # Owner chooses
            pbRecallAndReplace(idxBattler,idxPlayerPartyNew)
            switched.push(idxBattler)
          end
        end
      end
      break if switched.length==0
      pbPriority(true).each do |b|
        b.pbEffectsOnSwitchIn(true) if switched.include?(b.index)
      end
    end
  end
  
#==============================================================================#
# Changes in this section include the following:
#	* Removing explicit references to Pokemon as an individual species
#	* Added in a check for the Donation Box to the money doubling formula
#	* Made it so the Miasma type is immune to Poison Spikes
#	* Made it so the Earth type has the same immunity as Rock types to Stealth
#	  Rock (Not Implemented Yet)
#==============================================================================#  
  def pbOnActiveOne(battler)
    return false if battler.fainted?
    # Introduce Shadow Pokémon
    if battler.opposes? && battler.shadowPokemon?
      pbCommonAnimation("Shadow",battler)
      pbDisplay(_INTL("Oh!\nThey're cloaked in a shadowy aura!"))
    end
    # Record money-doubling effect of Amulet Coin/Luck Incense
    if !battler.opposes? && [:AMULETCOIN, :LUCKINCENSE, :DONATIONBOX].include?(battler.item_id)
      @field.effects[PBEffects::AmuletCoin] = true
    end
    # Update battlers' participants (who will gain Exp/EVs when a battler faints)
    eachBattler { |b| b.pbUpdateParticipants }
    # Healing Wish
    if @positions[battler.index].effects[PBEffects::HealingWish]
      pbCommonAnimation("HealingWish",battler)
      pbDisplay(_INTL("The healing wish came true for {1}!",battler.pbThis(true)))
      battler.pbRecoverHP(battler.totalhp)
      battler.pbCureStatus(false)
      @positions[battler.index].effects[PBEffects::HealingWish] = false
    end
    # Lunar Dance
    if @positions[battler.index].effects[PBEffects::LunarDance]
      pbCommonAnimation("LunarDance",battler)
      pbDisplay(_INTL("{1} became cloaked in mystical moonlight!",battler.pbThis))
      battler.pbRecoverHP(battler.totalhp)
      battler.pbCureStatus(false)
      battler.eachMove { |m| m.pp = m.total_pp }
      @positions[battler.index].effects[PBEffects::LunarDance] = false
    end
    # Entry hazards
    # Stealth Rock
    if battler.pbOwnSide.effects[PBEffects::StealthRock] && battler.takesIndirectDamage? &&
       GameData::Type.exists?(:ROCK)
      bTypes = battler.pbTypes(true)
      eff = Effectiveness.calculate(:ROCK, bTypes[0], bTypes[1], bTypes[2])
      if !Effectiveness.ineffective?(eff)
        eff = eff.to_f / Effectiveness::NORMAL_EFFECTIVE
        oldHP = battler.hp
        battler.pbReduceHP(battler.totalhp*eff/8,false)
        pbDisplay(_INTL("Pointed stones dug into {1}!",battler.pbThis))
        battler.pbItemHPHealCheck
        if battler.pbAbilitiesOnDamageTaken(oldHP)   # Switched out
          return pbOnActiveOne(battler)   # For replacement battler
        end
      end
    end
    # Spikes
    if battler.pbOwnSide.effects[PBEffects::Spikes]>0 && battler.takesIndirectDamage? &&
       !battler.airborne?
      spikesDiv = [8,6,4][battler.pbOwnSide.effects[PBEffects::Spikes]-1]
      oldHP = battler.hp
      battler.pbReduceHP(battler.totalhp/spikesDiv,false)
      pbDisplay(_INTL("{1} is hurt by the spikes!",battler.pbThis))
      battler.pbItemHPHealCheck
      if battler.pbAbilitiesOnDamageTaken(oldHP)   # Switched out
        return pbOnActiveOne(battler)   # For replacement battler
      end
    end
    # Toxic Spikes
    if battler.pbOwnSide.effects[PBEffects::ToxicSpikes]>0 && !battler.fainted? &&
       !battler.airborne?
      if battler.pbHasType?(:POISON) || battler.pbHasType?(:MIASMA18)
        battler.pbOwnSide.effects[PBEffects::ToxicSpikes] = 0
        pbDisplay(_INTL("{1} absorbed the poison spikes!",battler.pbThis))
      elsif battler.pbCanPoison?(nil,false)
        if battler.pbOwnSide.effects[PBEffects::ToxicSpikes]==2
          battler.pbPoison(nil,_INTL("{1} was badly poisoned by the poison spikes!",battler.pbThis),true)
        else
          battler.pbPoison(nil,_INTL("{1} was poisoned by the poison spikes!",battler.pbThis))
        end
      end
    end
    # Sticky Web
    if battler.pbOwnSide.effects[PBEffects::StickyWeb] && !battler.fainted? &&
       !battler.airborne?
      pbDisplay(_INTL("{1} was caught in a sticky web!",battler.pbThis))
      if battler.pbCanLowerStatStage?(:SPEED)
        battler.pbLowerStatStage(:SPEED,1,nil)
        battler.pbItemStatRestoreCheck
      end
    end
    # Battler faints if it is knocked out because of an entry hazard above
    if battler.fainted?
      battler.pbFaint
      pbGainExp
      pbJudge
      return false
    end
    battler.pbCheckForm
    return true
  end
end