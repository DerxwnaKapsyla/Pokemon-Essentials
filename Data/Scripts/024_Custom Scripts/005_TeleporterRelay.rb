class PokemonGlobalMetadata
    attr_writer  :eligibleTransferMaps    

    def eligibleTransferMaps
      @eligibleTransferMaps ||= {
        # List all eligable maps here
        48    =>    [43,3,true,"Pharos City"],
        52    =>    [43,3,false,"Veiskille City"],
        56    =>    [43,3,false,"Yozora Island"],
        54    =>    [43,3,false,"Kousen City"],
        57    =>    [43,3,false,"Fotia Village"],
        58    =>    [43,3,false,"Chusei City"],
        59    =>    [43,3,false,"Mendacium City"],
        60    =>    [43,3,false,"Fulgum Island"],
        53    =>    [43,3,false,"Kortalan City"],
        55    =>    [43,3,false,"Pélagite City"],
        131   =>    [43,3,false,"Charamada Island"],
        49    =>    [43,3,false,"Charamada Peak"],
        61    =>    [43,3,false,"Kaigara Village"],
        132   =>    [43,3,false,"Kaiyomi Island"]
        }
      return @eligibleTransferMaps
    end
end
  
Events.onMapChanging+=proc {|sender,e|
  newmapID = e[0]
  newmap   = e[1]
  if $PokemonGlobal.eligibleTransferMaps.has_key?(newmapID) 
    $PokemonGlobal.eligibleTransferMaps[newmapID][2] = true
 end
}

def pbLocationChoice
  locations= $PokemonGlobal.eligibleTransferMaps.keys.inject([]) do |loc, element|
    loc << $PokemonGlobal.eligibleTransferMaps[element][3] if $PokemonGlobal.eligibleTransferMaps[element][2]
    loc
  end.sort.map { |e| e.to_s }
  if locations.size>0
    Kernel.pbMessage(_INTL("Please choose a destination."))
    destination = locations[Kernel.pbShowCommands(nil, locations)]
#    print(destination)
    return if destination==-1
#    print(destination)
    destination=$PokemonGlobal.eligibleTransferMaps.find{ |key,value| value[3]==destination}[0]
    if $scene.is_a?(Scene_Map)
      pbSEPlay("teleporter2.wav")
      pbWait(60)
      $game_switches[90] = true # Run the exit cutscene after teleporting in
    pbFadeOutIn(99999){      
      $game_temp.player_new_map_id    = destination
      $game_temp.player_new_x         = $PokemonGlobal.eligibleTransferMaps[destination][0]
      $game_temp.player_new_y         = $PokemonGlobal.eligibleTransferMaps[destination][1]
      $game_temp.player_new_direction = 2
      $scene.transfer_player
      $game_map.refresh      
    }
    pbEraseEscapePoint      
    else
      Kernel.pbCancelVehicles
      $MapFactory.setup(destination)
      $game_player.moveto($PokemonGlobal.eligibleTransferMaps[destination][0],
        $PokemonGlobal.eligibleTransferMaps[destination][1])
      $game_player.turn_down
      $game_map.update
      $game_map.autoplay
      $game_map.refresh
    end
  else
    Kernel.pbMessage("No locations available")
  end
end