#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Addition of Strange Mist as an Ability
#==============================================================================#
class Battle::Battler
  def pbRecoverHPFromDrain(amt, target, msg = nil)
    if target.hasActiveAbility?(:LIQUIDOOZE, true)
      @battle.pbShowAbilitySplash(target)
      pbReduceHP(amt)
      @battle.pbDisplay(_INTL("{1} sucked up the liquid ooze!", pbThis))
      @battle.pbHideAbilitySplash(target)
      pbItemHPHealCheck
	elsif target.hasActiveAbility?(:STRANGEMIST, true)
      @battle.pbShowAbilitySplash(target)
      pbReduceHP(amt)
      @battle.pbDisplay(_INTL("{1} sucked up the strange mist!", pbThis))
      @battle.pbHideAbilitySplash(target)
      pbItemHPHealCheck
    else
      msg = _INTL("{1} had its energy drained!", target.pbThis) if nil_or_empty?(msg)
      @battle.pbDisplay(msg)
      if canHeal?
        amt = (amt * 1.3).floor if hasActiveItem?(:BIGROOT)
        pbRecoverHP(amt)
      end
    end
  end
  
  def pbFaint(showMessage = true)
    if !fainted?
      PBDebug.log("!!!***Can't faint with HP greater than 0")
      return
    end
    return if @fainted   # Has already fainted properly
    if $game_switches[Settings::SPECIAL_BATTLE_SWITCH]
	  case $game_variables[Settings::SPECIAL_BATTLE_VARIABLE]
	  when 5
	    @battle.pbDisplayBrief(_INTL("{1} was defeated!", pbThis)) if showMessage
	  end
	else
	  @battle.pbDisplayBrief(_INTL("{1} fainted!", pbThis)) if showMessage
	end
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