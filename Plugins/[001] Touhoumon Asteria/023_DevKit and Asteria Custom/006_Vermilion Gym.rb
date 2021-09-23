class Game_Event < Game_Character
  def hasMagnetPullUser?
	return true if $Trainer.get_pokemon_with_ability(:MAGNETPULL)
  end 
end

class Trainer  
  def get_pokemon_with_ability(ability)
    pokemon_party.each { |pkmn| return pkmn if pkmn.hasAbility?(ability) }
    return nil
  end
end

def pbMagnetPull
  ability = :MAGNETPULL
  abilityfinder = $Trainer.get_pokemon_with_ability(ability)
  if !abilityfinder || !$DEBUG
    pbMessage(_INTL("You don't have anybody with Magnet Pull in your party."))
    return false
  end
  #pbMessage(_INTL("This tree looks like it can be cut down!\1"))
  if pbConfirmMessage(_INTL("Would you like to use Magnet Pull?"))
    speciesname = (abilityfinder) ? abilityfinder.name : $Trainer.name
    pbMessage(_INTL("{1} used {2}!",speciesname,GameData::Ability.get(ability).name))
    pbHiddenMoveAnimation(abilityfinder)
	$game_switches[115] = true
	$game_variables[124] = -4
	pbSEPlay("Electronic Malfunction")
	pbSetSelfSwitch(16,"A",true)
	pbSetSelfSwitch(17,"A",true)
	pbSetSelfSwitch(18,"A",true)
	pbSetSelfSwitch(19,"A",true)
	pbSetSelfSwitch(20,"A",true)
	#p $game_variables[124]
	$game_map.refresh
    return true
  end
  return false
end

class PokemonTemp
  attr_accessor :magnet_pull_used
end

def pbMagnetPullReset
  $game_switches[115] = false
  $game_variables[124] = 6
end

Events.onStepTaken += proc {
  if $game_map.map_id == 244 && ($game_switches[115] || $game_switches[116]) == true # Vermilion City Gym and Magnet Pull Steps switch
	#p $game_variables[124]
    if $game_variables[124] < 6
      $game_variables[124] += 1
    end
  end
}

Events.onMapChange += proc { |sender, e|
  pbMagnetPullReset
}
