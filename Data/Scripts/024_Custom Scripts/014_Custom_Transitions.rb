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
   if $game_map && $game_switches[122]       # If the switch for Custom Vs. Transitions is on,
     case $game_variables[113]  # check this variable, and depending on the number returned...
     when 0; pbCommonEvent(7)   # Vs. Alyssia
     when 1; pbCommonEvent(9)   # Vs. Lazarus
     when 2; pbCommonEvent(10)  # Vs. Matthew
     when 3; pbCommonEvent(11)  # Vs. Joshua
     when 4; pbCommonEvent(12)  # Vs. Lindsey
     when 5; pbCommonEvent(13)  # Vs. Serafina
     when 6; pbCommonEvent(14)  # Vs. Phoebe & Deimos
     when 7; pbCommonEvent(15)  # Vs. Lifrana
     when 8; pbCommonEvent(16)  # Vs. Carrie
     when 9; pbCommonEvent(18)  # Vs. Elizabeth
     when 10; pbCommonEvent(19)  # Vs. Cecilia
     when 11; pbCommonEvent(20)  # Vs. Chester
     when 12; pbCommonEvent(21)  # Vs. Mitchell
     when 13; pbCommonEvent(22)  # Vs. Alexander
     when 14; pbCommonEvent(24)  # Vs. Delta
     when 15; pbCommonEvent(25)  # Vs. Iota
     when 16; pbCommonEvent(26)  # Vs. Delta & Iota
     when 17; pbCommonEvent(27)  # Vs. Kagari
     when 18; pbCommonEvent(28)  # Vs. Kotonoji
     when 19; pbCommonEvent(30)  # Vs. Marco
     when 20; pbCommonEvent(31)  # Vs. Hoshiko
     when 21; pbCommonEvent(32)  # Vs. Altair
     when 22; pbCommonEvent(33)  # Vs. Pholia
     when 23; pbCommonEvent(34)  # Vs. Stephen
     when 24; pbCommonEvent(35)  # Vs. Eleanor
     when 25; pbCommonEvent(36)  # Vs. Naomi
     when 26; pbCommonEvent(37)  # Vs. Andros
     when 27; pbCommonEvent(38)  # Vs. Doppelganger Device
     when 28; pbCommonEvent(40)  # Vs. Alyssia & Lifrana
     when 29; pbCommonEvent(41)  # Vs. Dist & Julia
     when 30; pbCommonEvent(42)  # Vs. Kalypsa
     when 31; pbCommonEvent(43)  # Vs. Lucia
     when 32; pbCommonEvent(45)  # Vs. Red
     when 33; pbCommonEvent(46)  # Vs. Blue
     when 34; pbCommonEvent(47)  # Vs. Green
     when 35; pbCommonEvent(48)  # Vs. Gold
     when 36; pbCommonEvent(49)  # Vs. Silver
     when 37; pbCommonEvent(50)  # Vs. Krys
     when 38; pbCommonEvent(51)  # Vs. Renko & Maribel
     when 39; pbCommonEvent(53)  # Vs. Derxwna
     when 40; pbCommonEvent(54)  # Vs. Schwer & Sean
     when 41; pbCommonEvent(55)  # Vs. Amra
     when 42; pbCommonEvent(56)  # Vs. Albatross
     when 43; pbCommonEvent(57)  # Vs. Booman
     when 44; pbCommonEvent(58)  # Vs. Agastya
     when 45; pbCommonEvent(59)  # Vs. Zei
     when 46; pbCommonEvent(60)  # Vs. Mimi
     when 47; pbCommonEvent(61)  # Vs. Stuffman
     when 48; pbCommonEvent(62)  # Vs. Xephyr
     when 49; pbCommonEvent(63)  # Vs. Eris
     when 50; pbCommonEvent(64)  # Vs. Reinhart
     when 51; pbCommonEvent(65)  # Vs. TAC
     when 52; pbCommonEvent(66)  # Vs. Ichor
     when 53; pbCommonEvent(67)  # Vs. Geizt
     when 54; pbCommonEvent(68)  # Vs. Birdy
     when 55; pbCommonEvent(69)  # Vs. Momi
     when 56; pbCommonEvent(71)  # Vs. MissingNo
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