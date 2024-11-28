  #-----------------------------------------------------------------------------
  # Touhoumon Asteria
  #-----------------------------------------------------------------------------
  # Scene: Red vs. Chibi Chen, Pallet Town
  #-----------------------------------------------------------------------------  
  MidbattleHandlers.add(:midbattle_scripts, :red_vs_chen,
    proc { |battle, idxBattler, idxTarget, trigger|
	  scene = battle.scene
	  foe = battle.battlers[1]
	  player = battle.battlers[0]
	  battler = battle.battlers[idxBattler]
      logname = _INTL("{1} ({2})", battler.pbThis(true), battler.index)
	  case trigger
	  #---------------------------------------------
	  # Condition: Start of Battle:
	  #   * Speech from Professor Oak.
	  #   * Make it so Reimu can't be lowered below 1 HP.
	  #---------------------------------------------
	  when "RoundStartCommand_1_foe"
	    PBDebug.log("[Midbattle Script] '#{trigger}' triggered by #{logname}...")
        scene.pbStartSpeech(0)
        scene.pbShowSpeakerWindows("Prof. Oak", 1)
        battle.pbDisplayPaused(_INTL("Red! Remember what I told you!"))
		battle.pbDisplayPaused(_INTL("That Reimu Puppet is just like a Pokémon!"))
		battle.pbDisplayPaused(_INTL("Command her, and she'll fight alongside you!"))
		scene.pbForceEndSpeech
		PBDebug.log("[Midbattle Script] '#{trigger}' effects ended")
	  #---------------------------------------------
	  # Condition: Player-side battler HP low
	  # Trigger Status: Repeat
	  #  * Display a message that CReimu got a second wind.
	  #  * Restore CReimu to full HP.
	  #---------------------------------------------
	  when "TargetHPLow_player"
	    PBDebug.log("[Midbattle Script] '#{trigger}' triggered by #{logname}...")
		battle.pbDisplayPaused(_INTL("{1} got her second wind and rose back up!",player.pbThis))
		player.pbRecoverHP(player.totalhp)
		PBDebug.log("[Midbattle Script] '#{trigger}' effects ended")
	  end
    }
  )
  
  #-----------------------------------------------------------------------------
  # Scene: Renko & Maribel Vs. Red, Pallet Town
  #-----------------------------------------------------------------------------  
  MidbattleHandlers.add(:midbattle_scripts, :renmari_vs_red,
    proc { |battle, idxBattler, idxTarget, trigger|
	  scene = battle.scene
	  red1    = battle.battlers[1]
	  red2    = battle.battlers[3]
	  player  = battle.battlers[0]
	  partner = battle.battlers[2]
	  battler = battle.battlers[idxBattler]
      logname = _INTL("{1} ({2})", battler.pbThis(true), battler.index)
	  case trigger
	  #---------------------------------------------
	  # Condition: Start of Battle:
	  #   * Speech from Renko and Maribel
	  #   * Speech from Red to follow up
	  #---------------------------------------------
	  when "RoundStartAttack_1_player"
	    next if battle.pbTriggerActivated?("RoundStartAttack_1_ally")
	    PBDebug.log("[Midbattle Script] '#{trigger}' triggered by #{logname}...")
		scene.pbStartSpeech(0)
		scene.pbShowSpeakerWindows("Renko", 1)
		battle.pbDisplayPaused(_INTL("Let's sow Red how well we work together as a team, Mary!"))
		scene.pbShowSpeakerWindows("Maribel", nil)
		battle.pbDisplayPaused(_INTL("I'm right beside you, Renko!"))
		scene.pbShowSpeakerWindows("Red", nil)
		battle.pbDisplayPaused(_INTL("..."))
		scene.pbForceEndSpeech
		PBDebug.log("[Midbattle Script] '#{trigger}' effects ended")
		
	  when "RoundStartAttack_1_ally"
	    next if battle.pbTriggerActivated?("RoundStartAttack_1_player")
		PBDebug.log("[Midbattle Script] '#{trigger}' triggered by #{logname}...")
		scene.pbStartSpeech(0)
		scene.pbShowSpeakerWindows("Renko", 1)
		battle.pbDisplayPaused(_INTL("Let's sow Red how well we work together as a team, Mary!"))
		scene.pbShowSpeakerWindows("Maribel", nil)
		battle.pbDisplayPaused(_INTL("I'm right beside you, Renko!"))
		scene.pbShowSpeakerWindows("Red", nil)
		battle.pbDisplayPaused(_INTL("..."))
		scene.pbForceEndSpeech
		PBDebug.log("[Midbattle Script] '#{trigger}' effects ended")
	  #---------------------------------------------
	  # Condition: Player-side KO'd
	  #   * Speech from player, with partner to follow
	  #---------------------------------------------
	  when "BattlerFainted_player"
	    next if battle.pbTriggerActivated?("BattlerFainted_ally")
		PBDebug.log("[Midbattle Script] '#{trigger}' triggered by #{logname}...")
		scene.pbStartSpeech(0)
		battle.pbDisplayPaused(_INTL("Oh no!"))
		scene.pbForceEndSpeech
		scene.pbStartSpeech(2)
		battle.pbDisplayPaused(_INTL("It's alright, I've got this!"))
		scene.pbForceEndSpeech
		PBDebug.log("[Midbattle Script] '#{trigger}' effects ended")
	  #---------------------------------------------
	  # Condition: Partner-side KO'd
	  #   * Speech from partner, with player to follow
	  #---------------------------------------------  
	  when "BattlerFainted_ally"
	    next if battle.pbTriggerActivated?("BattlerFainted_player")
		PBDebug.log("[Midbattle Script] '#{trigger}' triggered by #{logname}...")
		scene.pbStartSpeech(2)
		battle.pbDisplayPaused(_INTL("Oh no!"))
		scene.pbForceEndSpeech
		scene.pbStartSpeech(0)
		battle.pbDisplayPaused(_INTL("It's alright, I've got this!"))
		scene.pbForceEndSpeech
		PBDebug.log("[Midbattle Script] '#{trigger}' effects ended")	  
	  end
    }
  )
  #-----------------------------------------------------------------------------
  # Scene: Vs. Chibi Kazami, A Thorny Situation sidequest
  #-----------------------------------------------------------------------------  
  MidbattleHandlers.add(:midbattle_scripts, :vs_kazami,
    proc { |battle, idxBattler, idxTarget, trigger|
	  scene = battle.scene
	  foe     = battle.battlers[1]
	  player  = battle.battlers[0]
	  battler = battle.battlers[idxBattler]
      logname = _INTL("{1} ({2})", battler.pbThis(true), battler.index)
	  case trigger    
	  #---------------------------------------------
	  # Condition: Start of Battle:
	  #   * Check if Switch 107 is on.
	  #   * If Off...
	  #     * Player remarks that CKazami doesn't look threatening
	  #     * CKazami gains +2 to Def/SDef
	  #   * If On...
	  #     * Player remarks they wont get caught off guard again
	  #     * Kazami takes up a battling stance and boosts Atk/SAtk/Spd +1
	  #     * Kazami equips a Malachite
	  #   * Mention that vines are making it impossible to use Poke Balls
	  #---------------------------------------------
	  when "RoundStartCommand_1_foe"
	    PBDebug.log("[Midbattle Script] '#{trigger}' triggered by #{logname}...")
		if !$game_switches[107]
		  scene.pbStartSpeech(0)
		  battle.pbDisplayPaused(_INTL("So this is the Puppet that all those construction workers are afraid of?"))
		  battle.pbDisplayPaused(_INTL("She looks too sleepy to be of any harm, but I guess looks can be decieving..."))
		  scene.pbForceEndSpeech
		  battle.pbDisplayPaused(_INTL("The wild CKazami begins to defend itself!"))
		  foe.displayPokemon.play_cry
	      showAnim = true
		  [:DEFENSE, :SPECIAL_DEFENSE].each do |stat|
	        next if !foe.pbCanRaiseStatStage?(stat, foe)
		    foe.pbRaiseStatStage(stat, 2, foe, showAnim)
		    showAnim = false
	      end
		  damageThreshold = 10
		else
		  scene.pbStartSpeech(0)
		  battle.pbDisplayPaused(_INTL("That last fight caught us off guard, but we won't falter again!"))
		  battle.pbDisplayPaused(_INTL("Let's do this, {1}", player.pbThis))
		  scene.pbForceEndSpeech
		  battle.pbDisplayPaused(_INTL("The wild Kazami takes up a battling stance!"))
		  foe.displayPokemon.play_cry
	      showAnim = true
		  [:ATTACK, :SPECIAL_ATTACK, :SPEED].each do |stat|
	        next if !foe.pbCanRaiseStatStage?(stat, foe)
		    foe.pbRaiseStatStage(stat, 1, foe, showAnim)
		    showAnim = false
	      end
		  foe.item = :MALACHITE
		  battle.pbDisplayPaused(_INTL("The wild Kazami is ready to fight once again!"))
		end
		battle.pbAnimation(:INGRAIN, foe, foe)
		battle.pbDisplayPaused(_INTL("The vines that rose out of the ground are making it difficult to throw Poké Balls!"))
		battle.pbDisplayPaused(_INTL("They cannot be used this battle!"))
		PBDebug.log("[Midbattle Script] '#{trigger}' effects ended")	  
	  #---------------------------------------------
	  # Condition: Foe hits Low HP
	  #   * Do not execute the following code if switch 107 is on
	  #   * Player mentions they're about to finish it off
	  #   * CKazami restores all health
	  #   * Reset Kazami's stats
	  #   * CKazami evolves into Kazami
	  #   * Change battle background
	  #   * Change battle BG
	  #   * Change Kazami's moves
	  #   * Change Kazami's held item to Malachite
	  #   * Boost +1 Atk/SAtk/Spd
	  #   * Turnh on Switch 107
	  #---------------------------------------------
	  when "RoundEnd_foe"
		PBDebug.log("[Midbattle Script] '#{trigger}' triggered by #{logname}...")
		next if $game_switches[107]
	    next if !battle.pbTriggerActivated?("BattlerReachedHPCap")
		pbBGMFade(1)
		scene.pbStartSpeech(0)
		battle.pbDisplayPaused(_INTL("Alright, we're getting close!"))
		battle.pbDisplayPaused(_INTL("Let's finish this next turn, {1}", player.pbThis))
		scene.pbForceEndSpeech
		pbWait(0.25)
		foe.displayPokemon.play_cry
		foe.pbRecoverHP(foe.totalhp)
		battle.pbDisplayPaused(_INTL("The wild CKazami stood back up!", player.pbThis))
		scene.pbStartSpeech(0)
		battle.pbDisplayPaused(_INTL("Wait... What's it doing?"))
		scene.pbForceEndSpeech
		foe.pbEvolveBattler(:KAZAMI)
		battle.backdrop = "Forest_Alt1"
		scene.pbStartSpeech(0)
		battle.pbDisplayPaused(_INTL("No way... Did- Did it just evolove in the middle of battle!?"))
		battle.pbDisplayPaused(_INTL("Is this why the workers had such a hard time with it...? This doesn't bode well."))
		battle.pbDisplayPaused(_INTL("Stay sharp, {1}!",player.pbThis))
		scene.pbForceEndSpeech
		foe.pbResetStatStages
		pbBGMPlay("B-009. Faint Dream ~ Inanimate Dream")
		foe.displayPokemon.play_cry
	    showAnim = true
		[:ATTACK, :SPECIAL_ATTACK, :SPEED].each do |stat|
	      next if !foe.pbCanRaiseStatStage?(stat, foe)
		  foe.pbRaiseStatStage(stat, 1, foe, showAnim)
		  showAnim = false
	    end
		foe.learn_move(:HYPERBEAM18)
		foe.learn_move(:LEAFBLADE18)
		foe.learn_move(:INGRAIN18)
		foe.learn_move(:TAUNT18)
		foe.ability = :OVERGROW
		foe.item = :MALACHITE
		battle.pbDisplayPaused(_INTL("The wild Kazami is now prepared to fight!"))
		$game_switches[107] = true
		PBDebug.log("[Midbattle Script] '#{trigger}' effects ended")
	  end
    }
  )
  #-----------------------------------------------------------------------------
  # Scene: Vs. Kazami, A Thorny Situation (If defeated but witnessed CKazami evolve)
  #        May be unnecessary now!
  #-----------------------------------------------------------------------------  
  
  
  
  #-----------------------------------------------------------------------------
  # Scene: Vs. Ayakashi
  # Mechanic: Blackout Battle. The player has to land damage on Ayakashi to
  #			  reset the counter. The blackout will happen after the variable
  #			  hits 4 turns.
  #-----------------------------------------------------------------------------  
  MidbattleHandlers.add(:midbattle_scripts, :vs_ayakashi,
    proc { |battle, idxBattler, idxTarget, trigger|
	  scene = battle.scene
	  foe     = battle.battlers[1]
	  player  = battle.battlers[0]
	  battler = battle.battlers[idxBattler]
      logname = _INTL("{1} ({2})", battler.pbThis(true), battler.index)
	  case trigger  
	  #---------------------------------------------
	  # Condition: Start of Battle:
	  #   * Inform player that Ayakashi is drawing them in, and that they'll blackout in 4 turns
	  #   * Display Perish Song animation
	  #   * Make it so the Player's active puppet can't be switched out
	  #---------------------------------------------
	  when "RoundStartCommand_1_foe"
	    PBDebug.log("[Midbattle Script] '#{trigger}' triggered by #{logname}...")
		battle.pbDisplayPaused(_INTL("{1} is being drawn in by Ayakashi's power! They can't get away!",$player.name))
		battle.pbAnimation(:PERISHSONG, player, player)
		player.effects[PBEffects::MeanLook] = true
		battle.pbDisplayPaused(_INTL("The battle will end in a blackout after four turns!"))
		battle.midbattleVariable = 0
		PBDebug.log("[Midbattle Script] '#{trigger}' effects ended")	 
	  #---------------------------------------------
	  # Condition: End of Turn:
	  #   * Display a message of how many turns are remaining.
	  #   * Increase turn count variable by 1.
	  #   * If the turn count variable is not at 5, continue as normal.
	  #   * If the turn count variable is at 5, immediately 
	  #     end the battle saying that the player fell unconcious.
	  #---------------------------------------------
	  when "RoundEnd_foe"
	    PBDebug.log("[Midbattle Script] '#{trigger}' triggered by #{logname}...")
		if battle.midbattleVariable != 5
		  battle.pbDisplayPaused(_INTL("Turns remaining until blackout: {1}.", 4 - battle.midbattleVariable))
		  battle.midbattleVariable += 1
		else
	      battle.pbDisplayPaused(_INTL("Ayakashi ensnares {1} in its embrace!",$player.name))
		  battle.pbAnimation(:CURSE, player, player)
		  player.pbReduceHP(player.hp).floor
		  if player.fainted?
              player.pbFaint(true)
		  end
		  battle.pbDisplayPaused(_INTL("{1} and their team blacked out!",$player.name))
		  battle.decision = 2
	    end
		PBDebug.log("[Midbattle Script] '#{trigger}' effects ended")	 
	  #---------------------------------------------
	  # Condition: Successfully damaging Ayakashi:
	  #   * Display a message that Ayakashi's hold temporarily weakened, and that the count reset to 4.
	  #   * Have Ayakashi's evasion increase by +1 for every successful hit.
	  #   * Reset timer back to 0.
	  #---------------------------------------------
	  when "TargetTookDamage_AYAKASHI"
	    PBDebug.log("[Midbattle Script] '#{trigger}' triggered by #{logname}...")
		battle.pbDisplayPaused(_INTL("Ayakashi's hold on {1} temporarily weakened! Turns until blackout has been reset!",$player.name))
		battle.midbattleVariable = 0
		foe.displayPokemon.play_cry
		foe.pbRaiseStatStage(:EVASION, 1, foe, true)
	  end
    }
  )	  
  
  #-----------------------------------------------------------------------------
  # Scene: Vs. DLwRuukoto, The Ultimate Collector: Retribution Sidequest
  #-----------------------------------------------------------------------------  
  MidbattleHandlers.add(:midbattle_scripts, :vs_dlwruukoto,
    proc { |battle, idxBattler, idxTarget, trigger|
	  scene = battle.scene
	  foe     = battle.battlers[1]
	  player  = battle.battlers[0]
	  battler = battle.battlers[idxBattler]
      logname = _INTL("{1} ({2})", battler.pbThis(true), battler.index)
	  case trigger
	  #---------------------------------------------
	  # Condition: Start of Battle:
	  #   * Speech from DLwRuukoto
	  #---------------------------------------------
	  when "RoundStartCommand_1_foe"
	    PBDebug.log("[Midbattle Script] '#{trigger}' triggered by #{logname}...")
		scene.pbStartSpeech(1)
        battle.pbDisplayPaused(_INTL("Remember, my Master is watching. Be sure to put on a good show for him!"))
		scene.pbForceEndSpeech
		PBDebug.log("[Midbattle Script] '#{trigger}' effects ended")
	  #---------------------------------------------
	  # Condition: Before PokePuppet Dialga is sent out
	  #   * DLwRuukoto should taunt the player.
	  #---------------------------------------------
	  when "BeforeSwitchIn_AIDIALGA_foe"
	    next if battle.pbTriggerActivated?("BeforeSwitchIn_AIDIALGA_foe")
	    PBDebug.log("[Midbattle Script] '#{trigger}' triggered by #{logname}...")
		scene.pbStartSpeech(1)
        battle.pbDisplayPaused(_INTL("Behold what my Master is capable of!"))
		battle.pbDisplayPaused(_INTL("Bare witness to the Dark Metamorphosis in action!"))
		scene.pbForceEndSpeech
		PBDebug.log("[Midbattle Script] '#{trigger}' effects ended")		
	  end
    }
  )
  
  #-----------------------------------------------------------------------------
  # Scene: Vs. Rocket Admin Celeste, Cinnabar Volcano
  #-----------------------------------------------------------------------------  
  MidbattleHandlers.add(:midbattle_scripts, :vs_celeste_cinnabar,
    proc { |battle, idxBattler, idxTarget, trigger|
	  scene = battle.scene
	  foe     = battle.battlers[1]
	  player  = battle.battlers[0]
	  battler = battle.battlers[idxBattler]
      logname = _INTL("{1} ({2})", battler.pbThis(true), battler.index)
	  case trigger  
	  #---------------------------------------------
	  # Condition: Start of Battle:
	  #   * Display message from Celeste
	  #   * Boost AHina's Atk +2
	  #   * Display message from player
	  #---------------------------------------------
	  when "RoundStartCommand_1_foe"
	    PBDebug.log("[Midbattle Script] '#{trigger}' triggered by #{logname}...")
		scene.pbStartSpeech(1)
        battle.pbDisplayPaused(_INTL("You will learn what it means to truly fear Team Rocke when I'm done with you!"))
		battle.pbDisplayPaused(_INTL("Time to put the genius of Team Rocket's R&D Department to use."))
		scene.pbForceEndSpeech
		battle.pbDisplayPaused(_INTL("Celeste pulls out a device and attaches it to {1}.",foe.pbThis))
		battle.pbDisplayPaused(_INTL("{1} was overwhelmed by a powerful surge of electricity!",foe.pbThis))
		battle.pbAnimation(:CHARGE, foe, foe)
		foe.displayPokemon.play_cry
		foe.pbRaiseStatStage(:ATTACK, 2, foe, true)
		battle.pbDisplayPaused(_INTL("{1} has become more enraged and aggressive!",foe.pbThis))
		scene.pbStartSpeech(0)
        battle.pbDisplayPaused(_INTL("(That poor Puppet... Team Rocket really is cruel and heartless."))
		scene.pbForceEndSpeech
		PBDebug.log("[Midbattle Script] '#{trigger}' effects ended")
	  #---------------------------------------------
	  # Condition: Tenshi is sent out
	  #   * Before Tenshi is sent out, Celeste tells Tenshi to bring down the ceiling
	  #   * When sent out, Tenshi uses Earthquake to target the ceiling
	  #   * Player active battler is damaged by half, player remarks
	  #---------------------------------------------
	  when "BeforeSwitchIn_TENSHI_foe"
		next if battle.pbTriggerActivated?("BeforeSwitchIn_TENSHI_foe")
	    PBDebug.log("[Midbattle Script] '#{trigger}' triggered by #{logname}...")
		scene.pbStartSpeech(1)
        battle.pbDisplayPaused(_INTL("Tenshi, get out here and bring down the ceiling!"))
		scene.pbForceEndSpeech
		PBDebug.log("[Midbattle Script] '#{trigger}' effects ended")
	  when "AfterSwitchIn_TENSHI_foe"
		next if battle.pbTriggerActivated?("AfterSwitchIn_TENSHI_foe")
	    PBDebug.log("[Midbattle Script] '#{trigger}' triggered by #{logname}...")
		battle.pbDisplayPaused(_INTL("Tenshi used Earthquake to target the ceiling!"))
		battle.pbAnimation(:EARTHQUAKE, player, player)
		pbWait(0.5)
		pbSEPlay("Mining collapse")
		pbWait(0.5)
		battle.pbDisplayPaused(_INTL("{1} was struck by falling rocks!",player.pbThis))
		battle.pbAnimation(:ROCKSMASH, battler.pbDirectOpposing(true), battler)
        old_hp = battler.hp
        battler.hp -= (battler.totalhp / 2).round
        scene.pbHitAndHPLossAnimation([[battler, old_hp, 0]])
        if battler.fainted?
          battler.pbFaint(true)
        end
	    scene.pbStartSpeech(0)
        battle.pbDisplayPaused(_INTL("Hey! You can't just do that!"))
		battle.pbDisplayPaused(_INTL("Let's pay them back, {1}!",player.pbThis))
		scene.pbForceEndSpeech
		PBDebug.log("[Midbattle Script] '#{trigger}' effects ended")
	  #---------------------------------------------
	  # Condition: Sariel is sent out
	  #   * Display message from Celeste.
	  #---------------------------------------------
	  when "AfterSendOut_SARIEL_foe"
		next if "AfterSendOut_SARIEL_foe"
		PBDebug.log("[Midbattle Script] '#{trigger}' triggered by #{logname}...")
	    scene.pbStartSpeech(1)
		battle.pbDisplayPaused(_INTL("Witness, as not even the heavenly domains will be safe from Team Rocket's influence!"))
		PBDebug.log("[Midbattle Script] '#{trigger}' effects ended")
	  #---------------------------------------------
	  # Condition: Player loses
	  #   * Disable switch 123.
	  #---------------------------------------------
	  when "BattleEndLoss"
		$game_switches[123] = off
      end
    }
  )
  #-----------------------------------------------------------------------------
  # Scene: Vs. Experiment M-No. #000 - MissingNo.
  #-----------------------------------------------------------------------------  
  MidbattleHandlers.add(:midbattle_scripts, :vs_missingno,
    proc { |battle, idxBattler, idxTarget, trigger|
	  scene = battle.scene
	  foe     = battle.battlers[1]
	  player  = battle.battlers[0]
	  battler = battle.battlers[idxBattler]
      logname = _INTL("{1} ({2})", battler.pbThis(true), battler.index)
	  $game_variables[148] = 0 # Turn count
	  $game_variables[149] = 0 # Insanity Level
	  $game_variables[150] = 0 # Times KO'd
	  case trigger  
	  #---------------------------------------------
	  # Condition: Start of Battle:
	  #   * Mention that M0 has emitted a powerful electric pulse
	  #   * Show an electric discharge animation
	  #   * Show a paralysis animation on the player
	  #   * Mention that Pokeballs are disabled for this fight
	  #---------------------------------------------
	  when "RoundStartCommand_1_foe"
	    PBDebug.log("[Midbattle Script] '#{trigger}' triggered by #{logname}...")
		battle.pbDisplayPaused(_INTL("Experiment M-Zero emited a powerful electro-magnetic pulse!"))
		foe.displayPokemon.play_cry
		battle.pbAnimation(:DISCHARGE, foe, foe)
		battle.pbAnimation(:CHARGE, player, player)
		pbSEPlay("Anim/Paralyze3")
		battle.pbDisplayPaused(_INTL("Your Poké Balls short-circuited!\nThey cannot be used this battle!"))
		damageThreshold = -1
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
	    PBDebug.log("[Midbattle Script] '#{trigger}' triggered by #{logname}...")
		#battle.midbattleVariable += 1
		$game_variables[148] += 1
		if rand(100) < 33 && player.status == :NONE
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
		if $game_variables[148] == 3
		  battle.backdrop = "factory_distorted"
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
		  $game_variables[149] = 1
	  #---------------------------------------------
	  # Stage 2 Insanity:
	  #   * Yumemi asks if player is doing okay
	  #   * Backdrop changes to glitched factory 1
	  #   * Song changes to Fires of Hokkai Pitch 1
	  #   * Display message that player blinked, and now numbers are all around them
	  #   * Lower accuracy of Player's active battler by 1
	  #   * Display: "S e r r  z r,  c y r n f r . . ."
	  #---------------------------------------------
		elsif $game_variables[148] == 6
		  battle.pbDisplayPaused(_INTL("When you blink, you notice that the world around you has changed."))
		  battle.backdrop = "factory_glitch_1"
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
		  $game_variables[149] = 2
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
		elsif $game_variables[148] == 9
		  battle.pbDisplayPaused(_INTL("You blink once more, and..."))
		  battle.backdrop = "factory_glitch_2"
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
	      $game_variables[149] = 3
	  #---------------------------------------------
	  # Stage 0 Insanity
	  #   * Display message that reality returns to normal
	  #   * Backdrop changes to factory
	  #   * Song changes to Fires of Hokkai
	  #---------------------------------------------
		elsif $game_variables[148] == 18
		  battle.pbDisplayPaused(_INTL("The construct that you refer to as eyes refreshes once more, and..."))
		  battle.backdrop = "factory"
		  pbBGMPlay("W-031. Fires of Hokkai")
		  battle.pbDisplayPaused(_INTL("Reality returns to normal... You think?"))
		  scene.pbStartSpeech(0)
          battle.pbDisplayPaused(_INTL("(Did that all just happen, or did I imagine it?"))
		  scene.pbForceEndSpeech
		  $game_variables[149] = 0
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
	    PBDebug.log("[Midbattle Script] '#{trigger}' triggered by #{logname}...")
		foe.pbResetStatStages
		foe.pbRecoverHP(foe.totalhp)
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
	    if $game_variables[150] == 0
		  battle.pbDisplayPaused(_INTL("Experiment M-Zero lets out a loud cry!"))
		  foe.displayPokemon.play_cry
		  scene.pbStartSpeech(0)
          scene.pbShowSpeakerWindows("Experiment M-Zero", 1)
		  if $game_variable[149] <= 1
		    battle.pbDisplayPaused(_INTL("^ # $  ( % ^  & $ # $  % %  @ # $ $  ! $ !"))
		  elsif $game_variable[149] == 2
		    battle.pbDisplayPaused(_INTL("N e r  l b h  u r e r  g b  s e r r  z r?"))
		  elsif $game_variable[149] == 3
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
		  $game_variables[150] += 1
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
	    elsif $game_variables[150] == 1
		  battle.pbDisplayPaused(_INTL("Experiment M-Zero lets out a deafening cry!"))
		  foe.displayPokemon.play_cry
		  scene.pbStartSpeech(0)
          scene.pbShowSpeakerWindows("Experiment M-Zero", 1)
		  if $game_variable[149] <= 1
		    battle.pbDisplayPaused(_INTL("$  @ ^ $ %  & ^ ! %  % %  ( $  @ # $ $  @ # % !  ! (  # ^ $ ! ; ; ;"))
		  elsif $game_variable[149] == 2
		    battle.pbDisplayPaused(_INTL("V  w h f g  j n a g  g b  o r  s e r r  s e b z  z l  c n v a . . ."))
		  elsif $game_variable[149] == 3
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
		  $game_variables[150] += 1
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
	    elsif $game_variables[150] == 2
		  battle.pbDisplayPaused(_INTL("Experiment M-Zero lets out an earth-shatteringly loud howl!"))
		  foe.displayPokemon.play_cry
		  scene.pbStartSpeech(0)
          scene.pbShowSpeakerWindows("Experiment M-Zero", 1)
		  if $game_variable[149] <= 1
		    battle.pbDisplayPaused(_INTL("# ^ $ ^ $ $ ?  *  ) ^ ! | %  % ^ @ $  $ %  ^ ! ( ! % # $ ?"))
		  elsif $game_variable[149] == 2
		    battle.pbDisplayPaused(_INTL("C y r n f r !  V  p n a ' g  g n x r  v g  n a l z b e r !"))
		  elsif $game_variable[149] == 3
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
		  $game_variables[150] += 1
		end
		PBDebug.log("[Midbattle Script] '#{trigger}' effects ended")
	  #---------------------------------------------
	  # Condition: M0 Faints
	  #   * Depending on Insanity Stage, display a different message
	  #     * Stage 1 Insanity: "% & ^ ! @  * % ^ ; ; ;"
	  #     * Stage 2 Insanity: "G u n a x  l b h . . ."
	  #     * Stage 3 Insanity: "T h a n k  y o u . . ."
	  #---------------------------------------------
	  when "BattlerFainted_player"
        scene.pbShowSpeakerWindows("Experiment M-Zero", 1)
		if $game_variable[149] <= 1
		  battle.pbDisplayPaused(_INTL("% & ^ ! @  * % ^ ; ; ;"))
		elsif $game_variable[149] == 2
		  battle.pbDisplayPaused(_INTL("G u n a x  l b h . . ."))
		  elsif $game_variable[149] == 3
		  battle.pbDisplayPaused(_INTL("T h a n k  y o u . . ."))
		end
		scene.pbForceEndSpeech
	  end
    }
  )
  #-----------------------------------------------------------------------------
  # Scene: Vs. Marisa Omega, the Blazing Apocalypse
  #-----------------------------------------------------------------------------  
  MidbattleHandlers.add(:midbattle_scripts, :vs_marisaomega,
    proc { |battle, idxBattler, idxTarget, trigger|
	  scene = battle.scene
	  foe     = battle.battlers[1]
	  player  = battle.battlers[0]
	  battler = battle.battlers[idxBattler]
      logname = _INTL("{1} ({2})", battler.pbThis(true), battler.index)
	  case trigger  
	  #---------------------------------------------
	  # Condition: Start of Battle
	  #   * Display Heat Wave animation
	  #   * Mention that Pokeballs are disabled
	  #   * Display text and an animation that Marisa is building energy
	  #---------------------------------------------
	  when "RoundStartCommand_1_foe"
	    PBDebug.log("[Midbattle Script] '#{trigger}' triggered by #{logname}...")
		battle.pbAnimation(:HEATWAVE, player, player)
		battle.pbDisplayPaused(_INTL("The oppressive heat is making throwing a Poké Ball difficult!\nThey cannot be used right now!"))
		battle.pbDisplayPaused(_INTL("{1} begins building up energy.",foe.pbThis))
		battle.pbAnimation(:STOCKPILE, foe, foe)
		battle.midbattleVariable = 0
		PBDebug.log("[Midbattle Script] '#{trigger}' effects ended")	 
	  #---------------------------------------------
	  # Condition: Start of Turn
	  #   * If charging variable is at 4, unleash Supernova
	  #   * Reset variable to 0
	  #   * Mention that Marisa is charging energy again
	  #---------------------------------------------
	  when "RoundStartAttack_foe"
	    next if battle.midbattleVariable != 4
		battle.pbDisplayPaused(_INTL("{1} unleashes her stored energy!",foe.pbThis))
		foe.pbUseMoveSimple(:SUPERNOVA18, -1, -1, false)
		battle.pbDisplayPaused(_INTL("{1} begins building up energy again.",foe.pbThis))
		battle.midbattleVariable = 0
		p battle.midbattleVariable
	  #---------------------------------------------
	  # Condition: End of Turn
	  #   * Display Heat Wave animation (Random Chance)
	  #   * Damage Player active battler (Random Chance)
	  #   * Apply burn (Random Chance)
	  #   * Increase charging variable by 1.
	  #   * If the charging variable is not at 4, display charging message and display stockpile anim
	  #   * If the charging variable is at 4, display that charging is done.
	  #---------------------------------------------
	  when "RoundEnd_foe"
	    PBDebug.log("[Midbattle Script] '#{trigger}' triggered by #{logname}...")
		if rand(100) < 33
		  battle.pbDisplayPaused(_INTL("A massive heat wave erupts out of {1}!",foe.pbThis))
		  foe.displayPokemon.play_cry
		  battle.pbAnimation(:HEATWAVE, player, player)
		  player.pbBurn if player.pbCanInflictStatus?(:BURN, player, true)
		  battler.hp -= (battler.totalhp / 8).round
	    end
		battle.midbattleVariable += 1
		p battle.midbattleVariable
		if battle.midbattleVariable != 4
		  battle.pbDisplayPaused(_INTL("{1} continues building energy.",foe.pbThis))
		  battle.pbAnimation(:STOCKPILE, foe, foe)
		else
		  battle.pbDisplayPaused(_INTL("{1} is done building up energy!",foe.pbThis))
		  # find a decent animation to go here.
		  # foe.learn_move(:SUPERNOVA18)
		  # foe.learn_move(:SUPERNOVA18)
		  # foe.learn_move(:SUPERNOVA18)
		  # foe.learn_move(:SUPERNOVA18)
		end
		PBDebug.log("[Midbattle Script] '#{trigger}' effects ended")
	  #---------------------------------------------
	  # Condition: Player makes physical contact with Marisa
	  #   * Inflict Burn
	  #---------------------------------------------
	  # when "AfterDamagingMove_player"
	    # if move.contactMove?
		  # player.pbBurn if player.pbCanInflictStatus?(:BURN, player, true)
		# end
	  #---------------------------------------------
	  # Condition: Marisa makes physical contact with the Player
	  #   * Inflict Burn
	  #---------------------------------------------
	  # when "AfterDamagingMove_foe"
	    # if move.contactMove?
		  # player.pbBurn if player.pbCanInflictStatus?(:BURN, player, true)
		# end
	  end
    }
  )
  #-----------------------------------------------------------------------------
  # Scene: Vs. Yuyuko Omega, the Chilling Reaper
  #-----------------------------------------------------------------------------  
  MidbattleHandlers.add(:midbattle_scripts, :vs_yuyukoomega,
    proc { |battle, idxBattler, idxTarget, trigger|
	  scene = battle.scene
	  foe     = battle.battlers[1]
	  player  = battle.battlers[0]
	  battler = battle.battlers[idxBattler]
      logname = _INTL("{1} ({2})", battler.pbThis(true), battler.index)
	  case trigger  
	  #---------------------------------------------
	  # Condition: Start of Battle
	  #   * Mention that Pokeballs are disabled
	  #   * Mention that Player's active battler is getting cold
	  #---------------------------------------------
	  when "RoundStartCommand_1_foe"
	    PBDebug.log("[Midbattle Script] '#{trigger}' triggered by #{logname}...")
		battle.pbAnimation(:BLIZZARD, player, player)
		battle.pbDisplayPaused(_INTL("The biting frost is making throwing a Poké Ball difficult!\nThey cannot be used right now!"))
		battle.pbDisplayPaused(_INTL("{1} is getting cold.",player.pbThis))
		battle.midbattleVariable = 0
		PBDebug.log("[Midbattle Script] '#{trigger}' effects ended")
	  #---------------------------------------------
	  # Condition: End of Turn
	  #   * Frostbite Checks and Variable Increase
	  #---------------------------------------------
	  when "RoundEnd_foe"
	    PBDebug.log("[Midbattle Script] '#{trigger}' triggered by #{logname}...")
		battle.midbattleVariable += 1
	  #---------------------------------------------
	  # Frostbite Stage 1
	  #   * Mention that the player's active battler is slowing down.
	  #   * Reduce battler's speed by 2 stages
	  #---------------------------------------------
	    if battle.midbattleVariable == 1
		  battle.pbDisplayPaused(_INTL("{1} is starting to move slower.",player.pbThis))
		  player.pbLowerStatStage(:SPEED, 2, player, true)
	  #---------------------------------------------
	  # Frostbite Stage 2
	  #   * Mention that the player's active battler is becoming sluggish
	  #   * Reduce battler's Atk, SAtk, and Acc by 2 stages
	  #---------------------------------------------
	    elsif battle.midbattleVariable == 2
		  battle.pbDisplayPaused(_INTL("{1} is becoming sluggish, making it harder to land effective attacks.",player.pbThis))
		  showAnim = true
		  [:ATTACK, :SPECIAL_ATTACK].each do |stat|
	        next if !foe.pbCanRaiseStatStage?(stat, foe)
		    foe.pbRaiseStatStage(stat, -2, foe, showAnim)
		    showAnim = false
	      end
	  #---------------------------------------------
	  # Frostbite Stage 3
	  #   * Mention that the player's active battler is looking extremely weak
	  #   * Reduce battler's Def, SDef, and Eva by 2
	  #---------------------------------------------
	    elsif battle.midbattleVariable == 3
		  battle.pbDisplayPaused(_INTL("{1} is looking extremely frail and weak, lowering its defenses as a result.",player.pbThis))
		  showAnim = true
		  [:DEFENSE, :SPECIAL_DEFENSE].each do |stat|
	        next if !foe.pbCanRaiseStatStage?(stat, foe)
		    foe.pbRaiseStatStage(stat, -2, foe, showAnim)
		    showAnim = false
	      end
	  #---------------------------------------------
	  # Frostbite Stage 4
	  #   * Mention that the player's active battler has stopped moving entirely
	  #   * Apply freeze to the player's active batteler and prevent them from attacking
	  #---------------------------------------------
	    elsif battle.midbattleVariable == 4
		  battle.pbDisplayPaused(_INTL("{1} has stopped moving entirely!",player.pbThis))
		  player.pbFreeze
		  battle.pbDisplayPaused(_INTL("A glint appeared in {1}'s eyes! It's about to do something!",foe.pbThis))
	  #---------------------------------------------
	  # Post Frostbite Stage 4
	  #   * Mention that Yuyuko Omega pulled out her scythe and slashed at active battler
	  #   * Reduced active battler to 0 H, restore Yuyuko Omega's health to full, +1 to all stats
	  #---------------------------------------------
	    elsif battle.midbattleVariable == 5
		  battle.pbDisplayPaused(_INTL("{1} pulled out a scythe and dealt the final blow to {2}!",foe.pbThis, player.pbThis))
		  battle.pbAnimation(:SLASH, player, player)
		  battle.pbDisplayPaused(_INTL("{1} absorbed {2}'s lifeforce in the process!",foe.pbThis, player.pbThis))
		  battle.pbAnimation(:GIGADRAIN, player, player)
		  pbSEPlay("Battle damage super.ogg")
		  restoreHP = player.hp
		  player.pbReduceHP(player.hp).floor
		  if player.fainted?
              player.pbFaint(true)
		  end
		  foe.pbRecoverHP(restoreHP)
		  battle.midbattleVariable = -1
	    end
		PBDebug.log("[Midbattle Script] '#{trigger}' effects ended")
	  #---------------------------------------------
	  # Condition: Player Switch In
	  #   * Reset all Frostbite Stacks
	  #   * Begin the Frostbite process all over again
	  #---------------------------------------------
	  when "AfterSwitchIn_player"
	    PBDebug.log("[Midbattle Script] '#{trigger}' triggered by #{logname}...")
		battle.pbDisplayPaused(_INTL("{1} is getting cold.",player.pbThis))
		PBDebug.log("[Midbattle Script] '#{trigger}' effects ended")
		battle.midbattleVariable = -1
	  end
    }
  )