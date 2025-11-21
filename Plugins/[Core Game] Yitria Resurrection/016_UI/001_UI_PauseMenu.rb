MenuHandlers.add(:pause_menu, :trainer_card, {
  "name"      => proc { next $player.name },
  "order"     => 50,
  "condition" => proc { next $game_variables[107] >= 4 },
  "effect"    => proc { |menu|
    pbPlayDecisionSE
    pbFadeOutIn {
      scene = PokemonTrainerCard_Scene.new
      screen = PokemonTrainerCardScreen.new(scene)
      screen.pbStartScreen
      menu.pbRefresh
    }
    next false
  }
})

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