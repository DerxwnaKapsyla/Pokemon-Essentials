#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Removed explicit references to Pokemon
#==============================================================================#

def pbStorePokemon(pkmn)
  if pbBoxesFull?
    pbMessage(_INTL("There's no more room in the box!\1"))
    pbMessage(_INTL("They are full and can't accept any more!"))
    return
  end
  pkmn.record_first_moves
  if $Trainer.party_full?
    oldcurbox = $PokemonStorage.currentBox
    storedbox = $PokemonStorage.pbStoreCaught(pkmn)
    curboxname = $PokemonStorage[oldcurbox].name
    boxname = $PokemonStorage[storedbox].name
    creator = nil
    creator = pbGetStorageCreator if $Trainer.seen_storage_creator
    if storedbox != oldcurbox
      if creator
        pbMessage(_INTL("Box \"{1}\" on {2}'s PC was full.\1", curboxname, creator))
      else
        pbMessage(_INTL("Box \"{1}\" on someone's PC was full.\1", curboxname))
      end
      pbMessage(_INTL("{1} was transferred to box \"{2}.\"", pkmn.name, boxname))
    else
      if creator
        pbMessage(_INTL("{1} was transferred to {2}'s PC.\1", pkmn.name, creator))
      else
        pbMessage(_INTL("{1} was transferred to someone's PC.\1", pkmn.name))
      end
      pbMessage(_INTL("It was stored in box \"{1}.\"", boxname))
    end
  else
    $Trainer.party[$Trainer.party.length] = pkmn
  end
end

def pbNicknameAndStore(pkmn)
  if pbBoxesFull?
    pbMessage(_INTL("There's no more in the box!\1"))
    pbMessage(_INTL("They are full and can't accept any more!"))
    return
  end
  $Trainer.pokedex.set_seen(pkmn.species)
  $Trainer.pokedex.set_owned(pkmn.species)
  pbNickname(pkmn)
  pbStorePokemon(pkmn)
end

def pbAddPokemon(pkmn, level = 1, see_form = true)
  return false if !pkmn
  if pbBoxesFull?
    pbMessage(_INTL("There's no more room for Pokémon!\1"))
    pbMessage(_INTL("The Pokémon Boxes are full and can't accept any more!"))
    return false
  end
  pkmn = Pokemon.new(pkmn, level) if !pkmn.is_a?(Pokemon)
  species_name = pkmn.speciesName
  if $game_map && $game_map.map_id==18 # Derx: If the player is on Map 18 (Oak's Lab - 2F)
	pbMessage(_INTL("{1} received the {2} from Professor Oak!\\me[Pkmn get]\\wtnp[80]",$Trainer.name,species_name))
  else
	pbMessage(_INTL("{1} obtained {2}!\\me[Pkmn get]\\wtnp[80]\1", $Trainer.name, species_name))
  end
  pbNicknameAndStore(pkmn)
  $Trainer.pokedex.register(pkmn) if see_form
  return true
end