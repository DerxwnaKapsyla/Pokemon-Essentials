#=================================================================================
# Plugin Name: Map Display Name Override
# By: DerxwnaKapsyla, with fixes by GolisopodUser and Vendily
# Version: 1.1
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
#	"Name", that has to be filled in in order for a different name from the one 
#	used in the editor to show up. If "Name" is not filled in, it will use the 
#	name shown in the editor.
#
#	This also comes with support for anything that calls upon the map name,
#	such as Voltseon's Pause Menu, the Wild Encounter UI, and more. I didn't
#	do extensive testing to see what was and wasn't compatable. If something
#	breaks, uh... Message me?
#
#	NOTES:
#		* This script does NOT implement the in development v20's map_metadata
#		  file, nor any other changes associated with it. This script was made
#		  and finished literally a day before Maruno did the official version,
#		  and I edited it the next day for the sake of version parity.
#
#	UPDATE - V1.1:
#		* Changed the field to "Name" to maintain parity with v20 of Essentials.
#		* Tweaked the code slightly to match the official v20 code.
#
#=================================================================================
#
# Example (in metadata.txt, under the relevant map):
#	Name = Epic Super Fun Town
#
#=================================================================================
# 001_Technical/003_Intl_Messages.rb changes
#=================================================================================
def pbSetTextMessages
  Graphics.update
  begin
    t = Time.now.to_i
    texts=[]
    for script in $RGSS_SCRIPTS
      if Time.now.to_i - t >= 5
        t = Time.now.to_i
        Graphics.update
      end
      scr=Zlib::Inflate.inflate(script[2])
      pbAddRgssScriptTexts(texts,scr)
    end
    if safeExists?("Data/PluginScripts.rxdata")
      plugin_scripts = load_data("Data/PluginScripts.rxdata")
      for plugin in plugin_scripts
        for script in plugin[2]
          if Time.now.to_i - t >= 5
            t = Time.now.to_i
            Graphics.update
          end
          scr = Zlib::Inflate.inflate(script[1]).force_encoding(Encoding::UTF_8)
          pbAddRgssScriptTexts(texts,scr)
        end
      end
    end
    # Must add messages because this code is used by both game system and Editor
    MessageTypes.addMessagesAsHash(MessageTypes::ScriptTexts,texts)
    commonevents = load_data("Data/CommonEvents.rxdata")
    items=[]
    choices=[]
    for event in commonevents.compact
      if Time.now.to_i - t >= 5
        t = Time.now.to_i
        Graphics.update
      end
      begin
        neednewline=false
        lastitem=""
        for j in 0...event.list.size
          list = event.list[j]
          if neednewline && list.code!=401
            if lastitem!=""
              lastitem.gsub!(/([^\.\!\?])\s\s+/) { |m| $1+" " }
              items.push(lastitem)
              lastitem=""
            end
            neednewline=false
          end
          if list.code == 101
            lastitem+="#{list.parameters[0]}"
            neednewline=true
          elsif list.code == 102
            for k in 0...list.parameters[0].length
              choices.push(list.parameters[0][k])
            end
            neednewline=false
          elsif list.code == 401
            lastitem+=" " if lastitem!=""
            lastitem+="#{list.parameters[0]}"
            neednewline=true
          elsif list.code == 355 || list.code == 655
            pbAddScriptTexts(items,list.parameters[0])
          elsif list.code == 111 && list.parameters[0]==12
            pbAddScriptTexts(items,list.parameters[1])
          elsif list.code == 209
            route=list.parameters[1]
            for k in 0...route.list.size
              if route.list[k].code == 45
                pbAddScriptTexts(items,route.list[k].parameters[0])
              end
            end
          end
        end
        if neednewline
          if lastitem!=""
            items.push(lastitem)
            lastitem=""
          end
        end
      end
    end
    if Time.now.to_i - t >= 5
      t = Time.now.to_i
      Graphics.update
    end
    items|=[]
    choices|=[]
    items.concat(choices)
    MessageTypes.setMapMessagesAsHash(0,items)
    mapinfos = pbLoadMapInfos
    for id in mapinfos.keys
      if Time.now.to_i - t >= 5
        t = Time.now.to_i
        Graphics.update
      end
      filename=sprintf("Data/Map%03d.rxdata",id)
      next if !pbRgssExists?(filename)
      map = load_data(filename)
      items=[]
      choices=[]
      for event in map.events.values
        if Time.now.to_i - t >= 5
          t = Time.now.to_i
          Graphics.update
        end
        begin
          for i in 0...event.pages.size
            neednewline=false
            lastitem=""
            for j in 0...event.pages[i].list.size
              list = event.pages[i].list[j]
              if neednewline && list.code!=401
                if lastitem!=""
                  lastitem.gsub!(/([^\.\!\?])\s\s+/) { |m| $1+" " }
                  items.push(lastitem)
                  lastitem=""
                end
                neednewline=false
              end
              if list.code == 101
                lastitem+="#{list.parameters[0]}"
                neednewline=true
              elsif list.code == 102
                for k in 0...list.parameters[0].length
                  choices.push(list.parameters[0][k])
                end
                neednewline=false
              elsif list.code == 401
                lastitem+=" " if lastitem!=""
                lastitem+="#{list.parameters[0]}"
                neednewline=true
              elsif list.code == 355 || list.code==655
                pbAddScriptTexts(items,list.parameters[0])
              elsif list.code == 111 && list.parameters[0]==12
                pbAddScriptTexts(items,list.parameters[1])
              elsif list.code==209
                route=list.parameters[1]
                for k in 0...route.list.size
                  if route.list[k].code==45
                    pbAddScriptTexts(items,route.list[k].parameters[0])
                  end
                end
              end
            end
            if neednewline
              if lastitem!=""
                items.push(lastitem)
                lastitem=""
              end
            end
          end
        end
      end
      if Time.now.to_i - t >= 5
        t = Time.now.to_i
        Graphics.update
      end
      items|=[]
      choices|=[]
      items.concat(choices)
      MessageTypes.setMapMessagesAsHash(id,items)
      if Time.now.to_i - t >= 5
        t = Time.now.to_i
        Graphics.update
      end
    end
  rescue Hangup
  end
  Graphics.update
end


#=================================================================================
# 004_Game classes/004_Game_Map.rb changes
#=================================================================================
class Game_Map
  def name
    return pbGetMapNameFromId(@map_id) # Derx: OFFICIAL CODE - V20.
  end
end
  
  
#=================================================================================
# 007_Objects and windows/011_Messages.rb changes
#=================================================================================
def pbGetMapNameFromId(id)
  name = pbGetMessage(MessageTypes::MapNames, id)
  name = pbGetBasicMapNameFromId(id) if nil_or_empty?(name)
  name.gsub!(/\\PN/, $Trainer.name) if $Trainer
  return name
end


#=================================================================================
# 010_Data/002_PBS_data/015_MapMetadata.rb changes
#	Note: This is currently slated to become "016_MapMetadata.rb" in v20.
#=================================================================================
module GameData
  class MapMetadata
	attr_reader	:real_name 

    SCHEMA = {
       "Name"	  		  => [1, "s"],
	   "Outdoor"          => [2,  "b"],
       "ShowArea"         => [3,  "b"],
       "Bicycle"          => [4,  "b"],
       "BicycleAlways"    => [5,  "b"],
       "HealingSpot"      => [6,  "vuu"],
       "Weather"          => [7,  "eu", :Weather],
       "MapPosition"      => [8,  "uuu"],
       "DiveMap"          => [9,  "v"],
       "DarkMap"          => [10,  "b"],
       "SafariMap"        => [11, "b"],
       "SnapEdges"        => [12, "b"],
       "Dungeon"          => [13, "b"],
       "BattleBack"       => [14, "s"],
       "WildBattleBGM"    => [15, "s"],
       "TrainerBattleBGM" => [16, "s"],
       "WildVictoryME"    => [17, "s"],
       "TrainerVictoryME" => [18, "s"],
       "WildCaptureME"    => [19, "s"],
       "MapSize"          => [20, "us"],
       "Environment"      => [21, "e", :Environment]
    }

    def self.editor_properties
      return [
		 ["Name",      		  StringProperty, 					  _INTL("The name that gets displayed on the location signpost and save interface.")], # Derx: Changed from vanilla
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
         ["Environment",      GameDataProperty.new(:Environment), _INTL("The default battle environment for battles on this map.")]
      ]
    end

    alias displayname__initialize initialize
	def initialize(hash)
      displayname__initialize(hash)
	  @real_name   		= hash[:name] # Derx: Changed from vanilla
    end

    def property_from_string(str)
      case str
	  when "Name" 	  		  then return @real_name # Derx: Changed from vanilla
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
      end
      return nil
    end
	
	# Derx: OFFICIAL CODE - V20.
    # @return [String] the translated name of this map
    def name
      return pbGetMapNameFromId(@id)
    end
  end
end


#=================================================================================
# 012_Overworld/002_Battle triggering/005_Overworld_RoamingPokemon.rb changes
#=================================================================================
EncounterModifier.register(proc { |encounter|
  $PokemonTemp.roamerIndex = nil
  next nil if !encounter
  # Give the regular encounter if encountering a roaming Pokémon isn't possible
  next encounter if $PokemonGlobal.roamedAlready
  next encounter if $PokemonGlobal.partner
  next encounter if $PokemonTemp.pokeradar
  next encounter if rand(100) < 75   # 25% chance of encountering a roaming Pokémon
  # Look at each roaming Pokémon in turn and decide whether it's possible to
  # encounter it
  currentRegion = pbGetCurrentRegion
  currentMapName = $game_map.name # Derx: OFFICIAL CODE - V20.
  possible_roamers = []
  Settings::ROAMING_SPECIES.each_with_index do |data, i|
    # data = [species, level, Game Switch, roamer method, battle BGM, area maps hash]
    next if !GameData::Species.exists?(data[0])
    next if data[2] > 0 && !$game_switches[data[2]]   # Isn't roaming
    next if $PokemonGlobal.roamPokemon[i] == true   # Roaming Pokémon has been caught
    # Get the roamer's current map
    roamerMap = $PokemonGlobal.roamPosition[i]
    if !roamerMap
      mapIDs = pbRoamingAreas(i).keys   # Hash of area patrolled by the roaming Pokémon
      next if !mapIDs || mapIDs.length == 0   # No roaming area defined somehow
      roamerMap = mapIDs[rand(mapIDs.length)]
      $PokemonGlobal.roamPosition[i] = roamerMap
    end
    # If roamer isn't on the current map, check if it's on a map with the same
    # name and in the same region
    if roamerMap != $game_map.map_id
      map_metadata = GameData::MapMetadata.try_get(roamerMap)
      next if !map_metadata || !map_metadata.town_map_position ||
              map_metadata.town_map_position[0] != currentRegion
      next if pbGetMessage(MessageTypes::MapNames, roamerMap) != currentMapName
    end
    # Check whether the roamer's roamer method is currently possible
    next if !pbRoamingMethodAllowed(data[3])
    # Add this roaming Pokémon to the list of possible roaming Pokémon to encounter
    possible_roamers.push([i, data[0], data[1], data[4]])   # [i, species, level, BGM]
  end
  # No encounterable roaming Pokémon were found, just have the regular encounter
  next encounter if possible_roamers.length == 0
  # Pick a roaming Pokémon to encounter out of those available
  roamer = possible_roamers[rand(possible_roamers.length)]
  $PokemonGlobal.roamEncounter = roamer
  $PokemonTemp.roamerIndex     = roamer[0]
  $PokemonGlobal.nextBattleBGM = roamer[3] if roamer[3] && !roamer[3].empty?
  $PokemonTemp.forceSingleBattle = true
  next [roamer[1], roamer[2]]   # Species, level
})


#=================================================================================
# 013_Items/004_Item_Phone.rb
#=================================================================================
def pbTrainerMapName(phonenum)
  return "" if !phonenum[6] || phonenum[6] == 0
  return pbGetMapNameFromId(phonenum[6]) # Derx: OFFICIAL CODE - V20
end

#=================================================================================
# 016_UI/010_UI_Phone.rb changes
#=================================================================================
class PokemonPhoneScene
  def start
    commands = []
    @trainers = []
    if $PokemonGlobal.phoneNumbers
      for num in $PokemonGlobal.phoneNumbers
        if num[0]   # if visible
          if num.length==8   # if trainer
            @trainers.push([num[1],num[2],num[6],(num[4]>=2)])
          else               # if NPC
            @trainers.push([num[1],num[2],num[3]])
          end
        end
      end
    end
    if @trainers.length==0
      pbMessage(_INTL("There are no phone numbers stored."))
      return
    end
    @sprites = {}
    @viewport = Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z = 99999
    @sprites["list"] = Window_PhoneList.newEmpty(152,32,Graphics.width-142,Graphics.height-80,@viewport)
    @sprites["header"] = Window_UnformattedTextPokemon.newWithSize(_INTL("Phone"),
       2,-18,128,64,@viewport)
    @sprites["header"].baseColor   = Color.new(248,248,248)
    @sprites["header"].shadowColor = Color.new(0,0,0)
    mapname = (@trainers[0][2]) ? pbGetMapNameFromId(@trainers[0][2]) : "" # Derx: OFFICIAL CODE - v20
    @sprites["bottom"] = Window_AdvancedTextPokemon.newWithSize("",
       162,Graphics.height-64,Graphics.width-158,64,@viewport)
    @sprites["bottom"].text = "<ac>"+mapname
    @sprites["info"] = Window_AdvancedTextPokemon.newWithSize("",-8,224,180,160,@viewport)
    addBackgroundPlane(@sprites,"bg","phonebg",@viewport)
    @sprites["icon"] = IconSprite.new(70,102,@viewport)
    if @trainers[0].length==4
      filename = GameData::TrainerType.charset_filename(@trainers[0][0])
    else
      filename = sprintf("Graphics/Characters/phone%03d",@trainers[0][0])
    end
    @sprites["icon"].setBitmap(filename)
    charwidth  = @sprites["icon"].bitmap.width
    charheight = @sprites["icon"].bitmap.height
    @sprites["icon"].x = 86-charwidth/8
    @sprites["icon"].y = 134-charheight/8
    @sprites["icon"].src_rect = Rect.new(0,0,charwidth/4,charheight/4)
    for trainer in @trainers
      if trainer.length==4
        displayname = _INTL("{1} {2}", GameData::TrainerType.get(trainer[0]).name,
           pbGetMessageFromHash(MessageTypes::TrainerNames,trainer[1])
        )
        commands.push(displayname) # trainer's display name
      else
        commands.push(trainer[1]) # NPC's display name
      end
    end
    @sprites["list"].commands = commands
    for i in 0...@sprites["list"].page_item_max
      @sprites["rematch[#{i}]"] = IconSprite.new(468,62+i*32,@viewport)
      j = i+@sprites["list"].top_item
      next if j>=commands.length
      trainer = @trainers[j]
      if trainer.length==4
        if trainer[3]
          @sprites["rematch[#{i}]"].setBitmap("Graphics/Pictures/phoneRematch")
        end
      end
    end
    rematchcount = 0
    for trainer in @trainers
      if trainer.length==4
        rematchcount += 1 if trainer[3]
      end
    end
    infotext = _INTL("Registered<br>")
    infotext += _INTL(" <r>{1}<br>",@sprites["list"].commands.length)
    infotext += _INTL("Waiting for a rematch<r>{1}",rematchcount)
    @sprites["info"].text = infotext
    pbFadeInAndShow(@sprites)
    pbActivateWindow(@sprites,"list") {
      oldindex = -1
      loop do
        Graphics.update
        Input.update
        pbUpdateSpriteHash(@sprites)
        if @sprites["list"].index!=oldindex
          trainer = @trainers[@sprites["list"].index]
          if trainer.length==4
            filename = GameData::TrainerType.charset_filename(trainer[0])
          else
            filename = sprintf("Graphics/Characters/phone%03d",trainer[0])
          end
          @sprites["icon"].setBitmap(filename)
          charwidth  = @sprites["icon"].bitmap.width
          charheight = @sprites["icon"].bitmap.height
          @sprites["icon"].x        = 86-charwidth/8
          @sprites["icon"].y        = 134-charheight/8
          @sprites["icon"].src_rect = Rect.new(0,0,charwidth/4,charheight/4)
          mapname = (trainer[2]) ? pbGetMapNameFromId(trainer[2]) : "" # Derx: OFFICIAL CODE - v20
          @sprites["bottom"].text = "<ac>"+mapname
          for i in 0...@sprites["list"].page_item_max
            @sprites["rematch[#{i}]"].clearBitmaps
            j = i+@sprites["list"].top_item
            next if j>=commands.length
            trainer = @trainers[j]
            if trainer.length==4
              if trainer[3]
                @sprites["rematch[#{i}]"].setBitmap("Graphics/Pictures/phoneRematch")
              end
            end
          end
        end
        if Input.trigger?(Input::BACK)
          pbPlayCloseMenuSE
          break
        elsif Input.trigger?(Input::USE)
          index = @sprites["list"].index
          if index>=0
            pbCallTrainer(@trainers[index][0],@trainers[index][1])
          end
        end
      end
    }
    pbFadeOutAndHide(@sprites)
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end
end

#=================================================================================
# 020_Debug/001_Editor screens/001_EditorScreens.rb
#=================================================================================
def pbEditMetadata(map_id = 0)
  mapinfos = pbLoadMapInfos
  data = []
  if map_id == 0   # Global metadata
    map_name = _INTL("Global Metadata")
    metadata = GameData::Metadata.get
    properties = GameData::Metadata.editor_properties
  else   # Map metadata
    map_name = mapinfos[map_id].name
    metadata = GameData::MapMetadata.try_get(map_id)
    metadata = GameData::Metadata.new({}) if !metadata
    properties = GameData::MapMetadata.editor_properties
  end
  properties.each do |property|
    data.push(metadata.property_from_string(property[0]))
  end
  if pbPropertyList(map_name, data, properties, true)
    if map_id == 0   # Global metadata
      # Construct metadata hash
      metadata_hash = {
        :id                 => map_id,
        :home               => data[0],
        :wild_battle_BGM    => data[1],
        :trainer_battle_BGM => data[2],
        :wild_victory_ME    => data[3],
        :trainer_victory_ME => data[4],
        :wild_capture_ME    => data[5],
        :surf_BGM           => data[6],
        :bicycle_BGM        => data[7],
        :player_A           => data[8],
        :player_B           => data[9],
        :player_C           => data[10],
        :player_D           => data[11],
        :player_E           => data[12],
        :player_F           => data[13],
        :player_G           => data[14],
        :player_H           => data[15]
      }
      # Add metadata's data to records
      GameData::Metadata.register(metadata_hash)
      GameData::Metadata.save
    else   # Map metadata
      # Construct metadata hash
      metadata_hash = {
        :id                   => map_id,
        :name	 	          => data[0], # Derx: OFFICIAL CODE - v20
		:outdoor_map          => data[1],
        :announce_location    => data[2],
        :can_bicycle          => data[3],
        :always_bicycle       => data[4],
        :teleport_destination => data[5],
        :weather              => data[6],
        :town_map_position    => data[7],
        :dive_map_id          => data[8],
        :dark_map             => data[9],
        :safari_map           => data[10],
        :snap_edges           => data[11],
        :random_dungeon       => data[12],
        :battle_background    => data[13],
        :wild_battle_BGM      => data[14],
        :trainer_battle_BGM   => data[15],
        :wild_victory_ME      => data[16],
        :trainer_victory_ME   => data[17],
        :wild_capture_ME      => data[18],
        :town_map_size        => data[19],
        :battle_environment   => data[20]
      }
      # Add metadata's data to records
      GameData::MapMetadata.register(metadata_hash)
      GameData::MapMetadata.save
    end
    Compiler.write_metadata
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
    map_infos = pbLoadMapInfos
    map_names = []
    map_infos.keys.each { |id| map_names[id] = map_infos[id].name }
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
			:name   			  => contents["Name"], # Derx: OFFICIAL CODE - v20
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
            :battle_environment   => contents["Environment"]
          }
          # Add metadata's data to records
          GameData::MapMetadata.register(metadata_hash)
		  map_names[map_id] = metadata_hash[:name] if !nil_or_empty?(metadata_hash[:name])
        end
      }
    }
    # Save all data
    GameData::Metadata.save
    GameData::MapMetadata.save
	MessageTypes.setMessages(MessageTypes::MapNames, map_names)
    Graphics.update
  end
end