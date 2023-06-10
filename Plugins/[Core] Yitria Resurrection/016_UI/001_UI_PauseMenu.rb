MenuHandlers.add(:pause_menu, :quests, {
  "name"      =>  _INTL("Quests"),
  "order"     => 50,
  "condition" => proc { next hasAnyQuests? },
  "effect"    => proc { |menu|
    pbPlayDecisionSE
    pbFadeOutIn {
      scene = QuestList_Scene.new
      screen = QuestList_Screen.new(scene)
      screen.pbStartScreen
      menu.pbRefresh
    }
    next false
  }
})