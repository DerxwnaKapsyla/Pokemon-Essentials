#===============================================================================
# Choice Items
#===============================================================================
# Considers whether the selected move is a Z-Move/Dynamax move.
# Changes in this section include the following:
#	* Added the Touhoumon Choice Items to the relevant areas
#==============================================================================#
Battle::AI::Handlers::GeneralMoveScore.add(:good_move_for_choice_item,
  proc { |score, move, user, ai, battle|
    next score if move.move.powerMove?
    next score if !ai.trainer.medium_skill?
    next score if !user.has_active_item?([:CHOICEBAND, :CHOICESPECS, :CHOICESCARF, 
	                                      :BLOOMERS, :POWERRIBBON, :POWERGOGGLES, :POWERCAPE]) &&
                  !user.has_active_ability?(:GORILLATACTICS)
    old_score = score
    if move.statusMove? && move.function_code != "UserTargetSwapItems"
      score -= 25
      PBDebug.log_score_change(score - old_score, "don't want to be Choiced into a status move")
      next score
    end
    move_type = move.rough_type
    GameData::Type.each do |type_data|
      score -= 8 if type_data.immunities.include?(move_type)
    end
    if move.accuracy > 0
      score -= (0.4 * (100 - move.accuracy)).to_i
    end
    score -= 10 if move.move.pp <= 5
    PBDebug.log_score_change(score - old_score, "move is less suitable to be Choiced into")
    next score
  }
)

#===============================================================================
# External flinching effects.
#===============================================================================
# Considers whether the target is immune to flinch.
# Changes in this section include the following:
#	* Added Advent to ability checks for preventing flinching
#-------------------------------------------------------------------------------
Battle::AI::Handlers::GeneralMoveAgainstTargetScore.add(:external_flinching_effects,
  proc { |score, move, user, target, ai, battle|
    if ai.trainer.medium_skill? && move.damagingMove? && !move.move.flinchingMove? &&
       user.faster_than?(target) && target.effects[PBEffects::Substitute] == 0
      if user.has_active_item?([:KINGSROCK, :RAZORFANG]) ||
         user.has_active_ability?(:STENCH)
        flinchImmune = (
          target.battler.dynamax? ||
          target.battler.pokemon.immunities.include?(:FLINCH) ||
          (target.has_active_ability?([:INNERFOCUS, :SHIELDDUST, :ADVENT]) && !battle.moldBreaker)
        )
        if !flinchImmune
          old_score = score
          score += 8
          score += 5 if move.move.multiHitMove?
          PBDebug.log_score_change(score - old_score, "added chance to cause flinching")
        end
      end
    end
    next score
  }
)