#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Tweaks to existing move effects to account for Touhoumon mechanics
#==============================================================================#

#===============================================================================
# This move turns into the last move used by the target, until user switches
# out. (Mimic)
#
# Addition: Added in a check for Recollection
#===============================================================================
class PokeBattle_Move_05C < PokeBattle_Move

  def initialize(battle,move)
    super
    @moveBlacklist = [
       "014",   # Chatter
       "0B6",   # Metronome
       # Struggle
       "002",   # Struggle
       # Moves that affect the moveset
       "05C",   # Mimic
       "05D",   # Sketch
       "069",   # Transform
	   "504"	# Recollection
    ]
  end
end
  
#===============================================================================
# Target's ability becomes Simple. (Simple Beam)
#
# Addition: Added in a check for Fretful
#===============================================================================
class PokeBattle_Move_063 < PokeBattle_Move
  def pbFailsAgainstTarget?(user,target)
    if target.unstoppableAbility? || [:TRUANT, :SIMPLE, :FRETFUL].include?(target.ability)
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    return false
  end
end
  
#===============================================================================
# Target's ability becomes Insomnia. (Worry Seed)
#
# Addition: Added in a check for Fretful
#===============================================================================
class PokeBattle_Move_064 < PokeBattle_Move
  def pbFailsAgainstTarget?(user,target)
    if target.unstoppableAbility? || [:TRUANT, :INSOMNIA, :FRETFUL].include?(target.ability_id)
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    return false
  end
end
  
#===============================================================================
# User copies target's ability. (Role Play)
#
# Addition: Added in a check for Play Ghost
#===============================================================================
class PokeBattle_Move_065 < PokeBattle_Move
  def pbFailsAgainstTarget?(user,target)
    if !target.ability || user.ability==target.ability
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    if target.ungainableAbility? ||
       [:POWEROFALCHEMY, :RECEIVER, :TRACE, :WONDERGUARD, :PLAYGHOST].include?(target.ability_id)
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    return false
  end
end

#===============================================================================
# Target copies user's ability. (Entrainment)
#
# Addition: Added in a check for Fretful
#===============================================================================
class PokeBattle_Move_066 < PokeBattle_Move
  def pbFailsAgainstTarget?(user,target)
    if target.unstoppableAbility? || [:TRUANT, :FRETFUL].include?(target.ability_id)
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    return false
  end
end

#===============================================================================
# User and target swap abilities. (Skill Swap)
#
# Addition: Added in a check for Play Ghost
#===============================================================================
class PokeBattle_Move_067 < PokeBattle_Move
  def pbMoveFailed?(user,targets)
    if !user.ability
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    if user.unstoppableAbility?
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    if user.ungainableAbility? || [:WONDERGUARD, :PLAYGHOST].include?(user.ability_id)
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    return false
  end
  
  def pbFailsAgainstTarget?(user,target)
    if !target.ability ||
       (user.ability == target.ability && Settings::MECHANICS_GENERATION <= 5)
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    if target.unstoppableAbility?
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    if target.ungainableAbility? || [:WONDERGUARD, :PLAYGHOST].include?(target.ability_id)
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    return false
  end
end