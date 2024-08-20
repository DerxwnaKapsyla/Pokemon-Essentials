def pbBattleOnStepTaken(repel_active)
  return if $player.able_pokemon_count == 0
  return if !$PokemonEncounters.encounter_possible_here?
  encounter_type = $PokemonEncounters.encounter_type
  return if !encounter_type
  return if !$PokemonEncounters.encounter_triggered?(encounter_type, repel_active)
  $game_temp.encounter_type = encounter_type
  encounter = $PokemonEncounters.choose_wild_pokemon(encounter_type)
  EventHandlers.trigger(:on_wild_species_chosen, encounter)
  if $PokemonEncounters.allow_encounter?(encounter, repel_active)
    if GameData::MapMetadata.get($game_map.map_id)&.has_flag?("TLA")
	  TrainerBattle.start(:ANOMALY, "Anomaly", rand(10))
	else 
      if $PokemonEncounters.have_double_wild_battle?
        encounter2 = $PokemonEncounters.choose_wild_pokemon(encounter_type)
        EventHandlers.trigger(:on_wild_species_chosen, encounter2)
        WildBattle.start(encounter, encounter2, can_override: true)
      else
        WildBattle.start(encounter, can_override: true)
      end
	end
    $game_temp.encounter_type = nil
    $game_temp.encounter_triggered = true
  end
  $game_temp.force_single_battle = false
end