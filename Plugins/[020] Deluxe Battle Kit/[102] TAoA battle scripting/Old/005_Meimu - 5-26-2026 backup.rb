MidbattleHandlers.add(:midbattle_scripts, :vs_meimu,
  proc { |battle, idxBattler, idxTarget, trigger|
    scene  = battle.scene
	player = battle.battlers[0]
	foe    = battle.battlers[1]
	case trigger
	when "RoundStartCommand"
	  if pbGet(143) == 1
	    $game_temp.player_new_map_id    = 137 # Dummy Warp Map 2
	    $game_temp.player_new_x         = 15
	    $game_temp.player_new_y         = 26
	    $game_temp.player_new_direction = 2
	    $scene.transfer_player if $scene.is_a?(Scene_Map)
	    $game_temp.transition_processing = false
	    $game_map.refresh
	  end
	end
	}
)


# This controls where the player is teleported to after the battle scene is erased.

MidbattleHandlers.add(:midbattle_scripts, :vs_meimu_final_backup,
  proc { |battle, idxBattler, idxTarget, trigger|
    scene       = battle.scene
	player      = battle.battlers[0]
	meimu       = battle.battlers[1]
	partner     = battle.battlers[3]
	rand_puppet = [:MEEKO, :MAKURA, :MITORI, :TORAKO, :SASHA, :SUGAR, :KAREN, :MASHA]
	def_stats   = [:DEFENSE, :SPECIAL_DEFENSE]
	@inverse_turn_count = 0 if @inverse_turn_count.nil?
    @bbfar_turn_count   = 0 if @bbfar_turn_count.nil?
    @doe_turn_count     = 0 if @doe_turn_count.nil?
	@meimu_sleep        = false if @meimu_sleep.nil?
	case trigger
	#----------------------------------------------
	# Round 1 Start: Meimu's intro dialogue
	#----------------------------------------------
	when "RoundStartCommand_1_foe"
	  scene.pbStartSpeech(1)
	  battle.pbDisplayPaused(_INTL("I swore to myself that I would become real..."))
	  battle.pbDisplayPaused(_INTL("Do you know what it's like, trapped in a void of non-existence?"))
	  battle.pbDisplayPaused(_INTL("Knowing you're nothing but a fleeting dream!?"))
	  battle.pbDisplayPaused(_INTL("I won't go back to that! I won't!"))
	  scene.pbShowSpeakerWindows("Ayaka", nil)
	  battle.pbDisplayPaused(_INTL("(There has to be a way to save her...)"))
	  scene.pbForceEndSpeech
	  meimu.damageThreshold = 80 # Meimu's HP Bar should not go down below 80% her Max HP
	  echoln "* Meimu's Damage Threshold: #{meimu.damageThreshold}"
	#---------------------------------------------------------------
	# HP Thresholds
	#---------------------------------------------------------------
	when "BattlerReachedHPCap"
	#---------------------------------------------------------------
	# Threshold 1: Spell Card: 
	# Phantasmagoria - Fantasy Summoning
	#---------------------------------------------------------------
	  if battle.midbattleVariable == 0
	    next if battle.midbattleVariable != 0
		scene.pbStartSpeech(1)
		battle.pbDisplayPaused(_INTL("Lady Mima told me about Gensokyo's history..."))
		battle.pbDisplayPaused(_INTL("Specifically, how situations were resolved before Puppets existed."))
		battle.pbDisplayPaused(_INTL("Let's see if I have this right..."))
		pbSEPlay("Spell Card Activation.ogg")
		battle.pbDisplayPaused(_INTL("Spell Card Activate!"))
		battle.pbDisplayPaused(_INTL("Phantasmagoria \"Fantasy Summoning!\""))
		scene.pbForceEndSpeech
		card_fantasy_summoning(battle.scene, battle) # Handled in separate method
		battle.midbattleVariable += 1 # Increments variable to 1.
		meimu.damageThreshold = 60 # Meimu's HP Bar should not go down below 60% her Max HP
		echoln "* Mid Battle Variable: #{battle.midbattleVariable}"
		echoln "* Meimu's Damage Threshold: #{meimu.damageThreshold}"
	#---------------------------------------------------------------
	# Threshold 2: Spell Card: 
	# Manipulation - Inversion of Perception
	#---------------------------------------------------------------
	  elsif battle.midbattleVariable == 1
	    next if battle.midbattleVariable != 1
		scene.pbStartSpeech(1)
		battle.pbDisplayPaused(_INTL("That wasn't too hard... Let's see you stop this!"))
		pbSEPlay("Spell Card Activation.ogg")
		battle.pbDisplayPaused(_INTL("Spell Card Activate!"))
		battle.pbDisplayPaused(_INTL("Manipulation \"Inversion of Perception\"!"))
		scene.pbForceEndSpeech
		card_inversion_perception(battle.scene, battle) # Handled in separate method
		battle.midbattleVariable += 1 # Increments variable to 2.
		meimu.damageThreshold = 40 # Meimu's HP Bar should not go down below 40% her Max HP
		echoln "* Mid Battle Variable: #{battle.midbattleVariable}"
		echoln "* Meimu's Damage Threshold: #{meimu.damageThreshold}"
	#---------------------------------------------------------------
	# Threshold 3: Spell Card: 
	# Deep Sleep - Nightmare of the Non-Existant
	#---------------------------------------------------------------
	  elsif battle.midbattleVariable == 2
	    next if battle.midbattleVariable != 2
		scene.pbStartSpeech(1)
		battle.pbDisplayPaused(_INTL("Of course it wouldn't stop you, nothing will..."))
		battle.pbDisplayPaused(_INTL("So why don't I show you the nightmares I lived!"))
		pbSEPlay("Spell Card Activation.ogg")
		battle.pbDisplayPaused(_INTL("Spell Card Activate!"))
		battle.pbDisplayPaused(_INTL("Deep Sleep \"Nightmare of the Non-Existant\"!"))
		scene.pbForceEndSpeech
		card_deep_sleep(battle.scene, battle) # Handled in separate method
		battle.midbattleVariable += 1 # Increments variable to 3.
		meimu.damageThreshold = 20 # Meimu's HP Bar should not go down below 20% her Max HP
		echoln "* Mid Battle Variable: #{battle.midbattleVariable}"
		echoln "* Meimu's Damage Threshold: #{meimu.damageThreshold}"
	#---------------------------------------------------------------
	# Threshold 4: Spell Card: 
	# Tale of a Cruel, Unforgiving Reality
	#---------------------------------------------------------------
	  elsif battle.midbattleVariable == 3
	    next if battle.midbattleVariable != 3
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
		card_toacur(battle.scene, battle) # Handled in separate method
		battle.midbattleVariable += 1 # Increments variable to 4.
		meimu.damageThreshold = 10 # Meimu's HP Bar should not go down below 10% her Max HP
		echoln "* Mid Battle Variable: #{battle.midbattleVariable}"
		echoln "* Meimu's Damage Threshold: #{meimu.damageThreshold}"
	#---------------------------------------------------------------
	# Threshold 5: Spell Card: 
	# Phantasm - Boundary Between Fantasy and Reality
	#---------------------------------------------------------------
	  elsif battle.midbattleVariable == 4
	    next if battle.midbattleVariable != 4
		scene.pbStartSpeech(1)
		battle.pbDisplayPaused(_INTL("I don't... I can't keep this up... I need to finish this all in one attack!"))
		battle.pbDisplayPaused(_INTL("But I need more energy first...!"))
		pbSEPlay("Spell Card Activation.ogg")
		battle.pbDisplayPaused(_INTL("Spell Card Activate!"))
		battle.pbDisplayPaused(_INTL("Phantasm \"Boundary Between Fantasy and Reality\"!"))
		scene.pbForceEndSpeech
		card_bbfar(battle.scene, battle) # Handled in separate method
		scene.pbStartSpeech(1)
		battle.pbDisplayPaused(_INTL("Try as hard as you want... You won't break what doesn't exist on this plane!"))
		battle.pbDisplayPaused(_INTL("But I can attack you all I need to!"))
		scene.pbForceEndSpeech
		battle.midbattleVariable += 1 # Increments variable to 5.
		meimu.damageThreshold = 10 # Safety-check, but ultimately irrelevent. Meimu physically cannot take damage in this state.
		echoln "* Mid Battle Variable: #{battle.midbattleVariable}"
		echoln "* Meimu's Damage Threshold: #{meimu.damageThreshold}"
	#---------------------------------------------------------------
	# Threshold 6: Final Cutscene
	# * Meimu gives her parting speech, accepting that she's lost
	# * Meimu's last HP is subtracted (Is this necessary? Can we do something else?)
	# * Play a white-out cutscene that does the following:
	#   * Stops the BGM
	#   * Turns on the Music Override switch for "quiet_time" (Is this necessary? Check old code.)
	#   * Fades the screen to white.
	#   * Erases the battle scene.
	#   * Displays Meimu's last words
	#   * Begin credits.
	#---------------------------------------------------------------
	  elsif battle.midbattleVariable == 6
	    next if battle.midbattleVariable != 6
		pbBGMFade(1.0)
	    pbWait(2) # May make this be a shorter wait period?
	    scene.pbStartSpeech(1)
	    pbSEPlay("Voltorb Flip explosion")
	    # Play an explosion graphic here. Animation not made yet.
	    battle.pbDisplayPaused(_INTL("I... I can't..."))
	    battle.pbDisplayPaused(_INTL("W-... Why did this have to happen..."))
	    battle.pbDisplayPaused(_INTL("My existence.... Was it really just a fluke miracle...?"))
	    scene.pbShowSpeakerWindows("Ayaka", nil)
	    battle.pbDisplayPaused(_INTL("Meimu..."))
	    scene.pbShowSpeakerWindows("Meimu", nil)
	    battle.pbDisplayPaused(_INTL("No, this... Had to be done. I was being selfish... greedy..."))
	    pbSEPlay("Voltorb Flip explosion")
	    # Play an explosion graphic here. Animation not made yet.
	    battle.pbDisplayPaused(_INTL("One life... For the entirety of reality... Isn't really a fair trade, is it...? Hahaha..."))
	    battle.pbDisplayPaused(_INTL("Just, please... Promise that you'll remember me."))
	    pbSEPlay("Voltorb Flip explosion")
	    # Play an explosion graphic here. Animation not made yet.
	    battle.pbDisplayPaused(_INTL("Even if it was for one brief, shining moment... The girl named Meimu..."))
	    battle.pbDisplayPaused(_INTL("...Born from the dreams of all the Gensokyo's across time and space..."))
	    battle.pbDisplayPaused(_INTL("Remember... that she lived... Please..."))
	    scene.pbForceEndSpeech
	    pbSEPlay("Voltorb Flip explosion")
	    # Play an explosion graphic here. Animation not made yet.
	    pbSet(142, 8) # Increase The Last Adventure Plot Variable up to 8
	    $game_switches[96] = true # This stops the music from refreshing
	    pbWait(2) # Should wait be longer?
	    pbBGMFade(1.0)
	    $game_switches[95] = true # This triggers the white-out segment mid-battle.
	    # This controls where the player is teleported to after the battle scene is erased.
	    $game_player.transparent        = true
	    $game_temp.player_new_map_id    = 145 # Dummy Warp Map 2
	    $game_temp.player_new_x         = 8
	    $game_temp.player_new_y         = 6
	    $game_temp.player_new_direction = 2
	    $scene.transfer_player if $scene.is_a?(Scene_Map)
	    $game_temp.transition_processing = false
	    $game_map.refresh
	    pbSEPlay("Enemy Defeat.ogg")
	    battle.decision = 3
		$game_switches[158] = false
	    $game_switches[159] = false
	    $game_switches[160] = false
	    $game_temp.battle_inverse = false
	  end
	#---------------------------------------------------------
	# Round End Effects
	#---------------------------------------------------------
	when "RoundEnd_foe1"
	  if $game_switches[158] # Inverse Battle Active Check
	  echoln "Checking Inverse Battle status"
	    if @inverse_turn_count != 4
		  @inverse_turn_count += 1
		  echoln "Inverse Battle Turn Count: #{@inverse_turn_count}/4"
		else
		  echoln "Inverse Battle Turn Count: #{@inverse_turn_count}/4"
		  battle.pbDisplayPaused(_INTL("Type effectiveness inversion has stopped."))
		  $game_temp.battle_inverse = false
		  @inverse_turn_count = 0
		  $game_switches[158] = false
		end
	  end
	  
	  if $game_switches[159] # Boundary Between Fantasy and Reality Check
	  echoln "Checking BBFAR status"
	    if @bbfar_turn_count < 4
		  @bbfar_turn_count += 1
		  meimu.damageThreshold = 10
		  echoln "Boundary Between Fantasy and Reality Turn Count: #{@bbfar_turn_count}/5"
		else
		  echoln "Boundary Between Fantasy and Reality Turn Count: #{@bbfar_turn_count}/5"
		  battle.pbDisplayPaused(_INTL("...This is it! It's time to finish this!"))
		  scene.pbForceEndSpeech
		  battle.pbCommonAnimation("MeimuTF", meimu)
		  meimu.pbChangeForm(1, nil)
		  battle.pbDisplayPaused(_INTL("Meimu reappears!"))
		  meimu.pbChangeTypes(:PHANTASM)
		  meimu.ability = :PHANTASMDREAM_ALT2
		  meimu.pbResetStatStages
		  showAnim = true
	      def_stats.each do |stat|
	        next if !meimu.pbCanRaiseStatStage?(stat, meimu)
		    meimu.pbRaiseStatStage(stat, 2, meimu, showAnim)
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
		  #battle.pbDisplayPaused(_INTL("Meimu begins charging energy for her ultimate attack!"))
		  #Find a decent animation to play here
		  $game_switches[160] = true # Enables charging of Declaration of Existence
		  $game_switches[159] = false # No longer need bbfar being checked
		  battle.midbattleVariable += 1 # Increments variable to 6.
		  meimu.damageThreshold = 0 # Meimu should not drop below 1 HP.
		  echoln "* Mid Battle Variable: #{battle.midbattleVariable}"
		  echoln "* Meimu's Damage Threshold: #{meimu.damageThreshold}"
		  @doe_turn_count = 0
		end
	  end
	  
	  if $game_switches[160] # Declaration of Existence Check
	  echoln "Checking Declaration of Existence status"
	    case @doe_turn_count
		when 0
		  battle.pbDisplayPaused(_INTL("Meimu begins charging energy for her ultimate attack!"))
		  #Find a decent animation to play here
		  @doe_turn_count += 1
		when 1
		  battle.pbDisplayPaused(_INTL("Meimu prepares to unleash her ultimate attack!"))
		  #Find a decent animation to play here
		  @doe_turn_count += 1
		when 2
		  battle.pbDisplayPaused(_INTL("Meimu will unleash her ultimate attack next turn!"))
		  #Find a decent animation to play here
		  @doe_turn_count += 1
		when 3
		  card_doe(scene, battle)
		end
	  end
	# when "BattlerFainted_foe"
	  # echoln "Battler Fainted"
	  # battle.databoxStyle = :Long
	#---------------------------------------------------------
	# Special Scenes
	#---------------------------------------------------------
	# Condition: Meimu is put to sleep
	#---------------------------------------------------------
	when "BattlerStatusChange_foe"
	  if meimu.status == :SLEEP
	    if @meimu_sleep == false
		scene.pbStartSpeech(1)
		battle.pbDisplayPaused(_INTL("Did you forget? I was born from all of the dreams of every Gensokyo across time and space!"))
		battle.pbDisplayPaused(_INTL("Being put to sleep is nothing to me!"))
		@meimu_sleep = true
		end
	  end
	end
   }
  )
  
#---------------------------------------------------------
# Vs. Meimu (Final) - Boss Rush Variant
# This version strips out 90% of the dialogue as it is
# contextually irrelevent here.
#---------------------------------------------------------
MidbattleHandlers.add(:midbattle_scripts, :vs_meimu_bossrush,
  proc { |battle, idxBattler, idxTarget, trigger|
    scene       = battle.scene
	player      = battle.battlers[0]
	meimu       = battle.battlers[1]
	partner     = battle.battlers[3]
	rand_puppet = [:MEEKO, :MAKURA, :MITORI, :TORAKO, :SASHA, :SUGAR, :KAREN, :MASHA]
	def_stats   = [:DEFENSE, :SPECIAL_DEFENSE]
	@inverse_turn_count = 0 if @inverse_turn_count.nil?
    @bbfar_turn_count   = 0 if @bbfar_turn_count.nil?
    @doe_turn_count     = 0 if @doe_turn_count.nil?
	@meimu_sleep        = false if @meimu_sleep.nil?
	case trigger
	#---------------------------------------------------------------
	# HP Thresholds
	#---------------------------------------------------------------
	when "RoundStartCommand_1_foe"
	  meimu.damageThreshold = 80 # Meimu's HP Bar should not go down below 80% her Max HP
	  echoln "* Meimu's Damage Threshold: #{meimu.damageThreshold}"
	when "BattlerReachedHPCap"
	#---------------------------------------------------------------
	# Threshold 1: Spell Card: 
	# Phantasmagoria - Fantasy Summoning
	#---------------------------------------------------------------
	  if battle.midbattleVariable == 0
	    next if battle.midbattleVariable != 0
		scene.pbStartSpeech(1)
		pbSEPlay("Spell Card Activation.ogg")
		battle.pbDisplayPaused(_INTL("Spell Card Activate!"))
		battle.pbDisplayPaused(_INTL("Phantasmagoria \"Fantasy Summoning!\""))
		scene.pbForceEndSpeech
		card_fantasy_summoning(battle.scene, battle) # Handled in separate method
		battle.midbattleVariable += 1 # Increments variable to 1.
		meimu.damageThreshold = 60 # Meimu's HP Bar should not go down below 60% her Max HP
		echoln "* Mid Battle Variable: #{battle.midbattleVariable}"
		echoln "* Meimu's Damage Threshold: #{meimu.damageThreshold}"
	#---------------------------------------------------------------
	# Threshold 2: Spell Card: 
	# Manipulation - Inversion of Perception
	#---------------------------------------------------------------
	  elsif battle.midbattleVariable == 1
	    next if battle.midbattleVariable != 1
		scene.pbStartSpeech(1)
		pbSEPlay("Spell Card Activation.ogg")
		battle.pbDisplayPaused(_INTL("Spell Card Activate!"))
		battle.pbDisplayPaused(_INTL("Manipulation \"Inversion of Perception\"!"))
		scene.pbForceEndSpeech
		card_inversion_perception(battle.scene, battle) # Handled in separate method
		battle.midbattleVariable += 1 # Increments variable to 2.
		meimu.damageThreshold = 40 # Meimu's HP Bar should not go down below 40% her Max HP
		echoln "* Mid Battle Variable: #{battle.midbattleVariable}"
		echoln "* Meimu's Damage Threshold: #{meimu.damageThreshold}"
	#---------------------------------------------------------------
	# Threshold 3: Spell Card: 
	# Deep Sleep - Nightmare of the Non-Existant
	#---------------------------------------------------------------
	  elsif battle.midbattleVariable == 2
	    next if battle.midbattleVariable != 2
		scene.pbStartSpeech(1)
		pbSEPlay("Spell Card Activation.ogg")
		battle.pbDisplayPaused(_INTL("Spell Card Activate!"))
		battle.pbDisplayPaused(_INTL("Deep Sleep \"Nightmare of the Non-Existant\"!"))
		scene.pbForceEndSpeech
		card_deep_sleep(battle.scene, battle) # Handled in separate method
		battle.midbattleVariable += 1 # Increments variable to 3.
		meimu.damageThreshold = 20 # Meimu's HP Bar should not go down below 20% her Max HP
		echoln "* Mid Battle Variable: #{battle.midbattleVariable}"
		echoln "* Meimu's Damage Threshold: #{meimu.damageThreshold}"
	#---------------------------------------------------------------
	# Threshold 4: Spell Card: 
	# Tale of a Cruel, Unforgiving Reality
	#---------------------------------------------------------------
	  elsif battle.midbattleVariable == 3
	    next if battle.midbattleVariable != 3
		scene.pbStartSpeech(1)
		pbSEPlay("Spell Card Activation.ogg")
		battle.pbDisplayPaused(_INTL("Spell Card Activate!"))
		battle.pbDisplayPaused(_INTL("Tale of a Cruel, Unforgiving Reality!"))
		scene.pbForceEndSpeech
		card_toacur(battle.scene, battle) # Handled in separate method
		battle.midbattleVariable += 1 # Increments variable to 4.
		meimu.damageThreshold = 10 # Meimu's HP Bar should not go down below 10% her Max HP
		echoln "* Mid Battle Variable: #{battle.midbattleVariable}"
		echoln "* Meimu's Damage Threshold: #{meimu.damageThreshold}"
	#---------------------------------------------------------------
	# Threshold 5: Spell Card: 
	# Phantasm - Boundary Between Fantasy and Reality
	#---------------------------------------------------------------
	  elsif battle.midbattleVariable == 4
	    next if battle.midbattleVariable != 4
		scene.pbStartSpeech(1)
		pbSEPlay("Spell Card Activation.ogg")
		battle.pbDisplayPaused(_INTL("Spell Card Activate!"))
		battle.pbDisplayPaused(_INTL("Phantasm \"Boundary Between Fantasy and Reality\"!"))
		scene.pbForceEndSpeech
		card_bbfar(battle.scene, battle) # Handled in separate method
		battle.pbDisplayPaused(_INTL("Meimu became completely untouchable!"))
		scene.pbForceEndSpeech
		battle.midbattleVariable += 1 # Increments variable to 5.
		meimu.damageThreshold = 10 # Safety-check, but ultimately irrelevent. Meimu physically cannot take damage in this state.
		echoln "* Mid Battle Variable: #{battle.midbattleVariable}"
		echoln "* Meimu's Damage Threshold: #{meimu.damageThreshold}"
	  end
	#---------------------------------------------------------
	# Round End Effects
	#---------------------------------------------------------
	when "RoundEnd_foe1"
	  if $game_switches[158] # Inverse Battle Active Check
	  echoln "Checking Inverse Battle status"
	    if @inverse_turn_count != 4
		  @inverse_turn_count += 1
		  echoln "Inverse Battle Turn Count: #{@inverse_turn_count}/4"
		else
		  echoln "Inverse Battle Turn Count: #{@inverse_turn_count}/4"
		  battle.pbDisplayPaused(_INTL("Type effectiveness inversion has stopped."))
		  $game_temp.battle_inverse = false
		  @inverse_turn_count = 0
		  $game_switches[158] = false
		end
	  end
	  
	  if $game_switches[159] # Boundary Between Fantasy and Reality Check
	  echoln "Checking BBFAR status"
	    if @bbfar_turn_count < 4
		  @bbfar_turn_count += 1
		  meimu.damageThreshold = 10
		  echoln "Boundary Between Fantasy and Reality Turn Count: #{@bbfar_turn_count}/5"
		else
		  echoln "Boundary Between Fantasy and Reality Turn Count: #{@bbfar_turn_count}/5"
		  battle.pbCommonAnimation("MeimuTF", meimu)
		  meimu.pbChangeForm(1, nil)
		  battle.pbDisplayPaused(_INTL("Meimu reappears!"))
		  meimu.pbChangeTypes(:PHANTASM)
		  meimu.ability = :PHANTASMDREAM_ALT2
		  meimu.pbResetStatStages
		  showAnim = true
	      def_stats.each do |stat|
	        next if !meimu.pbCanRaiseStatStage?(stat, meimu)
		    meimu.pbRaiseStatStage(stat, 2, meimu, showAnim)
		    showAnim = false
	      end
		  scene.pbStartSpeech(1)
		  pbSEPlay("Spell Card Activation.ogg")
		  battle.pbDisplayPaused(_INTL("Final Spell Card Activate!"))
		  battle.pbDisplayPaused(_INTL("Declaration of Existence!"))
		  scene.pbForceEndSpeech
		  #battle.pbDisplayPaused(_INTL("Meimu begins charging energy for her ultimate attack!"))
		  #Find a decent animation to play here
		  $game_switches[160] = true # Enables charging of Declaration of Existence
		  $game_switches[159] = false # No longer need bbfar being checked
		  battle.midbattleVariable += 1 # Increments variable to 6.
		  meimu.damageThreshold = 0 # Meimu should not drop below 1 HP.
		  echoln "* Mid Battle Variable: #{battle.midbattleVariable}"
		  echoln "* Meimu's Damage Threshold: #{meimu.damageThreshold}"
		  @doe_turn_count = 0
		end
	  end
	  
	  if $game_switches[160] # Declaration of Existence Check
	  echoln "Checking Declaration of Existence status"
	    case @doe_turn_count
		when 0
		  battle.pbDisplayPaused(_INTL("Meimu begins charging energy for her ultimate attack!"))
		  #Find a decent animation to play here
		  @doe_turn_count += 1
		when 1
		  battle.pbDisplayPaused(_INTL("Meimu prepares to unleash her ultimate attack!"))
		  #Find a decent animation to play here
		  @doe_turn_count += 1
		when 2
		  battle.pbDisplayPaused(_INTL("Meimu will unleash her ultimate attack next turn!"))
		  #Find a decent animation to play here
		  @doe_turn_count += 1
		when 3
		  card_doe(scene, battle)
		end
	  end
	# when "BattlerFainted_foe"
	  # echoln "Battler Fainted"
	  # battle.databoxStyle = :Long
	#---------------------------------------------------------
	# Special Scenes
	#---------------------------------------------------------
	# Condition: Meimu is put to sleep
	#---------------------------------------------------------
	when "BattlerStatusChange_foe"
	  if meimu.status == :SLEEP
	    if @meimu_sleep == false
		scene.pbStartSpeech(1)
		battle.pbDisplayPaused(_INTL("Did you forget? I was born from all of the dreams of every Gensokyo across time and space!"))
		battle.pbDisplayPaused(_INTL("Being put to sleep is nothing to me!"))
		@meimu_sleep = true
		end
	  end
	end
   }
  )

#---------------------------------------------------------
# Phantasmagoria - Fantasy Summoning
#   * Meimu will summon one Puppet at her side when she
#     activates this Spell Card. They will be randomly
#     selected from the array of Non-Real Puppets.
#---------------------------------------------------------
def card_fantasy_summoning(scene, battle)
  player = battle.battlers[0]
  meimu  = battle.battlers[1]
  rand_puppet = [:MEEKO, :MAKURA, :MITORI, :TORAKO, :SASHA, :SUGAR, :KAREN, :MASHA]
  
  battle.pbDisplayPaused(_INTL("Meimu materialized a Puppet out of thin air!"))
  battle.pbAddNewBattler(rand_puppet.sample, 100)
end

#---------------------------------------------------------
# Manipulation - Inversion of Perception
#   * Meimu will invert the Type Chart for three turns.
#---------------------------------------------------------
def card_inversion_perception(scene, battle)
  player = battle.battlers[0]
  meimu  = battle.battlers[1]
  
  @inverse_turn_count ||= 0
  @inverse_turn_count += 1
  $game_temp.battle_inverse = true
  battle.pbDisplayPaused(_INTL("Meimu manipulated reality to reverse type effectiveness for the next three turns!"))
  $game_switches[158] = true # Inverse Battle Active switch
  echoln "Inverse Battle Status: #{$game_switches[158]}"
end

#---------------------------------------------------------
# Deep Sleep - Nightmare of the Non-Existant
#   * Meimu will trap the opposing Puppet in a 5 turn sleep,
#     as well as inflict them with a curse.
#---------------------------------------------------------
def card_deep_sleep(scene, battle)
  player = battle.battlers[0]
  meimu  = battle.battlers[1]
	
  battle.pbDisplayPaused(_INTL("Meimu locked your Puppet into a sleeping nightmare!"))
  battle.pbAnimation(:GRUDGE, player, player)
  player.pbSleep if player.pbCanInflictStatus?(:SLEEP, player, true)
  player.statusCount = 5
  player.effects[PBEffects::Curse] = true
end

#---------------------------------------------------------
# Tale of a Cruel, Unforgiving Reality
#   * Meimu will reactivate a previous Spell Card with the
#     same conditions as when it was initially activated
#---------------------------------------------------------
def card_toacur(scene, battle)
  battle.pbDisplayPaused(_INTL("Meimu used her Spell Card to replicate a previous Spell Card's effects!"))
  case rand(1..10)
  when 1..5 then card_fantasy_summoning(scene, battle)
  when 6, 7 then card_inversion_perception(scene, battle)
  when 8..10 then card_deep_sleep(scene, battle)
  end
end

#---------------------------------------------------------
# Phantasm - Boundary Between Fantasy and Reality
#   * Meimu will give herself complete damage, status, and
#     stat lowering immunity for five turns. During this
#     time, she will boost her Attack and Special Attack stats
#     by two.
#   * After five turns are up, she will drop invincibility,
#     reset her Attacking stats, boost defensive stats by 3,
#     and activate her final Spell Card, "Declaration of
#     Existence".
#---------------------------------------------------------
def card_bbfar(scene, battle)
  player = battle.battlers[0]
  meimu  = battle.battlers[1]
  atk_stats = [:ATTACK, :SPECIAL_ATTACK]

  battle.pbAnimation(:TELEPORT, meimu, meimu)
  meimu.pbChangeForm(2, _INTL("Meimu vanishes before your eyes!"))
  meimu.pbChangeTypes(:PHANTASM)
  meimu.ability = :PHANTASMDREAM_ALT1
  showAnim = true
  atk_stats.each do |stat|
    next if !meimu.pbCanRaiseStatStage?(stat, meimu)
    meimu.pbRaiseStatStage(stat, 2, meimu, showAnim)
    showAnim = false
  end
  $game_switches[159] = true # Switch that checks if bbfar is active. Required for the turn countdown. There may be a better way to do this.
end

#---------------------------------------------------------
# Declaration of Existence
#   * Meimu will charge energy for two turns, then launch
#     an attack that will immediately KO the active battler.
#     This repeats every two turns until the player is out 
#     of Puppets.
#---------------------------------------------------------
def card_doe(scene, battle)
  player = battle.battlers[0]
  meimu  = battle.battlers[1]
	
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
  @doe_turn_count = 0
end
