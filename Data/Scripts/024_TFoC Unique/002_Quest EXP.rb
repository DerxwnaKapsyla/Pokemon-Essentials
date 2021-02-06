def pbQuestEXPReward(exp)
  $Trainer.pokemonParty.each{|pkmn|
    oldlevel=pkmn.level
    pkmn.exp+=exp
    if pkmn.level>oldlevel
	  pkmn.calcStats
      pbMessage(_INTL("{1} grew to Lv. {2}!",pkmn.name,pkmn.level))
      movelist = pkmn.getMoveList
      for i in movelist
        next if i[0]!=pkmn.level
        pbLearnMove(pkmn,i[1],true)
      end
      # Check for evolution
      newspecies = pbCheckEvolution(pkmn)
      if newspecies>0
        pbFadeOutInWithMusic {
          evo = PokemonEvolutionScene.new
          evo.pbStartScreen(pkmn,newspecies)
          evo.pbEvolution
          evo.pbEndScreen
        }
      end
    end
  }
end