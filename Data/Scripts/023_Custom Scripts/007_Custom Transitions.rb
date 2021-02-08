# If you want to add a custom battle intro animation, copy the following alias
# line and method into a new script section. Change the name of the alias part
# ("__over1__") in your copied code in both places. Then add in your custom
# transition code in the place shown.
# Note that $game_temp.background_bitmap contains an image of the current game
# screen.
# When the custom animation has finished, the screen should have faded to black
# somehow.

alias CustompbBattleAnimationOverride pbBattleAnimationOverride

def pbBattleAnimationOverride(viewport,battletype=0,foe=nil)
   if $game_map && $game_switches[104]       # If the switch for Custom Vs. Transitions is on,
     case $game_variables[103]  # check this variable, and depending on the number returned...
     when 0;  pbCommonEvent(9)   # Vs. Kokoro
	 when 1;  pbCommonEvent(10)  # Vs. Minoriko
	 when 2;  pbCommonEvent(11)  # Vs. Nitori
	 when 3;  pbCommonEvent(12)  # Vs. Hatate
	 when 4;  pbCommonEvent(13)  # Vs. Hina
	 when 5;  pbCommonEvent(14)  # Vs. Star
	 when 6;  pbCommonEvent(15)  # Vs. Luna
	 when 7;  pbCommonEvent(16)  # Vs. Sunny
	 when 8;  pbCommonEvent(17)  # Vs. Three Fairies
	 when 9;  pbCommonEvent(18)  # Vs. Medicine
	 when 10; pbCommonEvent(19)  # Vs. Elly
	 when 11; pbCommonEvent(20)  # Vs. Yuuka
	 when 12; pbCommonEvent(21)  # Vs. Keine
	 when 13; pbCommonEvent(22)  # Vs. Marisa
	 when 14; pbCommonEvent(23)  # Vs. Youmu
	 when 15; pbCommonEvent(24)  # Vs. Lyrica
	 when 16; pbCommonEvent(25)  # Vs. Mystia
	 when 17; pbCommonEvent(26)  # Vs. Prismrivers
	 when 18; pbCommonEvent(27)  # Vs. Alice
	 when 19; pbCommonEvent(28)  # Vs. Sanae
	 when 20; pbCommonEvent(29)  # Vs. Minoriko and Shizuha
	 when 21; pbCommonEvent(30)  # Vs. Suika
	 when 22; pbCommonEvent(31)  # Vs. Sumireko
	 when 23; pbCommonEvent(32)  # Vs. Gio
	 when 24; pbCommonEvent(33)  # Vs. Kaliana
	 when 25; pbCommonEvent(34)  # Vs. Renko and Maribel
	 when 26; pbCommonEvent(35)  # Vs. Kalypsa
     end
     return true                # Note that the battle animation is done
   end  
  return CustompbBattleAnimationOverride(viewport,battletype,foe)
end





# Derx: Original after edits
#def pbBattleAnimationOverride(viewport,battletype=0,foe=nil)
#   if $game_map && $game_switches[122]       # If the switch for Custom Vs. Transitions is on,
#     case $game_variables[113]  # check this variable, and depending on the number returned...
#     when 0; pbCommonEvent(7)   # Vs. Alyssia
#     when 1; pbCommonEvent(1)   # Placeholder
#     end
#     return true                # Note that the battle animation is done
#   end  
#  return CustompbBattleAnimationOverride(viewport,battletype,foe)
#end