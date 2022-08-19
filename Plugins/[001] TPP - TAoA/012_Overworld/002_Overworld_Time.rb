#==============================================================================#
#                             Touhou Puppet Play                               #
#                          The Adventures of Ayaka                             #
#==============================================================================#
# Changes in this section include the following:
#	* Makes it so that if the player is playing The Mansion of Mystery, that
#	  all outside maps will always be dark.
#==============================================================================#

def pbDayNightTint(object)
  return if !$scene.is_a?(Scene_Map)
  if $game_variables[105] == 1 && $game_map.metadata&.outdoor_map # Check if the player is currently playing through The Mansion of Mystery
	object.tone.set(-70, -70, 11, 68)
  elsif Settings::TIME_SHADING && $game_map.metadata&.outdoor_map
    tone = PBDayNight.getTone
    object.tone.set(tone.red, tone.green, tone.blue, tone.gray)
  else
    object.tone.set(0, 0, 0, 0)
  end
end