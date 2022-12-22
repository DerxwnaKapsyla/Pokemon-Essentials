#==============================================================================#
#                             Touhou Puppet Play                               #
#                          The Adventures of Ayaka                             #
#==============================================================================#
# Changes in this section include the following:
#	* Makes it so that if the player is playing The Mansion of Mystery, that
#	  it will always be night.
#	* Makes it so that if the player is playing The Festival of Cureses, that
#	  it will always be day.
#==============================================================================#
def pbGetTimeNow
  if GameData::MapMetadata.get($game_map.map_id)&.has_flag?("TMoM")
    now = Time.now
    return Time.local(now.year,now.month,now.day, 23, 0)
  elsif GameData::MapMetadata.get($game_map.map_id)&.has_flag?("TFoC")
    now = Time.now
    return Time.local(now.year,now.month,now.day, 12, 0)
  end
  return Time.now
end


#def pbDayNightTint(object)
#  return if !$scene.is_a?(Scene_Map)
#  if $game_map.metadata&.outdoor_map
#    if Settings::TIME_SHADING
#      tone = PBDayNight.getTone
#      object.tone.set(tone.red, tone.green, tone.blue, tone.gray)
#    elsif playerIsInMansionOfMystery?
#      object.tone.set(-70, -70, 11, 68)
#    end
#  else
#    object.tone.set(0, 0, 0, 0)
#  end
#end

#def playerIsInMansionOfMystery?
#  return $game_variables[105] == 1
#end

#def playerIsInFestivalOfCurses?
#  return $game_variables[105] == 2
#end