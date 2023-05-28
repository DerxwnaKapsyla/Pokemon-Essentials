EventHandlers.add(:on_wild_pokemon_created, :legendary_music,
  proc { |pkmn|
    case pkmn.species
    when :MEW
      $PokemonGlobal.nextBattleBGM = pbStringToAudioFile("RSE 316 Battle! Mew")
    end
  }
)