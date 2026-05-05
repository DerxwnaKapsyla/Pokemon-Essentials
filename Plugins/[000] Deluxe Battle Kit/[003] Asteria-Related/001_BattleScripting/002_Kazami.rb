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
      @has_kazami_evolved ||= $game_switches[107]
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
        if !@has_kazami_evolved
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
          foe.damageThreshold = 10
        else
          scene.pbStartSpeech(0)
          battle.pbDisplayPaused(_INTL("That last fight caught us off guard, but we won't falter again!"))
          battle.pbDisplayPaused(_INTL("Let's do this, {1}!", player.pbThis))
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
	  # * Check for if Switch 107 is on.
	  # * If on...
	  #   - Do not execute sequence.
	  # * If off...
	  #   - Player remarks that it's time to finish it off
	  #   - CKazami lets out a cry and rises back up, returning HP to full.
	  #   - Player questions what's going on.
	  #   - Trigger evolution sequence to evolve CKazami into Kazami
	  #   - Change battle background
	  #   - Change battle music
	  #   - Change Kazami's moves
	  #   - Change Kazami's held item to Malachite
	  #   - Boost +1 to Atk/SAtk/Spd
	  #   - Turn on Switch 107.
	  #---------------------------------------------
      when "RoundEnd_foe"
	    PBDebug.log("[Midbattle Script] '#{trigger}' triggered by #{logname}...")
        if battle.pbTriggerActivated?("BattlerReachedHPCap") && !@has_kazami_evolved
		  @has_kazami_evolved = true
		  $game_switches[107] = true
          pbBGMFade(1)
          scene.pbStartSpeech(0)
          battle.pbDisplayPaused(_INTL("Alright, we're getting close!"))
          battle.pbDisplayPaused(_INTL("Let's finish this next turn, {1}!", player.pbThis))
          scene.pbForceEndSpeech
          pbWait(0.25)
          foe.displayPokemon.play_cry
          foe.pbRecoverHP(99999)
          battle.pbDisplayPaused(_INTL("The wild CKazami stood back up!", player.pbThis))
          scene.pbStartSpeech(0)
          battle.pbDisplayPaused(_INTL("Wait... What's it doing?"))
          scene.pbForceEndSpeech
          foe.pbEvolveBattler(:KAZAMI)
          pbBGMFade(0.001)
          pbBGMPlay("B-009. Faint Dream ~ Inanimate Dream")
          battle.backdrop = "Forest_Alt1"
          scene.pbRefreshEverything
          scene.pbStartSpeech(0)
          battle.pbDisplayPaused(_INTL("No way... Did- Did it just evolove in the middle of battle!?"))
          battle.pbDisplayPaused(_INTL("Is this why the workers had such a hard time with it...? This doesn't bode well."))
          battle.pbDisplayPaused(_INTL("Stay sharp, {1}!",player.pbThis))
          scene.pbForceEndSpeech
          foe.pbResetStatStages
          foe.displayPokemon.play_cry
          showAnim = true
            [:ATTACK, :SPECIAL_ATTACK, :SPEED].each do |stat|
              next if !foe.pbCanRaiseStatStage?(stat, foe)
              foe.pbRaiseStatStage(stat, 1, foe, showAnim)
              showAnim = false
            end
          moves_to_set = [:HYPERBEAM18, :LEAFBLADE18, :INGRAIN18, :TAUNT18]

          Pokemon::MAX_MOVES.times do |i|
            move = Pokemon::Move.new(moves_to_set[i])
            foe.moves[i] = Battle::Move.from_pokemon_move(battle, move)
          end

          foe.moves.compact!
          foe.moves.uniq!
          foe.pbCheckFormOnMovesetChange
          foe.ability = :OVERGROW
          foe.item = :MALACHITE
          battle.pbDisplayPaused(_INTL("The wild Kazami is now prepared to fight!"))
          PBDebug.log("[Midbattle Script] '#{trigger}' effects ended")
		end
      end
    }
  )
