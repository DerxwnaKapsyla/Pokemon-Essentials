ItemHandlers::UseOnPokemon.copy(:MAXREVIVE,:GOLDENRICESAKE)
ItemHandlers::UseInField.copy(:SACREDASH,:GOLDENPEACHSAKE)

ItemHandlers::UseOnPokemonMaximum.copy(:RARECANDY, :PRISMCANDY)


ItemHandlers::UseOnPokemon.add(:PRISMCANDY, proc { |item, qty, pkmn, scene|
  if pkmn.shadowPokemon?
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  if pkmn.level >= GameData::GrowthRate.max_level || (pkmn.level + (qty * 5) - 1) >= GameData::GrowthRate.max_level
    new_species = pkmn.check_evolution_on_level_up
    if !Settings::RARE_CANDY_USABLE_AT_MAX_LEVEL || !new_species
      scene.pbDisplay(_INTL("It won't have any effect."))
      next false
    end
    # Check for evolution
    pbFadeOutInWithMusic do
      evo = PokemonEvolutionScene.new
      evo.pbStartScreen(pkmn, new_species)
      evo.pbEvolution
      evo.pbEndScreen
      scene.pbRefresh if scene.is_a?(PokemonPartyScreen)
    end
    next true
  end
  # Level up
  pbSEPlay("Pkmn level up")
  pbChangeLevel(pkmn, pkmn.level + (qty * 5), scene)
  scene.pbHardRefresh
  next true
})

ItemHandlers::UseOnPokemon.add(:BEER, proc { |item, qty, pkmn, scene|
  next pbHPItem(pkmn, 40, scene)
})

ItemHandlers::UseOnPokemon.add(:SAKE, proc { |item, qty, pkmn, scene|
  next pbHPItem(pkmn, 80, scene)
})

ItemHandlers::UseOnPokemon.add(:ONIKILLERSAKE, proc { |item, qty, pkmn, scene|
  next pbHPItem(pkmn, pkmn.totalhp - pkmn.hp, scene)
  pkmn.changeHappiness("battleitem") if pkmn.species_data.has_flag?("Oni")
})

ItemHandlers::UseOnPokemon.add(:STRAWBERRYJAM, proc { |item, qty, pkmn, scene|
  if pkmn.fainted? || (pkmn.hp == pkmn.totalhp && pkmn.status == :NONE)
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  pbSEPlay("Use item in party")
  hpgain = pbItemRestoreHP(pkmn, pkmn.totalhp - pkmn.hp)
  pkmn.heal_status
  scene.pbRefresh
  if hpgain > 0
    scene.pbDisplay(_INTL("{1}'s HP was restored by {2} points.", pkmn.name, hpgain))
  else
    scene.pbDisplay(_INTL("{1} became healthy.", pkmn.name))
  end
  pkmn.changeHappiness("jam")
  next true
})

ItemHandlers::UseOnPokemon.add(:BLUEBERRYJAM, proc { |item, qty, pkmn, scene|
  move = scene.pbChooseMove(pkmn, _INTL("Restore which move?"))
  next false if move < 0
  if pbRestorePP(pkmn, move, pkmn.moves[move].total_pp - pkmn.moves[move].pp) == 0
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  pbSEPlay("Use item in party")
  scene.pbDisplay(_INTL("PP was restored."))
  pkmn.changeHappiness("jam")
  next true
})

ItemHandlers::UseOnPokemon.add(:MINORIKOJAM, proc { |item, qty, pkmn, scene|
  pprestored = 0
  pkmn.moves.length.times do |i|
    pprestored += pbRestorePP(pkmn, i, pkmn.moves[i].total_pp - pkmn.moves[i].pp)
  end
  if pkmn.fainted? || (pkmn.hp == pkmn.totalhp && pkmn.status == :NONE)
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  pbSEPlay("Use item in party")
  hpgain = pbItemRestoreHP(pkmn, pkmn.totalhp - pkmn.hp)
  pkmn.heal_status
  scene.pbRefresh
  if hpgain > 0
    scene.pbDisplay(_INTL("{1}'s HP was restored by {2} points.", pkmn.name, hpgain))
  else
    scene.pbDisplay(_INTL("{1} became healthy.", pkmn.name))
  end
  next true
  scene.pbDisplay(_INTL("PP was restored."))
  pkmn.changeHappiness("jam")
  next true
})