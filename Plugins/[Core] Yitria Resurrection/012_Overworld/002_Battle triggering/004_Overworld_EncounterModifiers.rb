EventHandlers.add(:on_wild_pokemon_created, :special_pokemon_encounters,
  proc { |pkmn|
   case $game_variables[108] # Unique Move Variable
     when 1 # Fury Attack Dunsparce
       pkmn.makeMale # To keep the gender consistent
       pkmn.add_first_move(:FURYATTACK)
	end
  }
)