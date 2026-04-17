#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Ensures that Amira Naxeroth will always be fought on the Starlight
#	  battle background. Because my shitposting is cosmic and interstellar.
#	  Out of this goddamn world.
#==============================================================================#
EventHandlers.add(:on_trainer_load, :shameless_self_insert,
  proc { |trainer|
    if trainer
      if trainer.name==("Amira Naxeroth")
        $PokemonGlobal.nextBattleBack = "starlight"
      end
    end
    }
)

#EventHandlers.add(:on_trainer_load, :junko,
#  proc { |trainer|
#    if trainer
#      if trainer.name==("Junko")
#        $PokemonGlobal.nextBattleBack = "starlight"
#      end
#    end
#    }
#)


EventHandlers.add(:on_wild_pokemon_created, :alter_shiny_rate,
  proc { |pkmn|
    if $PokemonGlobal.sake_active
      if rand(256) == 0
	    pkmn.shiny = true
		echoln "-------------------------------------------------------------------------------"
		echoln "Ancient Lunar Sake: Shiny Puppet generated."
		echoln "-------------------------------------------------------------------------------"
	  else
	    echoln "-------------------------------------------------------------------------------"
		echoln "Ancient Lunar Sake: Shiny Puppet not generated."
		echoln "-------------------------------------------------------------------------------"
	  end
    end
  }
)

EventHandlers.add(:on_trainer_load, :spirits_of_aggrivation,
  proc { |trainer|
    if trainer.trainer_type == :SPIRIT
        trainer.name = "Spirit"
    end
    }
)


# EventHandlers.add(:on_wild_pokemon_created, :pokemon_encounter,
    # proc { |pkmn|
      # next unless pkmn.species_data.has_flag?("Pokemon")
      # $PokemonGlobal.nextBattleBGM = pbStringToAudioFile("B-010. Battle vs. Hidden Encounter")
    # }
# )

#EventHandlers.add(:on_trainer_load, :make_trainer_shiny,
#  proc { |trainer|
#    if trainer
#	  for pkmn in trainer.party
#		pkmn.shiny = true if $game_switches[Settings::SHINY_WILD_POKEMON_SWITCH]
#	  end
#	end
#  }
#)

# Used in the Lunar Simulator Maps. Makes the levels of all wild Puppets in those
# maps depend on the levels of player's party.
# This is a simple method, and can/should be modified to account for evolutions
# and other such details.  Of course, you don't HAVE to use this code.
EventHandlers.add(:on_wild_pokemon_created, :level_depends_on_party,
  proc { |pkmn|
    next if !$game_map.metadata&.has_flag?("ScaleWildEncounterLevels")
    setBattleRule("canLose")
	setBattleRule("noMoney")
    setBattleRule("disablePokeBalls")
	new_level = pbBalancedLevel($player.party) - 4 + rand(5)   # For variety
    new_level = new_level.clamp(1, GameData::GrowthRate.max_level)
    pkmn.level = new_level
    pkmn.calc_stats
    pkmn.reset_moves
  }
)

EventHandlers.add(:on_wild_pokemon_created, :wild_music_override,
  proc { |pkmn|
    next if !$game_switches[98]
	  if pbGet(107) == 2
        setBattleRule("battleBGM", "W-004. Dimension of Reverie.ogg")
	  elsif pbGet(142) < 3
	    setBattleRule("battleBGM", "W-041. Magician of the Twilight.ogg")
	  end
    setBattleRule("victoryBGM", "")
  }
)

EventHandlers.add(:on_trainer_load, :trainer_music_override,
  proc { |trainer|
    next if !$game_switches[98]
	  if pbGet(107) == 2
        setBattleRule("battleBGM", "W-004. Dimension of Reverie.ogg")
	  elsif pbGet(142) < 3
	    setBattleRule("battleBGM", "W-041. Magician of the Twilight.ogg")
	  end
    setBattleRule("victoryBGM", "")
  }
)

EventHandlers.add(:on_trainer_load, :anomaly_override,
  proc { |trainer|
	if GameData::MapMetadata.get($game_map.map_id)&.has_flag?("CanRunFromTrainers")
      setBattleRule("battleIntroText", "A {1} appeared out of nowhere!")
      setBattleRule("setSlideSprite", "still")
    end
  }
)

EventHandlers.add(:on_trainer_load, :meimu_master_override,
  proc { |trainer|
    next if !$game_switches[157] # Fighting Meimu switch
	next if !$game_map.map_id == 137 # Main map
    setBattleRule("backdrop", "meimu")                          # Sets Meimu's Battle Background
    setBattleRule("base", "meimu")                              # Sets Meimu's Battle Base
    #setBattleRule("midbattleScript", :vs_meimu)
    if $game_variables[143] > 1                                 # Have Meimu's sprite stay in the same spot for subsequent battles.
      setBattleRule("setSlideSprite", "all-still")
    end
    if $game_variables[143] < 4
      setBattleRule("victoryBGM", "")                             # Nulls out victory music so theme can continue
    else
      setBattleRule("victoryBGM", "U-003. Victory! Gensokyo's Finest.ogg")
    end
  }
)

EventHandlers.add(:on_wild_species_chosen, :get_unique_encounter,
  proc { |pkmn|
  
  species = pkmn[0]
  level   = pkmn[1]
  
  echoln "-------------------------------------------------------------------------------"
  echoln "Checking if player has relevant item..."
  next false if !$bag.has?(:ANCIENTLUNARSAKE)
  echoln "Confirmed. Player has relevant item. Proceeding with modifier."
  
  echoln "Initial encounter: #{species}, Level #{level}."
  echoln "Checking if player owns #{species}..."
  
  if $player.owned?(species)
    echoln "Confirmed. #{species} is owned by the player."
	echoln "Executing reroll procedure."
	
	new_enc = nil
	500.times do
	  try_enc = $PokemonEncounters.choose_wild_pokemon($PokemonEncounters.encounter_type, 1)
	  echoln "New encounter: #{try_enc}"
	  unless $player.owned?(try_enc[0])
	    new_enc = try_enc
		break
	  end
	end
	
	if new_enc
	  echoln "Setting new encounter to #{new_enc[0]}."
	  echoln "-------------------------------------------------------------------------------"
	  pkmn[0] = new_enc[0]
	  pkmn[1] = new_enc[1]
	else
	  echoln "Limit on checks reached. Keeping original encounter."
	  echoln "-------------------------------------------------------------------------------"
	end
  else
    echoln "Negative. #{species} is not owned by the player."
	echoln "-------------------------------------------------------------------------------"
  end
  }
)