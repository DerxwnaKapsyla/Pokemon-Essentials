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
#   Spectral Touch (Rough Skin). Spectre's Strike (Parental Bond). Trickster Specter (Contrary). 
#   Spectre's Enchant (Cute Charm).
#-------------------------------------------------------------------------------

MidbattleHandlers.add(:midbattle_global, :battle_effects,
  proc { |battle, idxBattler, idxTarget, trigger|
    if GameData::MapMetadata.get($game_map.map_id)&.has_flag?("PrismriverManor")
	  scene     = battle.scene
	  player    = battle.battlers[0]
	  foe       = battle.battlers[1]
	  s_stats   = nil
	  s_ability = [:SPECTRALGUARD, :SPECTRALTWIN, :SPECTRALTOUCH, :SPECTRALSTRIKE, :TRICKSTERSPECTER, :SPECTRALENCHANT]
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
		  side_rand = rand(3)
		  case rand(5)
		  when 0 
		    player.pbParalyze if player.pbCanInflictStatus?(:PARALYSIS, player, true) if side_rand == 0 || 2
		    foe.pbParalyze if foe.pbCanInflictStatus?(:PARALYSIS, foe, true) if side_rand == 1 || 2
		  when 1 
  		    player.pbFreeze if player.pbCanInflictStatus?(:FREEZE, player, true) if side_rand == 0 || 2
		    foe.pbFreeze if foe.pbCanInflictStatus?(:FREEZE, foe, true) if side_rand == 1 || 2
		  when 2
		    player.pbBurn if player.pbCanInflictStatus?(:BURN, player, true) if side_rand == 0 || 2
		    foe.pbBurn if foe.pbCanInflictStatus?(:BURN, foe, true) if side_rand == 1 || 2
		  when 3
		    player.pbPoison if player.pbCanInflictStatus?(:POISON, player, true) if side_rand == 0 || 2
		    foe.pbPoison if foe.pbCanInflictStatus?(:POISON, foe, true) if side_rand == 1 || 2
		  when 4 
		    player.pbSleep if player.pbCanInflictStatus?(:SLEEP, player, true) if side_rand == 0 || 2
		    foe.pbSleep if foe.pbCanInflictStatus?(:SLEEP, foe, true) if side_rand == 1 || 2
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
		    player.pbRaiseStatStage(s_stats, value_rand + 1, player, showAnim) if side_rand == 0 || 2
		    foe.pbRaiseStatStage(s_stats, value_rand + 1, foe, showAnim) if side_rand == 1 || 2
		  when 1 # Lower Stats
		    player.pbLowerStatStage(s_stats, value_rand + 1, player, showAnim) if side_rand == 0 || 2
		    foe.pbLowerStatStage(s_stats, value_rand + 1, foe, showAnim) if side_rand == 1 || 2
		  end
	    #-------------------------------------
	    # Battle Effect 3: Spectral Abilities
	    #-------------------------------------
	    when 2
	      # Determine ability to set here
		  set_ability = s_ability.sample
		  # Execute the ability change to the relevant side
		  side_rand  = rand(3)
	      player.ability = set_ability if side_rand == 0 || 2
		  foe.ability = set_ability if side_rand == 1 || 2
		  if side_rand == 0
		    battle.pbDisplay(_INTL("The spirits changed your active ability to {1}!", player.abilityName))
		  elsif side_rand == 1
		    battle.pbDisplay(_INTL("The spirits changed your foe's active ability to {1}!", foe.abilityName))
		  else
		    battle.pbDisplay(_INTL("The spirits changed both battler's active ability to {1}!", player.abilityName))
		  end
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
    basement    = GameData::MapMetadata.get($game_map.map_id)&.has_flag?("Basement")
	
    if GameData::MapMetadata.get($game_map.map_id)&.has_flag?("PrismriverManor") && $game_switches[132]
	  case trigger
	  when "RoundStartCommand_1_foe"
	  #-------------------------------------
	  # Initate floor check here
	  #-------------------------------------
        pbFloorCheck
	  end	
    end
  }
)

def pbFloorCheck
  floor = 152
  if basement floor = 155
  elsif floor_three floor = 154
  elsif floor_two floor = 153
  end
  
  case pbGet(floor)
  when 0, 1, 2, 3
	pbFloorWeather
  when 4, 5, 6, 7
	pbFloorTerrain
  when 8
    battle.field.effects[PBEffects::TrickRoom] = -1
  when 9
    $game_temp.battle_inverse = true
  when 10
	player.pbLowerStatStage(:ACCURACY, 1, player, showAnim)
	foe.pbLowerStatStage(:ACCURACY, 1, foe, showAnim)
  when 11
	battle.canRun = false
	battle.canSwitch = false
  end
end

def pbFloorWeather
  rand_weather = nil
  case pbGet(152)
  when 0 then rand_weather = :Rain
  when 1 then rand_weather = :Sun
  when 2 then rand_weather = :Sandstorm
  when 3 then rand_weather = :Hail
  end
  battle.pbStartWeather(battler, rand_weather, false)
end

def pbFloorTerrain
  rand_terrain = nil
  case pbGet(152)
  when 4 then rand_terrain = :Electric
  when 5 then rand_terrain = :Grassy
  when 6 then rand_terrain = :Misty
  when 7 then rand_terrain = :Psychic
  battle.pbStartTerrain(battler, rand_terrain, false)
end