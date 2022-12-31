#===============================================================================
# OHKO. Accuracy increases by difference between levels of user and target.
#
# Changes: Made it check for Celestial Skin as well
#===============================================================================
class Battle::Move::OHKO < Battle::Move::FixedDamageMove
  def pbFailsAgainstTarget?(user, target, show_message)
    if target.level > user.level
      @battle.pbDisplay(_INTL("{1} is unaffected!", target.pbThis)) if show_message
      return true
    end
    if (target.hasActiveAbility?(:STURDY) || target.hasActiveAbility?(:CELESTIALSKIN) || target.hasActiveAbility?(:CELESTIALSKIN2)) && !@battle.moldBreaker
      if show_message && !target.hasActiveAbility?(:CELESTIALSKIN2)
        @battle.pbShowAbilitySplash(target)
        if Battle::Scene::USE_ABILITY_SPLASH
          @battle.pbDisplay(_INTL("But it failed to affect {1}!", target.pbThis(true)))
        else
          @battle.pbDisplay(_INTL("But it failed to affect {1} because of its {2}!",
                                  target.pbThis(true), target.abilityName))
        end
        @battle.pbHideAbilitySplash(target)
      end
      return true
    end
    return false
  end

  def pbAccuracyCheck(user, target)
    acc = @accuracy + user.level - target.level
    return @battle.pbRandom(100) < acc
  end

  def pbFixedDamage(user, target)
    return target.totalhp
  end

  def pbHitEffectivenessMessages(user, target, numTargets = 1)
    super
    if target.fainted?
      @battle.pbDisplay(_INTL("It's a one-hit KO!"))
    end
  end
end