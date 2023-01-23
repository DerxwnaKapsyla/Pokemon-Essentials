class Battle
  def pbMessageOnRecall(battler)
    if battler.pbOwnedByPlayer?
      if battler.hp <= battler.totalhp / 4
        pbDisplayBrief(_INTL("Good job, {1}! Come back!", battler.name))
      elsif battler.hp <= battler.totalhp / 2
        pbDisplayBrief(_INTL("OK, {1}! Come back!", battler.name))
      elsif battler.turnCount >= 5
        pbDisplayBrief(_INTL("{1}, that's enough! Come back!", battler.name))
      elsif battler.turnCount >= 2
        pbDisplayBrief(_INTL("{1}, come back!", battler.name))
      else
        pbDisplayBrief(_INTL("{1}, switch out! Come back!", battler.name))
      end
    else
      owner = pbGetOwnerName(battler.index)
	  if $game_map.map_id == 64 && $game_switches[102] == true # Derx: For the Medicine's Legion fights.
		pbDisplayBrief(_INTL("Medicine: {1}, retreat from the field!", battler.name))
	  else
		pbDisplayBrief(_INTL("{1} withdrew {2}!", owner, battler.name))
	  end
    end
  end
  
  def pbMessagesOnReplace(idxBattler, idxParty)
    party = pbParty(idxBattler)
    newPkmnName = party[idxParty].name
    if party[idxParty].ability == :ILLUSION && !pbCheckGlobalAbility(:NEUTRALIZINGGAS)
      new_index = pbLastInTeam(idxBattler)
      newPkmnName = party[new_index].name if new_index >= 0 && new_index != idxParty
    end
    if pbOwnedByPlayer?(idxBattler)
      opposing = @battlers[idxBattler].pbDirectOpposing
      if opposing.fainted? || opposing.hp == opposing.totalhp
        pbDisplayBrief(_INTL("You're in charge, {1}!", newPkmnName))
      elsif opposing.hp >= opposing.totalhp / 2
        pbDisplayBrief(_INTL("Go for it, {1}!", newPkmnName))
      elsif opposing.hp >= opposing.totalhp / 4
        pbDisplayBrief(_INTL("Just a little more! Hang in there, {1}!", newPkmnName))
      else
        pbDisplayBrief(_INTL("Your opponent's weak! Get 'em, {1}!", newPkmnName))
      end
    else
      owner = pbGetOwnerFromBattlerIndex(idxBattler)
	  if $game_map.map_id == 64 && $game_switches[102] == true # Derx: For the Medicine's Legion fights.
		pbDisplayBrief(_INTL("Medicine: {1}, lead the charge!", newPkmnName))
	  else
		pbDisplayBrief(_INTL("{1} sent out {2}!", owner.full_name, newPkmnName))
	  end
	end
  end
end