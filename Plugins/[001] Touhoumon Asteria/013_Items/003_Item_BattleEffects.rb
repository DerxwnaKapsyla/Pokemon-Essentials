#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Removed explicit references to Pokemon
#	* Added in new items for Touhoumon mechanics
#	* Added in custom items not in Touhoumon
#	* Made tweaks to existing items
#	* Added in a check to the Battle Rule for no capture to display an alt line
#==============================================================================#
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
ItemHandlers::CanUseInBattle.copy(:POTION, :POTATO, :BEER, :SAKE)
ItemHandlers::CanUseInBattle.copy(:FULLHEAL, :GRILLEDLAMPREY)
ItemHandlers::CanUseInBattle.copy(:REVIVE, :GOLDENRICESAKE)

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

# ------ Liquid Revive: Max Elixir + Max Revive
ItemHandlers::CanUseInBattle.add(:LIQUIDREVIVE, proc { |item, pokemon, battler, move, firstAction, battle, scene, showMessages|
  if pokemon.able? || pokemon.egg?
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
  next true
})
# ------ Derx: End of Liquid Revive code

ItemHandlers::CanUseInBattle.add(:BAKEDPOTATO, proc { |item, pokemon, battler, move, firstAction, battle, scene, showMessages|
  if !pokemon.able? || (pokemon.hp == pokemon.totalhp ||
                       (pokemon.status == :NONE &&
                       (!battler || battler.effects[PBEffects::Confusion] == 0)))
    scene.pbDisplay(_INTL("It won't have any effect.")) if showMessages
    next false
  end
})

ItemHandlers::UseInBattle.add(:POKEDOLL, proc { |item, battler, battle|
  battle.decision = 3
  pbSEPlay("Battle Flee")
  battle.pbDisplayPaused(_INTL("You got away safely!"))
})

ItemHandlers::UseInBattle.add(:POKEFLUTE, proc { |item, battler, battle|
  battle.allBattlers.each do |b|
    b.pbCureStatus(false) if b.status == :SLEEP && !b.hasActiveAbility?(:SOUNDPROOF)
  end
  battle.pbDisplay(_INTL("All active battlers were roused by the tune!"))
})

ItemHandlers::BattleUseOnPokemon.copy(:FULLHEAL, :GRILLEDLAMPREY)

# ------ Liquid Revive: Max Elixir + Max Revive
ItemHandlers::BattleUseOnPokemon.add(:LIQUIDREVIVE, proc { |item, pokemon, battler, choices, scene|
  pokemon.heal_HP
  pokemon.heal_status
  pokemon.moves.length.times do |i|
    pbBattleRestorePP(pokemon, battler, i, pokemon.moves[i].total_pp)
  end
  scene.pbRefresh
  scene.pbDisplay(_INTL("{1} was fully revitalized!", pokemon.name))
})
# ------ Derx: End of Liquid Revive code


ItemHandlers::BattleUseOnPokemon.add(:POTATO, proc { |item, pokemon, battler, choices, scene|
  pbBattleHPItem(pokemon, battler, 20, scene)
})

ItemHandlers::BattleUseOnPokemon.add(:BAKEDPOTATO, proc { |item, pokemon, battler, choices, scene|
  pokemon.heal_status
  battler&.pbCureStatus(false)
  battler&.pbCureConfusion
  name = (battler) ? battler.pbThis : pokemon.name
  if pokemon.hp < pokemon.totalhp
	pbBattleHPItem(pokemon, battler, pokemon.totalhp / 4, scene)
  else
    scene.pbRefresh
    scene.pbDisplay(_INTL("{1} became healthy.", name))
  end
})