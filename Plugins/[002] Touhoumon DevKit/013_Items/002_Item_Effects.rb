#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Removed explicit references to Pokemon. Kinda. It's weird.
#	* Tweaked existing items to implement Touhoumon mechanics
#	* Added in items not present in Vanilla Touhoumon
#	* Added sound effects to the Item Finder
#==============================================================================#
ItemHandlers::UseInField.add(:BLACKFLUTE, proc { |item|
  pbUseItemMessage(item)
  if Settings::FLUTES_CHANGE_WILD_ENCOUNTER_LEVELS
    pbMessage(_INTL("Now you're more likely to encounter high-level Pokémon and Puppets!"))
    $PokemonMap.higher_level_wild_pokemon = true
    $PokemonMap.lower_level_wild_pokemon = false
  else
    pbMessage(_INTL("The likelihood of encountering Pokémon and Puppets decreased!"))
    $PokemonMap.lower_encounter_rate = true
    $PokemonMap.higher_encounter_rate = false
  end
  next true
})

ItemHandlers::UseInField.add(:WHITEFLUTE, proc { |item|
  pbUseItemMessage(item)
  if Settings::FLUTES_CHANGE_WILD_ENCOUNTER_LEVELS
    pbMessage(_INTL("Now you're more likely to encounter low-level Pokémon and Puppets!"))
    $PokemonMap.lower_level_wild_pokemon = true
    $PokemonMap.higher_level_wild_pokemon = false
  else
    pbMessage(_INTL("The likelihood of encountering Pokémon and Puppets increased!"))
    $PokemonMap.higher_encounter_rate = true
    $PokemonMap.lower_encounter_rate = false
  end
  next true
})

ItemHandlers::UseInField.add(:SACREDASH, proc { |item|
  if $player.pokemon_count == 0
    pbMessage(_INTL("There is nothing in your party."))
    next false
  end
  canrevive = false
  $player.pokemon_party.each do |i|
    next if !i.fainted?
    canrevive = true
    break
  end
  if !canrevive
    pbMessage(_INTL("It won't have any effect."))
    next false
  end
  revived = 0
  pbFadeOutIn do
    scene = PokemonParty_Scene.new
    screen = PokemonPartyScreen.new(scene, $player.party)
    screen.pbStartScene(_INTL("Using item..."), false)
    pbSEPlay("Use item in party")
    $player.party.each_with_index do |pkmn, i|
      next if !pkmn.fainted?
      revived += 1
      pkmn.heal
      screen.pbRefreshSingle(i)
      screen.pbDisplay(_INTL("{1}'s HP was restored.", pkmn.name))
    end
    screen.pbDisplay(_INTL("It won't have any effect.")) if revived == 0
    screen.pbEndScene
  end
  next (revived > 0)
})

ItemHandlers::UseOnPokemon.add(:POTATO, proc { |item, qty, pkmn, scene|
  next pbHPItem(pkmn, 20, scene)
})

ItemHandlers::UseOnPokemon.add(:BAKEDPOTATO, proc { |item, qty, pkmn, scene|
  if pkmn.fainted?
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  pbSEPlay("Use item in party")
  pkmn.heal_status
  scene.pbRefresh
  hpgain = pbItemRestoreHP(pkmn, pkmn.totalhp / 4)
  if hpgain > 0
    scene.pbDisplay(_INTL("{1}'s HP was restored by {2} points.", pkmn.name, hpgain))
  else
    scene.pbDisplay(_INTL("{1} became healthy.", pkmn.name))
  end
  #next pbHPItem(pkmn, pkmn.totalhp / 4, scene)
})

ItemHandlers::UseOnPokemon.copy(:FULLHEAL, :GRILLEDLAMPREY)

# ------ Derx: Liquid Revive: Max Elixir + Max Revive
ItemHandlers::UseOnPokemon.add(:LIQUIDREVIVE, proc { |item, qty, pkmn, scene|
  if !pkmn.fainted?
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  pbSEPlay("Use item in party")
  pprestored = 0
  pkmn.moves.length.times do |i|
    pprestored += pbRestorePP(pkmn, i, pkmn.moves[i].total_pp - pkmn.moves[i].pp)
  end
  pkmn.heal_HP
  pkmn.heal_status
  scene.pbRefresh
  scene.pbDisplay(_INTL("{1} was fully revitalized.", pkmn.name))
  next true
})
# ------ Derx: End of Liquid Revive