def pbSafariBattle(pkmn, level = 1)
  # Generate a wild Pokémon based on the species and level
  pkmn = pbGenerateWildPokemon(pkmn, level) if !pkmn.is_a?(Pokemon)
  foeParty = [pkmn]
  # Calculate who the trainer is
  playerTrainer = $player
  # Create the battle scene (the visual side of it)
  scene = BattleCreationHelperMethods.create_battle_scene
  # Create the battle class (the mechanics side of it)
  battle = SafariBattle.new(scene, playerTrainer, foeParty)
  battle.ballCount = pbSafariState.ballcount
  BattleCreationHelperMethods.prepare_battle(battle)
  # Perform the battle itself
  decision = 0
  pbBattleAnimation(pbGetWildBattleBGM(foeParty), 0, foeParty) do
    pbSceneStandby { decision = battle.pbStartBattle }
  end
  Input.update
  # Update Safari game data based on result of battle
  pbSafariState.ballcount = battle.ballCount
  if pbSafariState.ballcount <= 0
    if decision != 2   # Last Safari Ball was used to catch the wild Pokémon
      pbMessage(_INTL("Attendant: You're out of orbs! Game over!"))
    end
    pbSafariState.decision = 1
    pbSafariState.pbGoToStart
  end
  # Save the result of the battle in Game Variable 1
  #    0 - Undecided or aborted
  #    2 - Player ran out of Safari Balls
  #    3 - Player or wild Pokémon ran from battle, or player forfeited the match
  #    4 - Wild Pokémon was caught
  if decision == 4
    $stats.safari_pokemon_caught += 1
    pbSafariState.captures += 1
    $stats.most_captures_per_safari_game = [$stats.most_captures_per_safari_game, pbSafariState.captures].max
  end
  pbSet(1, decision)
  # Used by the Poké Radar to update/break the chain
  EventHandlers.trigger(:on_wild_battle_end, pkmn.species_data.id, pkmn.level, decision)
  # Return the outcome of the battle
  return decision
end