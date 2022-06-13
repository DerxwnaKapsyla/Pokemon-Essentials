#===============================================================================
# "v20 Hotfixes" plugin
# This file contains fixes for bugs in Essentials v20.
# These bug fixes are also in the master branch of the GitHub version of
# Essentials:
# https://github.com/Maruno17/pokemon-essentials
#===============================================================================

Essentials::ERROR_TEXT += "[v20 Hotfixes 1.0.3]\r\n"

#===============================================================================
# Fixed event evolutions not working.
#===============================================================================
class Pokemon
  def check_evolution_by_event(value = 0)
    return check_evolution_internal { |pkmn, new_species, method, parameter|
      success = GameData::Evolution.get(method).call_event(pkmn, parameter, value)
      next (success) ? new_species : nil
    }
  end
end

#===============================================================================
# Fixed not registering a gifted Pokémon as seen/owned before looking at its
# Pokédex entry.
# Derx: Removed explicit references to Pokemon
#		Added the line for recieving a Pokemon from Oak.
#===============================================================================
def pbAddPokemon(pkmn, level = 1, see_form = true)
  return false if !pkmn
  if pbBoxesFull?
    pbMessage(_INTL("There's no more room in the box!\1"))
    pbMessage(_INTL("They are full and can't accept any more!"))
    return false
  end
  pkmn = Pokemon.new(pkmn, level) if !pkmn.is_a?(Pokemon)
  species_name = pkmn.speciesName
  pbMessage(_INTL("{1} obtained {2}!\\me[Pkmn get]\\wtnp[80]\1", $player.name, species_name))
  if $game_map && $game_map.map_id==18 # Derx: If the player is on Map 18 (Oak's Lab - 2F)
	pbMessage(_INTL("{1} received the {2} from Professor Oak!\\me[Pkmn get]\\wtnp[80]\1", $player.name, species_name))
  else
	pbMessage(_INTL("{1} obtained {2}!\\me[Pkmn get]\\wtnp[80]\1", $player.name, species_name))
  end
  was_owned = $player.owned?(pkmn.species)
  $player.pokedex.set_seen(pkmn.species)
  $player.pokedex.set_owned(pkmn.species)
  $player.pokedex.register(pkmn) if see_form
  # Show Pokédex entry for new species if it hasn't been owned before
  if Settings::SHOW_NEW_SPECIES_POKEDEX_ENTRY_MORE_OFTEN && see_form && !was_owned && $player.has_pokedex
    pbMessage(_INTL("{1}'s data was added to the Pokédex.", species_name))
    $player.pokedex.register_last_seen(pkmn)
    pbFadeOutIn {
      scene = PokemonPokedexInfo_Scene.new
      screen = PokemonPokedexInfoScreen.new(scene)
      screen.pbDexEntry(pkmn.species)
    }
  end
  # Nickname and add the Pokémon
  pbNicknameAndStore(pkmn)
  return true
end

def pbAddPokemonSilent(pkmn, level = 1, see_form = true)
  return false if !pkmn || pbBoxesFull?
  pkmn = Pokemon.new(pkmn, level) if !pkmn.is_a?(Pokemon)
  $player.pokedex.set_seen(pkmn.species)
  $player.pokedex.set_owned(pkmn.species)
  $player.pokedex.register(pkmn) if see_form
  pkmn.record_first_moves
  if $player.party_full?
    $PokemonStorage.pbStoreCaught(pkmn)
  else
    $player.party[$player.party.length] = pkmn
  end
  return true
end

def pbAddToParty(pkmn, level = 1, see_form = true)
  return false if !pkmn || $player.party_full?
  pkmn = Pokemon.new(pkmn, level) if !pkmn.is_a?(Pokemon)
  species_name = pkmn.speciesName
  pbMessage(_INTL("{1} obtained {2}!\\me[Pkmn get]\\wtnp[80]\1", $player.name, species_name))
  was_owned = $player.owned?(pkmn.species)
  $player.pokedex.set_seen(pkmn.species)
  $player.pokedex.set_owned(pkmn.species)
  $player.pokedex.register(pkmn) if see_form
  # Show Pokédex entry for new species if it hasn't been owned before
  if Settings::SHOW_NEW_SPECIES_POKEDEX_ENTRY_MORE_OFTEN && see_form && !was_owned && $player.has_pokedex
    pbMessage(_INTL("{1}'s data was added to the Pokédex.", species_name))
    $player.pokedex.register_last_seen(pkmn)
    pbFadeOutIn {
      scene = PokemonPokedexInfo_Scene.new
      screen = PokemonPokedexInfoScreen.new(scene)
      screen.pbDexEntry(pkmn.species)
    }
  end
  # Nickname and add the Pokémon
  pbNicknameAndStore(pkmn)
  return true
end

def pbAddForeignPokemon(pkmn, level = 1, owner_name = nil, nickname = nil, owner_gender = 0, see_form = true)
  return false if !pkmn || $player.party_full?
  pkmn = Pokemon.new(pkmn, level) if !pkmn.is_a?(Pokemon)
  pkmn.owner = Pokemon::Owner.new_foreign(owner_name || "", owner_gender)
  pkmn.name = nickname[0, Pokemon::MAX_NAME_SIZE] if !nil_or_empty?(nickname)
  pkmn.calc_stats
  if owner_name
    pbMessage(_INTL("\\me[Pkmn get]{1} received a Pokémon from {2}.\1", $player.name, owner_name))
  else
    pbMessage(_INTL("\\me[Pkmn get]{1} received a Pokémon.\1", $player.name))
  end
  was_owned = $player.owned?(pkmn.species)
  $player.pokedex.set_seen(pkmn.species)
  $player.pokedex.set_owned(pkmn.species)
  $player.pokedex.register(pkmn) if see_form
  # Show Pokédex entry for new species if it hasn't been owned before
  if Settings::SHOW_NEW_SPECIES_POKEDEX_ENTRY_MORE_OFTEN && see_form && !was_owned && $player.has_pokedex
    pbMessage(_INTL("The Pokémon's data was added to the Pokédex."))
    $player.pokedex.register_last_seen(pkmn)
    pbFadeOutIn {
      scene = PokemonPokedexInfo_Scene.new
      screen = PokemonPokedexInfoScreen.new(scene)
      screen.pbDexEntry(pkmn.species)
    }
  end
  # Add the Pokémon
  pbStorePokemon(pkmn)
  return true
end

#===============================================================================
# Fixed the player animating super-fast for a while after surfing.
#===============================================================================
class Game_Player < Game_Character
  alias __hotfixes_update_pattern update_pattern
  def update_pattern
    __hotfixes_update_pattern
    @anime_count = 0 if $PokemonGlobal&.surfing || $PokemonGlobal&.diving
  end
end

#===============================================================================
# Fixed error when using Rotom Catalog.
#===============================================================================
ItemHandlers::UseOnPokemon.add(:ROTOMCATALOG, proc { |item, qty, pkmn, scene|
  if !pkmn.isSpecies?(:ROTOM)
    scene.pbDisplay(_INTL("It had no effect."))
    next false
  elsif pkmn.fainted?
    scene.pbDisplay(_INTL("This can't be used on the fainted Pokémon."))
    next false
  end
  choices = [
    _INTL("Light bulb"),
    _INTL("Microwave oven"),
    _INTL("Washing machine"),
    _INTL("Refrigerator"),
    _INTL("Electric fan"),
    _INTL("Lawn mower"),
    _INTL("Cancel")
  ]
  new_form = scene.pbShowCommands(_INTL("Which appliance would you like to order?"),
     choices, pkmn.form)
  if new_form == pkmn.form
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  elsif new_form > 0 && new_form < choices.length - 1
    pkmn.setForm(new_form) {
      scene.pbRefresh
      scene.pbDisplay(_INTL("{1} transformed!", pkmn.name))
    }
    next true
  end
  next false
})

#===============================================================================
# Fixed Pickup's out-of-battle effect causing an error.
#===============================================================================
def pbPickup(pkmn)
  return if pkmn.egg? || !pkmn.hasAbility?(:PICKUP)
  return if pkmn.hasItem?
  return unless rand(100) < 10   # 10% chance for Pickup to trigger
  num_rarity_levels = 10
  # Ensure common and rare item lists contain defined items
  common_items = pbDynamicItemList(*PICKUP_COMMON_ITEMS)
  rare_items = pbDynamicItemList(*PICKUP_RARE_ITEMS)
  return if common_items.length < num_rarity_levels - 1 + PICKUP_COMMON_ITEM_CHANCES.length
  return if rare_items.length < num_rarity_levels - 1 + PICKUP_RARE_ITEM_CHANCES.length
  # Determine the starting point for adding items from the above arrays into the
  # pool
  start_index = [([100, pkmn.level].min - 1) * num_rarity_levels / 100, 0].max
  # Generate a pool of items depending on the Pokémon's level
  items = []
  PICKUP_COMMON_ITEM_CHANCES.length.times { |i| items.push(common_items[start_index + i]) }
  PICKUP_RARE_ITEM_CHANCES.length.times { |i| items.push(rare_items[start_index + i]) }
  # Randomly choose an item from the pool to give to the Pokémon
  all_chances = PICKUP_COMMON_ITEM_CHANCES + PICKUP_RARE_ITEM_CHANCES
  rnd = rand(all_chances.sum)
  cumul = 0
  all_chances.each_with_index do |c, i|
    cumul += c
    next if rnd >= cumul
    pkmn.item = items[i]
    break
  end
end

#===============================================================================
# Fixed some Battle Challenge code not recognising a valid team if a team size
# limit is imposed.
#===============================================================================
class PokemonRuleSet
  def canRegisterTeam?(team)
    return false if !team || team.length < self.minTeamLength
    return false if team.length > self.maxTeamLength
    teamNumber = self.minTeamLength
    team.each do |pkmn|
      return false if !isPokemonValid?(pkmn)
    end
    @teamRules.each do |rule|
      return false if !rule.isValid?(team)
    end
    if @subsetRules.length > 0
      pbEachCombination(team, teamNumber) { |comb|
        isValid = true
        @subsetRules.each do |rule|
          next if rule.isValid?(comb)
          isValid = false
          break
        end
        return true if isValid
      }
      return false
    end
    return true
  end

  def hasValidTeam?(team)
    return false if !team || team.length < self.minTeamLength
    teamNumber = self.minTeamLength
    validPokemon = []
    team.each do |pkmn|
      validPokemon.push(pkmn) if isPokemonValid?(pkmn)
    end
    return false if validPokemon.length < teamNumber
    if @teamRules.length > 0
      pbEachCombination(team, teamNumber) { |comb| return true if isValid?(comb) }
      return false
    end
    return true
  end
end

#===============================================================================
# Fixed memory leak caused by lots of map transfers.
#===============================================================================
class Scene_Map
  def createSpritesets
    @map_renderer = TilemapRenderer.new(Spriteset_Map.viewport) if !@map_renderer || @map_renderer.disposed?
    @spritesetGlobal = Spriteset_Global.new if !@spritesetGlobal
    @spritesets = {}
    $map_factory.maps.each do |map|
      @spritesets[map.map_id] = Spriteset_Map.new(map)
    end
    $map_factory.setSceneStarted(self)
    updateSpritesets
  end

  def disposeSpritesets
    return if !@spritesets
    @spritesets.each_key do |i|
      next if !@spritesets[i]
      @spritesets[i].dispose
      @spritesets[i] = nil
    end
    @spritesets.clear
    @spritesets = {}
  end
end

def pbSceneStandby
  yield
end

def pbLoadRpgxpScene(scene)
  return if !$scene.is_a?(Scene_Map)
  oldscene = $scene
  $scene = scene
  Graphics.freeze
  visibleObjects = pbHideVisibleObjects
  Graphics.transition
  Graphics.freeze
  while $scene && !$scene.is_a?(Scene_Map)
    $scene.main
  end
  Graphics.transition
  Graphics.freeze
  $scene = oldscene
  pbShowObjects(visibleObjects)
  Graphics.transition
end

#===============================================================================
# Fixed def pbChooseItemFromList not storing the correct result in a Game
# Variable.
#===============================================================================
def pbChooseItemFromList(message, variable, *args)
  commands = []
  itemid   = []
  args.each do |item|
    next if !GameData::Item.exists?(item)
    itm = GameData::Item.get(item)
    next if !$bag.has?(itm)
    commands.push(itm.name)
    itemid.push(itm.id)
  end
  if commands.length == 0
    $game_variables[variable] = :NONE
    return nil
  end
  commands.push(_INTL("Cancel"))
  itemid.push(nil)
  ret = pbMessage(message, commands, -1)
  if ret < 0 || ret >= commands.length - 1
    $game_variables[variable] = :NONE
    return nil
  end
  $game_variables[variable] = itemid[ret] || :NONE
  return itemid[ret]
end

#===============================================================================
# Fixed trainer intro BGM persisting after battles against multiple trainers.
#===============================================================================
def pbPlayTrainerIntroBGM(trainer_type)
  trainer_type_data = GameData::TrainerType.get(trainer_type)
  return if nil_or_empty?(trainer_type_data.intro_BGM)
  bgm = pbStringToAudioFile(trainer_type_data.intro_BGM)
  if !$game_temp.memorized_bgm
    $game_temp.memorized_bgm = $game_system.getPlayingBGM
    $game_temp.memorized_bgm_position = (Audio.bgm_pos rescue 0)
  end
  pbBGMPlay(bgm)
end

#===============================================================================
# Fixed SystemStackError when loading a connected map with an event at its edge.
#===============================================================================
class PokemonMapFactory
  def getNewMap(playerX, playerY, map_id = nil)
    id = map_id || $game_map.map_id
    MapFactoryHelper.eachConnectionForMap(id) do |conn|
      mapidB = nil
      newx = 0
      newy = 0
      if conn[0] == id
        mapidB = conn[3]
        mapB = MapFactoryHelper.getMapDims(conn[3])
        newx = conn[4] - conn[1] + playerX
        newy = conn[5] - conn[2] + playerY
      else
        mapidB = conn[0]
        mapB = MapFactoryHelper.getMapDims(conn[0])
        newx = conn[1] - conn[4] + playerX
        newy = conn[2] - conn[5] + playerY
      end
      if newx >= 0 && newx < mapB[0] && newy >= 0 && newy < mapB[1]
        return [getMap(mapidB), newx, newy]
      end
    end
    return nil
  end
end

class Game_Character
  def calculate_bush_depth
    if @tile_id > 0 || @always_on_top || jumping?
      @bush_depth = 0
      return
    end
    xbehind = @x + (@direction == 4 ? 1 : @direction == 6 ? -1 : 0)
    ybehind = @y + (@direction == 8 ? 1 : @direction == 2 ? -1 : 0)
    this_map = (self.map.valid?(@x, @y)) ? [self.map, @x, @y] : $map_factory&.getNewMap(@x, @y, self.map.map_id)
    behind_map = (self.map.valid?(xbehind, ybehind)) ? [self.map, xbehind, ybehind] : $map_factory&.getNewMap(xbehind, ybehind, self.map.map_id)
    if this_map && this_map[0].deepBush?(this_map[1], this_map[2]) &&
       (!behind_map || behind_map[0].deepBush?(behind_map[1], behind_map[2]))
      @bush_depth = Game_Map::TILE_HEIGHT
    elsif this_map && this_map[0].bush?(this_map[1], this_map[2]) && !moving?
      @bush_depth = 12
    else
      @bush_depth = 0
    end
  end
end
