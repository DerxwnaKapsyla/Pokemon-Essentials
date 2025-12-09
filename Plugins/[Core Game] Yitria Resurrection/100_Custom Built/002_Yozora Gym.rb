def check_player_tile
  # Check to make sure the player is in Yozora Gym
  if GameData::MapMetadata.get($game_map.map_id)&.has_flag?("YozoraGym")
    # Next, check if the player has the Time Remote
	if $bag.has?(:TIMEREMOTE)
      # Next, check their tiles, starting with...
	  case [$game_player.x, $game_player.y]
	  # Sun Mode -> Night Mode
	  when [35, 15]                      # Warp A
	    pbSet(1,  7)                     # X Coordinate
		pbSet(2, 15)                     # Y Coordinate
	  when [45, 19]                      # Warp B
	    pbSet(1, 17)                     # X Coordinate
		pbSet(2, 19)                     # Y Coordinate
	  when [36, 12]                      # Warp C
	    pbSet(1,  8)                     # X Coordinate
		pbSet(2, 12)                     # Y Coordinate
	  when [43,  6]                      # Warp D
	    pbSet(1, 15)                     # X Coordinate
		pbSet(2,  6)                     # Y Coordinate
	  # Night Mode -> Sun Mode
	  when [ 7, 15]                      # Warp A
	    pbSet(1, 35)                     # X Coordinate
		pbSet(2, 15)                     # Y Coordinate
	  when [17, 19]                      # Warp B
	    pbSet(1, 45)                     # X Coordinate
		pbSet(2, 19)                     # Y Coordinate
	  when [ 8, 12]                      # Warp C
	    pbSet(1, 36)                     # X Coordinate
		pbSet(2, 12)                     # Y Coordinate
	  when [15,  6]                      # Warp D
	    pbSet(1, 43)                     # X Coordinate
		pbSet(2,  6)                     # Y Coordinate
	  else
		return false
	  end
	  pbSet(3, $game_player.direction) # Retain player direction
      return true
	end
  end
  return false
end

def activate_time_remote
  return unless Input.trigger?(Input::ALT) && $bag.has?(:TIMEREMOTE)
  return if $game_switches[115]
  
  $game_switches[115] = true
  
  if check_player_tile 
    pbMessage(_INTL("Adjusting simulated time."))
	pbWait(0.001)
	$game_temp.player_new_map_id    = 123 # Yozora Gym
    $game_temp.player_new_x         = pbGet(1)
    $game_temp.player_new_y         = pbGet(2)
    $game_temp.player_new_direction = pbGet(3)
    $scene.transfer_player if $scene.is_a?(Scene_Map)
    $game_map.refresh
	pbWait(0.001)
	$game_switches[115] = false
  else
    pbMessage(_INTL("The remote doesn't seem to be responding..."))
	$game_switches[115] = false
  end
end