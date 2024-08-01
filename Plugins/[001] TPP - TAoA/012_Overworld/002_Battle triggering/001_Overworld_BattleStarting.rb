module BattleCreationHelperMethods
  module_function
  
  def set_outcome(outcome, outcome_variable = 1, trainer_battle = false)
    case outcome
    when 1, 4   # Won, caught
      $stats.wild_battles_won += 1 if !trainer_battle
      $stats.trainer_battles_won += 1 if trainer_battle
	  $game_variables[130] += 1 if $game_map&.metadata&.has_flag?("VRTraining")
      echoln "Puppets Defeated/Total: #{pbGet(130)}/#{pbGet(129)}" if $DEBUG && $game_map&.metadata&.has_flag?("VRTraining")
    when 2, 3, 5   # Lost, fled, draw
      $stats.wild_battles_lost += 1 if !trainer_battle
      $stats.trainer_battles_lost += 1 if trainer_battle
    end
    pbSet(outcome_variable, outcome)
  end
end