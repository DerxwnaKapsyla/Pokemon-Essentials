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
  
#==============================================================================#
# Changes in this section include the following:
#	* Addition of Severe Hail
#==============================================================================#
  alias asteria_pbCheckFormOnWeatherChange pbCheckFormOnWeatherChange
  def pbCheckFormOnWeatherChange(ability_changed = false)
  asteria_pbCheckFormOnWeatherChange(ability_changed)
    if isSpecies?(:CASTFORM)
      if hasActiveAbility?(:FORECAST)
        newForm = 0
        case effectiveWeather
        when :Sun, :HarshSun   		then newForm = 1
        when :Rain, :HeavyRain 		then newForm = 2
        when :Hail, :SevereHail     then newForm = 3
        end
        if @form != newForm
          @battle.pbShowAbilitySplash(self, true)
          @battle.pbHideAbilitySplash(self)
          pbChangeForm(newForm, _INTL("{1} transformed!", pbThis))
        end
      else
        pbChangeForm(0, _INTL("{1} transformed!", pbThis))
      end
    end
    if !ability_changed && isSpecies?(:EISCUE) && self.ability == :ICEFACE &&
       @form == 1 && effectiveWeather == :Hail || :SevereHail
      @canRestoreIceFace = true   # Changed form at end of round
    end
  end	
end