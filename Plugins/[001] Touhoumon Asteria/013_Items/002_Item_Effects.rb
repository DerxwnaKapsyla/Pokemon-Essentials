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
ItemHandlers::UseOnPokemon.copy(:MAXREVIVE,:GOLDENRICESAKE)
ItemHandlers::UseInField.copy(:SACREDASH,:GOLDENPEACHSAKE)

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
  pkmn.changeHappiness("evberry")
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
  pkmn.changeHappiness("evberry")
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
  pkmn.changeHappiness("evberry")
  next true
})

ItemHandlers::UseOnPokemonMaximum.add(:HPTALISMAN, proc { |item, pkmn|
  next pbMaxUsesOfEVRaisingItem(:HP, 252, pkmn, true)
})

ItemHandlers::UseOnPokemon.add(:HPTALISMAN, proc { |item, qty, pkmn, scene|
  next pbUseEVRaisingItem(:HP, 252, qty, pkmn, "vitamin", scene, true)
})

ItemHandlers::UseOnPokemonMaximum.add(:ATKTALISMAN, proc { |item, pkmn|
  next pbMaxUsesOfEVRaisingItem(:ATTACK, 252, pkmn, true)
})

ItemHandlers::UseOnPokemon.add(:ATKTALISMAN, proc { |item, qty, pkmn, scene|
  next pbUseEVRaisingItem(:ATTACK, 252, qty, pkmn, "vitamin", scene, true)
})

ItemHandlers::UseOnPokemonMaximum.add(:DEFTALISMAN, proc { |item, pkmn|
  next pbMaxUsesOfEVRaisingItem(:DEFENSE, 252, pkmn, true)
})

ItemHandlers::UseOnPokemon.add(:DEFTALISMAN, proc { |item, qty, pkmn, scene|
  next pbUseEVRaisingItem(:DEFENSE, 252, qty, pkmn, "vitamin", scene, true)
})

ItemHandlers::UseOnPokemonMaximum.add(:SPATKTALISMAN, proc { |item, pkmn|
  next pbMaxUsesOfEVRaisingItem(:SPECIAL_ATTACK, 252, pkmn, true)
})

ItemHandlers::UseOnPokemon.add(:SPATKTALISMAN, proc { |item, qty, pkmn, scene|
  next pbUseEVRaisingItem(:SPECIAL_ATTACK, 252, qty, pkmn, "vitamin", scene, true)
})

ItemHandlers::UseOnPokemonMaximum.add(:SPDEFTALISMAN, proc { |item, pkmn|
  next pbMaxUsesOfEVRaisingItem(:SPECIAL_DEFENSE, 252, pkmn, true)
})

ItemHandlers::UseOnPokemon.add(:SPDEFTALISMAN, proc { |item, qty, pkmn, scene|
  next pbUseEVRaisingItem(:SPECIAL_DEFENSE, 252, qty, pkmn, "vitamin", scene, true)
})

ItemHandlers::UseOnPokemonMaximum.add(:SPDTALISMAN, proc { |item, pkmn|
  next pbMaxUsesOfEVRaisingItem(:SPEED, 252, pkmn, true)
})

ItemHandlers::UseOnPokemon.add(:SPDTALISMAN, proc { |item, qty, pkmn, scene|
  next pbUseEVRaisingItem(:SPEED, 252, qty, pkmn, "vitamin", scene, true)
})

# ItemHandlers::UseOnPokemonMaximum.add(:RESETTALISMAN, proc { |item, pkmn|
  # next pbMaxUsesOfEVLoweringBerry(stat, pkmn)
# })

ItemHandlers::UseOnPokemon.add(:RESETTALISMAN, proc { |item, qty, pkmn, scene|
  stats = [:HP, :ATTACK, :DEFENSE, :SPEED, :SPECIAL_ATTACK, :SPECIAL_DEFENSE]
  has_evs = stats.any? { |stat| pkmn.ev[stat] > 0 }
  if !has_evs
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  stats.each do |stat|
    pbLowerEV(pkmn, scene, stat, qty, [])
  end
  scene.pbDisplay(_INTL("{1}'s stats were reset!", pkmn.name))
  next true
})

# Derx: This will need changing if the Dream Flute is ever used in Asteria
ItemHandlers::UseInField.add(:DREAMFLUTE, proc { |item|
  pbUseItemMessage(item)
  encounter_table = $PokemonGlobal.encounter_version
  if encounter_table == pbGet(99) && pbGet(99) != 0
    pbMessage(_INTL("Weaker Puppets seem to have become more common!"))
    $PokemonGlobal.encounter_version = 0
	if $DEBUG
	  pbMessage(_INTL("Current encounter table: {1}",$PokemonGlobal.encounter_version))
	end
  elsif encounter_table == 0 && pbGet(99) != 0
    pbMessage(_INTL("Stronger Puppets seem to have become more common!"))
    $PokemonGlobal.encounter_version = pbGet(99)
	if $DEBUG
	  pbMessage(_INTL("Current encounter table: {1}",$PokemonGlobal.encounter_version))
	end
  elsif encounter_table == 0 && pbGet(99) == 0
    pbMessage(_INTL("Nothing happened."))
  else
    pbMessage(_INTL("Nothing happened."))
  end
  next true
})

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

