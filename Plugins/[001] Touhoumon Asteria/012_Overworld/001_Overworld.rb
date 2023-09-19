#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Removed explicit references to Pokemon
#	* Adds a check for Cerulean Gym's hopping puzzle
#	* Adds pbFieldDamage, which is (currently) used for the Vermilion Gym
#	  Landmines. (Credits for script go to Reborn/Amethyst)
#   * Made adjustments to account for pbFieldDamageNoFaint
#   * Made additions to apply a status in the field
#	  May need to be tweaked for v20.
#==============================================================================#

def pbCheckAllFainted
  if $player.able_pokemon_count == 0
    pbMessage(_INTL("You have no more party members that can fight!") + "\1")
    pbMessage(_INTL("You blacked out!"))
    pbBGMFade(1.0)
    pbBGSFade(1.0)
    pbFadeOutIn { pbStartOver }
  end
end

def pbLedge(_xOffset, _yOffset)
  if $game_player.pbFacingTerrainTag.ledge || ($game_player.pbFacingTerrainTag.jump_platform && !$PokemonGlobal.surfing)
    if pbJumpToward(2, true)
      $scene.spriteset.addUserAnimation(Settings::DUST_ANIMATION_ID, $game_player.x, $game_player.y, true, 1)
      $game_player.increase_steps
      $game_player.check_event_trigger_here([1, 2])
    end
    return true
  end
  return false
end

def pbFieldDamage
    for i in $player.able_party
      if i.hp > 0 && !i.egg?
        if i.hp == 1
          next
        end
        i.hp-=(i.totalhp/8)
        if i.hp == 0
          i.changeHappiness("faint")
          i.status = 0
          pbMessage(_INTL("{1} fainted...",i.name))
        end
		if $player.able_pokemon_count == 0
		  pbCheckAllFainted()
		end
      end
    end
end

def pbFieldDamageNoFaint
    for i in $player.able_party
      if i.hp > 0 && !i.egg?
        if i.hp == 1
          next
        end
        i.hp -= (i.totalhp/8)
        if i.hp == 0
          i.hp = 1
        end
      end
    end
end

def canInflictStatus?(newStatus, ignoreStatus = false, ignoreImmunity = false)
    return false if fainted?
    # Already have that status problem
    if self.status == newStatus && !ignoreStatus
      return false
    end
    # Trying to replace a status problem with another one
    if self.status != :NONE && !ignoreStatus
      return false
    end
    # Type immunities
    hasImmuneType = false
    case newStatus
    when :SLEEP
      # No type is immune to sleep
    when :POISON
      hasImmuneType |= pbHasType?(:POISON)
      hasImmuneType |= pbHasType?(:STEEL)
      hasImmuneType |= pbHasType?(:MIASMA18)
      hasImmuneType |= pbHasType?(:STEEL18)
    when :BURN
      hasImmuneType |= pbHasType?(:FIRE)
	  hasImmuneType |= pbHasType?(:FIRE18)
    when :PARALYSIS
      hasImmuneType |= pbHasType?(:ELECTRIC) && Settings::MORE_TYPE_EFFECTS
	  hasImmuneType |= pbHasType?(:WIND18) && Settings::MORE_TYPE_EFFECTS
    when :FROZEN
      hasImmuneType |= pbHasType?(:ICE)
	  hasImmuneType |= pbHasType?(:ICE18)
    end
    if hasImmuneType && !ignoreImmunity
      return false
    end
    # Ability immunity
    immuneByAbility = false
    if Battle::AbilityEffects.triggerStatusImmunity(self.ability, self, newStatus)
       immuneByAbility = true
    end
    if immuneByAbility && !ignoreImmunity
      return false
    end
    return true
end

def inflictStatus(newStatus, newStatusCount = 0, msg = nil, user = nil)
    # Inflict the new status
    self.status      = newStatus
    self.statusCount = newStatusCount
end
  
def pbHasType?(type)
    return false if !type
    activeTypes = [self.types[0],self.types[1]]
    return activeTypes.include?(GameData::Type.get(type).id)
end

def pbFieldApplyStatus(status, total, overwrite = false, override = false)
  total.times do |i|
	if $player.able_party[i].canInflictStatus?(status, overwrite, override)
	  $player.able_party[i].inflictStatus(status)
	end
  end
end