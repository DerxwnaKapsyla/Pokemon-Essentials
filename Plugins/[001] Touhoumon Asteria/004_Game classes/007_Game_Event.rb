# Derx: Necessary for the Rival Gold stuff
class Game_Event < Game_Character

  def badgeQtyOdd?
	return $player.badge_count > 0 && $player.badge_count % 2 != 0
  end
  
end