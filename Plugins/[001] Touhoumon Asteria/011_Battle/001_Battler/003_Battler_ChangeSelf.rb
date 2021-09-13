#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Addition of Strange Mist as an Ability
#==============================================================================#
class PokeBattle_Battler
  def pbRecoverHPFromDrain(amt,target,msg=nil)
    if target.hasActiveAbility?(:LIQUIDOOZE)
      @battle.pbShowAbilitySplash(target)
      pbReduceHP(amt)
      @battle.pbDisplay(_INTL("{1} sucked up the liquid ooze!",pbThis))
      @battle.pbHideAbilitySplash(target)
      pbItemHPHealCheck
	elsif target.hasActiveAbility?(:STRANGEMIST)
      @battle.pbShowAbilitySplash(target)
      pbReduceHP(amt)
      @battle.pbDisplay(_INTL("{1} sucked up the strange mist!",pbThis))
      @battle.pbHideAbilitySplash(target)
      pbItemHPHealCheck
    else
      msg = _INTL("{1} had its energy drained!",target.pbThis) if nil_or_empty?(msg)
      @battle.pbDisplay(msg)
      if canHeal?
        amt = (amt*1.3).floor if hasActiveItem?(:BIGROOT)
        pbRecoverHP(amt)
      end
    end
  end
end