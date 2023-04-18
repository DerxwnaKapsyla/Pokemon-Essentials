#===============================================================================
# For 5 rounds, lowers power of attacks against the user's side. Fails if
# weather is not hail. (Aurora Veil)
#
# Addition: Added a check for Severe Hail
#===============================================================================
class Battle::Move::StartWeakenDamageAgainstUserSideIfHail < Battle::Move
  def canSnatch?; return true; end

  def pbMoveFailed?(user, targets)
    if ![:Hail, :SevereHail].include?(user.effectiveWeather)
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    if user.pbOwnSide.effects[PBEffects::AuroraVeil] > 0
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    return false
  end

  def pbEffectGeneral(user)
    user.pbOwnSide.effects[PBEffects::AuroraVeil] = 5
    user.pbOwnSide.effects[PBEffects::AuroraVeil] = 8 if user.hasActiveItem?(:LIGHTCLAY)
    @battle.pbDisplay(_INTL("{1} made {2} stronger against physical and special moves!",
                            @name, user.pbTeam(true)))
  end
end