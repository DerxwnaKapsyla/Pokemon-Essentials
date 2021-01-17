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
     when 0; pbCommonEvent(8)   # Vs. Red
     when 1; pbCommonEvent(9)   # Vs. Renko
     when 2; pbCommonEvent(10)  # Vs. Maribel
	 when 3; pbCommonEvent(11)	# Vs. Gym Leader
	 when 4; pbCommonEvent(34)  # Vs. Gold
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