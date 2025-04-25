class Battle::Move
  # The maximum number of hits in a round this move will actually perform. This
  # can be 1 for Beat Up, and can be 2 for any moves affected by Parental Bond.
  def pbNumHits(user, targets)
    if (user.hasActiveAbility?(:PARENTALBOND) ||
        user.hasActiveAbility?(:SPECTRALSTRIKE)) && pbDamagingMove? &&
       !chargingTurnMove? && targets.length == 1
      # Record that Parental Bond applies, to weaken the second attack
      user.effects[PBEffects::ParentalBond] = 3
      return 2
    end
    return 1
  end
end