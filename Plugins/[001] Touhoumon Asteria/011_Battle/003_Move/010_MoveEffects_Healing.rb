#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Tweaks to existing move effects to account for Touhoumon mechanics
#==============================================================================#

#===============================================================================
# Heals user by 1/2 of its max HP, or 2/3 of its max HP in a sandstorm. (Shore Up)
#
# Addition: Heals the user by 3/4ths its max HP during Cruel Sandstorm
#===============================================================================
class Battle::Move::HealUserDependingOnSandstorm < Battle::Move::HealingMove
  def pbHealAmount(user)
    return (user.totalhp * 2 / 3.0).round if user.effectiveWeather == :Sandstorm
	return (user.totalhp * 3 / 4.0).round if user.effectiveWeather == :CruelSandstorm
    return (user.totalhp / 2.0).round
  end
end

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