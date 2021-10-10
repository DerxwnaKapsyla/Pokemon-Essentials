# --- Gym Rematch Protocol
def pbGymRematch
  if $game_switches[118] # Is a Gym Rematch currently in progress
	if $game_variables[129] == $game_variables[127] # Is the Gym you want to rematch the same one that has one # Value was initially 130 instead of 127. Do I need to go back?
	  if pbConfirmMessage(_INTL("You currently have a rematch in progress for this gym. Would you like to cancel it?"))
		pbMessage(_INTL("Canceling gym rematch."))
		$game_variables[130] = nil
		$game_switches[118] = false
		for event in $game_map.events.values
		  if event.name[/GT_/i]
			$game_self_switches[[$game_map.map_id,event.id,"B"]] = false
		  end
		end
		$game_map.refresh
	  end
	else
	  pbMessage(_INTL("You currently have a rematch in progress for {1}. Please complete your challenge there before challenging another gym to a rematch.",$game_variables[127]))
	end
  else 
	$game_variables[2] = pbSelectGymSet
	$game_variables[3] = $game_variables[2] - 1
  end
end

def pbSelectGymSet
  sets = [
    ["12", "14"],
    ["18", "21"],
    ["22", "25"],
    ["30", "36"],
    ["xx6", "yy6"],
    ["xx7", "yy7"],
    ["xx8", "yy8"],
    ["xx9", "yy9"],
    ["xx10", "yy10"],
    ["xx11", "yy11"],
    ["xx12", "yy12"],
    ["xx13", "yy13"],
    ["xx14", "yy14"],
    ["xx15", "yy15"],
    ["xx16", "yy16"]
  ]
  array = []
  ids = []
  sets.each_with_index do |range, i|
    next if !$game_variables[2][i + 1]
    array.push(_INTL("Set {1} (Lv.{2} - {3})", i + 1, range[0], range[1])) if $Trainer.badge_count >= i
    ids.push(i + 1)
  end
  array.push(_INTL("Cancel"))
  cmd = pbMessage("Which team selection should the Gym use?", array, -1)
  return 0 if cmd < 0 || cmd == array.length - 1   # Cancel
  return ids[cmd]
end