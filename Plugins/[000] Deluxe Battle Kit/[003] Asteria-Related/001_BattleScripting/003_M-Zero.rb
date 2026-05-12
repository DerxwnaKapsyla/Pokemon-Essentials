  #-----------------------------------------------------------------------------
  # Scene: Vs. Experiment M-No. #000 - MissingNo.
  #-----------------------------------------------------------------------------  
  MidbattleHandlers.add(:midbattle_scripts, :vs_missingno,
    proc { |battle, idxBattler, idxTarget, trigger|
	  scene   = battle.scene
	  foe     = battle.battlers[1]
	  player  = battle.battlers[0]
	  battler = battle.battlers[idxBattler]
      logname = _INTL("{1} ({2})", battler.pbThis(true), battler.index)
	  #$game_variables[148] = 0 # Turn count
	  #$game_variables[149] = 0 # Insanity Level
	  #$game_variables[150] = 0 # Times KO'd
	  case trigger  
	  #---------------------------------------------
	  # Condition: Start of Battle:
	  #   * Mention that M0 has emitted a powerful electric pulse
	  #   * Show an electric discharge animation
	  #   * Show a paralysis animation on the player
	  #   * Mention that Pokeballs are disabled for this fight
	  #---------------------------------------------
	  when "RoundStartCommand_1_foe"
	    echoln "Condition: Start of Battle."
		PBDebug.log("[Midbattle Script] '#{trigger}' triggered by #{logname}...")
	    @mzero_turncount  = 0
	    @mzero_insanitylv = 0
	    @mzero_kocounter  = 0
		battle.pbDisplayPaused(_INTL("Experiment M-Zero emited a powerful electro-magnetic pulse!"))
		foe.displayPokemon.play_cry
		battle.pbAnimation(:DISCHARGE, foe, foe)
		battle.pbAnimation(:CHARGE, player, player)
		pbSEPlay("Anim/Paralyze3")
		battle.pbDisplayPaused(_INTL("Your Poké Balls short-circuited!\nThey cannot be used this battle!"))
		foe.damageThreshold = 1
		PBDebug.log("[Midbattle Script] '#{trigger}' effects ended")
	  #---------------------------------------------
	  # Condition: End of Turn
	  #   * 1 in 3 chance of inflicting a random status condition on the player's side
	  #   * Check Turn Counter for effects.
	  #     * Turn 3 - Stage 1 Insanity
	  #     * Turn 6 - Stage 2 Insanity
	  #     * Turn 9 - Stage 3 Insanity
	  #     * Turn 18 - Stage 0 Insanity
	  #---------------------------------------------
	  when "RoundEnd_foe"
	    echoln "Condition: End of Round."
		PBDebug.log("[Midbattle Script] '#{trigger}' triggered by #{logname}...")
		#battle.midbattleVariable += 1
		@mzero_turncount += 1
		if rand(100) < 33 && player.status == :NONE
		  echoln "Executing random status condition."
		  battle.pbDisplayPaused(_INTL("Experiment M-Zero emits a bizarre energy pulse!"))
		  foe.displayPokemon.play_cry
		  battle.pbAnimation(:TERRAINPULSE, player, player)
		  case rand(5)
		  when 0 then player.pbParalyze if player.pbCanInflictStatus?(:PARALYSIS, player, true)
		  when 1 then player.pbFreeze if player.pbCanInflictStatus?(:FREEZE, player, true)
		  when 2 then player.pbBurn if player.pbCanInflictStatus?(:BURN, player, true)
		  when 3 then player.pbPoison if player.pbCanInflictStatus?(:POISON, player, true)
		  when 4 then player.pbSleep if player.pbCanInflictStatus?(:SLEEP, player, true)
		  end
	    end
	  #---------------------------------------------
	  # Stage 1 Insanity:
	  #   * Player says they aren't feeling so good and that everthing is going out of focus
	  #   * Backdrop changes to distorted factory
	  #   * Display message that reality is bgecoming warped
	  #   * Lower accuracy of Player's active battler by 1
	  #   * Display: "@ # $ $  & $'  # ^ $ ^ $ $ ; ; ;"
	  #---------------------------------------------
		if @mzero_turncount == 3
		  echoln "Turn Count 3: Executing Stage 1 Insanity."
		  battle.backdrop = "factory_distorted"
		  scene.pbFlashRefresh
		  scene.pbStartSpeech(0)
          battle.pbDisplayPaused(_INTL("(Is it just me or is everything going out of focus...?)"))
		  scene.pbForceEndSpeech
		  battle.pbDisplayPaused(_INTL("Suddenly, realty around you is becoming warped."))
		  player.pbLowerStatStage(:ACCURACY, 1, player, true)
		  scene.pbStartSpeech(0)
          scene.pbShowSpeakerWindows("Experiment M-Zero", 1)
		  foe.displayPokemon.play_cry
		  battle.pbDisplayPaused(_INTL("@ # $ $  & $'  # ^ $ ^ $ $ ; ; ;"))
		  scene.pbForceEndSpeech
		  @mzero_insanitylv = 1
	  #---------------------------------------------
	  # Stage 2 Insanity:
	  #   * Yumemi asks if player is doing okay
	  #   * Backdrop changes to glitched factory 1
	  #   * Song changes to Fires of Hokkai Pitch 1
	  #   * Display message that player blinked, and now numbers are all around them
	  #   * Lower accuracy of Player's active battler by 1
	  #   * Display: "S e r r  z r,  c y r n f r . . ."
	  #---------------------------------------------
		elsif @mzero_turncount == 6
		  echoln "Turn Count 6: Executing Stage 2 Insanity."
		  battle.pbDisplayPaused(_INTL("When you blink, you notice that the world around you has changed."))
		  battle.backdrop = "factory_glitch_1"
		  scene.pbFlashRefresh
		  pbBGMPlay("W-031. Fires of Hokkai (Pitch Alter 1)")
		  scene.pbStartSpeech(0)
          scene.pbShowSpeakerWindows("Yumemi", 1)
		  battle.pbDisplayPaused(_INTL("Hey, {1}, are you okay? You don't look so good.",$player.name))
		  scene.pbForceEndSpeech
		  battle.pbDisplayPaused(_INTL("You look around, and your vision fills with numbers."))
		  player.pbLowerStatStage(:ACCURACY, 1, player, true)
		  scene.pbStartSpeech(0)
          scene.pbShowSpeakerWindows("Experiment M-Zero", 1)
		  foe.displayPokemon.play_cry
		  battle.pbDisplayPaused(_INTL("S e r r  z r,  c y r n f r . . ."))
		  scene.pbForceEndSpeech
		  @mzero_insanitylv = 2
	  #---------------------------------------------
	  # Stage 3 Insanity:
	  #   * Display binary from Yumemi
	  #   * Backdrop changes to glitched factory 2
	  #   * Song changes to Fires of Hokkai Pitch 2
	  #   * Display message that player blinked, and "The world is made of code. All life 
	  #	    is quantifiable by ones and zeroes."
	  #   * Lower accuracy of Player's active battler by 1
	  #   * Display: "F r e e  m e,  p l e a s e . . ."
	  #---------------------------------------------
		elsif @mzero_turncount == 9
		  echoln "Turn Count 9: Executing Stage 3 Insanity."
		  battle.pbDisplayPaused(_INTL("You blink once more, and..."))
		  battle.backdrop = "factory_glitch_2"
		  scene.pbFlashRefresh
		  pbBGMPlay("W-031. Fires of Hokkai (Pitch Alter 2)")
		  battle.pbDisplayPaused(_INTL("...The world is made of code."))
		  battle.pbDisplayPaused(_INTL("All life is quantifiable by ones and zeroes."))
		  battle.pbDisplayPaused(_INTL("Is this the truth of reality? A simulation? Bytes on a computer screen?"))
		  scene.pbStartSpeech(0)
          scene.pbShowSpeakerWindows("Yumemi", 1)
		  battle.pbDisplayPaused(_INTL("01001000 01100101 01111001 00100001 00100000 01010011 01101110 01100001 01110000 00100000 01101111 01110101 01110100 00100000 01101111 01100110 00100000 01101001 01110100 00100001"))
		  scene.pbForceEndSpeech
		  player.pbLowerStatStage(:ACCURACY, 1, player, true)
		  scene.pbStartSpeech(0)
          scene.pbShowSpeakerWindows("Experiment M-Zero", 1)
		  foe.displayPokemon.play_cry
		  battle.pbDisplayPaused(_INTL("F r e e  m e,  p l e a s e . . ."))
		  scene.pbForceEndSpeech
	      @mzero_insanitylv = 3
	  #---------------------------------------------
	  # Stage 0 Insanity
	  #   * Display message that reality returns to normal
	  #   * Backdrop changes to factory
	  #   * Song changes to Fires of Hokkai
	  #---------------------------------------------
		elsif @mzero_turncount == 18
		  echoln "Turn Count 18: Resetting insanity value to 0."
		  battle.pbDisplayPaused(_INTL("The construct that you refer to as eyes refreshes once more, and..."))
		  battle.backdrop = "factory"
		  pbBGMPlay("W-031. Fires of Hokkai")
		  battle.pbDisplayPaused(_INTL("Reality returns to normal... You think?"))
		  scene.pbStartSpeech(0)
          battle.pbDisplayPaused(_INTL("(Did that all just happen, or did I imagine it?"))
		  scene.pbForceEndSpeech
		  @mzero_insanitylv = 0
		end
		PBDebug.log("[Midbattle Script] '#{trigger}' effects ended")
	  #---------------------------------------------
	  # Condition: M0 hits low HP
	  #   * Three phases of this, increases variable each time.
	  #   * All altered stats are reset
	  #   * HP is fully restored
	  #   * Display messages based on which phase this is
	  #   * Boost M0's stats based on which phase this is
	  #---------------------------------------------
	  when "BattlerReachedHPCap"
	    echoln "Condition: M-Zero has reached low HP."
		PBDebug.log("[Midbattle Script] '#{trigger}' triggered by #{logname}...")
		echoln "Checking M-Zero KO counter."
		next if @mzero_kocounter == 3
		echoln "M-Zero KO Counter below 3. Continuing check."
		foe.pbResetStatStages
		foe.pbRecoverHP(999999)
	  #---------------------------------------------
	  # Phase 1:
	  #   * M0 lets out a loud cry
	  #   * Display glitched text which looks different based on what level of Insanity the player is in:
	  #     * Stage 1 Insanity: "^ # $  ( % ^  & $ # $  % %  @ # $ $  ! $ !"
	  #     * Stage 2 Insanity: "N e r  l b h  u r e r  g b  s e r r  z r?"
	  #     * Stage 3 Insanity: "A r e  y o u  h e r e  t o  f r e e  m e?"
	  #     * At Stage 0 Insanity, display the Stage 1 Insanity variant
	  #   * Boost M0's Def and SpDef by 1 stage
	  #   * Message from player.
	  #---------------------------------------------
	    if @mzero_kocounter == 0
		  echoln "M-Zero KO Counter is 0. Setting to 1."
		  battle.pbDisplayPaused(_INTL("Experiment M-Zero lets out a loud cry!"))
		  foe.displayPokemon.play_cry
		  scene.pbStartSpeech(0)
          scene.pbShowSpeakerWindows("Experiment M-Zero", 1)
		  if @mzero_insanitylv <= 1
		    battle.pbDisplayPaused(_INTL("^ # $  ( % ^  & $ # $  % %  @ # $ $  ! $ !"))
		  elsif @mzero_insanitylv == 2
		    battle.pbDisplayPaused(_INTL("N e r  l b h  u r e r  g b  s e r r  z r?"))
		  elsif @mzero_insanitylv == 3
		    battle.pbDisplayPaused(_INTL("A r e  y o u  h e r e  t o  f r e e  m e?"))
		  end
		  scene.pbForceEndSpeech
		  showAnim = true
		  [:DEFENSE, :SPECIAL_DEFENSE].each do |stat|
	        next if !foe.pbCanRaiseStatStage?(stat, foe)
		    foe.pbRaiseStatStage(stat, 1, foe, showAnim)
		    showAnim = false
	      end
		  scene.pbStartSpeech(0)
		  battle.pbDisplayPaused(_INTL("It stood back up... C'mon {1}, we can do this!", player.pbThis))
		  foe.damageThreshold = -1
		  @mzero_kocounter += 1
	  #---------------------------------------------
	  # Phase 2:
	  #   * M0 lets out a deafening cry
	  #   * Display glitched text which looks different based on what level of Insanity the player is in:
	  #     * Stage 1 Insanity: "$  @ ^ $ %  & ^ ! %  % %  ( $  @ # $ $  @ # % !  ! (  # ^ $ ! ; ; ;"
	  #     * Stage 2 Insanity: "V  w h f g  j n a g  g b  o r  s e r r  s e b z  z l  c n v a . . ."
	  #     * Stage 3 Insanity: "I  j u s t  w a n t  t o  b e  f r e e  f r o m  m y  p a i n . . ."
	  #     * At Stage 0 Insanity, display the Stage 1 Insanity variant
	  #   * Boost M0's Def and SpDef by 2 stages
	  #   * Message from player and Yumemi.
	  #---------------------------------------------
	    elsif @mzero_kocounter == 1
		  echoln "M-Zero KO Counter is 1. Setting to 2."
		  battle.pbDisplayPaused(_INTL("Experiment M-Zero lets out a deafening cry!"))
		  foe.displayPokemon.play_cry
		  scene.pbStartSpeech(0)
          scene.pbShowSpeakerWindows("Experiment M-Zero", 1)
		  if @mzero_insanitylv <= 1
		    battle.pbDisplayPaused(_INTL("$  @ ^ $ %  & ^ ! %  % %  ( $  @ # $ $  @ # % !  ! (  # ^ $ ! ; ; ;"))
		  elsif @mzero_insanitylv == 2
		    battle.pbDisplayPaused(_INTL("V  w h f g  j n a g  g b  o r  s e r r  s e b z  z l  c n v a . . ."))
		  elsif @mzero_insanitylv == 3
		    battle.pbDisplayPaused(_INTL("I  j u s t  w a n t  t o  b e  f r e e  f r o m  m y  p a i n . . ."))
		  end
		  scene.pbForceEndSpeech
		  showAnim = true
		  [:DEFENSE, :SPECIAL_DEFENSE].each do |stat|
	        next if !foe.pbCanRaiseStatStage?(stat, foe)
		    foe.pbRaiseStatStage(stat, 2, foe, showAnim)
		    showAnim = false
	      end
		  scene.pbStartSpeech(0)
		  battle.pbDisplayPaused(_INTL("It got back up again!?"))
		  scene.pbShowSpeakerWindows("Yumemi", 1)
		  battle.pbDisplayPaused(_INTL("It must have inherited Mew's propensity for life! That must be why it's still alive after all these years!"))
		  foe.damageThreshold = -1
		  @mzero_kocounter += 1
	  #---------------------------------------------
	  # Phase 3:
	  #   * M0 lets out a earth-shatteringly loud howl
	  #   * Display glitched text which looks different based on what level of Insanity the player is in:
	  #     * Stage 1 Insanity: "# ^ $ ^ $ $ ?  *  ) ^ ! | %  % ^ @ $  $ %  ^ ! ( ! % # $ ?"
	  #     * Stage 2 Insanity: "C y r n f r !  V  p n a ' g  g n x r  v g  n a l z b e r !"
	  #     * Stage 3 Insanity: "P l e a s e !  I  c a n ' t  t a k e  i t  a n y m o r e !"
	  #     * At Stage 0 Insanity, display the Stage 1 Insanity variant
	  #   * Boost M0's Def and SpDef by 3 stages
	  #   * Message from player and Yumemi.
	  #---------------------------------------------
	    elsif @mzero_kocounter == 2
		  echoln "M-Zero KO Counter is 2. Setting to 3."
		  battle.pbDisplayPaused(_INTL("Experiment M-Zero lets out an earth-shatteringly loud howl!"))
		  foe.displayPokemon.play_cry
		  scene.pbStartSpeech(0)
          scene.pbShowSpeakerWindows("Experiment M-Zero", 1)
		  if @mzero_insanitylv <= 1
		    battle.pbDisplayPaused(_INTL("# ^ $ ^ $ $ ?  *  ) ^ ! | %  % ^ @ $  $ %  ^ ! ( ! % # $ ?"))
		  elsif @mzero_insanitylv == 2
		    battle.pbDisplayPaused(_INTL("C y r n f r !  V  p n a ' g  g n x r  v g  n a l z b e r !"))
		  elsif @mzero_insanitylv == 3
		    battle.pbDisplayPaused(_INTL("P l e a s e !  I  c a n ' t  t a k e  i t  a n y m o r e !"))
		  end
		  scene.pbForceEndSpeech
		  showAnim = true
		  [:DEFENSE, :SPECIAL_DEFENSE].each do |stat|
	        next if !foe.pbCanRaiseStatStage?(stat, foe)
		    foe.pbRaiseStatStage(stat, 2, foe, showAnim)
		    showAnim = false
	      end
		  scene.pbStartSpeech(0)
		  battle.pbDisplayPaused(_INTL("How many more times can it get back up?!"))
		  scene.pbShowSpeakerWindows("Yumemi", 1)
		  battle.pbDisplayPaused(_INTL("It must be close to exhausted by this point! Don't let up!"))
		  scene.pbForceEndSpeech
		  @mzero_kocounter += 1
		  foe.damageThreshold = 0
		end
		PBDebug.log("[Midbattle Script] '#{trigger}' effects ended")
	  #---------------------------------------------
	  # Condition: M0 Faints
	  #   * Depending on Insanity Stage, display a different message
	  #     * Stage 1 Insanity: "% & ^ ! @  * % ^ ; ; ;"
	  #     * Stage 2 Insanity: "G u n a x  l b h . . ."
	  #     * Stage 3 Insanity: "T h a n k  y o u . . ."
	  #---------------------------------------------
	  # when "BattlerFainted_foe"
        # scene.pbShowSpeakerWindows("Experiment M-Zero", 1)
		# if @mzero_insanitylv <= 1
		  # battle.pbDisplayPaused(_INTL("% & ^ ! @  * % ^ ; ; ;"))
		# elsif @mzero_insanitylv == 2
		  # battle.pbDisplayPaused(_INTL("G u n a x  l b h . . ."))
		  # elsif @mzero_insanitylv == 3
		  # battle.pbDisplayPaused(_INTL("T h a n k  y o u . . ."))
		# end
		# scene.pbForceEndSpeech
	  end
    }
  )