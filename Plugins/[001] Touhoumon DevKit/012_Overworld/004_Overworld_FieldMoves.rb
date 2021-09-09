#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Removing explicit references to Pokemon
# 	* Adds in duplicate handlers for the Touhoumon variants of moves
#==============================================================================#

#===============================================================================
# Dive
#===============================================================================
def pbDive
  return false if $game_player.pbFacingEvent
  map_metadata = GameData::MapMetadata.try_get($game_map.map_id)
  return false if !map_metadata || !map_metadata.dive_map_id
  move = :DIVE
  movefinder = $Trainer.get_pokemon_with_move(move)
  if !pbCheckHiddenMoveBadge(Settings::BADGE_FOR_DIVE,false) || (!$DEBUG && !movefinder)
    pbMessage(_INTL("The sea is deep here. It may be possible to go underwater."))
    return false
  end
  if pbConfirmMessage(_INTL("The sea is deep here. Would you like to use Dive?"))
    speciesname = (movefinder) ? movefinder.name : $Trainer.name
    pbMessage(_INTL("{1} used {2}!",speciesname,GameData::Move.get(move).name))
    pbHiddenMoveAnimation(movefinder)
    pbFadeOutIn {
       $game_temp.player_new_map_id    = map_metadata.dive_map_id
       $game_temp.player_new_x         = $game_player.x
       $game_temp.player_new_y         = $game_player.y
       $game_temp.player_new_direction = $game_player.direction
       $PokemonGlobal.surfing = false
       $PokemonGlobal.diving  = true
       pbUpdateVehicle
       $scene.transfer_player(false)
       $game_map.autoplay
       $game_map.refresh
    }
    return true
  end
  return false
end

def pbSurfacing
  return if !$PokemonGlobal.diving
  return false if $game_player.pbFacingEvent
  surface_map_id = nil
  GameData::MapMetadata.each do |map_data|
    next if !map_data.dive_map_id || map_data.dive_map_id != $game_map.map_id
    surface_map_id = map_data.id
    break
  end
  return if !surface_map_id
  move = :DIVE
  movefinder = $Trainer.get_pokemon_with_move(move)
  if !pbCheckHiddenMoveBadge(Settings::BADGE_FOR_DIVE,false) || (!$DEBUG && !movefinder)
    pbMessage(_INTL("Light is filtering down from above. It may be possible to surface here."))
    return false
  end
  if pbConfirmMessage(_INTL("Light is filtering down from above. Would you like to use Dive?"))
    speciesname = (movefinder) ? movefinder.name : $Trainer.name
    pbMessage(_INTL("{1} used {2}!",speciesname,GameData::Move.get(move).name))
    pbHiddenMoveAnimation(movefinder)
    pbFadeOutIn {
       $game_temp.player_new_map_id    = surface_map_id
       $game_temp.player_new_x         = $game_player.x
       $game_temp.player_new_y         = $game_player.y
       $game_temp.player_new_direction = $game_player.direction
       $PokemonGlobal.surfing = true
       $PokemonGlobal.diving  = false
       pbUpdateVehicle
       $scene.transfer_player(false)
       surfbgm = GameData::Metadata.get.surf_BGM
       (surfbgm) ?  pbBGMPlay(surfbgm) : $game_map.autoplayAsCue
       $game_map.refresh
    }
    return true
  end
  return false
end

#===============================================================================
# Headbutt
#===============================================================================
def pbHeadbutt(event=nil)
  move = :HEADBUTT
  movefinder = $Trainer.get_pokemon_with_move(move)
  if !$DEBUG && !movefinder
    pbMessage(_INTL("Something could be in this tree. Maybe it could be shaken."))
    return false
  end
  if pbConfirmMessage(_INTL("Something could be in this tree. Would you like to use Headbutt?"))
    speciesname = (movefinder) ? movefinder.name : $Trainer.name
    pbMessage(_INTL("{1} used {2}!",speciesname,GameData::Move.get(move).name))
    pbHiddenMoveAnimation(movefinder)
    pbHeadbuttEffect(event)
    return true
  end
  return false
end

#===============================================================================
# Rock Smash
#===============================================================================
def pbRockSmash
  move = :ROCKSMASH
  movefinder = $Trainer.get_pokemon_with_move(move)
  if !pbCheckHiddenMoveBadge(Settings::BADGE_FOR_ROCKSMASH,false) || (!$DEBUG && !movefinder)
    pbMessage(_INTL("It's a rugged rock, but it may be possible to smash it."))
    return false
  end
  if pbConfirmMessage(_INTL("This rock appears to be breakable. Would you like to use Rock Smash?"))
    speciesname = (movefinder) ? movefinder.name : $Trainer.name
    pbMessage(_INTL("{1} used {2}!",speciesname,GameData::Move.get(move).name))
    pbHiddenMoveAnimation(movefinder)
    return true
  end
  return false
end

#===============================================================================
# Strength
#===============================================================================
def pbStrength
  if $PokemonMap.strengthUsed
    pbMessage(_INTL("Strength made it possible to move boulders around."))
    return false
  end
  move = :STRENGTH
  movefinder = $Trainer.get_pokemon_with_move(move)
  if !pbCheckHiddenMoveBadge(Settings::BADGE_FOR_STRENGTH,false) || (!$DEBUG && !movefinder)
    pbMessage(_INTL("It's a big boulder, but it may be possible to push it aside."))
    return false
  end
  pbMessage(_INTL("It's a big boulder, but it may be possible to push it aside.\1"))
  if pbConfirmMessage(_INTL("Would you like to use Strength?"))
    speciesname = (movefinder) ? movefinder.name : $Trainer.name
    pbMessage(_INTL("{1} used {2}!",speciesname,GameData::Move.get(move).name))
    pbHiddenMoveAnimation(movefinder)
    pbMessage(_INTL("{1}'s Strength made it possible to move boulders around!",speciesname))
    $PokemonMap.strengthUsed = true
    return true
  end
  return false
end

#-----------------------------------------------------
# Duplicates by Derxwna
#-----------------------------------------------------
# --- Derx: Required for Touhoumon Field Move compatability
# --- Cut handler
HiddenMoveHandlers::CanUseMove.copy(:CUT,:CUT18)
HiddenMoveHandlers::UseMove.copy(:CUT,:CUT18)
# --- Dig handler
HiddenMoveHandlers::CanUseMove.copy(:DIG,:DIG18)
HiddenMoveHandlers::UseMove.copy(:DIG,:DIG18)
# --- Shadow Dive handler
HiddenMoveHandlers::CanUseMove.copy(:DIVE,:SHADOWDIVE18)
HiddenMoveHandlers::UseMove.copy(:DIVE,:SHADOWDIVE18)
# --- Flash handler
HiddenMoveHandlers::CanUseMove.copy(:FLASH,:FLASH18)
HiddenMoveHandlers::UseMove.copy(:FLASH,:FLASH18)
# --- Fly handler
HiddenMoveHandlers::CanUseMove.copy(:FLY,:FLY18)
HiddenMoveHandlers::UseMove.copy(:FLY,:FLY18)
# --- Headbutt handler
HiddenMoveHandlers::CanUseMove.copy(:HEADBUTT,:HEADBUTT18)
HiddenMoveHandlers::UseMove.copy(:HEADBUTT,:HEADBUTT18)
# --- Rock Smash handler
HiddenMoveHandlers::CanUseMove.copy(:ROCKSMASH,:ROCKSMASH18)
HiddenMoveHandlers::UseMove.copy(:ROCKSMASH,:ROCKSMASH18)
# --- Strength handler
HiddenMoveHandlers::CanUseMove.copy(:STRENGTH,:STRENGTH18)
HiddenMoveHandlers::UseMove.copy(:STRENGTH,:STRENGTH18)
# --- Surf handler
HiddenMoveHandlers::CanUseMove.copy(:SURF,:SURF18)
HiddenMoveHandlers::UseMove.copy(:SURF,:SURF18)
# --- Nature Power handler
HiddenMoveHandlers::CanUseMove.copy(:SWEETSCENT,:NATUREPOWER18)
HiddenMoveHandlers::UseMove.copy(:SWEETSCENT,:NATUREPOWER18)
# --- Teleport handler
HiddenMoveHandlers::CanUseMove.copy(:TELEPORT,:TELEPORT18)
HiddenMoveHandlers::UseMove.copy(:TELEPORT,:TELEPORT18)
# --- Waterfall handler
HiddenMoveHandlers::CanUseMove.copy(:WATERFALL,:WATERFALL18)
HiddenMoveHandlers::UseMove.copy(:WATERFALL,:WATERFALL18)
# --- Derx: End of Touhoumon Field Move compatability