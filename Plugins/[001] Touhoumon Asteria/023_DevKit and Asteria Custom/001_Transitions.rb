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
    next $game_map && $game_switches[104] && $game_variables[103] <= 16
  },
  proc { |viewport, battle_type, foe, location|   # Animation
    case $game_variables[103]
    when 0  then pbCommonEvent(8)     # Vs. Red
    when 1  then pbCommonEvent(9)     # Vs. Renko
    when 2  then pbCommonEvent(10)    # Vs. Maribel
    when 3  then pbCommonEvent(11)    # Vs. Gym Leader
    when 4  then pbCommonEvent(34)    # Vs. Gold
    when 5  then pbCommonEvent(28)    # Vs. Stratos
    when 6  then pbCommonEvent(29)    # Vs. Astra
    when 7  then pbCommonEvent(30)    # Vs. Celeste
    when 8  then pbCommonEvent(31)    # Vs. Giovanni
    when 9  then pbCommonEvent(32)    # Vs. Astra & Celeste
    when 10 then pbCommonEvent(65)    # Vs. DLwRuukoto
    when 11 then pbCommonEvent(111)   # Vs. Ayakashi (Puppet)
    when 12 then pbCommonEvent(111)   # Vs. Marisa Omega (Puppet)
    when 13 then pbCommonEvent(111)   # Vs. Yuyuko Omega (Puppet)
    when 14 then pbCommonEvent(111)   # Vs. Sariel Omega (Puppet)
    when 15 then pbCommonEvent(14)    # Vs. Selene
    when 16 then pbCommonEvent(123)   # Vs. Sabrina (Double Battle)
    else
      raise "Custom animation #{$game_variables[103]} expected but not found somehow!"
    end
  }
)