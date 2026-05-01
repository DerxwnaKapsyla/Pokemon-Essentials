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

EventHandlers.add(:on_wild_pokemon_created, :pokemon_encounter,
    proc { |pkmn|
      next unless pkmn.species_data.has_flag?("Pokemon")
      $PokemonGlobal.nextBattleBGM = pbStringToAudioFile("B-010. Battle vs. Hidden Encounter")
    }
)

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
#EventHandlers.add(:on_trainer_load, :make_trainer_shiny,
#  proc { |trainer|
#    if trainer
#	  for pkmn in trainer.party
#		pkmn.shiny = true if $game_switches[Settings::SHINY_WILD_POKEMON_SWITCH]
#	  end
#	end
#  }
#)
EventHandlers.add(:on_wild_species_chosen, :get_unique_encounter,
  proc { |pkmn|
  
  species = pkmn[0]
  level   = pkmn[1]
  echoln "-------------------------------------------------------------------------------"
  echoln "Checking if player has enabled the option for the Ancient Lunar Sake."
  next false if $PokemonSystem.lunarsakepassive != 1
  echoln "Confirmed. Player has activated the passive effect of the Ancient Lunar Sake."
  echoln "-------------------------------------------------------------------------------"
  echoln "Checking if player has relevant item..."
  next false if !$bag.has?(:ANCIENTLUNARSAKE)
  echoln "Confirmed. Player has relevant item. Proceeding with modifier."
  echoln "-------------------------------------------------------------------------------"
  echoln "Initial encounter: #{species}, Level #{level}."
  echoln "Checking if player owns #{species}..."
  
  if $player.owned?(species)
    echoln "Confirmed. #{species} is owned by the player."
	echoln "Executing reroll procedure."
	
	new_enc = nil
	500.times do
	  if $game_temp.fishing_success
	    try_enc = $PokemonEncounters.choose_wild_pokemon(:GoodRod)
	  else
	    try_enc = $PokemonEncounters.choose_wild_pokemon($PokemonEncounters.encounter_type, 1)
	  end
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
  $game_temp.fishing_success = false
  }
)

class PokemonSystem
  attr_accessor :lunarsakepassive


  alias sake_passive_initialize initialize
  def initialize
    sake_passive_initialize
	@lunarsakepassive = 0 # Off or On.
  end
end

MenuHandlers.add(:options_menu, :lunar_sake_passive, {
  "name"        => _INTL("Lunar Sake Passive"),
  "order"       => 200,
  "type"        => EnumOption,
  "parameters"  => [_INTL("No"), _INTL("Yes")],
  "description" => _INTL("Should the Ancient Lunar Sake attempt to generate unique encounters?"),
  "get_proc"    => proc { next $PokemonSystem.lunarsakepassive },
  "set_proc"    => proc { |value, _scene| 
                           $PokemonSystem.lunarsakepassive = value 
						   echoln $PokemonSystem.lunarsakepassive = value}
})

class Game_Temp
  attr_accessor :fishing_success             # Is the player in a post-successful fishing state
  
  alias fishing_initialize initialize
  def initialize
    fishing_initialize
	@fishing_success = false
  end
end