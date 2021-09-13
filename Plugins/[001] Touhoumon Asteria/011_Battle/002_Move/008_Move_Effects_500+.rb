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
class PokeBattle_Move_500 < PokeBattle_Move
  def pbAdditionalEffect(user,target)
	return if !user.pbCanBurn?(user,true)
	user.pbBurn(user,_INTL("{1} was burned!",user.pbThis))
  end
end

################################################################################
# Increases the user's Accuracy by 2 stages. (Lock-On 1.8)
################################################################################
class PokeBattle_Move_501 < PokeBattle_StatUpMove
  def initialize(battle,move)
    super
    @statUp = [:ACCURACY,2]
  end
end

################################################################################
# Increases the user's Special Defense by 1 stage. (Mana Shield)
################################################################################
class PokeBattle_Move_502 < PokeBattle_StatUpMove
  def initialize(battle,move)
    super
    @statUp = [:SPECIAL_DEFENSE,2]
  end
end

################################################################################
# Decreases the user's Defense by 1 stage. (Thrash 1.8)
################################################################################
class PokeBattle_Move_503 < PokeBattle_StatDownMove
  def initialize(battle,move)
    super
    @statDown = [:DEFENSE,1]
  end
end

################################################################################
# User copies the foe's stats and moves, but doesn't become them. (Recollection)
################################################################################
class PokeBattle_Move_504 < PokeBattle_Move
  def pbMoveFailed?(user,targets)
    if user.effects[PBEffects::Transform]
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    return false
  end

  def pbFailsAgainstTarget?(user,target)
    if target.effects[PBEffects::Transform] ||
       target.effects[PBEffects::Illusion]
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    return false
  end

  def pbEffectAgainstTarget(user,target)
    user.pbTransform(target)
  end

  def pbShowAnimation(id,user,targets,hitNum=0,showAnimation=true)
    super
  end
end

################################################################################
# User gains half the HP it inflicts as damage. (Cursed Stab)
################################################################################
class PokeBattle_Move_505 < PokeBattle_Move
  def healingMove?; return Settings::MECHANICS_GENERATION >= 6; end
  
  def pbEffectAgainstTarget(user,target)
    return if target.damageState.hpLost<=0
    hpGain = (target.damageState.hpLost/2.0).round
    user.pbRecoverHPFromDrain(hpGain,target)
	@battle.pbDisplay(_INTL("{1} sliced {2} with Gehaburn and absorbed its life force!",user.pbThis,target.pbThis(true)))
  end
end

#===============================================================================
# Power is doubled in weather. Type changes depending on the weather. (Weather Ball)
# Derx: This Weather Ball is unique to Touhoumon and uses its types instead.
#===============================================================================
class PokeBattle_Move_506 < PokeBattle_Move
  def pbBaseDamage(baseDmg,user,target)
    baseDmg *= 2 if @battle.pbWeather != :None
    return baseDmg
  end

  def pbBaseType(user)
    ret = :NORMAL
    case @battle.pbWeather
    when :Sun, :HarshSun
      ret = :FIRE18 if GameData::Type.exists?(:FIRE18)
    when :Rain, :HeavyRain
      ret = :WATER18 if GameData::Type.exists?(:WATER18)
    when :Sandstorm
      ret = :BEAST18 if GameData::Type.exists?(:BEAST18)
    when :Hail
      ret = :ICE18 if GameData::Type.exists?(:ICE18)
    end
    return ret
  end

  def pbShowAnimation(id,user,targets,hitNum=0,showAnimation=true)
    t = pbBaseType(user)
    hitNum = 1 if t == :FIRE   # Type-specific anims
    hitNum = 2 if t == :WATER
    hitNum = 3 if t == :ROCK
    hitNum = 4 if t == :ICE
    super
  end
end