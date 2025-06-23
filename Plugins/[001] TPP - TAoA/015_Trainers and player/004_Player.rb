class Player < Trainer
  attr_accessor :scenario_name
  attr_accessor :new_game_plus
  attr_accessor :tmom_cleared
  attr_accessor :tfoc_cleared
  attr_accessor :tkol_cleared
  attr_accessor :tla_cleared
  
  alias taoa_initialize initialize
  def initialize(name, trainer_type)
	taoa_initialize(name, trainer_type)
	@scenario_name         = "The Adventures of Ayaka"
	@new_game_plus		   = false
	@tmom_cleared          = false
	@tfoc_cleared          = false
	@tkol_cleared          = false
	@tla_cleared           = false
  end
end
