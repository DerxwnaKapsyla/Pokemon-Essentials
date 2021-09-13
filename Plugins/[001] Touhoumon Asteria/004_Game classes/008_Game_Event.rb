# Derx: Necessary for the Rival Gold stuff
class Game_Event < Game_Character

  def badgeQtyOdd?
	return $Trainer.numbadges > 0 && $Trainer.numbadges % 2 != 0
  end
  
end