class Game_Event < Game_Character
  def hasMagnetPullUser?
	return true if $player.get_pokemon_with_ability(:MAGNETPULL)
  end 
end

class Trainer  
  def get_pokemon_with_ability(ability)
    pokemon_party.each { |pkmn| return pkmn if pkmn.hasAbility?(ability) }
    return nil
  end
end

class Game_Temp
  attr_accessor :specialActivation
  
  alias specialactivation_initialize initialize
  def initialize
	specialactivation_initialize
	@specialActivation		= false ############
  end
end

class Scene_Map
  def update
    loop do
      pbMapInterpreter.update
      $game_player.update
      updateMaps
      $game_system.update
      $game_screen.update
      break unless $game_temp.player_transferring
      transfer_player(false)
      break if $game_temp.transition_processing
    end
    updateSpritesets
    if $game_temp.title_screen_calling
      $game_temp.title_screen_calling = false
      SaveData.mark_values_as_unloaded
      $scene = pbCallTitle
      return
    end
    if $game_temp.transition_processing
      $game_temp.transition_processing = false
      if $game_temp.transition_name == ""
        Graphics.transition
      else
        Graphics.transition(40, "Graphics/Transitions/" + $game_temp.transition_name)
      end
    end
    return if $game_temp.message_window_showing
    if !pbMapInterpreterRunning?
      if Input.trigger?(Input::USE)
        $game_temp.interact_calling = true
      elsif Input.trigger?(Input::ACTION)
        unless $game_system.menu_disabled || $game_player.moving?
          $game_temp.menu_calling = true
          $game_temp.menu_beep = true
        end
      elsif Input.trigger?(Input::SPECIAL)
        unless $game_player.moving?
          $game_temp.ready_menu_calling = true
        end
      elsif Input.press?(Input::F9)
        $game_temp.debug_calling = true if $DEBUG
	#####################
	  elsif Input.press?(Input::ALT)
		$game_temp.specialActivation = true
	#####################
      end
    end
    unless $game_player.moving?
      if $game_temp.menu_calling
        call_menu
      elsif $game_temp.debug_calling
        call_debug
      elsif $game_temp.ready_menu_calling
        $game_temp.ready_menu_calling = false
        $game_player.straighten
        pbUseKeyItem
      elsif $game_temp.interact_calling
        $game_temp.interact_calling = false
        $game_player.straighten
        EventHandlers.trigger(:on_player_interact)
	#####################
	  elsif $game_temp.specialActivation
		$game_temp.specialActivation = false
		$game_player.straighten
		if $game_map.map_id == 244
			pbMagnetPull
		end
      end
	#####################
    end
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

EventHandlers.add(:on_player_step_taken_can_transfer, :magnet_pull_steps,
  proc {
    if $game_map.map_id == 244 && ($game_switches[115] || $game_switches[116]) == true 
      if $game_variables[124] < 6
        $game_variables[124] += 1
      end
    end
  }
)

EventHandlers.add(:on_leave_map, :magnet_pull_reset,
  proc {
    pbMagnetPullReset
  }
)

EventHandlers.add(:on_player_step_taken, :step_on_landmine,
  proc {
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
)

EventHandlers.add(:on_player_step_taken, :magnet_pull_expires,
  proc {
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
)