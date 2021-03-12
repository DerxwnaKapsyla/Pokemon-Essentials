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

Events.onStepTaken += proc {
  if $game_map.map_id == 3 && $game_switches[110] == true # Human Village and Divebomb Fairies set to be true
    $PokemonTemp.randBatt = rand(50..70) if $PokemonTemp.randBatt == nil
	#p $PokemonTemp.randBatt
    if $PokemonTemp.randBatt > 0 
      $PokemonTemp.randBatt -= 1
    else
	  next false if $game_temp.in_menu || $game_temp.menu_calling
	  pbMessage("Hee hee~ Incoming~")
	  $PokemonGlobal.nextBattleBGM = "B-010. Reverse Ideology.ogg"
	  trainer = [
		":FAIRY_1,\"Alphi\"", # Fairy Alphi
		":FAIRY_1,\"Betta\"", # Fairy Betta
		":FAIRY_2,\"Gamme\"", # Fairy Gamme
		":FAIRY_2,\"Epsil\"", # Fairy Epsil
		":FAIRY_G,\"Libra\"", # Greater Fairy Libra
		":FAIRY_G,\"Yunru\""  # Greater Fairy Yunru
		]
	  randtrainer = trainer[rand(trainer.size)]
      eval("pbTrainerBattle(#{randtrainer})")
    end
  end
}

Events.onMapChange += proc { |sender, e|
  pbRandBattCancel
}

Events.onStartBattle += proc { |sender, e|
  pbRandBattCancel
}