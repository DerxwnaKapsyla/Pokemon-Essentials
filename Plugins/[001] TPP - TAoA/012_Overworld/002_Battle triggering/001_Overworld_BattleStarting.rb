module BattleCreationHelperMethods
  module_function
  
class << self
    alias_method :vr_set_outcome, :set_outcome
  def set_outcome(outcome, outcome_variable = 1, trainer_battle = false)
    vr_set_outcome(outcome, outcome_variable = 1, trainer_battle = false)
	case outcome
	when 1
      $game_variables[130] += 1 if $game_map&.metadata&.has_flag?("VRTraining")
      echoln "Puppets Defeated/Total: \v[130]/\v[129]" if $DEBUG && $game_map&.metadata&.has_flag?("VRTraining")
	end
  end
end
end