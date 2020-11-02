################################################################################
# Burns the user. (Rage 1.8)
################################################################################
class PokeBattle_Move_500 < PokeBattle_Move
  def pbAdditionalEffect(user,targets)
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
    @statUp = [PBStats::ACCURACY,2]
  end
end
 

################################################################################
# Increases the user's Special Defense by 1 stage. (Mana Shield)
################################################################################
class PokeBattle_Move_502 < PokeBattle_MultiStatUpMove
  def initialize(battle,move)
    super
    @statUp = [PBStats::SPDEF,2]
  end
end

################################################################################
# Decreases the user's Defense by 1 stage. (Thrash 1.8)
################################################################################
class PokeBattle_Move_503 < PokeBattle_StatDownMove
  def initialize(battle,move)
    super
    @statDown = [PBStats::DEFENSE,1]
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
  def healingMove?; return NEWEST_BATTLE_MECHANICS; end

  def pbEffectAgainstTarget(user,target)
    return if target.damageState.hpLost<=0
    hpGain = (target.damageState.hpLost/2.0).round
    user.pbRecoverHPFromDrain(hpGain,target)
  end
  
  def pbEffectGeneral(user)
    @battle.pbDisplay(_INTL("{1} sliced {2} with Gehaburn and absorbed its life force!",user.pbThis,target.pbThis(true)))
  end
end