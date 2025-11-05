#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Added the Puppet Orbs variants
#	* Made it so the Net Ball works on Touhoumon Water and Beast Types
#	* Added the Glitter Ball, which will turn a species shiny on capture, or 
#	  have an enhanced rate against Shiny Encounter. (NOT YET IMPLEMENTED)
#==============================================================================#

Battle::PokeBallEffects::ModifyCatchRate.add(:NETBALL, proc { |ball, catchRate, battle, battler|
  multiplier = (Settings::NEW_POKE_BALL_CATCH_RATES) ? 3.5 : 3
  catchRate *= multiplier if battler.pbHasType?(:BUG) || battler.pbHasType?(:WATER) ||
							 battler.pbHasType?(:BEAST18) || battler.pbHasType?(:WATER18)
  next catchRate
})


Battle::PokeBallEffects::ModifyCatchRate.add(:GREATORB, proc { |ball, catchRate, battle, battler|
  next catchRate * 1.5
})

Battle::PokeBallEffects::ModifyCatchRate.add(:ULTRAORB, proc { |ball, catchRate, battle, battler|
  next catchRate * 2
})

Battle::PokeBallEffects::ModifyCatchRate.add(:SAFARIORB, proc { |ball, catchRate, battle, battler|
  next catchRate * 1.5
})

Battle::PokeBallEffects::ModifyCatchRate.add(:GLITTERBALL, proc { |ball, catchRate, battle, battler|
  catchRate *= 4 if battler.shiny? || battler.super_shiny?
  next catchRate
})

Battle::PokeBallEffects::ModifyCatchRate.add(:DREAMBALL, proc { |ball, catchRate, battle, battler|
  catchRate *= 4 if battler.asleep?
  next catchRate
})

Battle::PokeBallEffects::IsUnconditional.add(:MASTERORB, proc { |ball, battle, battler|
  next true
})

Battle::PokeBallEffects::OnCatch.add(:GLITTERBALL, proc { |ball, battle, pkmn|
  pkmn.shiny = true
})

Battle::PokeBallEffects::OnCatch.add(:DREAMBALL, proc { |ball, battle, pkmn|
  pkmn.ability_index = 2
})

#----------------------------------------
# The Adventures of Ayaka - Compatability Support
#----------------------------------------
Battle::PokeBallEffects::ModifyCatchRate.add(:GREATORB2,proc { |ball,catchRate,battle,battler,ultraBeast|
  next catchRate*1.5
})

Battle::PokeBallEffects::ModifyCatchRate.add(:INVERSEORB,proc { |ball,catchRate,battle,battler,ultraBeast|
  next catchRate*1.5
})

Battle::PokeBallEffects::ModifyCatchRate.add(:PRISMORB, proc { |ball, catchRate, battle, battler|
  next catchRate * 1.5
})

Battle::PokeBallEffects::OnCatch.add(:PUPPETORB2,proc { |ball,battle,pkmn|
  pkmn.happiness = 0
})

Battle::PokeBallEffects::OnCatch.add(:GREATORB2,proc { |ball,battle,pkmn|
  stats = GameData::Stats.each_main.map(&:id)
  stat1, stat2 = stats.sample(2)
  pkmn.iv[stat1] = 0
  pkmn.iv[stat2] = 31
})

Battle::PokeBallEffects::OnCatch.add(:INVERSEORB,proc { |ball,battle,pkmn|
  if rand(100) > 85
	pkmn.shiny = true
  end
})
