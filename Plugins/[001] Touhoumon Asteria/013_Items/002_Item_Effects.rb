#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Removed explicit references to Pokemon. Kinda. It's weird.
#	* Tweaked existing items to implement Touhoumon mechanics
#	* Added in items not present in Vanilla Touhoumon
#	* Added sound effects to the Item Finder
#==============================================================================#
ItemHandlers::UseInField.add(:BLACKFLUTE, proc { |item|
  pbUseItemMessage(item)
  pbMessage(_INTL("Wild Pokémon and Puppets will be repelled."))
  $PokemonMap.blackFluteUsed = true
  $PokemonMap.whiteFluteUsed = false
  next true
})

ItemHandlers::UseInField.add(:WHITEFLUTE, proc { |item|
  pbUseItemMessage(item)
  pbMessage(_INTL("Wild Pokémon and Puppets will be lured."))
  $PokemonMap.blackFluteUsed = false
  $PokemonMap.whiteFluteUsed = true
  next true
})

ItemHandlers::UseInField.add(:SACREDASH, proc { |item|
  if $player.pokemon_count == 0
    pbMessage(_INTL("There is nothing in your party."))
    next false
  end
  canrevive = false
  $player.pokemon_party.each do |i|
    next if !i.fainted?
    canrevive = true
    break
  end
  if !canrevive
    pbMessage(_INTL("It won't have any effect."))
    next false
  end
  revived = 0
  pbFadeOutIn {
    scene = PokemonParty_Scene.new
    screen = PokemonPartyScreen.new(scene, $player.party)
    screen.pbStartScene(_INTL("Using item..."), false)
    $player.party.each_with_index do |pkmn, i|
      next if !pkmn.fainted?
      revived += 1
      pkmn.heal
      screen.pbRefreshSingle(i)
      screen.pbDisplay(_INTL("{1}'s HP was restored.", pkmn.name))
    end
    if revived == 0
      screen.pbDisplay(_INTL("It won't have any effect."))
    end
    screen.pbEndScene
  }
  next (revived > 0)
})

ItemHandlers::UseInField.add(:ITEMFINDER, proc { |item|
  $stats.itemfinder_count += 1
  event = pbClosestHiddenItem
  if event
    offsetX = event.x - $game_player.x
    offsetY = event.y - $game_player.y
    if offsetX == 0 && offsetY == 0   # Standing on the item, spin around
      4.times do
        pbWait(Graphics.frame_rate * 2 / 10)
        $game_player.turn_right_90
		pbSEPlay("SlotsCoin")
      end
      pbWait(Graphics.frame_rate * 3 / 10)
      pbMessage(_INTL("The {1}'s indicating something right underfoot!", GameData::Item.get(item).name))
    else   # Item is nearby, face towards it
      direction = $game_player.direction
      if offsetX.abs > offsetY.abs
        direction = (offsetX < 0) ? 4 : 6
      else
        direction = (offsetY < 0) ? 8 : 2
      end
      case direction
      when 2 then $game_player.turn_down
      when 4 then $game_player.turn_left
      when 6 then $game_player.turn_right
      when 8 then $game_player.turn_up
      end
      pbWait(Graphics.frame_rate * 3 / 10)
       pbSEPlay("SlotsCoin")
       pbWait(30)
       pbSEPlay("SlotsCoin")
       pbWait(30)
       pbSEPlay("SlotsCoin")
       pbWait(30)
       pbSEPlay("SlotsCoin")
       pbWait(10)
      pbMessage(_INTL("Huh? The {1}'s responding!\1", GameData::Item.get(item).name))
      pbMessage(_INTL("There's an item buried around here!"))
    end
  else
    pbMessage(_INTL("... \\wt[10]... \\wt[10]... \\wt[10]...\\wt[10]Nope! There's no response."))
  end
  next true
})

# ------ Derx: Liquid Revive: Max Elixir + Max Revive
ItemHandlers::UseOnPokemon.add(:LIQUIDREVIVE, proc { |item, qty, pkmn, scene|
  pprestored = 0
  pkmn.moves.length.times do |i|
    pprestored += pbRestorePP(pkmn, i, pkmn.moves[i].total_pp - pkmn.moves[i].pp)
  end
  if !pkmn.fainted?
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end
  pkmn.heal_HP
  pkmn.heal_status
  scene.pbRefresh
  scene.pbDisplay(_INTL("{1} was fully revitalized.", pkmn.name))
  next true
})
# ------ Derx: End of Liquid Revive