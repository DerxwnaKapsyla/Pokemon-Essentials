#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Implementation of Cross-Map Self-Switch Setting
#==============================================================================#
class Interpreter
  def pbSetSelfSwitch2(map, eventid, switch_name, value)
    $game_self_switches[[map, eventid, switch_name]] = value
    $game_map.need_refresh = true
  end
end