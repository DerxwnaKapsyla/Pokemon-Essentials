class Battle::Scene
  def pbEndBattle(_result)
    @abortable = false
    pbShowWindow(BLANK)
    # Fade out all sprites
    pbBGMFade(1.0) if !$game_switches[98]
    pbFadeOutAndHide(@sprites)
    pbDisposeSprites
  end
end