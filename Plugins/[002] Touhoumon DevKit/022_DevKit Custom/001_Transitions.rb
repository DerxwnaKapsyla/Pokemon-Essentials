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
    next $game_map && $game_switches[104] && $game_variables[103] <= 8
  },
  proc { |viewport, battle_type, foe, location|   # Animation
    case $game_variables[103]    # check this variable, and depending on the number returned...
     when  0 then  pbCommonEvent(11)    # Vs. Keine
     when  1 then  pbCommonEvent(12)    # Vs. Marisa
     when  2 then  pbCommonEvent(12)    # Vs. Youmu
     when  3 then  pbCommonEvent(14)    # Vs. Lyrica
     when  4 then  pbCommonEvent(15)    # Vs. Mystia
     when  5 then  pbCommonEvent(16)    # Vs. Prismriver Sisters
     when  6 then  pbCommonEvent(17)    # Vs. Nue
     when  7 then  pbCommonEvent(18)    # Vs. Kogasa
     when  8 then  pbCommonEvent(19)    # Vs. Layla
    else
      raise "Custom animation #{$game_variables[103]} expected but not found somehow!"
    end
  }
)