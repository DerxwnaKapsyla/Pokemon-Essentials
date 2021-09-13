#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Added the Puppet Orbs to the Ball Types
#	* Made it so the Net Ball works on Touhoumon Water and Beast Types
#==============================================================================#
$BallTypes = {
  0  => :POKEBALL,
  1  => :GREATBALL,
  2  => :SAFARIBALL,
  3  => :ULTRABALL,
  4  => :MASTERBALL,
  5  => :NETBALL,
  6  => :DIVEBALL,
  7  => :NESTBALL,
  8  => :REPEATBALL,
  9  => :TIMERBALL,
  10 => :LUXURYBALL,
  11 => :PREMIERBALL,
  12 => :DUSKBALL,
  13 => :HEALBALL,
  14 => :QUICKBALL,
  15 => :CHERISHBALL,
  16 => :FASTBALL,
  17 => :LEVELBALL,
  18 => :LUREBALL,
  19 => :HEAVYBALL,
  20 => :LOVEBALL,
  21 => :FRIENDBALL,
  22 => :MOONBALL,
  23 => :SPORTBALL,
  24 => :DREAMBALL,
  25 => :BEASTBALL,
  # ------ Derx: Added in the core Puppet Orbs
  26=>:CHERISHORB,
  27=>:PUPPETORB,
  28=>:GREATORB,
  29=>:ULTRAORB,
  30=>:MASTERORB
  # ------ Derx: End of Puppet Orb additions
}

BallHandlers::ModifyCatchRate.add(:NETBALL,proc { |ball,catchRate,battle,battler,ultraBeast|
  multiplier = (Settings::NEW_POKE_BALL_CATCH_RATES) ? 3.5 : 3
  catchRate *= multiplier if battler.pbHasType?(:BUG) || battler.pbHasType?(:WATER) ||
							 battler.pbHasType?(:BEAST18) || battler.pbHasType?(:WATER18)
  next catchRate
})


BallHandlers::ModifyCatchRate.add(:GREATORB,proc { |ball,catchRate,battle,battler,ultraBeast|
  next catchRate*1.5
})

BallHandlers::ModifyCatchRate.add(:ULTRAORB,proc { |ball,catchRate,battle,battler,ultraBeast|
  next catchRate*2
})

BallHandlers::ModifyCatchRate.add(:SAFARIORB,proc { |ball,catchRate,battle,battler,ultraBeast|
  next catchRate*1.5
})
BallHandlers::IsUnconditional.add(:MASTERORB,proc { |ball,battle,battler|
  next true
})