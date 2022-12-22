class Player < Trainer
  attr_accessor :scenario_name
  attr_accessor :new_game_plus
  
  alias taoa_initialize initialize
  def initialize(name, trainer_type)
	taoa_initialize(name, trainer_type)
	@scenario_name         = "The Adventures of Ayaka"
	@new_game_plus		   = false
  end
end
