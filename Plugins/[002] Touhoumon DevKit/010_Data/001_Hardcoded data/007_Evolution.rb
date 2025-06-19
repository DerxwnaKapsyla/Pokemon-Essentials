GameData::Evolution.register({
  :id            => :LevelForceForm1,
  :parameter     => Integer,
  :level_up_proc => proc { |pkmn, parameter|
    next pkmn.level >= parameter
  },
  :after_evolution_proc => proc { |pkmn, new_species, parameter, evo_species|
    next false if evo_species != new_species
	pkmn.form = 1
	next true
  }
})

GameData::Evolution.register({
  :id            => :ItemForceForm1,
  :parameter     => :Item,
  :use_item_proc => proc { |pkmn, parameter, item|
    next item == parameter
  },
  :after_evolution_proc => proc { |pkmn, new_species, parameter, evo_species|
    next false if evo_species != new_species 
    pkmn.form = 1   # Force Form 1
    next true
  }
})