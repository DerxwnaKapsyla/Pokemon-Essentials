Battle::AI::Handlers::MoveEffectScore.add("UltimateDream",
  proc { |score, move, user, ai, battle|
  if !user.status == :SLEEP
    raises = []
    GameData::Stat.each_battle do |s|
      next if target.stages[s.id] <= 0
      raises.push(s.id)
      raises.push(target.stages[s.id])
    end
    if raises.length > 0
      score = ai.get_score_for_target_stat_raise(score, user, raises, false)
      score = ai.get_score_for_target_stat_drop(score, target, raises, false, true)
    end
    ai.each_foe_battler(user.side) do |b, i|
      score += 5 if !b.check_for_move { |m| m.ignoresSubstitute?(b.battler) }
    end
  else
    if (user.pbOwnSide.effects[PBEffects::Reflect] > 0 &&
        user.pbOwnSide.effects[PBEffects::LightScreen] > 0) ||
		user.pbOwnSide.effects[PBEffects::AuroraVeil] > 0
	  score -= 10
	end
	
  end
  next score + 15
  }
)


Battle::AI::Handlers::MoveEffectAgainstTargetScore.copy("HealUserByHalfOfDamageDone", "UltimateDream")