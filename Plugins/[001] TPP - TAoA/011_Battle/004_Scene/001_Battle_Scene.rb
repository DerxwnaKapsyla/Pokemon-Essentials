class Battle::Scene
  def pbEndBattle(_result)
    @abortable = false
    pbShowWindow(BLANK)
    #Fade out all sprites
    if $game_switches[95]
	  pbFadeOutAndHide_alt(@sprites)
	else
	  pbFadeOutAndHide(@sprites)
	end
	pbBGMFade(1.0) if !$game_switches[98]
    pbDisposeSprites
  end
end