#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* The custom Vs. Transitions used by the Touhoumon DevKit.
#==============================================================================#

alias CustompbBattleAnimationOverride pbBattleAnimationOverride

def pbBattleAnimationOverride(viewport,battletype=0,foe=nil)
   if $game_map && $game_switches[104]       # If the switch for Custom Vs. Transitions is on,
     case $game_variables[103]   	 # check this variable, and depending on the number returned...
     when 0;  pbCommonEvent(8)   	 # Vs. Red
     when 1;  pbCommonEvent(9)   	 # Vs. Renko
     when 2;  pbCommonEvent(10)  	 # Vs. Maribel
	 when 3;  pbCommonEvent(11)	 	 # Vs. Gym Leader
	 when 4;  pbCommonEvent(34)  	 # Vs. Gold
	 when 5;  pbCommonEvent(28)  	 # Vs. Stratos
	 when 6;  pbCommonEvent(29)  	 # Vs. Astra
	 when 7;  pbCommonEvent(30)  	 # Vs. Celeste
	 when 8;  pbCommonEvent(31)  	 # Vs. Giovanni
	 when 9;  pbCommonEvent(32)  	 # Vs. Astra & Celeste
	 when 10; pbCommonEvent(65)	 	 # Vs. DLwRuukoto
	 when 11; pbCommonEvent(111)	 # Vs. Ayakashi (Puppet)
	 when 12; pbCommonEvent(111)	 # Vs. Marisa Omega (Puppet)
	 when 13; pbCommonEvent(111)	 # Vs. Yuyuko Omega (Puppet)
	 when 14; pbCommonEvent(111)	 # Vs. Sariel Omega (Puppet)
	 when 15; pbCommonEvent(14)		 # Vs. Selene
     end
     return true                # Note that the battle animation is done
   end  
  return CustompbBattleAnimationOverride(viewport,battletype,foe)
end