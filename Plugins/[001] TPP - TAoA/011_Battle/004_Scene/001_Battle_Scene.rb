class Battle::Scene
  def pbEndBattle(_result)
    @abortable = false
    pbShowWindow(BLANK)
    # Fade out all sprites
    pbFadeOutAndHide(@sprites)
    if $game_switches[98]
	  dkBattleOverride
	end
	pbBGMFade(1.0) if !$game_switches[98]
    pbDisposeSprites
  end
  
  def dkBattleOverride
    if $game_switches[157]
	  $game_switches[104] = true
	  $game_variables[103] = 99
	  if $game_variables[143] == 3 || $game_variables[143] == 5
	    $player.heal_party
		@battle.pbDisplayPaused(_INTL("Your party has been healed."))
	  end
	  TrainerBattle.start(:MEIMU,"Meimu",pbGet(143))
	end
  end
end