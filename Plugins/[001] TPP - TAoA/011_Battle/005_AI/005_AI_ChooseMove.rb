  def set_up_move_check(move)
    case move.function_code
    when "UseLastMoveUsed"
      if @battle.lastMoveUsed &&
         GameData::Move.exists?(@battle.lastMoveUsed) &&
         !move.moveBlacklist.include?(GameData::Move.get(@battle.lastMoveUsed).function_code)
        move = Battle::Move.from_pokemon_move(@battle, Pokemon::Move.new(@battle.lastMoveUsed))
      end
    when "UseMoveDependingOnEnvironment", "UseMoveDependingOnEnvironmentThmn"
      move.pbOnStartUse(@user.battler, [])   # Determine which move is used instead
      move = Battle::Move.from_pokemon_move(@battle, Pokemon::Move.new(move.npMove))
    end
    @battle.moldBreaker = @user.has_mold_breaker?
    @move.set_up(move)
  end