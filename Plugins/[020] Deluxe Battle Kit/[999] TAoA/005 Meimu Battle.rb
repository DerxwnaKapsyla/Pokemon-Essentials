  #-----------------------------------------------------------------------------
  # The Last Adventure
  #-----------------------------------------------------------------------------  
  # Scene: Vs. Meimu
  #     * Have behind the scenes checks and activations for Switches and 
  #       variables in Phase 1.
  #		* Apply boss-level resistances and effects to the Phase 2 Meimu fight.
  #		* At certain HP thresholds, have Meimu activate a spell card.
  #		* For the final HP threshold, have Meimu go invincible for five turns, 
  #       the Player needs to survive until the invincibility ends.
  #-----------------------------------------------------------------------------  
  MidbattleHandlers.add(:midbattle_scripts, :vs_meimu,
    proc { |battle, idxBattler, idxTarget, trigger|
      scene = battle.scene
      case trigger
	  #-------------------------------------
	  when "BattleEndWin"
	    if pbGet(143) != 5
		  $game_variables[143] += 1
		  #p $game_variables[143]
		else
		  $game_switches[157] = false
		  $game_switches[98] = false
		  $game_variables[143] = 6
		  #p $game_switches[98]
		  #p $game_switches[157]
		end
	  end
     }
  ) 
  
  MidbattleHandlers.add(:midbattle_scripts, :vs_meimu_final_old,
    proc { |battle, idxBattler, idxTarget, trigger|
      scene  = battle.scene
	  player = battle.battlers[0]
	  meimu  = battle.battlers[1]
	  rand_puppet = [:MEEKO, :MAKURA, :MITORI, :TORAKO, :SASHA, :SUGAR, :KAREN, :MASHA]
	  #rand_puppet = [:REIMU, :MARISA, :SAKUYA, :YOUMU, :YUKARI, :ALICE, :REMILIA, :YUYUKO]
	  def_stats = [:DEFENSE, :SPECIAL_DEFENSE]
      case trigger
	  #-------------------------------------
	  # Round 1 Start: Meimu Dialogue
	  #-------------------------------------
	  when "RoundStartCommand_1_foe"

		scene.pbStartSpeech(1)
		battle.pbDisplayPaused(_INTL("I swore to myself that I would become real..."))
        battle.pbDisplayPaused(_INTL("Do you know what it's like, trapped in a void of non-existence?"))
        battle.pbDisplayPaused(_INTL("Knowing you're nothing but a fleeting dream!?"))
        battle.pbDisplayPaused(_INTL("I won't go back to that! I won't!"))
		scene.pbShowSpeakerWindows("Ayaka", nil)
		battle.pbDisplayPaused(_INTL("(There has to be a way to save her...)"))
	    scene.pbForceEndSpeech
		meimu.damageThreshold = -5
	  
	  #---------------------------------------------------------------
	  # HP Threshold 1: 
	  # Spell Card: Phantasmagoria - Fantasy Summoning
	  #           * Meimu will summon one Puppet at her side when
	  #             she reaches this HP threshold. They will be
	  #             randomly selected from a list of Non-Real Puppets.
	  #---------------------------------------------------------------
	  when "BattlerReachedHPCap"
	    if battle.midbattleVariable == 0
		  scene.pbStartSpeech(1)
		  battle.pbDisplayPaused(_INTL("Lady Mima told me about Gensokyo's history..."))
		  battle.pbDisplayPaused(_INTL("Specifically, how situations were resolved before Puppets existed."))
		  battle.pbDisplayPaused(_INTL("Let's see if I have this right..."))
		  pbSEPlay("Spell Card Activation.ogg")
		  battle.pbDisplayPaused(_INTL("Spell Card Activate!"))
		  battle.pbDisplayPaused(_INTL("Phantasmagoria \"Fantasy Summoning!\""))
		  scene.pbForceEndSpeech
		  battle.pbDisplayPaused(_INTL("Meimu materialized a Puppet out of thin air!"))
		  pbSet(5, rand_puppet.sample)
		  battle.pbAddNewBattler(pbGet(5), 100)
		  battle.midbattleVariable += 1
		  meimu.damageThreshold = -2.5
	  #---------------------------------------------------------------
	  # HP Threshold 2: 
	  # Spell Card: Manipulation - Inversion of Perception
	  #           * Meimu will invert the Type Chart for three turns.
	  #---------------------------------------------------------------
	    elsif battle.midbattleVariable == 1
		  scene.pbStartSpeech(1)
		  battle.pbDisplayPaused(_INTL("That wasn't too hard... Let's see you stop this!"))
		  pbSEPlay("Spell Card Activation.ogg")
		  battle.pbDisplayPaused(_INTL("Spell Card Activate!"))
		  battle.pbDisplayPaused(_INTL("Manipulation \"Inversion of Perception\"!"))
		  scene.pbForceEndSpeech
		  $game_variables[1] = 1
          $game_temp.battle_inverse = true
		  battle.pbDisplayPaused(_INTL("Meimu manipulated reality to reverse type effectiveness for the next three turns!"))
		  $game_switches[158] = true # Inverse Battle Active switch
		  #p $game_switches[158]
		  battle.midbattleVariable += 1
		  meimu.damageThreshold = 2.5
		  
	  #---------------------------------------------------------------
	  # HP Threshold 3: 
	  # Spell Card: Deep Sleep - Nightmare of the Non-Existant
	  #             * Meimu will trap the opposing Puppet in a 5 turn
	  #               sleep, as well as inflict them with a curse.
	  #---------------------------------------------------------------
	    elsif battle.midbattleVariable == 2
		  scene.pbStartSpeech(1)
		  battle.pbDisplayPaused(_INTL("Of course it wouldn't stop you, nothing will..."))
		  battle.pbDisplayPaused(_INTL("So why don't I show you the nightmares I lived!"))
		  pbSEPlay("Spell Card Activation.ogg")
		  battle.pbDisplayPaused(_INTL("Spell Card Activate!"))
		  battle.pbDisplayPaused(_INTL("Deep Sleep \"Nightmare of the Non-Existant\"!"))
		  scene.pbForceEndSpeech
		  battle.pbDisplayPaused(_INTL("Meimu locked your Puppet into a sleeping nightmare!"))
		  battle.pbAnimation(:GRUDGE, player, player)
		  player.pbSleep if player.pbCanInflictStatus?(:SLEEP, player, true)
		  player.statusCount = 5
		  player.effects[PBEffects::Curse] = true
		  battle.midbattleVariable += 1
		  meimu.damageThreshold = 5
	  
	  #---------------------------------------------------------------
	  # HP Threshold 4: 
	  # Spell Card: Tale of a Cruel, Unforgiving Reality
	  #           * Meimu will reactivate a previous Spell Card with
	  #             the same conditions as when it was initially
	  #             activated.
	  #---------------------------------------------------------------
	    elsif battle.midbattleVariable == 3
		  scene.pbStartSpeech(1)
		  battle.pbDisplayPaused(_INTL("Why... Why can't you just let me be..."))
		  battle.pbDisplayPaused(_INTL("I looked up to you, wanted to do what you and so many others did..."))
		  battle.pbDisplayPaused(_INTL("You gave me inspiration... hope... determination..."))
		  battle.pbDisplayPaused(_INTL("But... What good was it, if this is what the world is truly like..."))
		  battle.pbDisplayPaused(_INTL("Let the pain I've felt wash over you, again and again!"))
		  pbSEPlay("Spell Card Activation.ogg")
		  battle.pbDisplayPaused(_INTL("Spell Card Activate!"))
		  battle.pbDisplayPaused(_INTL("Tale of a Cruel, Unforgiving Reality!"))
		  scene.pbForceEndSpeech
		  battle.pbDisplayPaused(_INTL("Meimu used her Spell Card to replicate a previous Spell Card's effects!"))
		  $game_variables[3] = rand(1..3)
		  if pbGet(3) == 1
		    # Phantasmagoria - Fantasy Summoning
			battle.pbDisplayPaused(_INTL("Meimu materialized a Puppet out of thin air!"))
		    pbSet(5, rand_puppet.sample)
		    battle.pbAddNewBattler(pbGet(5), 100)
		  elsif pbGet(3) == 2
		    # Manipulation - Inversion of Perception
			$game_temp.battle_inverse = true
		    battle.pbDisplayPaused(_INTL("Meimu manipulated reality to reverse type effectiveness for the next three turns!"))
			$game_variables[1] = 1
		    $game_switches[158] = true # Inverse Battle Active switch
			#p $game_switches[158]
		  else
		    # Deep Sleep - Nightmare of the Non-Existant
			battle.pbDisplayPaused(_INTL("Meimu locked your Puppet into a sleeping nightmare!"))
		    battle.pbAnimation(:GRUDGE, player, player)
		    player.pbSleep if player.pbCanInflictStatus?(:SLEEP, player, true)
		    player.statusCount = 5
		    player.effects[PBEffects::Curse] = true
		  end
		  battle.midbattleVariable += 1
		  meimu.damageThreshold = 10
	  
	  #---------------------------------------------------------------
	  # HP Threshold 5: 
	  # Spell Card: Phantasm - Boundary Between Fantasy and Reality
	  #           * Meimu will give herself complete damage and stat
      #             lowering immunity for five turns. During this time
	  #             she will boost her Attack and Special Attack stats
	  #             by two.
	  #           * After five turns are up, she will drop invincibility,
	  #             reset her Attacking stats, boost defensive stats by 3
	  #             and activate final Spell Card.
	  #---------------------------------------------------------------
	    elsif battle.midbattleVariable == 4
		  scene.pbStartSpeech(1)
		  battle.pbDisplayPaused(_INTL("I don't... I can't keep this up... I need to finish this all in one attack!"))
		  battle.pbDisplayPaused(_INTL("But I need more energy first...!"))
		  pbSEPlay("Spell Card Activation.ogg")
		  battle.pbDisplayPaused(_INTL("Spell Card Activate!"))
		  battle.pbDisplayPaused(_INTL("Phantasm \"Boundary Between Fantasy and Reality\"!"))
		  scene.pbForceEndSpeech
		  battle.pbAnimation(:TELEPORT, meimu, meimu)
		  #battle.scene.sprites["pokemon_#{idxBattler}"].visible = false
		  #battle.pbDisplayPaused(_INTL("Meimu vanishes before your eyes!"))
		  meimu.pbChangeForm(2, _INTL("Meimu vanishes before your eyes!"))
		  # Change Meimu's sprite to be completely invisible.
		  #meimu.effects[PBEffects::Endure] = true
		  scene.pbStartSpeech(1)
		  battle.pbDisplayPaused(_INTL("Try as hard as you want... You won't break what doesn't exist on this plane!"))
		  battle.pbDisplayPaused(_INTL("But I can attack you all I need to!"))
		  scene.pbForceEndSpeech
		  $game_switches[159] = true
		  battle.midbattleVariable += 1
		  meimu.damageThreshold = 10
		  meimu.pbCureStatus
		  meimu.pbChangeTypes(:PHANTASM)
		  meimu.ability = :WONDERGUARD
		  $game_variables[2] = 0
	  
	  #---------------------------------------------------------------
	  # HP Threshold 6: 
	  # * Meimu says a parting message, accepting that she's lost.
	  # * Meimu's last HP is subtracted.
	  # * Play a blackout cutscene that:
	  #   * Stops the BGM
	  #   * Turns on the Music Override for quiet_time
	  #   * Fades the screen to white
	  #   * Erases the battle scene
	  #   * Displays Meimu's last words
	  #   * Begin Credits.
	  #---------------------------------------------------------------
	    elsif battle.midbattleVariable == 6
		pbBGMFade(1.0)
		pbWait(2)
		scene.pbStartSpeech(1)
		pbSEPlay("Voltorb Flip explosion")
		# Play an explosion graphic here
		battle.pbDisplayPaused(_INTL("I... I can't..."))
		battle.pbDisplayPaused(_INTL("W-... Why did this have to happen..."))
		battle.pbDisplayPaused(_INTL("My existence.... Was it really just a fluke miracle...?"))
		scene.pbShowSpeakerWindows("Ayaka", nil)
		battle.pbDisplayPaused(_INTL("Meimu..."))
		scene.pbShowSpeakerWindows("Meimu", nil)
		battle.pbDisplayPaused(_INTL("No, this... Had to be done. I was being selfish... greedy..."))
		pbSEPlay("Voltorb Flip explosion")
		# Play an explosion graphic here
		battle.pbDisplayPaused(_INTL("One life... For the entirety of reality... Isn't really a fair trade, is it...? Hahaha..."))
		battle.pbDisplayPaused(_INTL("Just, please... Promise that you'll remember me."))
		pbSEPlay("Voltorb Flip explosion")
		# Play an explosion graphic here
		battle.pbDisplayPaused(_INTL("Even if it was for one brief, shining moment... The girl named Meimu..."))
		battle.pbDisplayPaused(_INTL("...Born from the dreams of all the Gensokyo's across time and space..."))
		battle.pbDisplayPaused(_INTL("Remember... that she lived... Please..."))
		scene.pbForceEndSpeech
		pbSEPlay("Voltorb Flip explosion")
		# Play an explosion graphic here
	    $game_variables[142] = 8
		$game_switches[96] = true
		pbWait(2)
		pbBGMFade(1.0)
		$game_switches[95] = true
		$game_player.transparent        = true
		$game_temp.player_new_map_id    = 145
		$game_temp.player_new_x         = 8
		$game_temp.player_new_y         = 6
		$game_temp.player_new_direction = 2
		$scene.transfer_player if $scene.is_a?(Scene_Map)
		$game_temp.transition_processing = false
		$game_map.refresh
		pbSEPlay("Enemy Defeat.ogg")
		battle.decision = 3
	  
	  end
	  
	  when "RoundEnd_foe1"
	    #battle.pbDisplayPaused(_INTL("Testing"))
		#p $game_switches[158]
		if $game_switches[158] # Inverse Battle Effect
	      if $game_variables[1] != 4
		    $game_variables[1] += 1
			p $game_variables[1]
		  else
		    battle.pbDisplayPaused(_INTL("Type effectiveness inversion has stopped."))
		    $game_temp.battle_inverse = false
		    $game_variables[1] = 0
		    $game_switches[158] = false
		  end
		  		
	    elsif $game_switches[159] # Boundary Between Fantasy and Reality check
	      if $game_variables[2] < 4 # Turn Count Checker
			$game_variables[2] += 1
			meimu.damageThreshold = 10
			p $game_variables[2]
		  else
		    scene.pbStartSpeech(1)
			battle.pbDisplayPaused(_INTL("...This is it! It's time to finish this!"))
			scene.pbForceEndSpeech
			#battle.scene.pbFlashFadein
			battle.pbCommonAnimation("MeimuTF", meimu)
			meimu.pbChangeForm(1, nil)
			battle.pbDisplayPaused(_INTL("Meimu reappears!"))
			meimu.pbChangeTypes(:PHANTASM)
			showAnim = true
	          def_stats.each do |stat|
	          next if !meimu.pbCanRaiseStatStage?(stat, meimu)
		      meimu.pbRaiseStatStage(stat, 4, meimu, showAnim)
		      showAnim = false
	        end
			scene.pbStartSpeech(1)
			battle.pbDisplayPaused(_INTL("You think that you have the right to deny me my chance at existence!"))
			battle.pbDisplayPaused(_INTL("No! You don't! Nobody does!"))
			battle.pbDisplayPaused(_INTL("I am Meimu, the Phantasmal Dream brought to life!"))
			battle.pbDisplayPaused(_INTL("With the ability to manipulate the boundary between Fantasy and Reality..."))
			battle.pbDisplayPaused(_INTL("I alone get to determine what is and isn't allowed to exist!"))
			pbSEPlay("Spell Card Activation.ogg")
		    battle.pbDisplayPaused(_INTL("Final Spell Card Activate!"))
		    battle.pbDisplayPaused(_INTL("Declaration of Existence!"))
			scene.pbForceEndSpeech
			battle.pbDisplayPaused(_INTL("Meimu begins charging energy for her final attack!"))
			#Find a decent animation to play here
			$game_switches[160] = true # Final Attack Switch
			$game_switches[159] = false
			battle.midbattleVariable += 1
			meimu.damageThreshold = -1
  		  end
	    #end
		
	  #---------------------------------------------------------------
	  # Final Spell Card: Declaration of Existence
	  #           * Meimu will launch an attack every two turns that
	  #             will immediately KO the active battler.
	  #---------------------------------------------------------------
		elsif $game_switches[160]
		  if $game_variables[4] != 2
		    $game_variables[4] += 1
			p $game_variables[4]
		    battle.pbDisplayPaused(_INTL("Meimu begins preparing to unleash her final attack!")) if $game_variables[4] == 1
		  else
		    scene.pbStartSpeech(1)
			battle.pbDisplayPaused(_INTL("It's time to finish you!"))
			pbSEPlay("Spell Card Activation.ogg")
			battle.pbDisplayPaused(_INTL("{1}! I sentence you to non-existence!", player.pbThis))
			scene.pbForceEndSpeech
			battle.pbDisplayPaused(_INTL("Meimu unleashes an unfathomable, unreal power!"))
			battle.pbAnimation(:JUDGMENT, meimu, meimu)
			battle.pbAnimation(:THUNDER, player, player)
			pbSEPlay("Battle damage super.ogg")
			player.pbReduceHP(player.hp).floor
			battle.pbDisplayPaused(_INTL("{1} was KO'd immediately!", player.pbThis))
			if player.fainted?
              player.pbFaint(true)
			end
			$game_variables[4] = 0
		  end
	    #end

		end
	  end
     }
  ) 