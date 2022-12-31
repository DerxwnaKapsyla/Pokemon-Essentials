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
    next $game_map && $game_switches[104] && $game_variables[103] <= 10
  },
  proc { |viewport, battle_type, foe, location|   # Animation
    case $game_variables[103]    # check this variable, and depending on the number returned...
     when  0 then  pbCommonEvent(8)    # Vs. Tenshi Omega
    else
      raise "Custom animation #{$game_variables[103]} expected but not found somehow!"
    end
  }
)