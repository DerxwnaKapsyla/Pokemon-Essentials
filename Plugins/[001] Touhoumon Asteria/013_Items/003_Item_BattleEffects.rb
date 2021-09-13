#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Removed explicit references to Pokemon
#	* Added in new items for Touhoumon mechanics
#	* Added in custom items not in Touhoumon
#	* Made tweaks to existing items
#==============================================================================#

ItemHandlers::CanUseInBattle.addIf(proc { |item| GameData::Item.get(item).is_poke_ball? },   # Poké Balls
  proc { |item,pokemon,battler,move,firstAction,battle,scene,showMessages|
    if battle.pbPlayer.party_full? && $PokemonStorage.full?
      scene.pbDisplay(_INTL("There is no room left in the PC!")) if showMessages
      next false
    end
    # NOTE: Using a Poké Ball consumes all your actions for the round. The code
    #       below is one half of making this happen; the other half is in def
    #       pbItemUsesAllActions?.
    if !firstAction
      scene.pbDisplay(_INTL("It's impossible to aim without being focused!")) if showMessages
      next false
    end
    if battler.semiInvulnerable?
      scene.pbDisplay(_INTL("It's no good! It's impossible to aim when the target in sight!")) if showMessages
      next false
    end
    # NOTE: The code below stops you from throwing a Poké Ball if there is more
    #       than one unfainted opposing Pokémon. (Snag Balls can be thrown in
    #       this case, but only in trainer battles, and the trainer will deflect
    #       them if they are trying to catch a non-Shadow Pokémon.)
    if battle.pbOpposingBattlerCount>1 && !(GameData::Item.get(item).is_snag_ball? && battle.trainerBattle?)
      if battle.pbOpposingBattlerCount==2
        scene.pbDisplay(_INTL("It's no good! It's impossible to aim when there are two on the field!")) if showMessages
      else
        scene.pbDisplay(_INTL("It's no good! It's impossible to aim when there are more than one on the field!")) if showMessages
      end
      next false
    end
    next true
  }
)

# ------ Liquid Revive: Max Elixir + Max Revive
ItemHandlers::CanUseInBattle.add(:LIQUIDREVIVE,proc { |item,pokemon,battler,move,firstAction,battle,scene,showMessages|
  if pokemon.able? || pokemon.egg?
    scene.pbDisplay(_INTL("It won't have any effect.")) if showMessages
    next false
  end
  canRestore = false
  for m in pokemon.moves
    next if m.id==0
    next if m.totalpp<=0 || m.pp==m.totalpp
    canRestore = true
    break
  end
  if !canRestore
    scene.pbDisplay(_INTL("It won't have any effect.")) if showMessages
    next false
  end
  next true
})
# ------ Derx: End of Liquid Revive code

ItemHandlers::UseInBattle.add(:POKEDOLL,proc { |item,battler,battle|
  battle.decision = 3
  pbSEPlay("Battle Flee") # Derx: Official Game Emulation
  battle.pbDisplayPaused(_INTL("You got away safely!"))
})

ItemHandlers::UseInBattle.add(:POKEFLUTE,proc { |item,battler,battle|
  battle.eachBattler do |b|
    next if b.status != :SLEEP || b.hasActiveAbility?(:SOUNDPROOF)
    b.pbCureStatus(false)
  end
  battle.pbDisplay(_INTL("All active battlers were roused by the tune!"))
})

# ------ Liquid Revive: Max Elixir + Max Revive
ItemHandlers::BattleUseOnPokemon.add(:LIQUIDREVIVE,proc { |item,pokemon,battler,choices,scene|
  pokemon.heal_HP
  pokemon.heal_status
  scene.pbRefresh
  for i in 0...pokemon.moves.length
    pbBattleRestorePP(pokemon,battler,i,pokemon.moves[i].total_pp)
  end
  scene.pbDisplay(_INTL("{1} was fully revitalized!",pokemon.name))
})
# ------ Derx: End of Liquid Revive code