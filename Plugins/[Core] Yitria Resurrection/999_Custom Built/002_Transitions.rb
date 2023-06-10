#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* The custom Vs. Transitions used by the Touhoumon DevKit.
#==============================================================================#
SpecialBattleIntroAnimations.register("derx_animations", 100,   # Priority 100
  proc { |battle_type, foe, location|   # Condition
    next $game_map && $game_switches[104] && $game_variables[103] <= 1
  },
  proc { |viewport, battle_type, foe, location|   # Animation
    case $game_variables[103]
    when 0  then pbCommonEvent(6)     # Vs. Alyssia
	when 1  then pbCommonEvent(9)     # Vs. Gym Leader
	#when 99  then pbCommonEvent(9)     # Vs. Enigma Brigade Commanders
	#when 99  then pbCommonEvent(9)     # Vs. Kotonoji
	#when 99  then pbCommonEvent(9)     # Vs. Elite 4
	#when 99  then pbCommonEvent(9)     # Vs. Champion
	#when 99  then pbCommonEvent(9)     # Vs. Grand League
	#when 99  then pbCommonEvent(9)     # Vs. Doppel Device
	# --- Special Trainers below here ---
    else
      raise "Custom animation #{$game_variables[103]} expected but not found somehow!"
    end
  }
)