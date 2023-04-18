class Battle::Move::WeatherMove < Battle::Move
  
  alias asteria_pbMoveFailed? pbMoveFailed?
  def pbMoveFailed?(user, targets)
	asteria_pbMoveFailed?(user, targets)
	case @battle.field.weather
    when :SevereHail
      @battle.pbDisplay(_INTL("The severe hail continued to fall without stop!"))
      return true
    when :CruelSandstorm
      @battle.pbDisplay(_INTL("The cruel sandstorm refuses to let up!"))
      return true	
	end
  end
end