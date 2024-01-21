class PokemonSave_Scene
  def pbStartScreen
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport.z = 99999
    @sprites = {}
    totalsec = $stats.play_time.to_i
    hour = totalsec / 60 / 60
    min = totalsec / 60 % 60
    mapname = $game_map.name
    textColor = ["0070F8,78B8E8", "E82010,F8A8B8", "0070F8,78B8E8"][$player.gender]
    locationColor = "209808,90F090"   # green
    loctext = _INTL("<ac><c3={1}>{2}</c3></ac>", locationColor, mapname)
    loctext += _INTL("Player<r><c3={1}>{2}</c3><br>", textColor, $player.name)
    if hour > 0
      loctext += _INTL("Time<r><c3={1}>{2}h {3}m</c3><br>", textColor, hour, min)
    else
      loctext += _INTL("Time<r><c3={1}>{2}m</c3><br>", textColor, min)
    end
    loctext += _INTL("Losses<r><c3={1}>{2}</c3><br>", textColor, $stats.trainer_battles_lost)
    if $player.has_pokedex
      loctext += _INTL("Pokédex<r><c3={1}>{2}/{3}</c3>", textColor, $player.pokedex.owned_count, $player.pokedex.seen_count)
    end
    @sprites["locwindow"] = Window_AdvancedTextPokemon.new(loctext)
    @sprites["locwindow"].viewport = @viewport
    @sprites["locwindow"].x = 0
    @sprites["locwindow"].y = 0
    @sprites["locwindow"].width = 228 if @sprites["locwindow"].width < 228
    @sprites["locwindow"].visible = true
  end
end