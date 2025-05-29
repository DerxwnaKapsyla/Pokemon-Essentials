Battle::AI::Handlers::MoveFailureCheck.add("CreepingMycelium",
  proc { |move, user, ai, battle|
    next user.pbOpposingSide.effects[PBEffects::Miasma]
  }
)
Battle::AI::Handlers::MoveEffectScore.add("CreepingMycelium",
  proc { |score, move, user, ai, battle|
    inBattleIndices = battle.allSameSideBattlers(user.idxOpposingSide).map { |b| b.pokemonIndex }
    foe_reserves = []
    battle.pbParty(user.idxOpposingSide).each_with_index do |pkmn, idxParty|
      next if !pkmn || !pkmn.able? || inBattleIndices.include?(idxParty)
      if ai.trainer.medium_skill?
        next if pkmn.hasItem?(:HEAVYDUTYBOOTS)
        next if pkmn.hasAbility?(:MAGICGUARD)
      end
      foe_reserves.push(pkmn)   # pkmn will be affected by Stealth Rock
    end
    next Battle::AI::MOVE_USELESS_SCORE if foe_reserves.empty?
    score += [10 * foe_reserves.length, 30].min
    next score
  }
)