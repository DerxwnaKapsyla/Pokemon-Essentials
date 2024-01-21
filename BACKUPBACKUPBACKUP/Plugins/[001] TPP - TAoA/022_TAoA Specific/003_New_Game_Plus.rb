#===============================================================================
# New Game Plus setup for The Adventures of Ayaka
#===============================================================================
# This makes it so all events have their self switch flags get reset when 
# you visit their map if the New Game Plus flag is switched on.
# This works for both The Mansion of Mystery and The Festival of Curses, and the
# eventual third game.
#
# This does not control resetting global switches or variables, those will be
# handled in the event warp at The Tower of Adventure.
#===============================================================================
#EventHandlers.add(:on_game_map_setup, :new_game_plus,
#  proc { |map_id, map|
#    reset_maps = []
#	if $game_switches[107] && !@reset_maps.include?($game_map.map_id)
#      $game_map.events.each_value do |event|
#        $game_self_switches[[$game_map.map_id, event.id, "A"]] = false
#        $game_self_switches[[$game_map.map_id, event.id, "B"]] = false
#		$game_self_switches[[$game_map.map_id, event.id, "C"]] = false
#		$game_self_switches[[$game_map.map_id, event.id, "D"]] = false
#      end
#	  reset_maps.push $game_map.map_id
#	end
#  }
#}

class PokemonGlobalMetadata
  def reset_maps
    @reset_maps = [] if !@reset_maps
    return @reset_maps
  end
end

EventHandlers.add(:on_game_map_setup, :new_game_plus,
  proc { |map_id, map, _tileset_data|
    if $game_switches[107] && !$PokemonGlobal.reset_maps[map_id] && map_id != 19
      map.events.each_value do |event|
        $game_self_switches[[map_id, event.id, "A"]] = false
        $game_self_switches[[map_id, event.id, "B"]] = false
        $game_self_switches[[map_id, event.id, "C"]] = false
        $game_self_switches[[map_id, event.id, "D"]] = false
      end
      $PokemonGlobal.reset_maps[map_id] = true
    end
  }
)