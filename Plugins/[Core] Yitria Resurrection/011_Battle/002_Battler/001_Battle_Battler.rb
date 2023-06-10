class Battle::Battler
  def pbThis(lowerCase = false)
    if opposes?
      if @battle.trainerBattle?
        return lowerCase ? _INTL("the opposing {1}", name) : _INTL("The opposing {1}", name)
      else
		if $game_switches[Settings::SPECIAL_BATTLE_SWITCH] # Special Battle Switch
		  case $game_variables[Settings::SPECIAL_BATTLE_VARIABLE]
			when 1	then sbName = "the territorial"	 ; sbName2 = "The territorial" 
			when 2	then sbName = "the aggressive" 	 ; sbName2 = "The aggressive"
			when 3	then sbName = "Kortalan Gym's"	 ; sbName2 = "Kortalan Gym's"
			when 4	then sbName = "a trainer's"		 ; sbName2 = "A trainer's"
		    else		 sbName = "the wild"		 ; sbName2 = "The wild"
		  end
		  return lowerCase ? _INTL("{2} {1}", name, sbName) : _INTL("{2} {1}", name, sbName2)
		else
		  return lowerCase ? _INTL("the wild {1}", name) : _INTL("The wild {1}", name)
		end
      end
    elsif !pbOwnedByPlayer?
      return lowerCase ? _INTL("the ally {1}", name) : _INTL("The ally {1}", name)
    end
    return name
  end
end