def test_anim_battle
  pkmn1 = Pokemon.new(:AKYUU, 100)
  pkmn2 = Pokemon.new(:AKYUU, 100)
  pkmn3 = Pokemon.new(:AKYUU, 100)
  foepkmn1 = Pokemon.new(:AKYUU, 100)
  foepkmn2 = Pokemon.new(:AKYUU, 100)
  foepkmn3 = Pokemon.new(:AKYUU, 100)
  
  pkmn1move1 = :ROAROFTIME18
  pkmn1move2 = :BOLTBEAK18
  pkmn1move3 = :HIDDENPOWER18
  pkmn1move4 = :UNCOUNTABLESHEEP
  
  pkmn2move1 = :ABYSSOFCHAOS
  pkmn2move2 = :ENCHANTINGCONE
  pkmn2move3 = :SPIRALABYSS
  pkmn2move4 = :PROHIBITORYSIGNBOARD
  
  pkmn3move1 = :WALPURGISNIGHT
  pkmn3move2 = :LIGHTSPEED
  pkmn3move3 = :CREEPINGMYCELIUM
  pkmn3move4 = :FAETRICKERY
  
  pkmn1.learn_move(pkmn1move1)
  pkmn1.learn_move(pkmn1move2)
  pkmn1.learn_move(pkmn1move3)
  pkmn1.learn_move(pkmn1move4)
  
  pkmn2.learn_move(pkmn2move1)
  pkmn2.learn_move(pkmn2move2)
  pkmn2.learn_move(pkmn2move3)
  pkmn2.learn_move(pkmn2move4)
  
  pkmn3.learn_move(pkmn3move1)
  pkmn3.learn_move(pkmn3move2)
  pkmn3.learn_move(pkmn3move3)
  pkmn3.learn_move(pkmn3move4)
  setBattleRule("tempParty", [pkmn1, pkmn2, pkmn3])
  
  
  setBattleRule("editWildPokemon",{:hp_level => 10})
  setBattleRule("editWildPokemon", {
  :moves   => [pkmn1move1, pkmn1move2, pkmn1move3, pkmn1move4],
  })
  
  setBattleRule("editWildPokemon2",{:hp_level => 10})
  setBattleRule("editWildPokemon2", {
  :moves   => [pkmn2move1, pkmn2move2, pkmn2move3, pkmn2move4],
  })
  
  setBattleRule("editWildPokemon3",{:hp_level => 10})
  setBattleRule("editWildPokemon3", {
  :moves   => [pkmn3move1, pkmn3move2, pkmn3move3, pkmn3move4],
  })
  
  WildBattle.start(:AKYUU, 100, :AKYUU, 100, :AKYUU, 100)
end
