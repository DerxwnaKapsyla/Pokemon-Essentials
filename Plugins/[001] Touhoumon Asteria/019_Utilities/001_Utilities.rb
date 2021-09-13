#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Removed explicit references to Pokemon... mostly.
#==============================================================================#
def pbMoveTutorChoose(move,movelist=nil,bymachine=false,oneusemachine=false)
  ret = false
  move = GameData::Move.get(move).id
  if movelist!=nil && movelist.is_a?(Array)
    for i in 0...movelist.length
      movelist[i] = GameData::Move.get(movelist[i]).id
    end
  end
  pbFadeOutIn {
    movename = GameData::Move.get(move).name
    annot = pbMoveTutorAnnotations(move,movelist)
    scene = PokemonParty_Scene.new
    screen = PokemonPartyScreen.new(scene,$Trainer.party)
    screen.pbStartScene(_INTL("Whom should be taught?"),false,annot)
    loop do
      chosen = screen.pbChoosePokemon
      break if chosen<0
      pokemon = $Trainer.party[chosen]
      if pokemon.egg?
        pbMessage(_INTL("Eggs can't be taught any moves.")) { screen.pbUpdate }
      elsif pokemon.shadowPokemon?
        pbMessage(_INTL("Shadow Pokémon can't be taught any moves.")) { screen.pbUpdate } # Derx: Too awkward to change rn...
      elsif movelist && !movelist.any? { |j| j==pokemon.species }
        pbMessage(_INTL("{1} can't learn {2}.",pokemon.name,movename)) { screen.pbUpdate }
      elsif !pokemon.compatible_with_move?(move)
        pbMessage(_INTL("{1} can't learn {2}.",pokemon.name,movename)) { screen.pbUpdate }
      else
        if pbLearnMove(pokemon,move,false,bymachine) { screen.pbUpdate }
          pokemon.add_first_move(move) if oneusemachine
          ret = true
          break
        end
      end
    end
    screen.pbEndScene
  }
  return ret   # Returns whether the move was learned by a Pokemon
end