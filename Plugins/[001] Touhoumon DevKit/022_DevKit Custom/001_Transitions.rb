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
     case $game_variables[103]  # check this variable, and depending on the number returned...
     when 0; pbCommonEvent(6)   # Vs. Yukari
     when 1; pbCommonEvent(7)   # Vs. Eirin
     when 2; pbCommonEvent(8)   # Vs. Byakuren
     when 3; pbCommonEvent(9)   # Vs. Eiki
     when 4; pbCommonEvent(10)  # Vs. Shinki
     when 5; pbCommonEvent(12)  # Vs. Derxwna
     when 6; pbCommonEvent(13)   # Vs. Nue
     when 7; pbCommonEvent(14)   # Vs. The Collector
     when 8; pbCommonEvent(15)   # Vs. Renko
     when 9; pbCommonEvent(16)   # Vs. Maribel
     when 10; pbCommonEvent(18)  # Vs. Sariel (Puppet)
     end
     return true                # Note that the battle animation is done
   end  
  return CustompbBattleAnimationOverride(viewport,battletype,foe)
end