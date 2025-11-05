MenuHandlers.add(:debug_menu, :give_demo_party, {
  "name"        => _INTL("Give demo party"),
  "parent"      => :pokemon_menu,
  "description" => _INTL("Give yourself 6 preset Puppets. They overwrite the current party."),
  "effect"      => proc {
    party = []
    species = [:ADREISEN, :ASUMIREKO, :RIKAKO, :NEPGEAR, :SAYA, :SHINKI]
    species.each { |id| party.push(id) if GameData::Species.exists?(id) }
    $player.party.clear
    # Generate Puppets of each species at level 100
    party.each do |species|
      pkmn = Pokemon.new(species, 100)
	  pkmn.iv[:HP] = 31
	  pkmn.iv[:ATTACK] = 31
	  pkmn.iv[:DEFENSE] = 31
	  pkmn.iv[:SPEED] = 31
	  pkmn.iv[:SPECIAL_ATTACK] = 31
	  pkmn.iv[:SPECIAL_DEFENSE] = 31
      $player.party.push(pkmn)
      $player.pokedex.register(pkmn)
      $player.pokedex.set_owned(species)
	  if species != (:NEPGEAR || :SAYA)
	    pkmn.ev[:SPECIAL_ATTACK] = 252
		pkmn.ev[:SPEED] = 252
	  else  
	    pkmn.ev[:ATTACK] = 252
		pkmn.ev[:SPEED] = 252
	  end
    end
    pbMessage(_INTL("Filled party with demo Puppets."))
  }
})