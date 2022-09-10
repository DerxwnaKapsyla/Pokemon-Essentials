class Player < Trainer
  attr_accessor :scenario_name
  
  alias taoa_initialize initialize
  def initialize(name, trainer_type)
	taoa_initialize(name, trainer_type)
	@scenario_name         = "The Adventures of Ayaka"
  end
end
