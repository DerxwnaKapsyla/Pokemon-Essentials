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