################################################################################
# This section was created solely for you to put various bits of code that
# modify various wild Pokémon and trainers immediately prior to battling them.
# Be sure that any code you use here ONLY applies to the Pokémon/trainers you
# want it to apply to!
################################################################################

# Make all wild Pokémon shiny while a certain Switch is ON (see Settings).
Events.onWildPokemonCreate += proc { |_sender, e|
  pokemon = e[0]
  if $game_switches[SHINY_WILD_POKEMON_SWITCH]
    pokemon.makeShiny
  end
}

# Used in the random dungeon map.  Makes the levels of all wild Pokémon in that
# map depend on the levels of Pokémon in the player's party.
# This is a simple method, and can/should be modified to account for evolutions
# and other such details.  Of course, you don't HAVE to use this code.
Events.onWildPokemonCreate += proc { |_sender, e|
  pokemon = e[0]
  if $game_map.map_id == 51
    max_level = PBExperience.maxLevel
    new_level = pbBalancedLevel($Trainer.party) - 4 + rand(5)   # For variety
    new_level = 1 if new_level < 1
    new_level = max_level if new_level > max_level
    pokemon.level = new_level
    pokemon.calcStats
    pokemon.resetMoves
  end
}

# --- Derx: Utilized Special Wild Battles to give Pokemon unique moves or preset abilities
# Make all wild Pokémon have a certain unique move or preset ability depending on the variable set.
Events.onWildPokemonCreate+=proc {|sender,e|
   pokemon=e[0]
   case $game_variables[109] # Unique Move/Preset Ability Variable
     when 1 # Kazami Event Battle
		if $game_map.map_id == 186
			pokemon.makeFemale # To keep the gender consistent
			pokemon.setAbility(0) # Sets Overgrow
			pokemon.pbLearnMove(:VINEWHIP18)
			pokemon.pbLearnMove(:REST18)
			pokemon.pbLearnMove(:SCARYFACE18)
			pokemon.pbLearnMove(:YAWN18)
			pokemon.setNature(:QUIET) # Raises Sp.Atk, Lowers Speed
			pokemon.makeNotShiny # Because idk if I can guarantee this when you don't catch it in a standard way
			pokemon.calcStats
		end
     when 2 # Kazami Event Battle, Round 2
		if $game_map.map_id == 186
			pokemon.makeFemale # To keep the gender consistent
			pokemon.setAbility(0) # Sets Overgrow
			pokemon.pbLearnMove(:HYPERBEAM18)
			pokemon.pbLearnMove(:LEAFBLADE18)
			pokemon.pbLearnMove(:INGRAIN18)
			pokemon.pbLearnMove(:TAUNT18)
			pokemon.setNature(:QUIET) # Raises Sp.Atk, Lowers Speed
			pokemon.makeNotShiny # Because idk if I can guarantee this when you don't catch it in a standard way
			pokemon.calcStats
		end
   end
}
# --- Derx: End of Unique Move handler

# This is the basis of a trainer modifier.  It works both for trainers loaded
# when you battle them, and for partner trainers when they are registered.
# Note that you can only modify a partner trainer's Pokémon, and not the trainer
# themselves nor their items this way, as those are generated from scratch
# before each battle.
#Events.onTrainerPartyLoad += proc { |_sender, e|
#  if e[0] # Trainer data should exist to be loaded, but may not exist somehow
#    trainer = e[0][0] # A PokeBattle_Trainer object of the loaded trainer
#    items = e[0][1]   # An array of the trainer's items they can use
#    party = e[0][2]   # An array of the trainer's Pokémon
#    YOUR CODE HERE
#  end
#}
