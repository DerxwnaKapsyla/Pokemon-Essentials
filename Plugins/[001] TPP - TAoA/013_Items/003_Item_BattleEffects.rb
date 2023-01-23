ItemHandlers::CanUseInBattle.add(:KAPPAATTACK, proc { |item, pokemon, battler, move, firstAction, battle, scene, showMessages|
  next pbBattleItemCanRaiseStat?(:ATTACK, battler, scene, showMessages)
  next pbBattleItemCanRaiseStat?(:SPECIAL_ATTACK, battler, scene, showMessages)
  next pbBattleItemCanRaiseStat?(:SPEED, battler, scene, showMessages)
})

ItemHandlers::CanUseInBattle.add(:KAPPADEFENSE, proc { |item, pokemon, battler, move, firstAction, battle, scene, showMessages|
  next pbBattleItemCanRaiseStat?(:DEFENSE, battler, scene, showMessages)
  next pbBattleItemCanRaiseStat?(:SPECIAL_DEFENSE, battler, scene, showMessages)
  next pbBattleItemCanRaiseStat?(:EVASION, battler, scene, showMessages)
})

ItemHandlers::BattleUseOnBattler.add(:KAPPAATTACK, proc { |item, battler, scene|
  battler.pbRaiseStatStage(:ATTACK, 1, battler)
  battler.pbRaiseStatStage(:SPECIAL_ATTACK, 1, battler)
  battler.pbRaiseStatStage(:SPEED, 1, battler)
  battler.pokemon.changeHappiness("battleitem")
})

ItemHandlers::BattleUseOnBattler.add(:KAPPADEFENSE, proc { |item, battler, scene|
  battler.pbRaiseStatStage(:DEFENSE, 1, battler)
  battler.pbRaiseStatStage(:SPECIAL_DEFENSE, 1, battler)
  battler.pbRaiseStatStage(:EVASION, 1, battler)
  battler.pokemon.changeHappiness("battleitem")
})