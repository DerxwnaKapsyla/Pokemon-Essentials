MenuHandlers.add(:pause_menu, :reincarnation, {
  "name"      => _INTL("Reincarnation"),
  "order"     => 40,
  "condition" => proc { next $game_switches[107] },
  "effect"    => proc { |menu|
    pbPlayDecisionSE
    pbFadeOutIn do
      Reincarnation.show_reincarnation_scene
      menu.pbRefresh
    end
    next false
  }
})

MenuHandlers.add(:pause_menu, :jukebox, {
  "name"      => _INTL("Music Room"),
  "order"     => 41,
  "effect"    => proc { |menu|
    pbFadeOutIn {
      EnhancedJukebox.new
    }
    next false
  }
})

MenuHandlers.add(:pause_menu, :pc, {
  "name"      => _INTL("Portable Storage"),
  "order"     => 42,
  "effect"    => proc { |menu|
    pbPokeCenterPC
    next false
  }
})