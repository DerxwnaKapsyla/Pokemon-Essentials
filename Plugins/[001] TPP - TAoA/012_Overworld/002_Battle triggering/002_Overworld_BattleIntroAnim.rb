def pbBattleAnimation(bgm = nil, battletype = 0, foe = nil)
  $game_temp.in_battle = true
  viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
  viewport.z = 99999
  # Set up audio
  playingBGS = nil
  playingBGM = nil
  if $game_system.is_a?(Game_System)
    playingBGS = $game_system.getPlayingBGS
    playingBGM = $game_system.getPlayingBGM
    $game_system.bgm_pause
    $game_system.bgs_pause
    if $game_temp.memorized_bgm
      playingBGM = $game_temp.memorized_bgm
      $game_system.bgm_position = $game_temp.memorized_bgm_position
    end
  end
  # Play battle music
  bgm = pbGetWildBattleBGM([]) if !bgm
  pbBGMPlay(bgm)
  # Determine location of battle
  location = 0   # 0=outside, 1=inside, 2=cave, 3=water
  if $PokemonGlobal.surfing || $PokemonGlobal.diving
    location = 3
  elsif $game_temp.encounter_type &&
        GameData::EncounterType.get($game_temp.encounter_type).type == :fishing
    location = 3
  elsif $PokemonEncounters.has_cave_encounters?
    location = 2
  elsif !$game_map.metadata&.outdoor_map
    location = 1
  end
  # Check for custom battle intro animations
  handled = false
  SpecialBattleIntroAnimations.each do |name, priority, condition, animation|
    next if !condition.call(battletype, foe, location)
    animation.call(viewport, battletype, foe, location)
    handled = true
    break
  end
  # Default battle intro animation
  if !handled
    # Determine which animation is played
    anim = ""
    if PBDayNight.isDay?
      case battletype
      when 0, 2   # Wild, double wild
        anim = ["SnakeSquares", "DiagonalBubbleTL", "DiagonalBubbleBR", "RisingSplash"][location]
      when 1      # Trainer
        anim = ["TwoBallPass", "ThreeBallDown", "BallDown", "WavyThreeBallUp"][location]
      when 3      # Double trainer
        anim = "FourBallBurst"
      end
    else
      case battletype
      when 0, 2   # Wild, double wild
        anim = ["SnakeSquares", "DiagonalBubbleBR", "DiagonalBubbleBR", "RisingSplash"][location]
      when 1      # Trainer
        anim = ["SpinBallSplit", "BallDown", "BallDown", "WavySpinBall"][location]
      when 3      # Double trainer
        anim = "FourBallBurst"
      end
    end
    pbBattleAnimationCore(anim, viewport, location)
  end
  pbPushFade
  # Yield to the battle scene
  yield if block_given?
  # After the battle
  pbPopFade
  if $game_system.is_a?(Game_System) && !$game_switches[96]
    $game_system.bgm_resume(playingBGM)
    $game_system.bgs_resume(playingBGS)
  end
  $game_temp.memorized_bgm            = nil
  $game_temp.memorized_bgm_position   = 0
  $PokemonGlobal.nextBattleBGM        = nil
  $PokemonGlobal.nextBattleVictoryBGM = nil
  $PokemonGlobal.nextBattleCaptureME  = nil
  $PokemonGlobal.nextBattleBack       = nil
  $PokemonEncounters.reset_step_count
  # Fade back to the overworld in 0.4 seconds
  if !$game_switches[95]
    viewport.color = Color.black
  else
    viewport.color = Color.white
  end
  timer_start = System.uptime
  loop do
    Graphics.update
    Input.update
    pbUpdateSceneMap
    viewport.color.alpha = 255 * (1 - ((System.uptime - timer_start) / 0.4))
    break if viewport.color.alpha <= 0
  end
  viewport.dispose
  $game_temp.in_battle = false
end
