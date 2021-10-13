#=============================================================================
# Plugin Name: Map Name Overhaul Plugin
# By: DerxwnaKapsyla
#
# Description:
#
#	This system will overhaul how the map names are displayed in games to
#	emulate a functionality similar to how RPG Maker VX Ace games onward
#	handle map names.
#
#	In VX Ace, when creating a map, there are two fields that relate to a
#	map's name. One of them is the Internal Name, which is what the editor
#	exclusively uses. This is for the sake of the developer and for the sake
#	of organization. The other is the Display Name, which is what is used when
#	displaying the name of the map in game.
#
#	For example, if you had filled the Internal Name field with "Professor 
#	Birch's Lab", but you had the Display Name filled as "Littleroot Town",
#	it would display Littleroot Town on the save menu, the location signpost,
#	and anywhere else it would get called.
#
#	The way this system works is by defining a new metadata field called
#	"DisplayName", that has to be filled in in order for a different name
#	from the one used in the editor to show up. If "DisplayName" is not
#	filled in, it will use the name shown in the editor.
#
#	Any relevant changes will be commented as such.
#
#=============================================================================
#
#	This file contains changes to make this compatable with other plugins.
#	Plugins that are currently supported are:
#	* Voltseon's Pause Menu - Voltseon
#	* Modern Quest System + UI - ThatWelshOne
#	* Encounter List UI - ThatWelshOne_
#
#	Only use this file if you have these scripts installed. If you have only
#	one or two installed, comment out/remove the other. They will be in their
#	own sections for ease of removal.
#
#=============================================================================
# Voltseon's Pause Menu
#=============================================================================
class VoltseonsPauseMenu_Scene
  def pbRefresh
    return if @shouldExit
    # Refresh the location text
    @sprites["location"].bitmap.clear if @sprites["location"].bitmap
    if pbResolveBitmap(MENU_FILE_PATH + "Backgrounds/bg_location_#{$PokemonSystem.current_menu_theme}")
      filename = MENU_FILE_PATH + "Backgrounds/bg_location_#{$PokemonSystem.current_menu_theme}"
    else
      filename = MENU_FILE_PATH + "Backgrounds/bg_location_#{DEFAULT_MENU_THEME}"
    end
    @sprites["location"].bitmap = Bitmap.new(filename)
	map_metadata = GameData::MapMetadata.try_get($game_map.map_id)	# Derx: Added for compatibility
    mapname = (map_metadata&.display_name || $game_map.name)		# DerxL Adjusted for compatibility
    baseColor = LOCATION_TEXTCOLOR[$PokemonSystem.current_menu_theme].is_a?(Color) ? LOCATION_TEXTCOLOR[$PokemonSystem.current_menu_theme] : Color.new(248,248,248)
    shadowColor = LOCATION_TEXTOUTLINE[$PokemonSystem.current_menu_theme].is_a?(Color) ? LOCATION_TEXTOUTLINE[$PokemonSystem.current_menu_theme] : Color.new(48,48,48)
    xOffset = @sprites["location"].bitmap.width - 64
    pbSetSystemFont(@sprites["location"].bitmap)
    pbDrawTextPositions(@sprites["location"].bitmap,[["#{map_metadata&.display_name || $game_map.name}",xOffset,4,1,baseColor,shadowColor,true]])	# Derx: Adjusted for compatibility
    @sprites["location"].x = -@sprites["location"].bitmap.width + (@sprites["location"].bitmap.text_size(map_metadata&.display_name || $game_map.name).width + 64 + 32)	# Derx: Adjusted for compatibility
    @components.each do |component|
      component.refresh
    end
    @shouldRefresh = false
  end
end

#=============================================================================
# Modern Quest System + UI
#=============================================================================
class EncounterList_Scene
  # Draw text and icons if map has encounters defined
  def drawPresent
    @sprites["rightarrow"].visible = (@index < @eLength-1) ? true : false
    @sprites["leftarrow"].visible = (@index > 0) ? true : false
    i = 0
    enc_array, currKey = getEncData
    enc_array.each do |s|
      species_data = GameData::Species.get(s)
      if !$Trainer.pokedex.owned?(s) && !seen_form_any_gender?(s,species_data.form)
        @sprites["icon_#{i}"].pbSetParams(0,0,0,false)
        @sprites["icon_#{i}"].visible = true
      elsif !$Trainer.pokedex.owned?(s)
        @sprites["icon_#{i}"].pbSetParams(s,0,species_data.form,false)
        @sprites["icon_#{i}"].tone = Tone.new(0,0,0,255)
        @sprites["icon_#{i}"].visible = true
      else
        @sprites["icon_#{i}"].pbSetParams(s,0,species_data.form,false)
        @sprites["icon_#{i}"].tone = Tone.new(0,0,0,0)
        @sprites["icon_#{i}"].visible = true
      end
      i += 1
    end
    # Get user-defined encounter name or default one if not present
    name = USER_DEFINED_NAMES ? USER_DEFINED_NAMES[currKey] : GameData::EncounterType.get(currKey).real_name
	map_metadata = GameData::MapMetadata.try_get($game_map.map_id)	# Derx: Added for compatibility
    loctext = _INTL("<ac><c2=43F022E8>{1}: {2}</c2></ac>", (map_metadata&.display_name || $game_map.name),name)	# Derx: Adjusted for compatibility
    loctext += sprintf("<al><c2=7FF05EE8>Total encounters for area: %s</c2></al>",enc_array.length)
    loctext += sprintf("<c2=63184210>-----------------------------------------</c2>")
    @sprites["locwindow"].setText(loctext)
  end
  
  # Draw text if map has no encounters defined (e.g. in buildings)
  def drawAbsent
    map_metadata = GameData::MapMetadata.try_get($game_map.map_id)	# Derx: Added for compatibility
	loctext = _INTL("<ac><c2=43F022E8>{1}</c2></ac>", (map_metadata&.display_name || $game_map.name))	# Derx: Adjusted for compatibility
    loctext += sprintf("<al><c2=7FF05EE8>This area has no encounters!</c2></al>")
    loctext += sprintf("<c2=63184210>-----------------------------------------</c2>")
    @sprites["locwindow"].setText(loctext)
  end
end

#=============================================================================
# Encounter List UI
#=============================================================================
class Quest
  def initialize(id,color,story)
	map_metadata = map_metadata = GameData::MapMetadata.try_get($game_map.map_id)	# Derx: Added for compatibility
	self.id       = id
    self.stage    = 1
    self.time     = Time.now
    self.location = (map_metadata&.display_name || $game_map.name)	# Derx: Adjusted for compatibility
    self.new      = true
    self.color    = color
    self.story    = story
  end
end