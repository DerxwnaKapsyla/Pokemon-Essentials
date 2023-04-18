class Battle::AI
  alias asteria_aiEffectScorePart2_pbGetMoveScoreFunctionCode pbGetMoveScoreFunctionCode
  
  def pbGetMoveScoreFunctionCode(score, move, user, target, skill = 100)
    case move.function
    #---------------------------------------------------------------------------
    when "StartWeakenDamageAgainstUserSideIfHail"
      if user.pbOwnSide.effects[PBEffects::AuroraVeil] > 0 || ![:Hail, :SevereHail].include?(user.effectiveWeather)
        score -= 90
      else
        score += 40
      end
    #---------------------------------------------------------------------------
    when "HealUserDependingOnSandstorm"
      if user.hp == user.totalhp || (skill >= PBTrainerAI.mediumSkill && !user.canHeal?)
        score -= 90
      else
        score += 50
        score -= user.hp * 100 / user.totalhp
        score += 30 if [:Sandstorm, :CruelSandstorm].include?(user.effectiveWeather)
      end
    #---------------------------------------------------------------------------
    else
      return asteria_pbGetMoveScoreFunctionCode(score, move, user, target, skill)
    end
    return score
  end
end