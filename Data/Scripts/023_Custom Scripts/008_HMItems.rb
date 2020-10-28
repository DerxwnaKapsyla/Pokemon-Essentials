#===============================================================================
#HMs as Items by FL
#
#additional editing by derFischae and Bulbasaurlvl5
#===============================================================================
#
#This script is for Pokémon Essentials 17.
#
#features included:
#          - allows surfing, cutting trees etc. by using items
#            instead of pokemon moves
#          - HM moves can still be used
#          - supports the script "Following Pokemon"
#            https://www.pokecommunity.com/showthread.php?t=360846
#
#Installation: Installation as simple as it can be.
# 1) Open items.txt in your PBS folder and add the following items
#    (change the numbers 1-12 such that it does not coincide with
#    one of your allready existing items):
#      800,AXE,Axe,Axes,8,0,"A small tool used to cut down small road-side trees.",2,0,6
#      801,LANTERN,Lantern,Lanterns,8,0,"A retro-themed lantern that runs on batteries. It can be used to illuminate dark caves.",2,0,6
#      802,PICKAXE,Pickaxe,Pickaxes,8,0,"A tool used to pick apart rocks.",2,0,6
#      803,BOAT,Boat,Boats,8,0,"An inflatable boat that can be used to cross bodies of water.",2,0,6
#      804,HOOK,Grappling Hook,Grappling Hooks,8,0,"A hookshot that can be used to reach higher places.",2,0,6
#      805,DIVEGEAR,Diving Gear,Diving Gear,8,0,"A set of gear used for diving under the water.",2,0,6
#      806,TELEPORTER,Mini Teleporter,Mini Teleporters,8,0,"A device which allows you to teleport to locations within a region.",2,0,6
#      807,GAUNTLETS,Iron Gauntlets,Iron Gauntlets,8,0,"A pair of gloves that will endow the wearer with the strength to push boulders.",2,0,6
# 2) add pictures in the folder \Graphics\Icons with the names item001.png, ... item.013.png,
#    where the number in the names equal the number above
# 3) Insert a new file in the script editor above main,
#    name it HMs_as_items and copy this code into it.
#    If you use the script "Following Pokemon"
#    https://www.pokecommunity.com/showthread.php?t=360846
#    make sure that you insert HMs_as_items UNDER that script.
# 4) If you use the script "Following Pokemon" set
#          IUSEFOLLOWINGPOKEMON = true
#    in the settings section below.

################################################################################
# There is a bug in pokemon essentials occuring while using an item in the ready
# menu or in the bag. It happens that the flag $game_temp.in_menu is not set
# to false. Hence all events including there animations are frozen. This is
# especially annoying if you want to replace rocksmash with an item,
# but you won't get the smash animation.
#
# Well just for replacing HMs with Items you can simply add
#      $game_temp.in_menu = false
# at the beginning of the methods useMoveCut, useMoveRockSmash, ...
# instead of using this bug fix. But infact this bug fix is also useful for
# fishing, etc.
# So it is recommend to use "Bug fixes for Item Usage in Field" see
#      https://www.pokecommunity.com/showthread.php?t=429033
################################################################################

#===============================================================================
# SETTINGS
#===============================================================================
IUSEFOLLOWINGPOKEMON = false
#false - means that you don't use the script "Following Pokemon"
#true  - means that you use the script "Following Pokemon" and that you have
#        inserted the Following Pokemon Script above this script

#===============================================================================
# Cut
#===============================================================================
#===============================================================================
# overrides the method Kernel.pbRockSmash in pField_FieldMoves
# to include interacting via AXE with a tree on the map
#===============================================================================
def Kernel.pbCut
  move = getID(PBMoves,:CUT)
  movefinder = Kernel.pbCheckMove(move)
  if !pbCheckHiddenMoveBadge(BADGEFORCUT,false) || (!$DEBUG && !movefinder && $PokemonBag.pbQuantity(PBItems::AXE)==0)
    Kernel.pbMessage(_INTL("It's a small tree. Come back then you or your Pokémon have learned to cut it."))
    return false
  end
  if Kernel.pbConfirmMessage(_INTL("Would you like to cut this small tree?"))
    if $PokemonBag.pbQuantity(PBItems::AXE)>0
      Kernel.pbMessage(_INTL("{1} used the {2}!",$Trainer.name,PBItems.getName(PBItems::AXE)))
      pbHiddenMoveAnimation(nil)
    else
      speciesname = (movefinder) ? movefinder.name : $Trainer.name
      Kernel.pbMessage(_INTL("{1} used {2}!",speciesname,PBMoves.getName(move)))
      pbHiddenMoveAnimation(movefinder)
    end
    return true
  end
  return false
end

#===============================================================================
# adding new methods in Script PItem_Items
# to include interacting via AXE with a tree on the map
#===============================================================================
def canUseMoveCut?
  showmsg = true
  return false if !pbCheckHiddenMoveBadge(BADGEFORCUT,showmsg)
  facingEvent = $game_player.pbFacingEvent
  if !facingEvent || facingEvent.name!="Tree"
    Kernel.pbMessage(_INTL("Can't use that here.")) if showmsg
    return false
  end
  return true
end

def useMoveCut
  if !pbHiddenMoveAnimation(nil)
    Kernel.pbMessage(_INTL("{1} used the {2}!",$Trainer.name,PBItems.getName(PBItems::AXE)))
  end
  facingEvent = $game_player.pbFacingEvent
  if facingEvent
    pbSmashEvent(facingEvent)
  end
  return true
end

#===============================================================================
# adding new ItemHandlers in the script PItem_ItemEffects
# for the Items to use them in the bag and in field
#===============================================================================
ItemHandlers::UseFromBag.add(:AXE,proc{|item|
  next canUseMoveCut? ? 2 : 0
})

ItemHandlers::UseInField.add(:AXE,proc{|item|
  useMoveCut if canUseMoveCut?
})

#===============================================================================
# Dig
# Removed because I'm not using it. - Derxwna
#===============================================================================
#
# Free Shrugs!
# https://www.pokecommunity.com/printthread.php?t=429034 Thread if you want to add it back in
#
#===============================================================================
# Dive
#===============================================================================
#===============================================================================
# overrides the methods Kernel.pbDive and Kernel.pbSurfacing in pField_FieldMoves
# to include interacting via Diving Gear with a deap sea on the map
#===============================================================================

def Kernel.pbDive
  divemap = pbGetMetadata($game_map.map_id,MetadataDiveMap)
  return false if !divemap
  move = getID(PBMoves,:DIVE)
  movefinder = Kernel.pbCheckMove(move)
  if !pbCheckHiddenMoveBadge(BADGEFORDIVE,false) || (!$DEBUG && !movefinder && $PokemonBag.pbQuantity(PBItems::DIVEGEAR)==0)
    Kernel.pbMessage(_INTL("The sea is deep here. Come back then you or your Pokémon learned to go underwater."))
    return false
  end
  if Kernel.pbConfirmMessage(_INTL("The sea is deep here. Would you like to use Dive?"))
    if $PokemonBag.pbQuantity(PBItems::DIVEGEAR)>0
      Kernel.pbMessage(_INTL("{1} used their {2}!",$Trainer.name,PBItems.getName(PBItems::DIVEGEAR)))
      pbHiddenMoveAnimation(nil)
    else
      speciesname = (movefinder) ? movefinder.name : $Trainer.name
      Kernel.pbMessage(_INTL("{1} used {2}!",speciesname,PBMoves.getName(move)))
      pbHiddenMoveAnimation(movefinder)
    end
    pbFadeOutIn(99999){
      $game_temp.player_new_map_id    = divemap
      $game_temp.player_new_x        = $game_player.x
      $game_temp.player_new_y        = $game_player.y
      $game_temp.player_new_direction = $game_player.direction
      Kernel.pbCancelVehicles
      $PokemonGlobal.diving = true
      Kernel.pbUpdateVehicle
      $scene.transfer_player(false)
      $game_map.autoplay
      $game_map.refresh
    }
    return true
  end
  return false
end

def Kernel.pbSurfacing
  return if !$PokemonGlobal.diving
  divemap = nil
  meta = pbLoadMetadata
  for i in 0...meta.length
    if meta[i] && meta[i][MetadataDiveMap] && meta[i][MetadataDiveMap]==$game_map.map_id
      divemap = i; break
    end
  end
  return if !divemap
  move = getID(PBMoves,:DIVE)
  movefinder = Kernel.pbCheckMove(move)
  if !pbCheckHiddenMoveBadge(BADGEFORDIVE,false) || (!$DEBUG && !movefinder && $PokemonBag.pbQuantity(PBItems::DIVEGEAR)==0)
    Kernel.pbMessage(_INTL("Light is filtering down from above.  Come back then you or your Pokémon learned to go underwater."))
    return false
  end
  if Kernel.pbConfirmMessage(_INTL("Light is filtering down from above. Would you like to use Dive?"))
    if $PokemonBag.pbQuantity(PBItems::DIVEGEAR)>0
      Kernel.pbMessage(_INTL("{1} used their {2}!",$Trainer.name,PBItems.getName(PBItems::DIVEGEAR)))
      pbHiddenMoveAnimation(nil)
    else
      speciesname = (movefinder) ? movefinder.name : $Trainer.name
      Kernel.pbMessage(_INTL("{1} used {2}!",speciesname,PBMoves.getName(move)))
      pbHiddenMoveAnimation(movefinder)
    end
    pbFadeOutIn(99999){
      $game_temp.player_new_map_id    = divemap
      $game_temp.player_new_x        = $game_player.x
      $game_temp.player_new_y        = $game_player.y
      $game_temp.player_new_direction = $game_player.direction
      Kernel.pbCancelVehicles
      $PokemonGlobal.surfing = true
      Kernel.pbUpdateVehicle
      $scene.transfer_player(false)
      surfbgm = pbGetMetadata(0,MetadataSurfBGM)
      (surfbgm) ?  pbBGMPlay(surfbgm) : $game_map.autoplayAsCue
      $game_map.refresh
    }
    return true
  end
  return false
end

#===============================================================================
# adding new methods in Script PItem_Items
# to include interacting via DIVEGEAR with deep sea in the bag
#===============================================================================
def canUseMoveDive?
  showmsg = true
  return false if !pbCheckHiddenMoveBadge(BADGEFORDIVE,showmsg)
  if $PokemonGlobal.diving
    return true if DIVINGSURFACEANYWHERE
    divemap = nil
    meta = pbLoadMetadata
    for i in 0...meta.length
      if meta[i] && meta[i][MetadataDiveMap] && meta[i][MetadataDiveMap]==$game_map.map_id
        divemap = i; break
      end
    end
    if !PBTerrain.isDeepWater?($MapFactory.getTerrainTag(divemap,$game_player.x,$game_player.y))
      Kernel.pbMessage(_INTL("Can't use that here.")) if showmsg
      return false
    end
  else
    if !pbGetMetadata($game_map.map_id,MetadataDiveMap)
      Kernel.pbMessage(_INTL("Can't use that here.")) if showmsg
      return false
    end
    if !PBTerrain.isDeepWater?($game_player.terrain_tag)
      Kernel.pbMessage(_INTL("Can't use that here.")) if showmsg
      return false
    end
  end
  return true
end

def useMoveDive
  wasdiving = $PokemonGlobal.diving
  if $PokemonGlobal.diving
    divemap = nil
    meta = pbLoadMetadata
    for i in 0...meta.length
      if meta[i] && meta[i][MetadataDiveMap] && meta[i][MetadataDiveMap]==$game_map.map_id
        divemap = i; break
      end
    end
  else
    divemap = pbGetMetadata($game_map.map_id,MetadataDiveMap)
  end
  return false if !divemap
  if !pbHiddenMoveAnimation(nil)
    Kernel.pbMessage(_INTL("{1} used their {2}!",$Trainer.name,PBItems.getName(PBItems::DIVEGEAR)))
  end
  pbFadeOutIn(99999){
      $game_temp.player_new_map_id    = divemap
      $game_temp.player_new_x        = $game_player.x
      $game_temp.player_new_y        = $game_player.y
      $game_temp.player_new_direction = $game_player.direction
      Kernel.pbCancelVehicles
      (wasdiving) ? $PokemonGlobal.surfing = true : $PokemonGlobal.diving = true
      Kernel.pbUpdateVehicle
      $scene.transfer_player(false)
      $game_map.autoplay
      $game_map.refresh
  }
  return true
end

#===============================================================================
# adding new ItemHandlers in the script PItem_ItemEffects
# for the Items to use them in the bag and in field
#===============================================================================
ItemHandlers::UseFromBag.add(:DIVEGEAR,proc{|item|
  next canUseMoveDive? ? 2 : 0
})

ItemHandlers::UseInField.add(:DIVEGEAR,proc{|item|
  useMoveDive if canUseMoveDive?
})

#===============================================================================
# Flash
#===============================================================================
#===============================================================================
# adding new methods in Script PItem_Items
# to include interacting via LANTERN with deep sea in the bag
#===============================================================================
def canUseMoveFlash?
  showmsg = true
  return false if !pbCheckHiddenMoveBadge(BADGEFORFLASH,showmsg)
  if !pbGetMetadata($game_map.map_id,MetadataDarkMap)
    Kernel.pbMessage(_INTL("Can't use that here.")) if showmsg
    return false
  end
  if $PokemonGlobal.flashUsed
    Kernel.pbMessage(_INTL("Flash is already being used.")) if showmsg
    return false
  end
  return true
end

def useMoveFlash
  darkness = $PokemonTemp.darknessSprite
  return false if !darkness || darkness.disposed?
  if !pbHiddenMoveAnimation(nil)
    Kernel.pbMessage(_INTL("{1} used a {2}!",$Trainer.name,PBItems.getName(PBItems::LANTERN)))
  end
  $PokemonGlobal.flashUsed = true
  while darkness.radius<176
    Graphics.update
    Input.update
    pbUpdateSceneMap
    darkness.radius += 4
  end
  return true
end

#===============================================================================
# adding new ItemHandlers in the script PItem_ItemEffects
# for the Items to use them in the bag and in field
#===============================================================================
ItemHandlers::UseFromBag.add(:LANTERN,proc{|item|
  next canUseMoveFlash? ? 2 : 0
})

ItemHandlers::UseInField.add(:LANTERN,proc{|item|
  useMoveFlash if canUseMoveFlash?
})

#===============================================================================
# Fly
#===============================================================================
#===============================================================================
# adding new methods in Script PItem_Items
# to include interacting via LANTERN with deep sea in the bag
#===============================================================================
def canUseMoveFly?
  showmsg = true
  return false if !pbCheckHiddenMoveBadge(BADGEFORFLY,showmsg)
  if $game_player.pbHasDependentEvents? && (IUSEFOLLOWINGPOKEMON ? !$game_switches[Following_Activated_Switch] : true)
    Kernel.pbMessage(_INTL("It can't be used when you have someone with you.")) if showmsg
    return false
  end
  if !pbGetMetadata($game_map.map_id,MetadataOutdoor)
    Kernel.pbMessage(_INTL("Can't use that here.")) if showmsg
    return false
  end
  return true
end 

def useMoveFly
  scene=PokemonRegionMap_Scene.new(-1,false)
  screen=PokemonRegionMapScreen.new(scene)
  $PokemonTemp.flydata=screen.pbStartFlyScreen
  if !$PokemonTemp.flydata
    Kernel.pbMessage(_INTL("{1} put away the {2}.",$Trainer.name,PBItems.getName(PBItems::TELEPORTER)))
  else !pbHiddenMoveAnimation(nil)
    Kernel.pbMessage(_INTL("{1} used the {2}!",$Trainer.name,PBItems.getName(PBItems::TELEPORTER)))
	pbSEPlay("Teleport")	
	pbFadeOutIn(99999){
    Kernel.pbCancelVehicles
    $game_temp.player_new_map_id=$PokemonTemp.flydata[0]
    $game_temp.player_new_x=$PokemonTemp.flydata[1]
    $game_temp.player_new_y=$PokemonTemp.flydata[2]
    $PokemonTemp.flydata=nil
    $game_temp.player_new_direction=2
    $scene.transfer_player
    $game_map.autoplay
		$game_map.refresh
		pbSEPlay("teleporter")	
  }
  pbEraseEscapePoint
  return true
  end
end

#===============================================================================
# adding new ItemHandlers in the script PItem_ItemEffects
# for the Items to use them in the bag and in field
#===============================================================================
ItemHandlers::UseFromBag.add(:TELEPORTER,proc{|item|
  next canUseMoveFly? ? 2 : 0
})

ItemHandlers::UseInField.add(:TELEPORTER,proc{|item|
  useMoveFly if canUseMoveFly?
})

#===============================================================================
# Headbutt# Removed because I'm not using it. - Derxwna
#===============================================================================
#
# Free Shrugs!
# https://www.pokecommunity.com/printthread.php?t=429034 Thread if you want to add it back in
#
#===============================================================================
# Rock Smash
#===============================================================================
#===============================================================================
# overrides the method Kernel.pbRockSmash in Script PField_FieldMoves
# to include interacting via a PICKAXE with a rock on the map
#===============================================================================
def Kernel.pbRockSmash
  move = getID(PBMoves,:ROCKSMASH)
  movefinder = Kernel.pbCheckMove(move)
  if !pbCheckHiddenMoveBadge(BADGEFORROCKSMASH,false) || (!$DEBUG && !movefinder && $PokemonBag.pbQuantity(PBItems::PICKAXE)==0)
    Kernel.pbMessage(_INTL("It's a rugged rock. Come back then you or your Pokémon have learned to smash it."))
    return false
  end
  if Kernel.pbConfirmMessage(_INTL("This rock appears to be breakable. Would you like to use Rock Smash?"))
    if $PokemonBag.pbQuantity(PBItems::PICKAXE)>0
      Kernel.pbMessage(_INTL("{1} used their {2}!",$Trainer.name,PBItems.getName(PBItems::PICKAXE)))
      pbHiddenMoveAnimation(nil)
    else
      speciesname = (movefinder) ? movefinder.name : $Trainer.name
      Kernel.pbMessage(_INTL("{1} used {2}!",speciesname,PBMoves.getName(move)))
      pbHiddenMoveAnimation(movefinder)
    end
    return true
  end
  return false
end

#===============================================================================
# adding new method Kernel.pbRockSmash in Script PItem_Items
# to include interacting via a PICKAXE with a rock on the map
#===============================================================================
def canUseMoveRockSmash?
  showmsg = true
  return false if !pbCheckHiddenMoveBadge(BADGEFORROCKSMASH,showmsg)
  facingEvent = $game_player.pbFacingEvent
  if !facingEvent || facingEvent.name!="Rock"
    Kernel.pbMessage(_INTL("Can't use that here.")) if showmsg
    return false
  end
  return true
end

def useMoveRockSmash
  if !pbHiddenMoveAnimation(nil)
    Kernel.pbMessage(_INTL("{1} used their {2}!",$Trainer.name,PBItems.getName(PBItems::PICKAXE)))
  end
  facingEvent = $game_player.pbFacingEvent
  if facingEvent
    pbSmashEvent(facingEvent)
    pbRockSmashRandomEncounter
  end
  return true
end

#===============================================================================
# adding new ItemHandlers in the script PItem_ItemEffects
# for the Items to use them in the bag and in field
#===============================================================================
ItemHandlers::UseFromBag.add(:PICKAXE,proc{|item|
  next canUseMoveRockSmash? ? 2 : 0
})

ItemHandlers::UseInField.add(:PICKAXE,proc{|item|
  useMoveRockSmash if canUseMoveRockSmash?
})

#===============================================================================
# Strength
#===============================================================================
#===============================================================================
# overrides the method Kernel.pbRockSmash in Script PField_FieldMoves
# to include interacting via GAUNTLETS (exoskeleton :) ) with a rock on the map
#===============================================================================
def Kernel.pbStrength
  if $PokemonMap.strengthUsed
    Kernel.pbMessage(_INTL("You made it possible to move boulders around."))
    return false
  end
  move = getID(PBMoves,:STRENGTH)
  movefinder = Kernel.pbCheckMove(move)
    if !pbCheckHiddenMoveBadge(BADGEFORSTRENGTH,false) ||
      (!$DEBUG && !movefinder && $PokemonBag.pbQuantity(PBItems::GAUNTLETS)==0)
    Kernel.pbMessage(_INTL("It's a big boulder, but theoretically it should be movable."))
    return false
  end
  if Kernel.pbConfirmMessage(_INTL("Would you like to move the boulder?"))
    if $PokemonBag.pbQuantity(PBItems::GAUNTLETS)>0
      Kernel.pbMessage(_INTL("{1} used the {2}!",$Trainer.name,PBItems.getName(PBItems::GAUNTLETS)))
      pbHiddenMoveAnimation(nil)
    else
      speciesname = (movefinder) ? movefinder.name : $Trainer.name
      Kernel.pbMessage(_INTL("{1} used {2}!",speciesname,PBMoves.getName(move)))
      pbHiddenMoveAnimation(movefinder)
      Kernel.pbMessage(_INTL("{1}'s Strength made it possible to move boulders around!",speciesname))
    end
    $PokemonMap.strengthUsed = true
    return true
  end
  return false
end

#===============================================================================
# adding new methods in Script PItem_Items
# to include interacting via GAUNTLETS with a rock on the map from the bag
#===============================================================================
def canUseMoveStrength?
  showmsg = true
  return false if !pbCheckHiddenMoveBadge(BADGEFORSTRENGTH,showmsg)
  if $PokemonMap.strengthUsed
    Kernel.pbMessage(_INTL("The {1} are already equipped.",PBItems.getName(PBItems::GAUNTLETS))) if showmsg
    return false
  end
  return true
end

def useMoveStrength
  if !pbHiddenMoveAnimation(nil)
    Kernel.pbMessage(_INTL("{1} used the {2} to move boulders!",$Trainer.name,PBItems.getName(PBItems::GAUNTLETS)))
  end
  $PokemonMap.strengthUsed = true
  return true
end

#===============================================================================
# adding new ItemHandlers in the script PItem_ItemEffects
# for the Items to use them in the bag and in field
#===============================================================================
ItemHandlers::UseFromBag.add(:GAUNTLETS,proc{|item|
  next canUseMoveStrength? ? 2 : 0
})

ItemHandlers::UseInField.add(:GAUNTLETS,proc{|item|
  useMoveStrength if canUseMoveStrength?
})

#===============================================================================
# Surf
#===============================================================================
#===============================================================================
# overrides the method Kernel.pbSurf in Script PField_FieldMoves
# to include interacting via BOAT with water on the map
#===============================================================================
def Kernel.pbSurf
  return false if $game_player.pbHasDependentEvents? && (IUSEFOLLOWINGPOKEMON ? !$game_switches[Following_Activated_Switch] : true)
  #return false if $game_player.pbHasDependentEvents? && !$game_switches[Following_Activated_Switch]
  move = getID(PBMoves,:SURF)
  movefinder = Kernel.pbCheckMove(move)
  if !pbCheckHiddenMoveBadge(BADGEFORSURF,false) || (!$DEBUG && !movefinder && $PokemonBag.pbQuantity(PBItems::BOAT)==0)
    return false
  end
  if Kernel.pbConfirmMessage(_INTL("The water is a deep blue...\nWould you like to surf on it?"))
    if $PokemonBag.pbQuantity(PBItems::BOAT)>0
      Kernel.pbMessage(_INTL("{1} got on their boat!",$Trainer.name))
      Kernel.pbCancelVehicles
      pbHiddenMoveAnimation(nil)
    else
      speciesname = (movefinder) ? movefinder.name : $Trainer.name
      Kernel.pbMessage(_INTL("{1} used {2}!",speciesname,PBMoves.getName(move)))
      Kernel.pbCancelVehicles
      pbHiddenMoveAnimation(movefinder)
    end
    surfbgm = pbGetMetadata(0,MetadataSurfBGM)
    $PokemonTemp.dependentEvents.check_surf(true) if IUSEFOLLOWINGPOKEMON == true
    pbCueBGM(surfbgm,0.5) if surfbgm
    pbStartSurfing
    return true
  end
  return false
end

#===============================================================================
# adding new methods in Script PItem_Items
# to include interacting via BOAT with water on the map from the bag
#===============================================================================
def canUseMoveSurf?
  showmsg = true
  return false if !pbCheckHiddenMoveBadge(BADGEFORSURF,showmsg)
  if $PokemonGlobal.surfing
    Kernel.pbMessage(_INTL("You're already surfing.")) if showmsg
    return false
  end
  if $game_player.pbHasDependentEvents? && (IUSEFOLLOWINGPOKEMON ? !$game_switches[Following_Activated_Switch] : true)
    Kernel.pbMessage(_INTL("It can't be used when you have someone with you.")) if showmsg
    return false
  end
  if pbGetMetadata($game_map.map_id,MetadataBicycleAlways)
    Kernel.pbMessage(_INTL("Let's enjoy cycling!")) if showmsg
    return false
  end
  if !PBTerrain.isSurfable?(Kernel.pbFacingTerrainTag) ||
      !$game_map.passable?($game_player.x,$game_player.y,$game_player.direction,$game_player)
    Kernel.pbMessage(_INTL("No surfing here!")) if showmsg
    return false
  end
  ########################
  #das folgende hatte FL im code statt der letzten if abfrage oben
  #-----------------------
  #terrain=Kernel.pbFacingTerrainTag
  #notCliff=$game_map.passable?($game_player.x,$game_player.y,$game_player.direction)
  #if !PBTerrain.isSurfable?(terrain) || !notCliff
  #  Kernel.pbMessage(_INTL("No surfing here!"))
  #  return false
  #end
  #######################
  return true
end

def useMoveSurf
  $game_temp.in_menu = false
  Kernel.pbCancelVehicles
  if !pbHiddenMoveAnimation(nil)
    Kernel.pbMessage(_INTL("{1} got on their boat!",$Trainer.name,PBItems.getName(PBItems::BOAT)))
  end
  surfbgm = pbGetMetadata(0,MetadataSurfBGM)
  pbCueBGM(surfbgm,0.5) if surfbgm
  pbStartSurfing
  return true
end

#===============================================================================
# adding new ItemHandlers in the script PItem_ItemEffects
# for the Items to use them in the bag and in field
#===============================================================================
ItemHandlers::UseFromBag.add(:BOAT,proc{|item|
  next canUseMoveSurf? ? 2 : 0
})

ItemHandlers::UseInField.add(:BOAT,proc{|item|
  useMoveSurf if canUseMoveSurf?
})

#===============================================================================
# Sweet Scent
# Removed because I'm not using it. - Derxwna
#===============================================================================
#
# Free Shrugs!
# https://www.pokecommunity.com/printthread.php?t=429034 Thread if you want to add it back in
#
#===============================================================================
# Teleport
# Removed because I'm not using it. - Derxwna
#===============================================================================
#
# Free Shrugs!
# https://www.pokecommunity.com/printthread.php?t=429034 Thread if you want to add it back in
#
#===============================================================================
# Waterfall
#===============================================================================
#===============================================================================
# overrides the method Kernel.pbWaterfall in Script PField_FieldMoves
# to include interacting via HOOK with waterfalls on the map
#===============================================================================
def Kernel.pbWaterfall
  move = getID(PBMoves,:WATERFALL)
  movefinder = Kernel.pbCheckMove(move)
  if !pbCheckHiddenMoveBadge(BADGEFORWATERFALL,false) || (!$DEBUG && !movefinder && $PokemonBag.pbQuantity(PBItems::HOOK)==0)
    Kernel.pbMessage(_INTL("A wall of water is crashing down with a mighty roar."))
    return false
  end
  if Kernel.pbConfirmMessage(_INTL("It's a large waterfall. Would you like to climb it?"))
    if $PokemonBag.pbQuantity(PBItems::HOOK)>0
      Kernel.pbMessage(_INTL("{1} climbs the waterfall!",$Trainer.name))
      pbHiddenMoveAnimation(nil)
    else
      speciesname = (movefinder) ? movefinder.name : $Trainer.name
      Kernel.pbMessage(_INTL("{1} used {2}!",speciesname,PBMoves.getName(move)))
      pbHiddenMoveAnimation(movefinder)
    end
    pbAscendWaterfall
    return true
  end
  return false
end

#===============================================================================
# adding new methods in Script PItem_Items
# to include interacting via HOOK from the bag
#===============================================================================
def canUseMoveWaterfall?
  showmsg = true
  return false if !pbCheckHiddenMoveBadge(BADGEFORWATERFALL,showmsg)
  if Kernel.pbFacingTerrainTag!=PBTerrain::Waterfall
    Kernel.pbMessage(_INTL("Can't use that here.")) if showmsg
    return false
  end
  return true
end

def useMoveWaterfall
  if !pbHiddenMoveAnimation(nil)
    Kernel.pbMessage(_INTL("{1} climbs the waterfall!",$Trainer.name))
  end
  Kernel.pbAscendWaterfall
  return true
end

#===============================================================================
# adding new ItemHandlers in the script PItem_ItemEffects
# for the Items to use them in the bag and in field
#===============================================================================
ItemHandlers::UseFromBag.add(:HOOK,proc{|item|
  next canUseMoveWaterfall? ? 2 : 0
})

ItemHandlers::UseInField.add(:HOOK,proc{|item|
  useMoveWaterfall if canUseMoveWaterfall?
})