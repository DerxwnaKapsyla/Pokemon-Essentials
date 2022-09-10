EventHandlers.add(:on_end_battle, :lamprey_counter,
  proc { |decision, canLose|
	if $game_switches[110] 		# Lamprey Eaten
	  if $game_variables[109] == 7
	    if GameData::MapMetadata.get($game_map.map_id)&.has_flag?("LampreyBlindness")
		  pbMessage(_INTL("\\pn feels her vision begin to worsen again..."))
		end
		$game_variables[109] = 0 			# Lamprey Eaten Counter
		$game_switches[110] = false 		# Lamprey Eaten Switch
		changeDarkCircleRadiusSlowly(96)
		#pbWait(10)
	  else
		$game_variables[109] += 1 # Lamprey Countdown
	  end
	  case decision
      when 2 		# Lose
		if !GameData::MapMetadata.get($game_map.map_id)&.has_flag?("LampreyBlindness")
		  $game_variables[109] = 0 			# Lamprey Eaten Counter
		  $game_switches[110] = false 		# Lamprey Eaten Switch
          endDarkCircle
		end
	  end
	end
  }
)