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

ItemHandlers::CanUseInBattle.add(:ONIKILLERSAKE, proc { |item, pokemon, battler, move, firstAction, battle, scene, showMessages|
  if !pokemon.able? || pokemon.hp == pokemon.totalhp
    scene.pbDisplay(_INTL("It won't have any effect.")) if showMessages
    next false
  end
  if pokemon.species_data.has_flag?("Oni")
    next pbBattleItemCanRaiseStat?(:ATTACK, battler, scene, showMessages)
    next pbBattleItemCanRaiseStat?(:SPECIAL_ATTACK, battler, scene, showMessages)
  end
  next true
})

ItemHandlers::CanUseInBattle.copy(:POTION, :BEER, :SAKE)

ItemHandlers::CanUseInBattle.copy(:REVIVE, :GOLDENRICESAKE)

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


ItemHandlers::BattleUseOnPokemon.add(:BEER, proc { |item, pokemon, battler, choices, scene|
  pbBattleHPItem(pokemon, battler, 40, scene)
  next unless battler
  next if !battler.pbCanConfuseSelf?(false)
  if rand(100) < 25
    battler.pbConfuse( _INTL("{1} became inebriated!", battler.pbThis, battler.itemName))
  end
})

ItemHandlers::BattleUseOnPokemon.add(:SAKE, proc { |item, pokemon, battler, choices, scene|
  pbBattleHPItem(pokemon, battler, 80, scene)
  next unless battler
  next if !battler.pbCanConfuseSelf?(false)
  if rand(100) < 50
    battler.pbConfuse( _INTL("{1} became inebriated!", battler.pbThis, battler.itemName))
  end
})

ItemHandlers::BattleUseOnPokemon.add(:ONIKILLERSAKE, proc { |item, pokemon, battler, choices, scene|
  pbBattleHPItem(pokemon, battler, pokemon.totalhp - pokemon.hp, scene)
  next unless battler
  next if !battler.pbCanConfuseSelf?(false)
  if battler.pokemon.species_data.has_flag?("Oni")
    battler.pbRaiseStatStage(:ATTACK, 1, battler)
    battler.pbRaiseStatStage(:SPECIAL_ATTACK, 1, battler)
	battler.pokemon.changeHappiness("battleitem")
  end
  if rand(100) < 75
    battler.pbConfuse(_INTL("{1} became inebriated!", battler.pbThis, battler.itemName))
  end
})

ItemHandlers::BattleUseOnPokemon.copy(:MAXREVIVE,:GOLDENRICESAKE)

ItemHandlers::CanUseInBattle.add(:BLUEBERRYJAM, proc { |item, pokemon, battler, move, firstAction, battle, scene, showMessages|
  if !pokemon.able? || move < 0 ||
     pokemon.moves[move].total_pp <= 0 ||
     pokemon.moves[move].pp == pokemon.moves[move].total_pp
    scene.pbDisplay(_INTL("It won't have any effect.")) if showMessages
    next false
  end
  battler.pokemon.changeHappiness("evberry")
  next true
})

ItemHandlers::CanUseInBattle.add(:STRAWBERRYJAM, proc { |item, pokemon, battler, move, firstAction, battle, scene, showMessages|
  if !pokemon.able? ||
     (pokemon.hp == pokemon.totalhp && pokemon.status == :NONE &&
     (!battler || battler.effects[PBEffects::Confusion] == 0))
    scene.pbDisplay(_INTL("It won't have any effect.")) if showMessages
    next false
  end
  battler.pokemon.changeHappiness("evberry")
  next true
})

ItemHandlers::BattleUseOnPokemon.add(:BLUEBERRYJAM, proc { |item, pokemon, battler, choices, scene|
  idxMove = choices[3]
  pbBattleRestorePP(pokemon, battler, idxMove, pokemon.moves[idxMove].total_pp)
  pbSEPlay("Use item in party")
  scene.pbDisplay(_INTL("PP was restored."))
  pokemon.changeHappiness("evberry")
})

ItemHandlers::BattleUseOnPokemon.add(:STRAWBERRYJAM, proc { |item, pokemon, battler, choices, scene|
  pokemon.heal_status
  battler&.pbCureStatus(false)
  battler&.pbCureConfusion
  name = (battler) ? battler.pbThis : pokemon.name
  if pokemon.hp < pokemon.totalhp
    pbBattleHPItem(pokemon, battler, pokemon.totalhp, scene)
  else
    scene.pbRefresh
    scene.pbDisplay(_INTL("{1} became healthy.", name))
	pokemon.changeHappiness("evberry")
  end
})


# ------ Derx: New item - Minoriko's Speciality. Full Restore + Max Elixir, raises happiness.
ItemHandlers::BattleUseOnPokemon.add(:MINORIKOJAM, proc { |item, pokemon, battler, choices, scene|
  pokemon.heal_status
  battler&.pbCureStatus(false)
  battler&.pbCureConfusion
  name = (battler) ? battler.pbThis : pokemon.name
  pokemon.moves.length.times do |i|
    pbBattleRestorePP(pokemon, battler, i, pokemon.moves[i].total_pp)
  end
  if pokemon.hp < pokemon.totalhp
    pbBattleHPItem(pokemon, battler, pokemon.totalhp, scene)
  else
    scene.pbRefresh
    scene.pbDisplay(_INTL("{1} was revitalized.", name))
	pokemon.changeHappiness("evberry")
  end
})
# ------ Derx: End of Minoriko's Speciality addition

# ------ Derx: New item - Minoriko's Speciality. Full Restore + Max Elixir, raises happiness.
ItemHandlers::CanUseInBattle.add(:MINORIKOJAM, proc { |item, pokemon, battler, move, firstAction, battle, scene, showMessages|
  if !pokemon.able?
    scene.pbDisplay(_INTL("It won't have any effect.")) if showMessages
    next false
  end
  canRestore = false
  pokemon.moves.each do |m|
    next if m.id == 0
    next if m.total_pp <= 0 || m.pp == m.total_pp
    canRestore = true
    break
  end
  if !canRestore
    scene.pbDisplay(_INTL("It won't have any effect.")) if showMessages
    next false
  end
  if !pokemon.able? ||
     (pokemon.hp == pokemon.totalhp && pokemon.status == :NONE &&
     (!battler || battler.effects[PBEffects::Confusion] == 0))
    scene.pbDisplay(_INTL("It won't have any effect.")) if showMessages
    next false
  end
  next true
})
# ------ Derx: End of Minoriko's Speciality addition