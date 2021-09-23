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

class Scene_Map
  def update
    loop do
      updateMaps
      pbMapInterpreter.update
      $game_player.update
      $game_system.update
      $game_screen.update
      break unless $game_temp.player_transferring
      transfer_player
      break if $game_temp.transition_processing
    end
    updateSpritesets
    if $game_temp.to_title
      $game_temp.to_title = false
      SaveData.mark_values_as_unloaded
      $scene = pbCallTitle
      return
    end
    if $game_temp.transition_processing
      $game_temp.transition_processing = false
      if $game_temp.transition_name == ""
        Graphics.transition(20)
      else
        Graphics.transition(40, "Graphics/Transitions/" + $game_temp.transition_name)
      end
    end
    return if $game_temp.message_window_showing
    if !pbMapInterpreterRunning?
      if Input.trigger?(Input::USE)
        $PokemonTemp.hiddenMoveEventCalling = true
      elsif Input.trigger?(Input::BACK)
        unless $game_system.menu_disabled || $game_player.moving?
          $game_temp.menu_calling = true
          $game_temp.menu_beep = true
        end
      elsif Input.trigger?(Input::SPECIAL)
        unless $game_player.moving?
          $PokemonTemp.keyItemCalling = true
        end
      elsif Input.press?(Input::F9)
        $game_temp.debug_calling = true if $DEBUG
	#####################
	  elsif Input.press?(Input::ALT)
		$PokemonTemp.specialActivation = true
	#####################
      end
    end
    unless $game_player.moving?
      if $game_temp.menu_calling
        call_menu
      elsif $game_temp.debug_calling
        call_debug
      elsif $PokemonTemp.keyItemCalling
        $PokemonTemp.keyItemCalling = false
        $game_player.straighten
        pbUseKeyItem
      elsif $PokemonTemp.hiddenMoveEventCalling
        $PokemonTemp.hiddenMoveEventCalling = false
        $game_player.straighten
        Events.onAction.trigger(self)
	#####################
	  elsif $PokemonTemp.specialActivation
		$PokemonTemp.specialActivation = false
		$game_player.straighten
		if $game_map.map_id == 244
			pbMagnetPull
		end
      end
	#####################
    end
  end
end

class PokemonTemp
  attr_accessor :specialActivation
  
  alias specialactivation_initialize initialize
  def initialize
	specialactivation_initialize
	@specialActivation		= false ############
  end
end


def pbMagnetPull
  ability = :MAGNETPULL
  abilityfinder = $Trainer.get_pokemon_with_ability(ability)
  if !abilityfinder || !$DEBUG
    pbMessage(_INTL("You don't have anybody with Magnet Pull in your party."))
    return false
  end
  if $game_variables[124] < 1
	pbMessage(_INTL("Magnet Pull is currently in effect."))
  elsif $game_variables[124] <= 5
	pbMessage(_INTL("Magnet Pull is currently recharging."))
  else
	if pbConfirmMessage(_INTL("Would you like to use Magnet Pull?"))
      speciesname = (abilityfinder) ? abilityfinder.name : $Trainer.name
      pbMessage(_INTL("{1} used {2}!",speciesname,GameData::Ability.get(ability).name))
      pbHiddenMoveAnimation(abilityfinder)
	  $game_switches[115] = true
	  $game_variables[124] = -4
	  pbSEPlay("Electronic Malfunction")
	  #p $game_variables[124]
	  $game_map.refresh
      return true
    end
  end
  return false
end

def pbMagnetPullReset
  $game_switches[115] = false
  $game_variables[124] = 6
end

Events.onStepTaken += proc {
  if $game_map.map_id == 244 && ($game_switches[115] || $game_switches[116]) == true # Vermilion City Gym and Magnet Pull Steps switch
    if $game_variables[124] < 6
      $game_variables[124] += 1
    end
  end
}

Events.onMapChange += proc { |sender, e|
  pbMagnetPullReset
}


Events.onStepTaken += proc {
  if $game_map.map_id == 244 && $game_player.pbTerrainTag.landmine
	Pokemon.play_cry(:VOLTORB)
	pbExclaim($game_player)
	pbMessage(_INTL("Oh no! You stepped on a landmine!"))
	pbSEPlay("Voltorb Flip explosion")
	pbFadeOutIn(99999) {
	  $game_temp.player_new_map_id    = 244
      $game_temp.player_new_x         = 24
      $game_temp.player_new_y         = 39
      $game_temp.player_new_direction = 2
      $scene.transfer_player
	}
	pbFieldDamage
  end
}

Events.onStepTaken += proc {
  if $game_map.map_id == 244 && $game_switches[115] == true
	if $game_variables[124] == 1
	  pbMessage(_INTL("The effects of the Magnet Pull wear off, and the landmines sink back into the ground."))
	  pbSEPlay("Electronic Malfunction")
	  $game_switches[115] = false
	  $game_switches[116] = true
	  $game_map.refresh
	end
  end
}