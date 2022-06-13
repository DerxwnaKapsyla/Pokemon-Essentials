#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Removed explicit references to Pokemon. Now featuring Shadows!
#==============================================================================#
def pbMoveTutorChoose(move, movelist = nil, bymachine = false, oneusemachine = false)
  ret = false
  move = GameData::Move.get(move).id
  if movelist.is_a?(Array)
    movelist.map! { |m| GameData::Move.get(m).id }
  end
  pbFadeOutIn {
    movename = GameData::Move.get(move).name
    annot = pbMoveTutorAnnotations(move, movelist)
    scene = PokemonParty_Scene.new
    screen = PokemonPartyScreen.new(scene, $player.party)
    screen.pbStartScene(_INTL("Whom should be taught?"), false, annot)
    loop do
      chosen = screen.pbChoosePokemon
      break if chosen < 0
      pokemon = $player.party[chosen]
      if pokemon.egg?
        pbMessage(_INTL("Eggs can't be taught any moves.")) { screen.pbUpdate }
      elsif pokemon.shadowPokemon?
        pbMessage(_INTL("Those with their hearts shut can't be taught any moves.")) { screen.pbUpdate }
      elsif movelist && movelist.none? { |j| j == pokemon.species }
        pbMessage(_INTL("{1} can't learn {2}.", pokemon.name, movename)) { screen.pbUpdate }
      elsif !pokemon.compatible_with_move?(move)
        pbMessage(_INTL("{1} can't learn {2}.", pokemon.name, movename)) { screen.pbUpdate }
      elsif pbLearnMove(pokemon, move, false, bymachine) { screen.pbUpdate }
        $stats.moves_taught_by_item += 1 if bymachine
        $stats.moves_taught_by_tutor += 1 if !bymachine
        pokemon.add_first_move(move) if oneusemachine
        ret = true
        break
      end
    end
    screen.pbEndScene
  }
  return ret   # Returns whether the move was learned by a Pokemon
end

# Derx: Commented out for now as who knows, maybe v20 handled this better!!!!
#def pbExclaim(event,id=Settings::EXCLAMATION_ANIMATION_ID,tinting=false)
#  if event.is_a?(Array)
#    sprite = nil
#    done = []
#    for i in event
#      if !done.include?(i.id)
#        sprite = $scene.spriteset.addUserAnimation(id,i.x,i.y-1,tinting,2)
#        done.push(i.id)
#      end
#    end
#  else
#    sprite = $scene.spriteset.addUserAnimation(id,event.x,event.y-1,tinting,2)
#  end
#  while !sprite.disposed?
#    Graphics.update
#    Input.update
#    pbUpdateSceneMap
#  end
#end