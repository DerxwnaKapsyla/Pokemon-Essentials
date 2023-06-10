class Battle
  def pbThisEx(idxBattler, idxParty)
    party = pbParty(idxBattler)
    if opposes?(idxBattler)
	  if $game_switches[Settings::SPECIAL_BATTLE_SWITCH]
		case $game_variables[Settings::SPECIAL_BATTLE_VARIABLE]
		  when 1	then sbName = "The territorial"
		  when 2	then sbName = "The aggressive"
		  when 3	then sbName = "Kortalan Gym's"
		  when 4	then sbName = "A trainer's"
		  else			 sbName = "The wild"
		end
		return _INTL("{2} {1}",party[idxParty].name,sbName)
	  else
		return _INTL("The opposing {1}",party[idxParty].name) if trainerBattle?
		return _INTL("The wild {1}",party[idxParty].name)
	  end
    end
    return _INTL("The ally {1}",party[idxParty].name) if !pbOwnedByPlayer?(idxBattler)
    return party[idxParty].name
  end
end