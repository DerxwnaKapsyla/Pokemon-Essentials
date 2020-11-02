class PokeBattle_Move_500 < PokeBattle_Move

  def pbAdditionalEffect(user,targets)
    return if !user.pbCanBurn?(user,true)
    user.pbBurn(user,_INTL("{1} was burned!",user.pbThis))
  end
end

class PokeBattle_Move_501 < PokeBattle_Move
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