# ---------------------------------------------------------------------
# This code controls random Trainer Battles on a map. Nothing more,
# nothing less. It checks for a map ID and for a switch to be on.
# After that, it rolls a random number to determine the number of
# steps the player needs to take before it calls up the trainer.
#
# This is because I want there to be random trainer battles in
# the Human Village when the Fairies are pulling pranks on the
# villagers. Divebomb Attacks!
# ---------------------------------------------------------------------
class PokemonTemp
  attr_accessor :randBatt
end

def pbRandBattCancel
  $PokemonTemp.randBatt = nil
end

EventHandlers.add(:on_player_step_taken, :divebomb_fairies,
  proc { |event|
  if $game_map.map_id == 37 && $game_switches[122] == true # Human Village and Divebomb Fairies set to be true
    $PokemonTemp.randBatt = rand(50..70) if $PokemonTemp.randBatt == nil
	#p $PokemonTemp.randBatt
    if $PokemonTemp.randBatt > 0 
      $PokemonTemp.randBatt -= 1
    else
	  next false if $game_temp.in_menu || $game_temp.menu_calling
	  pbMessage("Hee hee~ Incoming~")
	  $PokemonGlobal.nextBattleBGM = "B-021. Reverse Ideology.ogg"
	  trainer = [
		":FAIRY_1_ALT,\"Alphi\"", # Fairy Alphi
		":FAIRY_1_ALT,\"Betta\"", # Fairy Betta
		":FAIRY_2_ALT,\"Gamme\"", # Fairy Gamme
		":FAIRY_2_ALT,\"Epsil\"", # Fairy Epsil
		":FAIRY_G_ALT,\"Libra\"", # Greater Fairy Libra
		":FAIRY_G_ALT,\"Yunru\""  # Greater Fairy Yunru
		]
	  randtrainer = trainer[rand(trainer.size)]
	  setBattleRule("base","autumn_field")
      eval("TrainerBattle.start(#{randtrainer},pbGet(99))")
    end
  end
  }
)

EventHandlers.add(:on_leave_map, :divebomb_cancel,
  proc {
    pbRandBattCancel
  }
)

EventHandlers.add(:on_start_battle, :divebomb_cancel_2,
  proc {
    pbRandBattCancel
  }
)