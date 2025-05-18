class GameStats
  attr_accessor  :trainer_battles_lost_tmom


  alias taoa_init initialize
  def initialize
    taoa_init
	@trainer_battles_lost_tmom = 0
  end
end