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
		echoln "Condition: Start of Battle. Triggering effects"
		echoln "* Display Heat Wave Animation."
		echoln "* Display message that Pokeballs are disabled."
		echoln "* Mention that Marisa Omega is building up energy."
		echoln "* Display Stockpile animation."
		echoln "* Set the Supernova Turn Counter to 0."
		battle.pbAnimation(:HEATWAVE, player, player)
		battle.pbDisplayPaused(_INTL("The oppressive heat is making throwing a Poké Ball difficult!\nThey cannot be used right now!"))
		battle.pbDisplayPaused(_INTL("{1} begins building up energy.",foe.pbThis))
		battle.pbAnimation(:STOCKPILE, foe, foe)
		@supernova_charge_turn = 0
	  #---------------------------------------------
	  # Condition: End of Turn - Multiple Effects
	  #   * Damage Player Randomly
	  #     - Display Heat Wave Animation
	  #     - Damage Player active battler
	  #     - Apply Burn
	  #   * Increment the Supernova Charge Variable
	  #   * Check Supernova Charge Status
	  #     - Check the Supernova Charge Variable
	  #     - If the variable is not at 4...
	  #       * Display charging message
	  #       * Display Stockpile Animation
	  #     - If the variable is at 4...
	  #       * Change Marisa Omega's moves to only be Supernova
	  #       * Display message that Marisa Omega is done charging
	  #     - If the variable is at 5 - COUNTERMEASURE
	  #       * Reset Marisa Omega's moves.
	  #       * Reset charge variable to to 0.
	  #---------------------------------------------
	  when "RoundEnd_foe"
	    echoln "Condition: Start of Turn."
		echoln "First effect - Random Heat Wave damage check."
		if rand(100) < 33
		  echoln "> Random Heat Wave Damage success. Executing effect."
		  battle.pbDisplayPaused(_INTL("A massive heat wave erupts out of {1}!",foe.pbThis))
		  foe.displayPokemon.play_cry
		  battle.pbAnimation(:HEATWAVE, player, player)
		  player.pbBurn if player.pbCanInflictStatus?(:BURN, player, true)
		  echoln "> Damaging the player for 1/8th their max hp."
		  #player.hp -= (player.totalhp / 8).round # CURRENTLY NOT WORKING
		  player.pbReduceHP(player.totalhp / 8).round
		end
		@supernova_charge_turn += 1
		echoln "Second effect - Supernova Charge Counter increment."
	    case @supernova_charge_turn
		when 0, 1, 2, 3
		  echoln "> Value of Supernova Charge Counter is below 4. Executing animation and message."
		  battle.pbDisplayPaused(_INTL("{1} continues building energy.",foe.pbThis))
		  battle.pbAnimation(:STOCKPILE, foe, foe)
		when 4
		  echoln "> Value of Supernova Charge Counter is at 4. Changing Marisa Omega's move to be Supernova."
		  moves_to_set = [:SUPERNOVA18, :SUPERNOVA18, :SUPERNOVA18, :SUPERNOVA18]

          Pokemon::MAX_MOVES.times do |i|
            move = Pokemon::Move.new(moves_to_set[i])
            foe.moves[i] = Battle::Move.from_pokemon_move(battle, move)
          end

          foe.moves.compact!
          foe.moves.uniq!
          foe.pbCheckFormOnMovesetChange
		  battle.pbDisplayPaused(_INTL("{1} is done building up energy!",foe.pbThis))
		when 5
		  echoln "> Value of Supernova Charge Counter is at 5. Resetting Marisa Omega's moves and the charge variable to 0."
		  moves_to_set = [:ERUPTION18, :SOLARBEAM18, :ICEBEAM18, :HYPERBEAM18]
          Pokemon::MAX_MOVES.times do |i|
            move = Pokemon::Move.new(moves_to_set[i])
            foe.moves[i] = Battle::Move.from_pokemon_move(battle, move)
          end
          foe.moves.compact!
          foe.moves.uniq!
          foe.pbCheckFormOnMovesetChange
		  battle.pbDisplayPaused(_INTL("{1}'s energy fizzled out. She begins bulding it back up!",foe.pbThis))
		  @supernova_charge_turn = 0
		end		
	  #---------------------------------------------
	  # Condition: Using Supernova
	  #   * Only execute when Supernova is selected.
	  #   * Display message that Supernova is being unleashed.
	  #---------------------------------------------
	  when "BeforeMove_SUPERNOVA18"
	    next if @supernova_charge_turn != 4
		battle.pbDisplayPaused(_INTL("{1} unleashes her stored energy!",foe.pbThis))
	  #---------------------------------------------
	  # Condition: After Using Supernova
	  #   * Only execute after Supernova was used.
	  #   * Display message that energy is building up.
	  #   * Reset charge variable to 0.
	  #---------------------------------------------
      when "AfterMove_SUPERNOVA18" # REMEMBER TO RESET VARIABLE.
		next if @supernova_charge_turn != 4
		battle.pbDisplayPaused(_INTL("{1} begins building up energy again.",foe.pbThis))
		@supernova_charge_turn = 0
	  #---------------------------------------------
	  # Condition: Player makes contact with Marisa in any way.
	  #   * Checks if the player made physical contact with Marisa
	  #   * If so, inflict Burn on player-side.
	  #---------------------------------------------
	  when "AfterDamagingMove_player", "AfterDamagingMove_foe"
	    # if move.contactMove?
		  # player.pbBurn if player.pbCanInflictStatus?(:BURN, player, true)
		# end
	  end
    }
  )
		
