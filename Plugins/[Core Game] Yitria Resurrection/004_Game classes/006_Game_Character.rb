class Game_Character
  def turn_random_UD
	case rand(2)
	when 0 then turn_up
	when 1 then turn_down
	end
  end
  
  def turn_random_RL
    case rand(2)
    when 0 then turn_right
    when 1 then turn_left
    end
  end
  
  def turn_random_UR
    case rand(2)
    when 0 then turn_up
    when 1 then turn_right
    end
  end
  
  def turn_random_UL
    case rand(2)
    when 0 then turn_up
    when 1 then turn_left
    end
  end
  
  def turn_random_DR
    case rand(2)
    when 0 then turn_down
    when 1 then turn_right
    end
  end
  
  def turn_random_DL
    case rand(2)
    when 0 then turn_down
    when 1 then turn_left
    end
  end
  
  def turn_random_ULD
    case rand(3)
    when 0 then turn_up
    when 1 then turn_left
    when 2 then turn_down
    end
  end
  
  def turn_random_URD
    case rand(3)
    when 0 then turn_up
    when 1 then turn_right
    when 2 then turn_down
    end
  end
  
  def turn_random_LUR
    case rand(3)
    when 0 then turn_left
    when 1 then turn_up
    when 2 then turn_right
    end
  end
  
  def turn_random_LDR
    case rand(3)
    when 0 then turn_left
    when 1 then turn_down
    when 2 then turn_right
    end
  end
end