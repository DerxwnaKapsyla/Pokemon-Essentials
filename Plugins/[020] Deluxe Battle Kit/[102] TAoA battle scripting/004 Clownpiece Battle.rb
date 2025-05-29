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
    showAnim      = true

    # Game variables for tracking fairy cycling and faint counts
    fairy_seen    = $game_variables[133] # Counts all individual fairy trainers (1-9)
    fairy_faints  = $game_variables[134] # Puppets defeated for current fairy (0-2)
    clown_faints  = $game_variables[135] # Amount of Clownpiece's Puppets defeated count

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
	    hellfairy.pbLowerStatStage(stat, 1, hellfairy, showAnim)
		showAnim = false
	  end
	#----------------------------------------------------------------------------- 
	# On Turn End: 5% chance to confuse Player's active Puppets
	#----------------------------------------------------------------------------- 
	when "RoundEnd_player"
      [p1, p2].each do |battler|
        if rand(100) <= 5 && battler.pbCanConfuse?(battler, false)
          battle.pbDisplayPaused(_INTL("{1} was drawn in by Clownpiece's torchlight, and started flailing wildly!", battler.pbThis))
          battler.pbConfuse
        end
      end
	#----------------------------------------------------------------------------- 
	# Reinforcements: After a Hell Fairy is defeated, another one takes its place.
	#                 This repeats infinitely. After this has repeated three times, 
	#                 with one repeat being three trainers, on the start of the
	#                 fourth cycle (in this case, the 10th trainer), Clownpiece 
	#                 will taunt the player, and make it so you can't gain any 
	#                 further experience in the battle.
	#----------------------------------------------------------------------------- 
    when "BattlerFainted_foe2"
      fairy_faints += 1
      $game_variables[134] = fairy_faints
	  
      if fairy_faints == 2
        fairy_seen += 1
		$game_variables[133] = fairy_seen
        $game_variables[134] = 0
		
        scene.pbStartSpeech(3)
        battle.pbDisplayPaused(_INTL("Oh no, I need to retreat!"))
        pbSEPlay("Battle flee")
        scene.pbForceEndSpeech
		
		new_fairy_name = %w[Lucia Astera Olivia][fairy_seen % 3]
		echoln "Swapping in new Hell Fairy: #{new_fairy_name}"
		
		show_fairy_intro(scene, battle, fairy_seen)
		battle.pbAddNewTrainer(:HELLFAIRY, new_fairy_name, pbGet(99))
		show_player_reaction(scene, battle, fairy_seen)
		
		stop_exp_gain(scene, battle) if fairy_seen == 10
        echoln "Amount of Hell Fairies battled: #{fairy_seen}"
      end
	
	#----------------------------------------------------------------------------- 
	# Clownpiece Defeat: When Clownpiece is defeated, have the partner fairy
	#                    retreat from battle.
	#----------------------------------------------------------------------------- 
	when "BattlerFainted_foe1"
	  clown_faints += 1
	  $game_variables[135] = clown_faints
	  echoln "Total puppets of Clownpiece's fainted: #{clown_faints}"

	  if clown_faints == 4
	    battle.pbDisplayPaused(_INTL("The madness-enhancements that were powering all of the Hell Fairy's puppets subsided!"))
	    scene.pbStartSpeech(3)
	    battle.pbDisplayPaused(_INTL("C-Clownpiece fell! Oh no!! Everyone retreat!"))
	    scene.pbForceEndSpeech
	    scene.pbRecall(3)
	    battle.decision = 1
	    $game_variables[133] = 0
	    $game_variables[134] = 0
	    $game_variables[135] = 0
	  end
	end
    }
  )  
  
def show_fairy_intro(scene, battle, fairy_seen)
  case fairy_seen
  when 1
    scene.pbStartSpeech(0)
    battle.pbDisplayPaused(_INTL("Alright, that means all that's left is Clownpiece!"))
    scene.pbShowSpeakerWindows("???", 1)
    battle.pbDisplayPaused(_INTL("Not so fast! I'll take over for her!"))
    scene.pbForceEndSpeech  
  when 2
    scene.pbStartSpeech(0)
    scene.pbShowSpeakerWindows("???", 1)
    battle.pbDisplayPaused(_INTL("Oh! Me next, me next~!"))
    scene.pbForceEndSpeech	
  when 3
    scene.pbStartSpeech(0)
    battle.pbDisplayPaused(_INTL("Surely that should be all of them, now I can focus on Clownpiece!"))
    scene.pbShowSpeakerWindows("???", 1)
    battle.pbDisplayPaused(_INTL("Silly human, I'm already ready for another go!"))
    scene.pbForceEndSpeech	
  end
end


def show_player_reaction(scene, battle, fairy_seen)
  case fairy_seen
  when 1
    scene.pbStartSpeech(0)
    battle.pbDisplayPaused(_INTL("Another one, huh? Alright! Bring 'em on!"))
    scene.pbForceEndSpeech
  when 2
    scene.pbStartSpeech(0)
    battle.pbDisplayPaused(_INTL("Okay, I can take one more, no problem!"))
    scene.pbForceEndSpeech
  when 3
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
  when 6
    scene.pbStartSpeech(1)
    battle.pbDisplayPaused(_INTL("What did I tell you! They won't stop coming. They won't stop coming, gyahahaha!"))
    scene.pbForceEndSpeech	
  end
end

def stop_exp_gain(scene, battle)
  scene.pbStartSpeech(1)
  battle.pbDisplayPaused(_INTL("...It's not any fun if you don't focus on me! Let's see how you like it when I do this!"))
  scene.pbForceEndSpeech
  
  battle.expGain = false
  battle.pbDisplayPaused(_INTL("Clownpiece waved her torch around in front of your Puppets!"))
  battle.pbDisplayPaused(_INTL("It looks like they won't gain any further experience this battle!"))
end