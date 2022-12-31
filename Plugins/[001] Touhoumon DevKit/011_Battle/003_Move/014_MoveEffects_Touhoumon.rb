#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* New Move Effects exclusive to the 1.8 generation of Touhoumon
#==============================================================================#

################################################################################
# Burns the user. (Rage 1.8)
################################################################################
class Battle::Move::BurnAttackerAtRandom < Battle::Move
  def pbAdditionalEffect(user,target)
	return if !user.pbCanBurn?(user,true)
	user.pbBurn(user,_INTL("{1} was burned!",user.pbThis))
  end
end

################################################################################
# Increases the user's Accuracy by 2 stages. (Lock-On 1.8)
################################################################################
#class Battle::Move::RaiseUserAccuracy2 < Battle::Move::StatUpMove
#  def initialize(battle, move)
#    super
#    @statUp = [:ACCURACY, 2]
#  end
#end

################################################################################
# Increases the user's Special Defense by 1 stage. (Mana Shield)
################################################################################
#class Battle::Move::RaiseUserEvasion1 < Battle::Move::StatUpMove
#  def initialize(battle, move)
#    super
#    @statUp = [:SPECIAL_DEFENSE, 1]
#  end
#end

################################################################################
# Decreases the user's Defense by 1 stage. (Thrash 1.8)
################################################################################
#class Battle::Move::LowerUserDefense1 < Battle::Move::StatDownMove
#  def initialize(battle, move)
#    super
#    @statDown = [:DEFENSE, 1]
#  end
#end

################################################################################
# User copies the foe's stats and moves, but doesn't become them. (Recollection)
################################################################################
class Battle::Move::UserCopiesMovesWithoutTransforming < Battle::Move
  def pbMoveFailed?(user, targets)
    if user.effects[PBEffects::Transform]
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    return false
  end

  def pbFailsAgainstTarget?(user, target, show_message)
    if target.effects[PBEffects::Transform] ||
       target.effects[PBEffects::Illusion]
      @battle.pbDisplay(_INTL("But it failed!")) if show_message
      return true
    end
    return false
  end

  def pbEffectAgainstTarget(user, target)
    user.pbTransform(target)
  end

  def pbShowAnimation(id, user, targets, hitNum = 0, showAnimation = true)
    super
  end
end

################################################################################
# User gains half the HP it inflicts as damage. (Cursed Stab)
################################################################################
class Battle::Move::HealUserByHalfOfDamageDoneThmn < Battle::Move
  def healingMove?; return Settings::MECHANICS_GENERATION >= 6; end

  def pbEffectAgainstTarget(user, target)
    return if target.damageState.hpLost <= 0
    hpGain = (target.damageState.hpLost / 2.0).round
    user.pbRecoverHPFromDrain(hpGain, target)
	@battle.pbDisplay(_INTL("{1} sliced {2} with Gehaburn and absorbed its life force!",user.pbThis,target.pbThis(true)))
  end
end

#===============================================================================
# Power is doubled in weather. Type changes depending on the weather. (Weather Ball)
# Derx: This Weather Ball is unique to Touhoumon and uses its types instead.
#===============================================================================
class Battle::Move::TypeAndPowerDependOnWeatherThmn < Battle::Move
  def pbBaseDamage(baseDmg, user, target)
    baseDmg *= 2 if user.effectiveWeather != :None
    return baseDmg
  end

  def pbBaseType(user)
    ret = :NORMAL
    case user.effectiveWeather
    when :Sun, :HarshSun
      ret = :FIRE18 if GameData::Type.exists?(:FIRE18)
    when :Rain, :HeavyRain
      ret = :WATER18 if GameData::Type.exists?(:WATER18)
    when :Sandstorm
      ret = :ROCK18 if GameData::Type.exists?(:ROCK18)
    when :Hail
      ret = :ICE18 if GameData::Type.exists?(:ICE18)
    end
    return ret
  end

  def pbShowAnimation(id, user, targets, hitNum = 0, showAnimation = true)
    t = pbBaseType(user)
    hitNum = 1 if t == :FIRE   # Type-specific anims
    hitNum = 2 if t == :WATER
    hitNum = 3 if t == :ROCK
    hitNum = 4 if t == :ICE
    super
  end
end

#===============================================================================
# Increases the user's Attack, Special Attack, and Speed by 2 stages each. 
# Resets the user's Defense and Special Defense to 0. 
# Removes the effects of Ingrain, Safeguard, and Mist on the user's side
# (Celestial Mind)
#===============================================================================
class Battle::Move::RaiseUserAtkSpAtkSpd2ResetUserStatStagesResetUserFieldEffects < Battle::Move
  def initialize(battle, move)
    super
    @statUp = [:ATTACK, 2, :SPECIAL_ATTACK, 2, :SPEED, 2]
  end
  
  def pbEffectGeneral(user)
    showAnim = true
    (@statUp.length / 2).times do |i|
      next if !user.pbCanRaiseStatStage?(@statUp[i * 2], user, self)
      if user.pbRaiseStatStage(@statUp[i * 2], @statUp[(i * 2) + 1], user, showAnim)
        showAnim = false
      end
    end
    # copied-ish from pbResetStatStages (used by Haze)
    [:DEFENSE,:SPECIAL_DEFENSE].each do |s|
      if user.stages[s] > 0
        user.statsLoweredThisRound = true
        user.statsDropped = true
      elsif user.stages[s] < 0
        user.statsRaisedThisRound = true
      end
      user.stages[s] = 0
    end
    user.effects[PBEffects::Ingrain] = false
    user.pbOwnSide.effects[PBEffects::Safeguard] = 0
    user.pbOwnSide.effects[PBEffects::Mist] = 0
  end
end

#===============================================================================
# Multi-Hit Move that has a chance to paralyze. Is always treated as a Super
# Effective move. (Hisou Sword)
#===============================================================================
class Battle::Move::HitTwoToFiveTimesParalyzeTargetAlwaysSuperEffective < Battle::Move::ParalyzeTarget
  def multiHitMove?; return true; end

  def pbNumHits(user, targets)
    hitChances = [
      2, 2, 2, 2, 2, 2, 2,
      3, 3, 3, 3, 3, 3, 3,
      4, 4, 4,
      5, 5, 5
    ]
    r = @battle.pbRandom(hitChances.length)
    r = hitChances.length - 1 if user.hasActiveAbility?(:SKILLLINK)
    return hitChances[r]
  end
  
  def pbCalcTypeModSingle(moveType, defType, user, target)
    return Effectiveness::SUPER_EFFECTIVE_ONE
    return super
  end
end