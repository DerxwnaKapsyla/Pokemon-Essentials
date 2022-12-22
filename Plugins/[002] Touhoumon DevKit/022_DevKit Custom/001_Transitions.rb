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
    next $game_map && $game_switches[104] && $game_variables[103] <= 40
  },
  proc { |viewport, battle_type, foe, location|   # Animation
    case $game_variables[103]    # check this variable, and depending on the number returned...
     when  0 then  pbCommonEvent(11)    # Vs. Keine
     when  1 then  pbCommonEvent(12)    # Vs. Marisa
     when  2 then  pbCommonEvent(13)    # Vs. Youmu
     when  3 then  pbCommonEvent(14)    # Vs. Lyrica
     when  4 then  pbCommonEvent(15)    # Vs. Mystia
     when  5 then  pbCommonEvent(16)    # Vs. Prismriver Sisters
     when  6 then  pbCommonEvent(17)    # Vs. Nue
     when  7 then  pbCommonEvent(18)    # Vs. Kogasa
     when  8 then  pbCommonEvent(19)    # Vs. Layla
	 when  9 then  pbCommonEvent(20)    # Vs. Doppel Device
	 
     when 10 then  pbCommonEvent(26)  # Vs. Kokoro
	 when 11 then  pbCommonEvent(27)  # Vs. Minoriko
	 when 12 then  pbCommonEvent(28)  # Vs. Nitori
	 when 13 then  pbCommonEvent(29)  # Vs. Hatate
	 when 14 then  pbCommonEvent(30)  # Vs. Hina
	 when 15 then  pbCommonEvent(31)  # Vs. Star
	 when 16 then  pbCommonEvent(32)  # Vs. Luna
	 when 17 then  pbCommonEvent(33)  # Vs. Sunny
	 when 18 then  pbCommonEvent(34)  # Vs. Three Fairies
	 when 19 then  pbCommonEvent(35)  # Vs. Medicine
	 when 20 then  pbCommonEvent(36)  # Vs. Elly
	 when 21 then  pbCommonEvent(37)  # Vs. Yuuka
	 when 22 then  pbCommonEvent(39)  # Vs. Keine
	 when 23 then  pbCommonEvent(40)  # Vs. Marisa
	 when 24 then  pbCommonEvent(41)  # Vs. Youmu
	 when 25 then  pbCommonEvent(42)  # Vs. Lyrica
	 when 26 then  pbCommonEvent(43)  # Vs. Mystia
	 when 27 then  pbCommonEvent(44)  # Vs. Prismrivers
	 when 28 then  pbCommonEvent(45)  # Vs. Alice
	 when 29 then  pbCommonEvent(46)  # Vs. Sanae
	 when 30 then  pbCommonEvent(47)  # Vs. Minoriko and Shizuha
	 when 31 then  pbCommonEvent(48)  # Vs. Suika
	 when 32 then  pbCommonEvent(49)  # Vs. Sumireko
	 when 33 then  pbCommonEvent(50)  # Vs. Gio
	 when 34 then  pbCommonEvent(51)  # Vs. Anura
	 when 35 then  pbCommonEvent(52)  # Vs. Renko and Maribel
	 when 36 then  pbCommonEvent(53)  # Vs. Kalypsa
	 when 37 then  pbCommonEvent(54)  # Reserved if necessary
	 when 38 then  pbCommonEvent(55)  # Reserved if necessary
	 when 39 then  pbCommonEvent(56)  # Reserved if necessary
	 when 40 then  pbCommonEvent(57)  # Vs. Doppel Device
    else
      raise "Custom animation #{$game_variables[103]} expected but not found somehow!"
    end
  }
)