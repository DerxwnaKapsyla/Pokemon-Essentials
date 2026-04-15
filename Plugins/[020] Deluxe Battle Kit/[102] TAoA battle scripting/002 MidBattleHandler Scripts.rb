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
	    scene.pbStartSpeech(1)
		battle.pbDisplayPaused(_INTL("Experimental augment, activate!"))
		scene.pbForceEndSpeech
		atk_stats = [:ATTACK, :SPECIAL_ATTACK]
	    def_stats = [:DEFENSE, :SPECIAL_DEFENSE]
	    showAnim = true
	    if rand(2) == 1 # Attack Boost
  	      atk_stats.each do |stat|
		    next if !foe.pbCanRaiseStatStage?(stat, foe)
		    showAnim = false
		    foe.pbRaiseStatStage(stat, 1, foe, showAnim)
	      end
	    else # Defense Boost
	      def_stats.each do |stat|
		    next if !foe.pbCanRaiseStatStage?(stat, foe)
		    showAnim = false
		    foe.pbRaiseStatStage(stat, 1, foe, showAnim)
	      end
	    end
	  end
     }
  ) 
  
  
MidbattleHandlers.add(:midbattle_global, :miasma_field,
  proc { |battle, idxBattler, idxTarget, trigger|
    #if GameData::MapMetadata.get($game_map.map_id)&.has_flag?("SuzuranField")
	  player = battle.battlers[0]
	  ratio_value = 25
      case trigger
      when "RoundStartCommand_1_player"
        battle.pbDisplayPaused(_INTL("The field is choked in a thick miasma!"))    
      when "RoundEnd_player"
	    if $game_switches[135] # Are we battling Medicine? If not, skip and execute as normal
		  ratio_value = 100 # Set to 5% as opposed to 25%
		end
		echoln "Executing Miasma Field Check"
        if rand(100) <= ratio_value
		echoln "> Miasma Field Check: Success"
		  battle.pbDisplayPaused(_INTL("The miasma crept closer to your party..."))    
		  echoln "Executing Miasma Field Effect Check"
		  if rand(100) <= 25 # 25% chance that you'll get a positive effect. 75% for negative effect.
		    battle.pbDisplayPaused(_INTL("...But your party stood firm and resisted the miasma!"))    
			echoln "> Miasma Field Effect Check: Resist"
			echoln "Executing Miasma Field Effect Type"
			case rand(2)
			when 0 
			  echoln "> Miasma Field Effect Type: Affliction Removal"
			  player.pbCureStatus
			  player.pbCureConfusion
			  player.pbCureAttract
			  player.effects[PBEffects::Taunt] = 0
			  player.effects[PBEffects::Torment] = false
			  player.effects[PBEffects::Disable] = 0
			  battle.pbDisplayPaused(_INTL("{1} was cured of all negative afflictions!", player.pbThis))    
			when 1 # Boost the active party member's stats by 1 stage. Attack/Special Attack, Defense/Special Defense, Speed/Evasion
			  echoln "> Miasma Field Effect Type: Stat Increase"
			  showAnim = true
			  case rand(3) 
			  when 1 # Boost Attack and Special Attack
			    echoln "> Boosting Attacks"
			  	[:ATTACK, :SPECIAL_ATTACK].each do |stat|
                  next if !player.pbCanRaiseStatStage?(stat, player)
	              player.pbRaiseStatStage(stat, 1, player, showAnim)
                  showAnim = false
	             end
			  when 2 # Boost Defense and Special Defense
			  	echoln "> Boosting Defenses"
				[:DEFENSE, :SPECIAL_DEFENSE].each do |stat|
                  next if !player.pbCanRaiseStatStage?(stat, player)
	              player.pbRaiseStatStage(stat, 1, player, showAnim)
                  showAnim = false
	             end
			  when 3 # Boost Speed and Evasion
			  	echoln "> Boosting Speed/Evasion"
				[:SPEED, :EVASION].each do |stat|
                  next if !player.pbCanRaiseStatStage?(stat, player)
	              player.pbRaiseStatStage(stat, 1, player, showAnim)
                  showAnim = false
	             end
			  end
			end
		  else
		    echoln "> Miasma Field Effect Check: Afflict"
			case rand(3) # Determining Status Condition
		    when 0
			  player.pbPoison if player.pbCanInflictStatus?(:POISON, player, true) 
			  echoln "> Applying Poison if possible"
		    when 1
			  player.pbBurn if player.pbCanInflictStatus?(:BURN, player, true) 
			  echoln "> Applying Burn if possible"
		    when 2 
			  player.pbParalyze if player.pbCanInflictStatus?(:PARALYSIS, player, true)
			  echoln "> Applying Paralysis if possible"
		    # when 3 
		      # battle.pbAnimation(:GRUDGE, player, player)
		      # battle.pbDisplayPaused(_INTL("{1} was inflicted with a curse!", player.pbThis))
		      # player.effects[PBEffects::Curse] = true
		    end
          end	    
		else
		  echoln "> Miasma Field Check: Failed"
		end
      end
	#end
  }
)

# MidbattleHandlers.add(:midbattle_scripts, :miasma_field,
  # proc { |battle, idxBattler, idxTarget, trigger|
    # if GameData::MapMetadata.get($game_map.map_id)&.has_flag?("SuzuranField")
	  # player = battle.battlers[0]
      # case trigger
      # when "RoundStartCommand_1_player"
        # battle.pbDisplayPaused(_INTL("The field is choked in a thick miasma!"))    
      # when "RoundEnd_player"
        # if rand(100) <= 25
		  # battle.pbDisplayPaused(_INTL("The miasma crept closer to your party..."))    
		  # case rand(4) # Determining Status Condition
		  # when 0 then player.pbPoison if player.pbCanInflictStatus?(:POISON, player, true)
		  # when 1 then player.pbBurn if player.pbCanInflictStatus?(:BURN, player, true)
		  # when 2 then player.pbParalyze if player.pbCanInflictStatus?(:PARALYSIS, player, true)
		  # when 3 then player.effects[PBEffects::Curse]
		  # end
        # end	    
      # end
	# end
  # }
# )
  
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
  # Being handled elsewhere!
  
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
      [p1, p2].each do |battler|
        if rand(100) <= 5 && battler.pbCanConfuse?(battler, false)
	      battle.pbDisplayPaused(_INTL("{1} started flailing about wildly!",p1.pbThis))
          battler.pbConfuse
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
  # Being handled elsewhere!

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
  # Being handled elsewhere!