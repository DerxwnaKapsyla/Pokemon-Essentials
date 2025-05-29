#===============================================================================
# Walpurgis Night - Sasha's Signature Attack
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.add("WalpurgisNight",
  proc { |move, user, ai, battle|
    will_fail = true
    battle.eachInTeamFromBattlerIndex(user.index) do |pkmn, i|
      next if pkmn.able?
      will_fail = false
      break
    end
    next will_fail
  }
)
Battle::AI::Handlers::MoveBasePower.add("WalpurgisNight",
  proc { |power, move, user, target, ai, battle|
    ret = 0
    battle.eachInTeamFromBattlerIndex(user.index) do |pkmn, _i|
      ret += 5 + (pkmn.baseStats[:ATTACK] / 10) if !pkmn.able?
    end
    next ret
  }
)
Battle::AI::Handlers::MoveEffectAgainstTargetScore.add("WalpurgisNight",
  proc { |score, move, user, target, ai, battle|
    # Prefer if the target has a Substitute and this move can break it before
    # the last hit
    if target.effects[PBEffects::Substitute] > 0 && !move.move.ignoresSubstitute?(user.battler)
      dmg = move.rough_damage
      num_hits = 0
      battle.eachInTeamFromBattlerIndex(user.index) do |pkmn, _i|
        num_hits += 1 if !pkmn.able?
      end
      score += 10 if target.effects[PBEffects::Substitute] < dmg * (num_hits - 1) / num_hits
    end
    next score
  }
)

