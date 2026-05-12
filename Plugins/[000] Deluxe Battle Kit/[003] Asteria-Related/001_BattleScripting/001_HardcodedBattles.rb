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


