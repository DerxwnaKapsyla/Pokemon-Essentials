#=================================================================================
# Plugin Name: Map Display Name Override
# By: DerxwnaKapsyla, with fixes by GolisopodUser and Vendily
#=================================================================================
# Description:
#
#	This system will create an override flag in metadata.txt for how the map 
#	names are displayed in games to emulate a functionality similar to how 
#	RPG Maker VX Ace games onward handle map names.
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
#	This also comes with support for anything that calls upon the map name,
#	such as Voltseon's Pause Menu, the Wild Encounter UI, and more. I didn't
#	do extensive testing to see what was and wasn't compatable. If something
#	breaks, uh... Message me?
#
#=================================================================================
#
# Example (in metadata.txt, under the relevant map):
#	DisplayName = Epic Super Fun Town
#
#=================================================================================
# 010_Data/002_PBS Data/015_MapMetadata.rb Changes
#=================================================================================
module GameData
  class MapMetadata
	attr_reader	:display_name # Derx: Changed from vanilla

    SCHEMA = {
	   "Outdoor"          => [1,  "b"],
       "ShowArea"         => [2,  "b"],
       "Bicycle"          => [3,  "b"],
       "BicycleAlways"    => [4,  "b"],
       "HealingSpot"      => [5,  "vuu"],
       "Weather"          => [6,  "eu", :Weather],
       "MapPosition"      => [7,  "uuu"],
       "DiveMap"          => [8,  "v"],
       "DarkMap"          => [9,  "b"],
       "SafariMap"        => [10, "b"],
       "SnapEdges"        => [11, "b"],
       "Dungeon"          => [12, "b"],
       "BattleBack"       => [13, "s"],
       "WildBattleBGM"    => [14, "s"],
       "TrainerBattleBGM" => [15, "s"],
       "WildVictoryME"    => [16, "s"],
       "TrainerVictoryME" => [17, "s"],
       "WildCaptureME"    => [18, "s"],
       "MapSize"          => [19, "us"],
       "Environment"      => [20, "e", :Environment],
       "DisplayName"	  => [21, "s"] # Derx: Changed from vanilla
    }

    def self.editor_properties
      return [
         ["Outdoor",          BooleanProperty,                    _INTL("If true, this map is an outdoor map and will be tinted according to time of day.")],
         ["ShowArea",         BooleanProperty,                    _INTL("If true, the game will display the map's name upon entry.")],
         ["Bicycle",          BooleanProperty,                    _INTL("If true, the bicycle can be used on this map.")],
         ["BicycleAlways",    BooleanProperty,                    _INTL("If true, the bicycle will be mounted automatically on this map and cannot be dismounted.")],
         ["HealingSpot",      MapCoordsProperty,                  _INTL("Map ID of this Pokémon Center's town, and X and Y coordinates of its entrance within that town.")],
         ["Weather",          WeatherEffectProperty,              _INTL("Weather conditions in effect for this map.")],
         ["MapPosition",      RegionMapCoordsProperty,            _INTL("Identifies the point on the regional map for this map.")],
         ["DiveMap",          MapProperty,                        _INTL("Specifies the underwater layer of this map. Use only if this map has deep water.")],
         ["DarkMap",          BooleanProperty,                    _INTL("If true, this map is dark and a circle of light appears around the player. Flash can be used to expand the circle.")],
         ["SafariMap",        BooleanProperty,                    _INTL("If true, this map is part of the Safari Zone (both indoor and outdoor). Not to be used in the reception desk.")],
         ["SnapEdges",        BooleanProperty,                    _INTL("If true, when the player goes near this map's edge, the game doesn't center the player as usual.")],
         ["Dungeon",          BooleanProperty,                    _INTL("If true, this map has a randomly generated layout. See the wiki for more information.")],
         ["BattleBack",       StringProperty,                     _INTL("PNG files named 'XXX_bg', 'XXX_base0', 'XXX_base1', 'XXX_message' in Battlebacks folder, where XXX is this property's value.")],
         ["WildBattleBGM",    BGMProperty,                        _INTL("Default BGM for wild Pokémon battles on this map.")],
         ["TrainerBattleBGM", BGMProperty,                        _INTL("Default BGM for trainer battles on this map.")],
         ["WildVictoryME",    MEProperty,                         _INTL("Default ME played after winning a wild Pokémon battle on this map.")],
         ["TrainerVictoryME", MEProperty,                         _INTL("Default ME played after winning a Trainer battle on this map.")],
         ["WildCaptureME",    MEProperty,                         _INTL("Default ME played after catching a wild Pokémon on this map.")],
         ["MapSize",          MapSizeProperty,                    _INTL("The width of the map in Town Map squares, and a string indicating which squares are part of this map.")],
         ["Environment",      GameDataProperty.new(:Environment), _INTL("The default battle environment for battles on this map.")],
		 ["DisplayName",      StringProperty, 					  _INTL("The name that gets displayed on the location signpost and save interface.")] # Derx: Changed from vanilla
      ]
    end

    alias displayname__initialize initialize
	def initialize(hash)
      displayname__initialize(hash)
	  @display_name   		= hash[:display_name] # Derx: Changed from vanilla
    end

    def property_from_string(str)
      case str
      when "Outdoor"          then return @outdoor_map
      when "ShowArea"         then return @announce_location
      when "Bicycle"          then return @can_bicycle
      when "BicycleAlways"    then return @always_bicycle
      when "HealingSpot"      then return @teleport_destination
      when "Weather"          then return @weather
      when "MapPosition"      then return @town_map_position
      when "DiveMap"          then return @dive_map_id
      when "DarkMap"          then return @dark_map
      when "SafariMap"        then return @safari_map
      when "SnapEdges"        then return @snap_edges
      when "Dungeon"          then return @random_dungeon
      when "BattleBack"       then return @battle_background
      when "WildBattleBGM"    then return @wild_battle_BGM
      when "TrainerBattleBGM" then return @trainer_battle_BGM
      when "WildVictoryME"    then return @wild_victory_ME
      when "TrainerVictoryME" then return @trainer_victory_ME
      when "WildCaptureME"    then return @wild_capture_ME
      when "MapSize"          then return @town_map_size
      when "Environment"      then return @battle_environment
	  when "DisplayName" 	  then return @display_name # Derx: Changed from vanilla
      end
      return nil
    end
  end
end

#=================================================================================
# 021_Compiler/002_Compiler_CompilePBS.rb Changes
#=================================================================================
module Compiler
  module_function
  
  def compile_metadata(path = "PBS/metadata.txt")
    GameData::Metadata::DATA.clear
    GameData::MapMetadata::DATA.clear
    # Read from PBS file
    File.open(path, "rb") { |f|
      FileLineData.file = path   # For error reporting
      # Read a whole section's lines at once, then run through this code.
      # contents is a hash containing all the XXX=YYY lines in that section, where
      # the keys are the XXX and the values are the YYY (as unprocessed strings).
      pbEachFileSection(f) { |contents, map_id|
        schema = (map_id == 0) ? GameData::Metadata::SCHEMA : GameData::MapMetadata::SCHEMA
        # Go through schema hash of compilable data and compile this section
        for key in schema.keys
          FileLineData.setSection(map_id, key, contents[key])   # For error reporting
          # Skip empty properties, or raise an error if a required property is
          # empty
          if contents[key].nil?
            if map_id == 0 && ["Home", "PlayerA"].include?(key)
              raise _INTL("The entry {1} is required in {2} section 0.", key, path)
            end
            next
          end
          # Compile value for key
          value = pbGetCsvRecord(contents[key], key, schema[key])
          value = nil if value.is_a?(Array) && value.length == 0
          contents[key] = value
        end
        if map_id == 0   # Global metadata
          # Construct metadata hash
          metadata_hash = {
            :id                 => map_id,
            :home               => contents["Home"],
            :wild_battle_BGM    => contents["WildBattleBGM"],
            :trainer_battle_BGM => contents["TrainerBattleBGM"],
            :wild_victory_ME    => contents["WildVictoryME"],
            :trainer_victory_ME => contents["TrainerVictoryME"],
            :wild_capture_ME    => contents["WildCaptureME"],
            :surf_BGM           => contents["SurfBGM"],
            :bicycle_BGM        => contents["BicycleBGM"],
            :player_A           => contents["PlayerA"],
            :player_B           => contents["PlayerB"],
            :player_C           => contents["PlayerC"],
            :player_D           => contents["PlayerD"],
            :player_E           => contents["PlayerE"],
            :player_F           => contents["PlayerF"],
            :player_G           => contents["PlayerG"],
            :player_H           => contents["PlayerH"]
          }
          # Add metadata's data to records
          GameData::Metadata.register(metadata_hash)
        else   # Map metadata
          # Construct metadata hash
          metadata_hash = {
            :id                   => map_id,
            :outdoor_map          => contents["Outdoor"],
            :announce_location    => contents["ShowArea"],
            :can_bicycle          => contents["Bicycle"],
            :always_bicycle       => contents["BicycleAlways"],
            :teleport_destination => contents["HealingSpot"],
            :weather              => contents["Weather"],
            :town_map_position    => contents["MapPosition"],
            :dive_map_id          => contents["DiveMap"],
            :dark_map             => contents["DarkMap"],
            :safari_map           => contents["SafariMap"],
            :snap_edges           => contents["SnapEdges"],
            :random_dungeon       => contents["Dungeon"],
            :battle_background    => contents["BattleBack"],
            :wild_battle_BGM      => contents["WildBattleBGM"],
            :trainer_battle_BGM   => contents["TrainerBattleBGM"],
            :wild_victory_ME      => contents["WildVictoryME"],
            :trainer_victory_ME   => contents["TrainerVictoryME"],
            :wild_capture_ME      => contents["WildCaptureME"],
            :town_map_size        => contents["MapSize"],
            :battle_environment   => contents["Environment"],
			:display_name   	  => contents["DisplayName"] # Derx: Changed from vanilla
          }
          # Add metadata's data to records
          GameData::MapMetadata.register(metadata_hash)
        end
      }
    }
    # Save all data
    GameData::Metadata.save
    GameData::MapMetadata.save
    Graphics.update
  end
end

#=================================================================================
# 004_Game Classes/004_Game_Map.rb changes
#=================================================================================
class Game_Map
  def name
    ret = pbGetMessage(MessageTypes::MapNames,@map_id)
    metadata = GameData::MapMetadata.try_get(@map_id)
    ret = metadata.display_name if metadata && !nil_or_empty?(metadata.display_name)
    ret.gsub!(/\\PN/,$Trainer.name) if $Trainer
    return ret
  end
end

#=================================================================================
# 007_Objects and windows/011_Messages.rb changes
#=================================================================================
def pbGetMapNameFromId(id)
  map = pbGetBasicMapNameFromId(id)
  metadata = GameData::MapMetadata.try_get(id)
  map = metadata.display_name if metadata && !nil_or_empty?(metadata.display_name)
  map.gsub!(/\\PN/,$Trainer.name) if $Trainer
  return map
end