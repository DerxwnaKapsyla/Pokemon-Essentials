#-------------------------------------------------------------------------------
# I want to keep all of Prismriver Manor's specific scripts in one file so it is
# easier to find them. A detailed list of effects will be provided below.
#-------------------------------------------------------------------------------
# In the Challenge Mode for Prismriver Manor, there will be several effects
# that can occur within the mansion on different floors. There will be two
# types of effects. 
#
# The first one is Floor Effects, which will occur for every battle on that 
# floor. Things like blidness (lowers accuracy in every battle by 1), Phantom
# Weather (Rain, Sun, Hail, Sand), stuff like that.
#
# The second type is Random Effects, which occur during battle, but are only
# relevant for that battle specifically (except for in the case of Status
# conditions). These can range from the adjustment of stats, completely
# changing the ability of a battler, the application of effects such as
# Ingrain and Aurora Veil, the aforementioned status conditions, and more.
#
# Every floor will determine its Floor Effect upon the first time visiting
# it, and it will always be different every run. 
#-------------------------------------------------------------------------------
# Per Floor Effects:
#-------------------------------------------------------------------------------
# Phantom Weather:
# * Will apply the effects of weather to all battles on that floor.
# * Weathers that can be applied: Rain. Sun. Sand. Hail.
#
# Blindness:
# * Makes it so all Puppets have -1 Accuracy.
#
# Phantom Terrain:
# * Will apply Field Effects to all battles on that floor.
# * Terrains and Fields that can be applied: Trick Room. Inverse Battle. Grassy Terrain. Electric Terrain.
#   Misty Terrain. Psychic Terrain. 
# 
# Phantom Lockdown:
# * Makes it so the Player's active battler cannot switch out or flee.
#-------------------------------------------------------------------------------
# Per Battle Effects:
#-------------------------------------------------------------------------------
# Spectral Status:
# * Will apply a random status condition to one or both sides.
# * Statuses that can be applied: Poison. Paralysis. Burn. Sleep. Freeze.
#
# Spectral Stats:
# * Will raise or lower a random stat to one or both sides.
# * Stats that can be adjusted: Attack. Defense. Speed. Special Attack. Special Defense. Accuracy.
# * Stats will be adjusted by the following values: +1. +2. -1. -2.
#
# Spectral Abilities:
# * Will "add" a second ability to one or both sides. (Might not be actual ability.)
# * Spectral Abilities will be based off of existing abilities but renamed from vanilla counterparts.
# * Abilitires that can be added: Spectre's Guard (Wonder Guard). Spectral Image (Sturdy). 
#   Spectral Touch (Rough Skin). Spectre's Strike (Parental Bond). Spectre's Enchant (Cute Charm).
#-------------------------------------------------------------------------------

MidbattleHandlers.add(:midbattle_global, :battle_effects,
  proc { |battle, idxBattler, idxTarget, trigger|
    if GameData::MapMetadata.get($game_map.map_id)&.has_flag?("PrismriverManor") &&
	   GameData::MapMetadata.get($game_map.map_id)&.has_flag?("TFoC") && $game_switches[132]
	  scene     = battle.scene
	  player    = battle.battlers[0]
	  foe       = battle.battlers[1]
	  s_stats   = nil
	  s_ability = [:SPECTRALGUARD, :SPECTRALTWIN, :SPECTRALTOUCH, :SPECTRALSTRIKE, :SPECTRALENCHANT]
	  side_rand = rand(3)
	  $game_variables[5] = 0
      case trigger
	  when "RoundStartCommand_1_foe"
	  #-------------------------------------
	  # Run a Random Number Generation here to determine effect.
	  #-------------------------------------
	    battle.pbDisplayPaused(_INTL("The field has become haunted by spirits!"))
	    case rand(3)
	    #-------------------------------------
	    # Battle Effect 1: Spectral Status
	    #-------------------------------------
	    when 0
	      # Determine status condition and side to affect here
		  case rand(5)
		  when 0
		    if side_rand == 0
		      player.pbParalyze if player.pbCanInflictStatus?(:PARALYSIS, player, true)
			  pbSet(5,1)
			elsif side_rand == 1
		      foe.pbParalyze if foe.pbCanInflictStatus?(:PARALYSIS, foe, true)
			elsif side_rand == 2
			  player.pbParalyze if player.pbCanInflictStatus?(:PARALYSIS, player, true)
			  foe.pbParalyze if foe.pbCanInflictStatus?(:PARALYSIS, foe, true)
			  pbSet(5,1)
			end
		  when 1
  		    if side_rand == 0
			  player.pbFreeze if player.pbCanInflictStatus?(:FREEZE, player, true)
			  pbSet(5,2)
			elsif side_rand == 1
		      foe.pbFreeze if foe.pbCanInflictStatus?(:FREEZE, foe, true)
			elsif side_rand == 2
			  player.pbFreeze if player.pbCanInflictStatus?(:FREEZE, player, true)
			  foe.pbFreeze if foe.pbCanInflictStatus?(:FREEZE, foe, true)
			  pbSet(5,2)
			end
		  when 2
  		    if side_rand == 0
			  player.pbBurn if player.pbCanInflictStatus?(:BURN, player, true)
			  pbSet(5,3)
			elsif side_rand == 1
			  foe.pbBurn if foe.pbCanInflictStatus?(:BURN, foe, true)
			elsif side_rand == 2
			  player.pbBurn if player.pbCanInflictStatus?(:BURN, player, true)
			  foe.pbBurn if foe.pbCanInflictStatus?(:BURN, foe, true)
			  pbSet(5,3)
			end
		  when 3
		    if side_rand == 0
			  player.pbPoison if player.pbCanInflictStatus?(:POISON, player, true)
			  pbSet(5,4)
			elsif side_rand == 1
			  foe.pbPoison if foe.pbCanInflictStatus?(:POISON, foe, true)
			elsif side_rand == 2
			  player.pbPoison if player.pbCanInflictStatus?(:POISON, player, true)
			  pbSet(5,4)
			end
		  when 4 
		    if side_rand == 0
			  player.pbSleep if player.pbCanInflictStatus?(:SLEEP, player, true)
			  pbSet(5,5)
			elsif side_rand == 1
			  foe.pbSleep if foe.pbCanInflictStatus?(:SLEEP, foe, true)
			elsif side_rand == 2
			  player.pbSleep if player.pbCanInflictStatus?(:SLEEP, player, true)
			  foe.pbSleep if foe.pbCanInflictStatus?(:SLEEP, foe, true)
			  pbSet(5,5)
			end
		  end
	    #-------------------------------------
	    # Battle Effect 2: Spectral Stats
	    #-------------------------------------
	    when 1
	      # Determine stats to adjust here
		  case rand(6)
		  when 0 then s_stats = :ATTACK
		  when 1 then s_stats = :DEFENSE
		  when 2 then s_stats = :SPEED
		  when 3 then s_stats = :SPECIAL_ATTACK
		  when 4 then s_stats = :SPECIAL_DEFENSE
		  when 5 then s_stats = :ACCURACY
		  end
		  # Execute the application to the relevant side
		  side_rand  = rand(3)
		  value_rand = rand(2)
		  case rand(2)
		  when 0 # Raise Stats
		    if side_rand == 0
			  player.pbRaiseStatStage(s_stats, value_rand + 1, player)
			  pbSet(5,6)
			elsif side_rand == 1
			  foe.pbRaiseStatStage(s_stats, value_rand + 1, foe)
			elsif side_rand == 2
			  player.pbRaiseStatStage(s_stats, value_rand + 1, player)
			  foe.pbRaiseStatStage(s_stats, value_rand + 1, foe)
			  pbSet(5,6)
			end
		  when 1 # Lower Stats
		    if side_rand == 0
			  player.pbLowerStatStage(s_stats, value_rand + 1, player)
			  pbSet(5,7)
			elsif side_rand == 1
			  foe.pbLowerStatStage(s_stats, value_rand + 1, foe)
			elsif side_rand == 2
			  player.pbLowerStatStage(s_stats, value_rand + 1, player)
			  foe.pbLowerStatStage(s_stats, value_rand + 1, foe)
			  pbSet(5,7)
			end
		  end
	    #-------------------------------------
	    # Battle Effect 3: Spectral Abilities
	    #-------------------------------------
	    when 2
	      # Determine ability to set here
		  set_ability = s_ability.sample
		  # Execute the ability change to the relevant side
		  side_rand  = rand(3)
		  pbSet(5,8)
		  if side_rand == 0
	        player.ability = set_ability
		    battle.pbDisplay(_INTL("The spirits changed your active ability to {1}!", player.abilityName))
		  elsif side_rand == 1
		    foe.ability = set_ability
		    battle.pbDisplay(_INTL("The spirits changed your foe's active ability to {1}!", foe.abilityName))
		  else
		    player.ability = set_ability
			foe.ability = set_ability
		    battle.pbDisplay(_INTL("The spirits changed both battler's active ability to {1}!", player.abilityName))
		  end
	    end
	  when "AfterSendOut_player"
	    battle.pbDisplayPaused(_INTL("The spirits continue to haunt the battlefield!")) if pbGet(5) != 0
		case pbGet(5)
		when 1
		  player.pbParalyze if player.pbCanInflictStatus?(:PARALYSIS, player, true)
		when 2
		  player.pbFreeze if player.pbCanInflictStatus?(:FREEZE, player, true)
		when 3
		  player.pbBurn if player.pbCanInflictStatus?(:BURN, player, true)
		when 4
		  player.pbPoison if player.pbCanInflictStatus?(:POISON, player, true)
		when 5
		  player.pbSleep if player.pbCanInflictStatus?(:SLEEP, player, true)
		when 6
		  player.pbRaiseStatStage(s_stats, value_rand + 1, player)
		when 7
		  player.pbLowerStatStage(s_stats, value_rand + 1, player)
		when 8
		  battle.pbDisplay(_INTL("The spirits changed your active ability to {1}!", player.abilityName))
		end
	  end
	end
  }
)


MidbattleHandlers.add(:midbattle_global, :floor_effects,
  proc { |battle, idxBattler, idxTarget, trigger|
	scene       = battle.scene
	player      = battle.battlers[0]
	foe         = battle.battlers[1]
	
    floor_one   = GameData::MapMetadata.get($game_map.map_id)&.has_flag?("FloorOne")
    floor_two   = GameData::MapMetadata.get($game_map.map_id)&.has_flag?("FloorTwo")
    floor_three = GameData::MapMetadata.get($game_map.map_id)&.has_flag?("FloorThree")
    basement    = GameData::MapMetadata.get($game_map.map_id)&.has_flag?("BasementFloor")
	
    if GameData::MapMetadata.get($game_map.map_id)&.has_flag?("PrismriverManor") && 
	   GameData::MapMetadata.get($game_map.map_id)&.has_flag?("TFoC") && $game_switches[132] 
	  case trigger
	  when "RoundStartCommand_1_foe"
	  #-------------------------------------
	  # Initate floor check here
	  #-------------------------------------
        floor = 152
        if basement 
          floor = 155
        elsif floor_three 
          floor = 154
        elsif floor_two 
          floor = 153
        end
  
        case pbGet(floor)
        when 0, 1, 2, 3
          rand_weather = nil
          case pbGet(floor)
          when 0 then rand_weather = :Rain
          when 1 then rand_weather = :Sun
          when 2 then rand_weather = :Sandstorm
          when 3 then rand_weather = :Hail
          end
          battle.defaultWeather = rand_weather
		  battle.pbDisplay(_INTL("The spirits have influenced the weather within the mansion!"))
        when 4, 5, 6, 7
          rand_terrain = nil
          case pbGet(floor)
          when 4 then rand_terrain = :Electric
          when 5 then rand_terrain = :Grassy
          when 6 then rand_terrain = :Misty
          when 7 then rand_terrain = :Psychic
          end
          battle.defaultTerrain = rand_terrain
		  battle.pbDisplay(_INTL("The spirits have influenced the terrain within the mansion!"))
        when 8
          battle.field.effects[PBEffects::TrickRoom] = -1
		  battle.pbDisplay(_INTL("The spirits have influenced the terrain within the mansion!"))
		  battle.pbDisplay(_INTL("Slower battlers now move first."))
        when 9
          $game_temp.battle_inverse = true
		  battle.pbDisplay(_INTL("The spirits have influenced the terrain within the mansion!"))
		  battle.pbDisplay(_INTL("Type effectiveness was inverted."))
        when 10
	      battle.pbDisplay(_INTL("The spirits have influenced the brightness within the mansion!"))
		  player.pbLowerStatStage(:ACCURACY, 1, player)
	      foe.pbLowerStatStage(:ACCURACY, 1, foe)
        when 11
	      battle.pbDisplay(_INTL("The spirits have latched onto your Puppet and have prevented it from escaping!"))
		  battle.canRun = false
    	  battle.canSwitch = false
        end
      when "AfterSendOut_player"
        floor = 152
        if basement 
          floor = 155
        elsif floor_three 
          floor = 154
        elsif floor_two 
          floor = 153
        end
		
        case pbGet(floor)
        when 10
	      battle.pbDisplay(_INTL("{1}'s vision was impared thanks to the spirits anticts!", player.pbThis))
		  player.pbLowerStatStage(:ACCURACY, 1, player)
		end
	  end	
    end
  }
)

def pbGetFloorEffectText(id)
  # Attempt 1: Writing the text to an array, calling the array in the event
  effect = ["Phantom Weather: Rain", "Phantom Weather: Sun", "Phantom Weather: Sand", "Phantom Weather: Hail", 
            "Phantom Terrain: Grassy", "Phantom Terrain: Electric", "Phantom Terrain: Misty", "Phantom Terrain: Psychic",
			"Phantom Terrain: Trick", "Phantom Terrain: Inverse", "Phantom Blindness: -1 Accuracy", "Phantom Lockdown: Cannot swap or flee"]
  return effect[id]
end

EventHandlers.add(:on_player_step_taken_can_transfer, :safari_game_counter,
  proc { |handled|
    # handled is an array: [nil]. If [true], a transfer has happened because of
    # this event, so don't do anything that might cause another one
    next if handled[0]
    next if Settings::SAFARI_STEPS == 0 || !pbInSafari? || pbSafariState.decision != 0
    pbSafariState.steps -= 1
    next if pbSafariState.steps > 0
    pbMessage("\\se[Safari Zone end]" + _INTL("Attendant: Ding-dong!") + "\1")
    pbMessage(_INTL("Attendant: Your catching game is over!"))
    pbSafariState.decision = 1
    pbSafariState.pbGoToStart
    handled[0] = true
  }
)

MenuHandlers.add(:pause_menu, :quit_safari_game, {
  "name"      => _INTL("Quit"),
  "order"     => 60,
  "condition" => proc { next pbInSafari? },
  "effect"    => proc { |menu|
    menu.pbHideMenu
    if pbConfirmMessage(_INTL("Would you like to leave the catching game right now?"))
      menu.pbEndScene
      pbSafariState.decision = 1
      pbSafariState.pbGoToStart
      next true
    end
    menu.pbRefresh
    menu.pbShowMenu
    next false
  }
})
