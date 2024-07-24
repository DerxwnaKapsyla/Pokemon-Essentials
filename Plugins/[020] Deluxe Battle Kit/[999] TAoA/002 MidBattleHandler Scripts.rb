  #-----------------------------------------------------------------------------
  # The Adventures of Ayaka
  #-----------------------------------------------------------------------------
  # The Mansion of Mystery
  #-----------------------------------------------------------------------------    
  # None here!
  #-----------------------------------------------------------------------------
  # The Festival of Curses
  #-----------------------------------------------------------------------------  
  # Scene: Nitori using the Kappa Augment Items
  #		* Randomly, Nitori will use either an Attack or Defense augment
  #		  at the start of the turn.
  #-----------------------------------------------------------------------------  
  MidbattleHandlers.add(:midbattle_scripts, :vs_nitori,
    proc { |battle, idxBattler, idxTarget, trigger|
      scene = battle.scene
	  foe = battle.battlers[1]
      case trigger
	  #-------------------------------------
	  when "RoundStartAttack_foe"
	    next if rand(100) < 80
	    atk_stats = [:ATTACK, :SPECIAL_ATTACK]
	    def_stats = [:DEFENSE, :SPECIAL_DEFENSE]
	    showAnim = true
	    if rand(2) == 1 # Attack Boost
  	      atk_stats.each do |stat|
		    next if !foe.pbCanRaiseStatStage?(stat, foe)
		    if showAnim
		      scene.pbStartSpeech(1)
		      battle.pbDisplayPaused(_INTL("Defense augment, activate!"))
		    end
		    foe.pbRaiseStatStage(stat, 1, foe, showAnim)
		    showAnim = false
	      end
	    else # Defense Boost
	      def_stats.each do |stat|
		    next if !foe.pbCanRaiseStatStage?(stat, foe)
		    if showAnim
		      scene.pbStartSpeech(1)
		      battle.pbDisplayPaused(_INTL("Defense augment, activate!"))
		    end
		    foe.pbRaiseStatStage(stat, 1, foe, showAnim)
		    showAnim = false
	      end
	    end
	  end
     }
  ) 
  
  #-----------------------------------------------------------------------------  
  # Scene: Medicine Battle
  #		* General taunts against the Player
  #		* Buffs her Puppets at random intervals
  #		* Inflicts Curse on the Player's Puppets
  #		* Have a rebound effect at random, which either buffs the player or
  #       debuffs Medicine
  #		* On last Puppet, boosts both Atk. and Def. stats by +4, apply perma
  #		  endure, Ingrain, and Aurora Veil
  #		* When last Puppet is at low health, rebound effect and drop all buffs
  #		  to final Puppet, play cutscene and change music
  #-----------------------------------------------------------------------------    
  MidbattleHandlers.add(:midbattle_scripts, :vs_medicine,
    proc { |battle, idxBattler, idxTarget, trigger|
    scene    = battle.scene
    medi     = battle.battlers[1]
    player   = battle.battlers[0]
	case trigger
	#-----------------------------------------------------------------
	# Battle Start: Medicine taunts the player, inflicts player side
	#               with a curse.
	#-----------------------------------------------------------------
	when "RoundStartCommand_1_foe"
      scene.pbStartSpeech(1)
      battle.pbDisplayPaused(_INTL("With this Tome of Curses, there's no way you'll be able to beat me!"))
	  battle.pbDisplayPaused(_INTL("I call upon this Tome of Curses... smite my enemies!"))
	  scene.pbForceEndSpeech
	  battle.pbAnimation(:GRUDGE, player, player)
	  player.effects[PBEffects::Curse]
	  battle.pbDisplayPaused(_INTL("{1} was inflicted with a curse!", player.pbThis))
	#-----------------------------------------------------------------
	# Round Two: Medicine taunts the player, boosts stats of her
	#            active Puppet.
	#-----------------------------------------------------------------
	when "RoundStartCommand_2_foe"
	  scene.pbStartSpeech(1)
	  battle.pbDisplayPaused(_INTL("I can do a lot more than just bring harm to my foes. Just watch!"))
	  battle.pbDisplayPaused(_INTL("I call upon this Tome of Curses... bless my allies with power!"))
	  scene.pbForceEndSpeech
	  battle.pbDisplayPaused(_INTL("Medicine uses the Tome of Curses to boost her party's strength!"))
	  showAnim = true
	  [:ATTACK, :SPECIAL_ATTACK, :SPEED, :ACCURACY].each do |stat|
	    next if !medi.pbCanRaiseStatStage?(stat, medi)
		medi.pRaiseStatStage(stat, 2, medi, showAnim)
		showAnim = false
	  end
	#-----------------------------------------------------------------
	# On Foe Sendout: Medicine uses the Tome of Curses to buff her
	#                 sent-in Puppet.
	#-----------------------------------------------------------------  
	when "AfterSendOut_foe"
	  scene.pbStartSpeech(1)
	  battle.pbDisplayPaused(_INTL("I call upon this Tome of Curses... bless my allies with power!"))
	  scene.pbForceEndSpeech
	  battle.pbDisplayPaused(_INTL("Medicine uses the Tome of Curses to boost her party's strength!"))
	  showAnim = true
	  [:ATTACK, :SPECIAL_ATTACK, :SPEED, :ACCURACY].each do |stat|
	    next if !medi.pbCanRaiseStatStage?(stat, medi)
		medi.pRaiseStatStage(stat, 2, medi, showAnim)
		showAnim = false
	  end
	#------------------------------------------------------------------------
	# Random At Turn End: Medicine utilizes the Tome of Curses.
	# Effects: * Debuff player's party (Stats 25%, Statuses 75%) 65%
	#          * Buffs Medicine's party (Stats) 35%
	#          * Rebound effect (Applies boon/bane to opposite side) 15%
	#------------------------------------------------------------------------
	when "RoundEnd_player"
	  next if battle.pbTriggerActivated?("AfterLastSendOut_foe")
	  if rand(300) <= 100 # Trigger the Tome of Curses
	    scene.pbStartSpeech(1)
		battle.pbDisplayPaused(_INTL("I call upon this Tome of Curses... smite my enemies!"))
		scene.pbForceEndSpeech
	    if rand(100) <= 65 # Debuff Effect
		battle.pbDisplayPaused(_INTL("Medicine lays a curse upon your party!"))
		  if rand(100) <= 85 # Non-Rebound Effect
		    if rand(100) <= 75 # Status Conditions
			  case rand(7) # Determining Status Condition
			  when 0 then player.pbParalyze if player.pbCanInflictStatus?(:PARALYSIS, player, true)
			  when 1 then player.pbFreeze if player.pbCanInflictStatus?(:FREEZE, player, true)
			  when 2 then player.pbBurn if player.pbCanInflictStatus?(:BURN, player, true)
			  when 3 then player.pbPoison if player.pbCanInflictStatus?(:POISON, player, true)
			  when 3 then player.pbSleep if player.pbCanInflictStatus?(:SLEEP, player, true)
			  when 5 then player.pbConfuse if player.pbCanConfuse?(battler, false)
			  when 6 then player.effects[PBEffects::Curse]
			  end
			else # Stat Decreasers
			  case rand(3) # Determining Stats to lower
			  when 0
	            showAnim = true
			    [:ATTACK, :SPECIAL_ATTACK].each do |stat|
	            next if !player.pbCanLowerStatStage?(stat, player)
	              player.pbLowerStatStage(stat, 1, player, showAnim)
	              showAnim = false
	            end
			  when 1
	            showAnim = true
			    [:DEFENSE, :SPECIAL_DEFENSE].each do |stat|
	            next if !player.pbCanLowerStatStage?(stat, player)
	              player.pbLowerStatStage(stat, 1, player, showAnim)
	              showAnim = false
	            end
		  	  when 2
	            showAnim = true
			    [:SPEED].each do |stat|
	            next if !player.pbCanLowerStatStage?(stat, player)
	              player.pbLowerStatStage(stat, 1, player, showAnim)
	              showAnim = false
	            end
			  end
			end
		  else # Rebound Effect
		    battle.midbattleVariable += 1
			pbWait(10)
			battle.pbDisplayPaused(_INTL("...Except, the effect rebounded!"))
			if rand(100) <= 75 # Status Conditions
			  case rand(7) # Determining Status Condition
			  when 0 then medi.pbParalyze if medi.pbCanInflictStatus?(:PARALYSIS, medi, true)
			  when 1 then medi.pbFreeze if medi.pbCanInflictStatus?(:FREEZE, medi, true)
			  when 2 then medi.pbBurn if medi.pbCanInflictStatus?(:BURN, medi, true)
			  when 3 then medi.pbPoison if medi.pbCanInflictStatus?(:POISON, medi, true)
			  when 3 then medi.pbSleep if medi.pbCanInflictStatus?(:SLEEP, medi, true)
			  when 5 then medi.pbConfuse if medi.pbCanConfuse?(battler, false)
			  when 6 then medi.effects[PBEffects::Curse]
			  end
			else # Stat Decreasers
			  case rand(3) # Determining Stats to lower
			  when 0
	            showAnim = true
			    [:ATTACK, :SPECIAL_ATTACK].each do |stat|
	            next if !medi.pbCanLowerStatStage?(stat, medi)
	              medi.pbLowerStatStage(stat, 1, medi, showAnim)
	              showAnim = false
	            end
			  when 1
	            showAnim = true
			    [:DEFENSE, :SPECIAL_DEFENSE].each do |stat|
	            next if !medi.pbCanLowerStatStage?(stat, medi)
	              medi.pbLowerStatStage(stat, 1, medi, showAnim)
	              showAnim = false
	            end
		  	  when 2
	            showAnim = true
			    [:SPEED].each do |stat|
	            next if !medi.pbCanLowerStatStage?(stat, medi)
	              medi.pbLowerStatStage(stat, 1, medi, showAnim)
	              showAnim = false
	            end
			  end
			end
		    case battle.midbattleVariable
		    when battle.midbattleVariable == 1
		      scene.pbStartSpeech(1)
			  battle.pbDisplayPaused(_INTL("No! That wasn't supposed to happen!"))
			  scene.pbStartSpeech(0)
			  battle.pbDisplayPaused(_INTL("(It's just like Miss Hina said... the effects are rebounding because of her inexperience!)"))
			  scene.pbForceEndSpeech
		    when battle.midbattleVariable == 2
			  scene.pbStartSpeech(1)
			  battle.pbDisplayPaused(_INTL("Grr! Why does this keep happening!?"))
			  scene.pbForceEndSpeech
			end
		  end
		else # Buff Effect
		  if rand(100) <= 85 # Non-Rebound Effect
			case rand(3) # Determining Stats to Raise
			when 0
	          showAnim = true
			  [:ATTACK, :SPECIAL_ATTACK].each do |stat|
	          next if !medi.pbCanRaiseStatStage?(stat, medi)
	            medi.pbRaiseStatStage(stat, 1, medi, showAnim)
	            showAnim = false
	          end
			when 1
	          showAnim = true
			  [:DEFENSE, :SPECIAL_DEFENSE].each do |stat|
	          next if !medi.pbCanRaiseStatStage?(stat, medi)
	            medi.pbRaiseStatStage(stat, 1, medi, showAnim)
	            showAnim = false
	          end
		  	when 2
	          showAnim = true
			  [:SPEED].each do |stat|
	          next if !medi.pbCanRaiseStatStage?(stat, medi)
	            medi.pbRaiseStatStage(stat, 1, medi, showAnim)
	            showAnim = false
	          end
			end
		  else # Rebound Effect
		    battle.midbattleVariable += 1
			pbWait(10)
			battle.pbDisplayPaused(_INTL("...Except, the effect rebounded!"))
			case rand(3) # Determining Stats to Raise
			when 0
	          showAnim = true
			  [:ATTACK, :SPECIAL_ATTACK].each do |stat|
	          next if !player.pbCanRaiseStatStage?(stat, player)
	            player.pbRaiseStatStage(stat, 1, player, showAnim)
	            showAnim = false
	          end
			when 1
	          showAnim = true
			  [:DEFENSE, :SPECIAL_DEFENSE].each do |stat|
	          next if !player.pbCanRaiseStatStage?(stat, player)
	            player.pbRaiseStatStage(stat, 1, player, showAnim)
	            showAnim = false
	          end
		  	when 2
	          showAnim = true
			  [:SPEED].each do |stat|
	          next if !player.pbCanRaiseStatStage?(stat, player)
	            player.pbRaiseStatStage(stat, 1, player, showAnim)
	            showAnim = false
	          end
			end
		    case battle.midbattleVariable
		    when battle.midbattleVariable == 1
		      scene.pbStartSpeech(1)
			  battle.pbDisplayPaused(_INTL("No! That wasn't supposed to happen!"))
			  scene.pbStartSpeech(0)
			  battle.pbDisplayPaused(_INTL("(It's just like Miss Hina said... the effects are rebounding because of her inexperience!)"))
			  scene.pbForceEndSpeech
		    when battle.midbattleVariable == 2
			  scene.pbStartSpeech(1)
			  battle.pbDisplayPaused(_INTL("Grr! Why does this keep happening!?"))
			  scene.pbForceEndSpeech
			end
		  end
		end
	  end
	#-----------------------------------------------------------------
	# Foe's Puppet Faints: Medicine inflicts a debuff curse on the
	#                      player's side.
	#-----------------------------------------------------------------
	when "TargetHPHalf_foe"
	  next if battle.pbTriggerActivated?("AfterLastSendOut_foe")
	  scene.pbStartSpeech(1)
	  battle.pbDisplayPaused(_INTL("Try picking on someone your own size!"))
	  scene.pbForceEndSpeech
	  battle.pbDisplayPaused(_INTL("Medicine uses the Tome of Curses to boost her party's defenses!"))
	  showAnim = true
	  [:DEFENSE, :SPECIAL_DEFENSE].each do |stat|
	  next if !medi.pbCanRaiseStatStage?(stat, medi)
	    medi.pbRaiseStatStage(stat, 1, medi, showAnim)
	    showAnim = false
	  end
	#-----------------------------------------------------------------
	# Foe's Puppet Faints: Medicine inflicts a debuff curse on the
	#                      player's side.
	#-----------------------------------------------------------------
	when "BattlerFainted_foe"
	  next if battle.pbTriggerActivated?("AfterLastSendOut_foe")
	  scene.pbStartSpeech(1)
	  battle.pbDisplayPaused(_INTL("Let's see how you feel being weak!"))
	  scene.pbForceEndSpeech
	  battle.pbDisplayPaused(_INTL("Medicine lays a curse upon your party!"))
	  battle.pbAnimation(:GRUDGE, player, player)
	  showAnim = true
	  [:DEFENSE, :SPECIAL_DEFENSE].each do |stat|
	  next if !player.pbCanLowerStatStage?(stat, player)
	    player.pbLowerStatStage(stat, 1, player, showAnim)
	    showAnim = false
	  end
	  player.effects[PBEffects::Curse]
	#-----------------------------------------------------------------
	# Final Foe Sendout: Medicine taunts the player and superboosts
	#                    her final Puppet's stats, applys Ingrain, and
	#                    sets Aurora Veil (can probably be replaced
	#                    with general boss buff status)
	#-----------------------------------------------------------------
	when "AfterLastSendOut_foe"
	  scene.pbStartSpeech(1)
	  battle.pbDisplayPaused(_INTL("I will bring an end to this, here and now!"))
	  battle.pbDisplayPaused(_INTL("Tome of Curses, grant my allies with unbreakable resolve and power!"))
	  scene.pbForceEndSpeech
	  battle.pbAnimation(:HARDEN, medi, medi)
	  battle.pbDisplayPaused(_INTL("{1} glows with immense power!",medi.pbThis))
	  showAnim = true
	  [:DEFENSE, :SPECIAL_DEFENSE, :ATTACK, :SPECIAL_ATTACK].each do |stat|
	  next if !medi.pbCanRaiseStatStage?(stat, medi)
	    medi.pbRaiseStatStage(stat, 4, medi, showAnim)
	    showAnim = false
	  end
	  medi.effects[PBEffects::Ingrain]
	  medi.effects[PBEffects::AuroraVeil] = 99
	  medi.effects[PBEffects::Mist] = 99
	  foe.damageThreshold = -1
	  scene.pbStartSpeech(1)
	  battle.pbDisplayPaused(_INTL("There's no way you'll be able to overcome us now!"))
	  scene.pbStartSpeech(0)
	  battle.pbDisplayPaused(_INTL("We're just going to have to try... Let's do this, {1}", player.pbThis))
	  scene.pbForceEndSpeech
	#-----------------------------------------------------------------
	# Final Foe Half HP: Medicine activates a Spell Card,
	#                    (Effect) - Scrapped Concept
	#-----------------------------------------------------------------
	
	
	#-----------------------------------------------------------------
	# Final Foe Low HP: Medicine taunts the player and attempts to
	#                   use the Tome of Curses again, which does
	#                   nothing and then rebounds, removing all of
	#                   the last Puppet's boons.
	#-----------------------------------------------------------------
	when "LastTargetHPLow_foe"
	  scene.pbStartSpeech(1)
	  battle.pbDisplayPaused(_INTL("I can't... I won't let my kindred down!"))
	  battle.pbDisplayPaused(_INTL("Tome of Curses, bring my foe to their knees!"))
	  scene.pbForceEndSpeech
	  battle.pbDisplayPaused(_INTL("Medicine calls upon the Tome of Curses one last time!"))
	  pbBGMFade(1.0)
	  pbWait(60)
	  battle.pbDisplayPaused(_INTL("... Nothing happened."))
	  pbBGMPlay("W-017. Seeds of the Incident")
	  scene.pbStartSpeech(1)
	  battle.pbDisplayPaused(_INTL("... Let's try that again!"))
	  battle.pbDisplayPaused(_INTL("Tome of Curses! Bring my foe to their knees!"))
	  pbWait(30)
	  battle.pbDisplayPaused(_INTL("Why... Why aren't you working anymore?!"))
	  if battle.midbattleVariable < 1
	    scene.pbStartSpeech(0)
	    battle.pbDisplayPaused(_INTL("(It's just like Miss Hina said... the effects are rebounding because of her inexperience!)"))
		scene.pbStartSpeech(1)
	  end
	  battle.pbDisplayPaused(_INTL("I call upon the Tome of Curses! Please, bring my foe to their knees!"))
	  scene.pbForceEndSpeech
	  pbWait(30)
	  battle.pbDisplayPaused(_INTL("The Tome of Curses reacts!"))
	  pbWait(30)
	  battle.pbDisplayPaused(_INTL("... The effect rebounds."))
	  battle.pbAnimation(:GRUDGE, medi, medi)
	  medi.pbResetStatStages
	  medi.effects[PBEffects::Ingrain] = false
	  medi.effects[PBEffects::AuroraVeil] = 0
	  medi.effects[PBEffects::Mist] = 0
	  battle.pbDisplayPaused(_INTL("All of the protections surounding Medicine's team disappeared!"))
	  scene.pbStartSpeech(1)
	  battle.pbDisplayPaused(_INTL("N-No! That wasn't supposed to happen! Why is this happening now!?"))
	  scene.pbStartSpeech(0)
	  battle.pbDisplayPaused(_INTL("(This is our chance to finish it!)"))
	  scene.pbForceEndSpeech
	end
    }
  )
  
  #-----------------------------------------------------------------------------
  # The Kingdom of Lunacy
  #-----------------------------------------------------------------------------   
  # Scene: Vs. Hell Fairies
  #		* Hell Fairies have boosted stats. +1 Atk, Sp.Atk, Spd
  #		* Player's Puppets have a 5% chance to become confused at end of turn
  #-----------------------------------------------------------------------------  
  MidbattleHandlers.add(:midbattle_scripts, :vs_hfs,
    proc { |battle, idxBattler, idxTarget, trigger|
    scene         = battle.scene
    hf1           = battle.battlers[1]
	hf2           = battle.battlers[3]
    p1            = battle.battlers[0]
	p2            = battle.battlers[2]
	atk_stats     = [:ATTACK, :SPECIAL_ATTACK, :SPEED]
	showAnim = true
	case trigger
	when "AfterSendOut_foe1"
	  battle.pbDisplayPaused(_INTL("The Hell Fairy's {1} started glowing with immense strength!",hf1.pbThis))
	  atk_stats.each do |stat|
	    hf1.pbRaiseStatStage(stat, 1, hf1, showAnim)
		showAnim = false
	  end
	
	when "AfterSendOut_foe2"
	  battle.pbDisplayPaused(_INTL("The Hell Fairy's {1} started glowing with immense strength!",hf2.pbThis))
	  atk_stats.each do |stat|
	    hf2.pbRaiseStatStage(stat, 1, hf2, showAnim)
		showAnim = false
	  end
	
	when "RoundEnd_player"
	  if rand(100) <= 5
	    if p1.pbCanConfuse?(player, false)
	      battle.pbDisplayPaused(_INTL("{1} started flailing about wildly!",p1.pbThis))
          p1.pbConfuse
	    end
      end	
	  if rand(100) <= 5
	    if p2.pbCanConfuse?(player, false)
	      battle.pbDisplayPaused(_INTL("{1} started plailing about wildly!",p2.pbThis))
          p2.pbConfuse
	    end
      end	
	end
	}
  )
  
  #-----------------------------------------------------------------------------  
  # Scene: Vs. Clownpiece & Hell Fairies
  #		* Hell Fairies have boosted stats. +1 Atk, Sp.Atk, Spd
  #     * Hell Fairies have decreased stats. -1 Def, Sp.Def, Eva
  #		* Player's Puppets have a 5% chance to become confused at end of turn
  #		* Hell Fairies cycle in after being defeated. After three cycles,
  #		  Player stops gaining EXP for defeating them.
  #		* When Clownpiece is defeated, the partner fairy retreats.
  #----------------------------------------------------------------------------- 
  MidbattleHandlers.add(:midbattle_scripts, :vs_clownpiece,
    proc { |battle, idxBattler, idxTarget, trigger|
    scene         = battle.scene
    clownpiece    = battle.battlers[1]
	hellfairy     = battle.battlers[3]
    p1            = battle.battlers[0]
	p2            = battle.battlers[2]
	atk_stats     = [:ATTACK, :SPECIAL_ATTACK, :SPEED]
	def_stats     = [:DEFENSE, :SPECIAL_DEFENSE, :EVASION]
	fairy_counter = $game_variables[133] # Hell Fairy Counter variable
	hf_faint      = $game_variables[134] # Hell Fairy Faint Counter
	cl_faint      = $game_variables[135] # Clownpiece Faint Counter
	showAnim = true
	case trigger
	#----------------------------------------------------------------------------- 
	# On Send Out: Both Clownpiece and Hell Fairies gain +1 to Attacking stats
	#              and a -1 to all Defensive stats
	#----------------------------------------------------------------------------- 
	when "AfterSendOut_foe1"
	  battle.pbDisplayPaused(_INTL("Clownpiece's Puppet started glowing with immense strength!"))
	  atk_stats.each do |stat|
	    clownpiece.pbRaiseStatStage(stat, 1, clownpiece, showAnim)
		showAnim = false
	  end
	  def_stats.each do |stat|
	    clownpiece.pbLowerStatStage(stat, 1, clownpiece, showAnim)
		showAnim = false
	  end
	
	when "AfterSendOut_foe2"
	  battle.pbDisplayPaused(_INTL("The Hell Fairy's Puppet started glowing with immense strength!"))
	  atk_stats.each do |stat|
	    hellfairy.pbRaiseStatStage(stat, 1, hellfairy, showAnim)
		showAnim = false
	  end
	  def_stats.each do |stat|
	    hellfairy.pbLowerStatStage(stat, 1, clownpiece, showAnim)
		showAnim = false
	  end
	#----------------------------------------------------------------------------- 
	# On Turn End: 5% chance to confuse Player's active Puppets
	#----------------------------------------------------------------------------- 
	when "RoundEnd_player"
	 if rand(100) <= 5
	   if p1.pbCanConfuse?(p1, false)
	     battle.pbDisplayPaused(_INTL("{1} was drawn in by Clownpiece's torchlight, and started flailing wildly!",p1.pbThis))
         p1.pbConfuse
	   end
     end	
	 if rand(100) <= 5
	   if p2.pbCanConfuse?(p2, false)
	     battle.pbDisplayPaused(_INTL("{1} was drawn in by Clownpiece's torchlight, and started flailing wildly!",p2.pbThis))
         p2.pbConfuse
	   end
     end	
	#----------------------------------------------------------------------------- 
	# Reinforcements: After a Hell Fairy is defeated, another one takes its place.
	#                 This cycles infinitely. After three cycles of Hell Fairies 
	#                 (Nine switch ins), Clownpiece will taunt the player, and 
	#                 make it so you can't gain any further experience in the 
	#                 battle.
	#----------------------------------------------------------------------------- 
    when "BattlerFainted_foe2"
      $game_variables[134] += 1
      if $game_variables[134] == 2
        $game_variables[133] += 1
        scene.pbStartSpeech(3)
        battle.pbDisplayPaused(_INTL("Oh no, I need to retreat!"))
        pbSEPlay("Battle flee")
        scene.pbForceEndSpeech
        case ($game_variables[133] % 3)
        when 1 
          if $game_variables[133] == 1
            scene.pbStartSpeech(0)
            battle.pbDisplayPaused(_INTL("Alright, that means all that's left is Clownpiece!"))
            scene.pbShowSpeakerWindows("???", 1)
            battle.pbDisplayPaused(_INTL("Not so fast! I'll take over for her!"))
            scene.pbForceEndSpeech
            battle.pbAddNewTrainer(:HELLFAIRY, "Astera", $game_variables[99])
            scene.pbStartSpeech(0)
            battle.pbDisplayPaused(_INTL("Another one, huh? Alright! Bring 'em on!"))
            scene.pbForceEndSpeech
            $game_variables[134] = 0
          else
            battle.pbAddNewTrainer(:HELLFAIRY, "Astera", $game_variables[99])
            $game_variables[134] = 0		  
          end
        when 2
          if $game_variables[133] == 2
            scene.pbStartSpeech(0)
            scene.pbShowSpeakerWindows("???", 1)
            battle.pbDisplayPaused(_INTL("Oh! Me next, me next~!"))
            scene.pbForceEndSpeech
            battle.pbAddNewTrainer(:HELLFAIRY, "Olivia", $game_variables[99])
            scene.pbStartSpeech(0)
            battle.pbDisplayPaused(_INTL("Okay, I can take one more, no problem!"))
            scene.pbForceEndSpeech
            $game_variables[134] = 0
          else
            battle.pbAddNewTrainer(:HELLFAIRY, "Olivia", $game_variables[99])
            $game_variables[134] = 0	
          end
        when 0
          if $game_variables[133] == 3
            scene.pbStartSpeech(0)
            battle.pbDisplayPaused(_INTL("Surely that should be all of them, now I can focus on Clownpiece!"))
            scene.pbShowSpeakerWindows("???", 1)
            battle.pbDisplayPaused(_INTL("Silly human, I'm already ready for another go!"))
            scene.pbForceEndSpeech
            battle.pbAddNewTrainer(:HELLFAIRY, "Lucia", $game_variables[99])
            scene.pbStartSpeech(0)
            battle.pbDisplayPaused(_INTL("But- But I just beat you! How!?"))
            scene.pbShowSpeaker(1)
            scene.pbShowSpeakerWindows(scene.pbGetSpeaker)
            battle.pbDisplayPaused(_INTL("Gyahahaha, these girls are boosted by my torch's light! They'll always be ready for another go after every time you beat them!"))
            scene.pbHideSpeaker
            scene.pbShowSpeaker(0)
            scene.pbShowSpeakerWindows(scene.pbGetSpeaker)
            battle.pbDisplayPaused(_INTL("Ghhk- How is that even fair!"))
            scene.pbForceEndSpeech
            $game_variables[134] = 0
          elsif $game_variables[133] == 6	  
            battle.pbAddNewTrainer(:HELLFAIRY, "Lucia", $game_variables[99])
            scene.pbStartSpeech(1)
            #scene.pbShowSpeaker(:CLOWNPIECET)
            #scene.pbShowSpeakerWindows("Clownpiece", 1)
            battle.pbDisplayPaused(_INTL("What did I tell you! They won't stop coming. They won't stop coming, gyahahaha!"))
            scene.pbForceEndSpeech
            $game_variables[134] = 0
          elsif $game_variables[133] == 9
            battle.pbAddNewTrainer(:HELLFAIRY, "Lucia", $game_variables[99])
            scene.pbStartSpeech(1)
            #scene.pbShowSpeaker(:CLOWNPIECET)
            #scene.pbShowSpeakerWindows("Clownpiece", 1)
            battle.pbDisplayPaused(_INTL("...It's not any fun if you don't focus on me! Let's see how you like it when I do this!"))
            scene.pbForceEndSpeech
            battle.expGain = false
            battle.pbDisplayPaused(_INTL("Clownpiece waved her torch around in front of your Puppets! It looks like they won't gain any further experience this battle!"))
            $game_variables[134] = 0
          else
            battle.pbAddNewTrainer(:HELLFAIRY, "Lucia", $game_variables[99])
            $game_variables[134] = 0
          end
        end
      end
	
	#----------------------------------------------------------------------------- 
	# Clownpiece Defeat: When Clownpiece is defeated, have the partner fairy
	#                    retreat from battle.
	#----------------------------------------------------------------------------- 
	when "BattlerFainted_foe1"
	  $game_variables[135] += 1
	  if $DEBUG
	    p $game_variables[135]
	  end
	  if $game_variables[135] == 4
	    battle.pbDisplayPaused(_INTL("The madness-enhancements that were powering all of the Hell Fairy's puppets subsided!"))
	    scene.pbStartSpeech(3)
	    battle.pbDisplayPaused(_INTL("C-Clownpiece fell! Oh no!! Everyone retreat!"))
	    scene.pbForceEndSpeech
	    scene.pbRecall(3)
	    battle.decision = 1
	  end
	end
    }
  )  
  
  
MidbattleHandlers.add(:midbattle_global, :miasma_field,
  proc { |battle, idxBattler, idxTarget, trigger|
    if GameData::MapMetadata.get($game_map.map_id)&.has_flag?("SuzuranField")
	  player = battle.battlers[0]
      case trigger
      when "RoundStartCommand"
        battle.pbDisplayPaused(_INTL("The field is choked in a thick miasma!"))    
      when "RoundEnd_player"
        if rand(100) <= 25
		  case rand(7) # Determining Status Condition
		  when 0 then player.pbPoison if medi.pbCanInflictStatus?(:POISON, medi, true)
		  when 1 then player.pbBurn if medi.pbCanInflictStatus?(:BURN, medi, true)
		  when 2 then player.pbParalyze if medi.pbCanInflictStatus?(:PARALYSIS, medi, true)
		  when 3 then player.effects[PBEffects::Curse]
		  end
        end	    
      end
	end
  }
)

  #-----------------------------------------------------------------------------
  # The Last Adventure
  #-----------------------------------------------------------------------------  
  # Scene: Vs. Meimu
  #		* Apply boss-level resistances and effects to the final Meimu fight
  #		* At certain HP thresholds, have Meimu launch a signature attack
  #		* At low HP, have Meimu go invincible for five turns, the Player needs
  #		  to survive until the invincibility ends
  #-----------------------------------------------------------------------------  