#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Tweaks to existing move effects to account for Touhoumon mechanics
#	* Made Destiny Bond fail against Celestial Skin
#==============================================================================#

#===============================================================================
# All current battlers will perish after 3 more rounds. (Perish Song)
#
# Change: Removed explicit references to Pokemon as an individual species
#===============================================================================
class Battle::Move::StartPerishCountsForAllBattlers < Battle::Move
  def pbShowAnimation(id, user, targets, hitNum = 0, showAnimation = true)
    super
    @battle.pbDisplay(_INTL("Everyone on the field that heard the song will faint in three turns!"))
  end
end

#===============================================================================
# If user is KO'd before it next moves, the battler that caused it also faints.
# (Destiny Bond)
#
# Change: Made it so Destiny Bond fails against targets with the Celestial Skin
# ability.
#===============================================================================
class Battle::Move::AttackerFaintsIfUserFaints < Battle::Move
  def pbMoveFailed?(user, targets)
    if (Settings::MECHANICS_GENERATION >= 7 && user.effects[PBEffects::DestinyBondPrevious]) || (target.hasActiveAbility?(:CELESTIALSKIN) || target.hasActiveAbility?(:CELESTIALSKIN2))
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    return false
  end

  def pbEffectGeneral(user)
    user.effects[PBEffects::DestinyBond] = true
    @battle.pbDisplay(_INTL("{1} is hoping to take its attacker down with it!", user.pbThis))
  end
end