#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Adjustments to battle strings for Special Battles
#==============================================================================#
class Battle::Battler
  def pbThis(lowerCase = false)
    if opposes?
      if @battle.trainerBattle?
        return lowerCase ? _INTL("the opposing {1}", name) : _INTL("The opposing {1}", name)
      else
		if $game_variables[Settings::SPECIAL_BATTLE_VARIABLE].is_a?(String)
		  return lowerCase ? _INTL("{1}", name) : _INTL("{1}", name)
		else
		  return lowerCase ? _INTL("the wild {1}", name) : _INTL("The wild {1}", name)
		end
      end
    elsif !pbOwnedByPlayer?
      return lowerCase ? _INTL("the ally {1}", name) : _INTL("The ally {1}", name)
    end
    return name
  end
  
#==============================================================================#
# Changes in this section include the following:
#	* Added checks for Touhoumon Flying to count as Airborne
#==============================================================================#  
  def airborne?
    return false if hasActiveItem?(:IRONBALL)
    return false if @effects[PBEffects::Ingrain]
    return false if @effects[PBEffects::SmackDown]
    return false if @battle.field.effects[PBEffects::Gravity] > 0
    return true if pbHasType?(:FLYING)
	return true if pbHasType?(:FLYING18)
    return true if hasActiveAbility?(:LEVITATE) && !@battle.moldBreaker
    return true if hasActiveItem?(:AIRBALLOON)
    return true if @effects[PBEffects::MagnetRise] > 0
    return true if @effects[PBEffects::Telekinesis] > 0
    return false
  end

#==============================================================================#
# Changes in this section include the following:
#	* Added checks for Touhoumon types in regards to Sandstorm immunity
#==============================================================================#
  def takesSandstormDamage?
    return false if !takesIndirectDamage?
    return false if pbHasType?(:GROUND) || pbHasType?(:ROCK) || pbHasType?(:STEEL) ||
					pbHasType?(:EARTH18) || pbHasType?(:BEAST18) || pbHasType?(:STEEL18)
    return false if inTwoTurnAttack?("TwoTurnAttackInvulnerableUnderground",
                                     "TwoTurnAttackInvulnerableUnderwater")
    return false if hasActiveAbility?([:OVERCOAT,:SANDFORCE,:SANDRUSH,:SANDVEIL])
    return false if hasActiveItem?(:SAFETYGOGGLES)
    return true
  end
  
#==============================================================================#
# Changes in this section include the following:
#	* Added checks for Touhoumon types in regards to Hail immunity
#==============================================================================#  
  def takesHailDamage?
    return false if !takesIndirectDamage?
    return false if pbHasType?(:ICE) || pbHasType?(:ICE18)
    return false if inTwoTurnAttack?("TwoTurnAttackInvulnerableUnderground",
                                     "TwoTurnAttackInvulnerableUnderwater")
    return false if hasActiveAbility?([:OVERCOAT,:ICEBODY,:SNOWCLOAK])
    return false if hasActiveItem?(:SAFETYGOGGLES)
    return true
  end

#==============================================================================#
# Changes in this section include the following:
#	* Added Celestial Skin to the list of abilities that can't be removed
#     or gained.
#==============================================================================#    
  # Applies to both losing self's ability (i.e. being replaced by another) and
  # having self's ability be negated.
  def unstoppableAbility?(abil = nil)
    abil = @ability_id if !abil
    abil = GameData::Ability.try_get(abil)
    return false if !abil
    ability_blacklist = [
      # Form-changing abilities
      :BATTLEBOND,
      :DISGUISE,
#      :FLOWERGIFT,                                        # This can be stopped
#      :FORECAST,                                          # This can be stopped
      :GULPMISSILE,
      :ICEFACE,
      :MULTITYPE,
      :POWERCONSTRUCT,
      :SCHOOLING,
      :SHIELDSDOWN,
      :STANCECHANGE,
      :ZENMODE,
      # Abilities intended to be inherent properties of a certain species
      :ASONECHILLINGNEIGH,
      :ASONEGRIMNEIGH,
      :COMATOSE,
      :RKSSYSTEM,
	  # --- Custom Abilities
	  :CELESTIALSKIN,
	  :CELESTIALSKIN2
    ]
    return ability_blacklist.include?(abil.id)
  end
  
  # Applies to gaining the ability.
  def ungainableAbility?(abil = nil)
    abil = @ability_id if !abil
    abil = GameData::Ability.try_get(abil)
    return false if !abil
    ability_blacklist = [
      # Form-changing abilities
      :BATTLEBOND,
      :DISGUISE,
      :FLOWERGIFT,
      :FORECAST,
      :GULPMISSILE,
      :ICEFACE,
      :MULTITYPE,
      :POWERCONSTRUCT,
      :SCHOOLING,
      :SHIELDSDOWN,
      :STANCECHANGE,
      :ZENMODE,
      # Appearance-changing abilities
      :ILLUSION,
      :IMPOSTER,
      # Abilities intended to be inherent properties of a certain species
      :ASONECHILLINGNEIGH,
      :ASONEGRIMNEIGH,
      :COMATOSE,
      :RKSSYSTEM,
      # Abilities that can't be negated
      :NEUTRALIZINGGAS,
	  # --- Custom Abilities
	  :CELESTIALSKIN,
	  :CELESTIALSKIN2
    ]
    return ability_blacklist.include?(abil.id)
  end
end