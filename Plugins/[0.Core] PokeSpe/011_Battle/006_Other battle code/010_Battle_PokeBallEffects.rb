
#===============================================================================
# IsUnconditional
#===============================================================================
Battle::PokeBallEffects::IsUnconditional.add(:POKEBALL_2, proc { |ball, battle, battler|
  next true
})
