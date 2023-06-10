# Derx: This is unneeded with v18, but I'm bringing it in for the time being.

# [4:14 PM] Maruno: You could combine the two by using move_forward and
# turn_180 instead of specific directions.
class Game_Character
  def wanderLeftRight
    case rand(6)
    when 0; move_left(false)
    when 1; move_right(false)
    when 2; turn_left
    when 3; turn_right
    end
  end

  def wanderUpDown
    case rand(6)
    when 0; move_up(false)
    when 1; move_down(false)
    when 2; turn_up
    when 3; turn_down
    end
  end
end

