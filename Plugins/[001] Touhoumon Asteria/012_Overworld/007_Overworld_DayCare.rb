#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Removes explicit references to Pokemon
#==============================================================================#
def pbDayCareDeposit(index)
  for i in 0...2
    next if $PokemonGlobal.daycare[i][0]
    $PokemonGlobal.daycare[i][0] = $Trainer.party[index]
    $PokemonGlobal.daycare[i][1] = $Trainer.party[index].level
    $PokemonGlobal.daycare[i][0].heal
    $Trainer.party[index] = nil
    $Trainer.party.compact!
    $PokemonGlobal.daycareEgg      = 0
    $PokemonGlobal.daycareEggSteps = 0
    return
  end
  raise _INTL("No room to deposit")
end

def pbDayCareWithdraw(index)
  if !$PokemonGlobal.daycare[index][0]
    raise _INTL("There's nothing here...")
  elsif $Trainer.party_full?
    raise _INTL("Can't store anything else...")
  else
    $Trainer.party[$Trainer.party.length] = $PokemonGlobal.daycare[index][0]
    $PokemonGlobal.daycare[index][0] = nil
    $PokemonGlobal.daycare[index][1] = 0
    $PokemonGlobal.daycareEgg = 0
  end
end


#==============================================================================#
# Changes in this section include the following:
#	* Removes explicit references to Pokemon
#	* Changes the way text is displayed in the choice box to display Yin/Yang
#	  icons for gender.
#==============================================================================#
def pbDayCareChoose(text,variable)
  count = pbDayCareDeposited
  if count==0
    raise _INTL("There's nothing here...")
  elsif count==1
    $game_variables[variable] = ($PokemonGlobal.daycare[0][0]) ? 0 : 1
  else
    choices = []
    for i in 0...2
	  pkmn_data = GameData::Species.get_species_form(pokemon.species, pokemon.form)
      pokemon = $PokemonGlobal.daycare[i][0]
	  if pkmn_data.generation <20
        if pokemon.male?
		  choices.push(_ISPRINTF("<c3=585850,a8b8b8>{1:s} (<icon=yin>, Lv{2:d})</c3>",pokemon.name,pokemon.level))
		elsif pokemon.female? && pkmn_data == 20
          choices.push(_ISPRINTF("<c3=585850,a8b8b8>{1:s} (<icon=yang>, Lv{2:d})</c3>",pokemon.name,pokemon.level))
		else
		  choices.push(_ISPRINTF("{1:s} (Lv.{2:d})",pokemon.name,pokemon.level))
		end
	  else
		if pokemon.male?
          choices.push(_ISPRINTF("<c3=585850,a8b8b8>{1:s} (</c3><c3=0080f8,a8b8b8>♂</c3><c3=585850,a8b8b8>, Lv{2:d})</c3>",pokemon.name,pokemon.level))
		elsif pokemon.female?
          choices.push(_ISPRINTF("<c3=585850,a8b8b8>{1:s} (</c3><c3=f81818,a8b8b8>♀</c3><c3=585850,a8b8b8> Lv{2:d})</c3>",pokemon.name,pokemon.level))
		else
		  choices.push(_ISPRINTF("{1:s} (Lv.{2:d})",pokemon.name,pokemon.level))
	    end
      end
    end
    choices.push(_INTL("<c3=585850,a8b8b8>CANCEL</c3>"))
    command = pbMessageAlt(text,choices,choices.length)
    $game_variables[variable] = (command==2) ? -1 : command
  end
end

#==============================================================================#
# Changes in this section include the following:
#	* The addition of the pbHatchAll command, which is used in the Debug Menu
#==============================================================================#
def pbHatchAll
  for egg in $Trainer.party
    if egg.egg?
      egg.steps_to_hatch=0
      pbHatch(egg)
    end
  end
end