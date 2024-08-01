# def pbGetWildBattleStart(encounters)
  # if GameData::MapMetadata.get($game_map.map_id)&.has_flag?("Suzuran")
    # WildBattle.dx_start([*encounters], {}, {}, :SUZURAN_FIELD)
  # else
    # WildBattle.start(*encounters, can_override: true)
  # end
# end