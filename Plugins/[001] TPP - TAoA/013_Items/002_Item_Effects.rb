ItemHandlers::UseInField.copy(:SACREDASH, :GOLDENPEACHSAKE)

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
    pbFadeOutInWithMusic {
      evo = PokemonEvolutionScene.new
      evo.pbStartScreen(pkmn, new_species)
      evo.pbEvolution
      evo.pbEndScreen
      scene.pbRefresh if scene.is_a?(PokemonPartyScreen)
    }
    next true
  end
  # Level up
  pbChangeLevel(pkmn, pkmn.level + (qty * 5), scene)
  scene.pbHardRefresh
  next true
})