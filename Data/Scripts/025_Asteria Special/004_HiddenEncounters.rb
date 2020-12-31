# ---------------------------------------------------------------------------------------------------
# Hidden Encounters, made by Maruno (With edits by Derxwna)
# 
# This code will allow you to have more than the default number of encounters on any given map. If
# defined here, by default, a map will have a 20% chance to generate a Hidden Encounter, split up
# between several different entries as defined by an array in here. If a map has the encounter
# types (Water, Grass, Cave, Fishing, Rock Smash, Headbutt, etc), you can define their entries here.
# ---------------------------------------------------------------------------------------------------

#class PokemonEncounters
#  alias pbHiddenEncounteredPokemon pbEncounteredPokemon
#
#  def pbEncounteredPokemon(enctype, tries = 1)
#	mapid = $game_map.map_id
#    ret = pbHiddenEncounteredPokemon(enctype, tries)
#    return ret if !ret
#	case mapid
#		when 45, 46; if rand(100) < 30 # Route 1, Route 2
#			if EncounterTypes::EnctypeCompileDens[enctype] == 1
#				species = [getConst(PBSpecies,:PIDGEY), getConst(PBSpecies,:RATTATA), getConst(PBSpecies,:ODDISH), getConst(PBSpecies,:BELLSPROUT), getConst(PBSpecies,:SENTRET), getConst(PBSpecies,:SHINX)]
#				ret[0] = species[rand(species.length)]
#			end
#		  end
#		when 67; if rand(100) < 30 # Route 22
#			if EncounterTypes::EnctypeCompileDens[enctype] == 1 # Land Encounters
#				species = [getConst(PBSpecies,:SPEAROW), getConst(PBSpecies,:NIDORANfE), getConst(PBSpecies,:NIDORANmA), getConst(PBSpecies,:MANKEY), getConst(PBSpecies,:ZIGZAGOON), getConst(PBSpecies,:BIDOOF)]
#				ret[0] = species[rand(species.length)]
#			elsif EncounterTypes::EnctypeCompileDens[enctype] == 3 # Surfing Encounters
#				species = [getConst(PBSpecies,:PSYDUCK), getConst(PBSpecies,:SLOWPOKE), getConst(PBSpecies,:BUIZEL)]
#				ret[0] = species[rand(species.length)]
#			elsif [EncounterTypes::OldRod].include?(enctype) # Old Rod Encounters
#				species = [getConst(PBSpecies,:MAGIKARP)]
#				ret[0] = species[rand(species.length)]
#			elsif [EncounterTypes::GoodRod].include?(enctype) # Good Rod Encounters
#				species = [getConst(PBSpecies,:POLIWAG), getConst(PBSpecies,:GOLDEEN)]
#				ret[0] = species[rand(species.length)]
#			elsif [EncounterTypes::SuperRod].include?(enctype) # Super Rod Encounters
#				species = [getConst(PBSpecies,:PSYDUCK), getConst(PBSpecies,:SLOWPOKE), getConst(PBSpecies,:BUIZEL)]
#				ret[0] = species[rand(species.length)]
#			end
#		  end
#		end		
#    return ret
#  end
#end