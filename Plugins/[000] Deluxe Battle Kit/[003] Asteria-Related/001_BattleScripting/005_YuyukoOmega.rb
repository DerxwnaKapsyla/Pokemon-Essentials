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