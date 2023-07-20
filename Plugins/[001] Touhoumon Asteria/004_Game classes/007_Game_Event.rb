# Derx: Necessary for the Rival Gold stuff
class Game_Event < Game_Character

  def badgeQtyOdd?
	return $Trainer.badge_count > 0 && $Trainer.badge_count % 2 != 0
  end
  
end