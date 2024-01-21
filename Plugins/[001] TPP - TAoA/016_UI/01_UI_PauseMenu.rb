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