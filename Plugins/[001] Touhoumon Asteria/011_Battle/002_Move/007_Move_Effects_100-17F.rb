#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Tweaks to existing move effects to account for Touhoumon mechanics
#==============================================================================#

#===============================================================================
# User is Ghost: User loses 1/2 of max HP, and curses the target.
# Cursed Pokémon lose 1/4 of their max HP at the end of each round.
# User is not Ghost: Decreases the user's Speed by 1 stage, and increases the
# user's Attack and Defense by 1 stage each. (Curse)
#
# Additions: Now made to account for Touhoumon Ghost
#===============================================================================
class PokeBattle_Move_10D < PokeBattle_Move

  def pbTarget(user)
    return GameData::Target.get(:NearFoe) if (user.pbHasType?(:GHOST) ||
											  user.pbHasType?(:GHOST18))
    return super
  end

  def pbMoveFailed?(user,targets)
    return false if (user.pbHasType?(:GHOST) ||
					 user.pbHasType?(:GHOST18))
    if !user.pbCanLowerStatStage?(:SPEED,user,self) &&
       !user.pbCanRaiseStatStage?(:ATTACK,user,self) &&
       !user.pbCanRaiseStatStage?(:DEFENSE,user,self)
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    return false
  end

  def pbFailsAgainstTarget?(user,target)
    if (user.pbHasType?(:GHOST) || 
		user.pbHasType?(:GHOST18)) && target.effects[PBEffects::Curse]
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    return false
  end

  def pbEffectGeneral(user)
    return if (user.pbHasType?(:GHOST) ||
			   user.pbHasType?(:GHOST18))
    # Non-Ghost effect
    if user.pbCanLowerStatStage?(:SPEED,user,self)
      user.pbLowerStatStage(:SPEED,1,user)
    end
    showAnim = true
    if user.pbCanRaiseStatStage?(:ATTACK,user,self)
      if user.pbRaiseStatStage(:ATTACK,1,user,showAnim)
        showAnim = false
      end
    end
    if user.pbCanRaiseStatStage?(:DEFENSE,user,self)
      user.pbRaiseStatStage(:DEFENSE,1,user,showAnim)
    end
  end

  def pbEffectAgainstTarget(user,target)
    return if !(user.pbHasType?(:GHOST) ||
				user.pbHasType?(:GHOST18))
    # Ghost effect
    @battle.pbDisplay(_INTL("{1} cut its own HP and laid a curse on {2}!",user.pbThis,target.pbThis(true)))
    target.effects[PBEffects::Curse] = true
    user.pbReduceHP(user.totalhp/2,false)
    user.pbItemHPHealCheck
  end

  def pbShowAnimation(id,user,targets,hitNum=0,showAnimation=true)
    hitNum = 1 if !(user.pbHasType?(:GHOST) ||
					user.pbHasType?(:GHOST18)) # Non-Ghost anim
    super
  end
end

#===============================================================================
# The target uses its most recent move again. (Instruct)
# 
# Additions: Added Recollection to Instruct's blacklist
#===============================================================================
class PokeBattle_Move_16B < PokeBattle_Move
  def initialize(battle,move)
    super
    @moveBlacklist = [
       "0D4",   # Bide
       "14B",   # King's Shield
       "16B",   # Instruct (this move)
       # Struggle
       "002",   # Struggle
       # Moves that affect the moveset
       "05C",   # Mimic
       "05D",   # Sketch
       "069",   # Transform
       # Moves that call other moves
       "0AE",   # Mirror Move
       "0AF",   # Copycat
       "0B0",   # Me First
       "0B3",   # Nature Power
       "0B4",   # Sleep Talk
       "0B5",   # Assist
       "0B6",   # Metronome
       # Moves that require a recharge turn
       "0C2",   # Hyper Beam
       # Two-turn attacks
       "0C3",   # Razor Wind
       "0C4",   # Solar Beam, Solar Blade
       "0C5",   # Freeze Shock
       "0C6",   # Ice Burn
       "0C7",   # Sky Attack
       "0C8",   # Skull Bash
       "0C9",   # Fly
       "0CA",   # Dig
       "0CB",   # Dive
       "0CC",   # Bounce
       "0CD",   # Shadow Force
       "0CE",   # Sky Drop
       "12E",   # Shadow Half
       "14D",   # Phantom Force
       "14E",   # Geomancy
       # Moves that start focussing at the start of the round
       "115",   # Focus Punch
       "171",   # Shell Trap
       "172",   # Beak Blast
	   "504"	# Recollection
    ]
  end
end