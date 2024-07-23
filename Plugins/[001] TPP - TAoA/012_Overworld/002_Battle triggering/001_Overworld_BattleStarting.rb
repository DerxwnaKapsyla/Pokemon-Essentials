module BattleCreationHelperMethods
  module_function
  
class << self
    alias_method :vr_set_outcome, :set_outcome
  def set_outcome(outcome, outcome_variable = 1, trainer_battle = false)
    vr_set_outcome(outcome, outcome_variable = 1, trainer_battle = false)
	case outcome
	when 1
      $game_variables[130] += 1 if $game_map&.metadata&.has_flag?("VRTraining")
      p pbGet(130) if $DEBUG
	end
  end
end
end