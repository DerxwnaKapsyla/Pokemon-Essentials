class PokemonSave_Scene
  def pbStartScreen
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport.z = 99999
    @sprites = {}
    totalsec = $stats.play_time.to_i
    hour = totalsec / 60 / 60
    min = totalsec / 60 % 60
    mapname = $game_map.name
    if $player.male?
      text_tag = shadowc3tag(MALE_TEXT_BASE, MALE_TEXT_SHADOW)
    elsif $player.female?
      text_tag = shadowc3tag(FEMALE_TEXT_BASE, FEMALE_TEXT_SHADOW)
    else
      text_tag = shadowc3tag(OTHER_TEXT_BASE, OTHER_TEXT_SHADOW)
    end
    location_tag = shadowc3tag(LOCATION_TEXT_BASE, LOCATION_TEXT_SHADOW)
    loctext = location_tag + "<ac>" + mapname + "</ac></c3>"
    loctext += _INTL("Player") + "<r>" + text_tag + $player.name + "</c3><br>"
    if hour > 0
      loctext += _INTL("Time") + "<r>" + text_tag + _INTL("{1}h {2}m", hour, min) + "</c3><br>"
    else
      loctext += _INTL("Time") + "<r>" + text_tag + _INTL("{1}m", min) + "</c3><br>"
    end
	if $game_switches[105]
      loctext += _INTL("Badges") + "<r>" + text_tag + $player.badge_count.to_s + "</c3><br>"
	end
    if $player.has_pokedex
      loctext += _INTL("Pokédex") + "<r>" + text_tag + $player.pokedex.owned_count.to_s + "/" + $player.pokedex.seen_count.to_s + "</c3>"
    end
    @sprites["locwindow"] = Window_AdvancedTextPokemon.new(loctext)
    @sprites["locwindow"].viewport = @viewport
    @sprites["locwindow"].x = 0
    @sprites["locwindow"].y = 0
    @sprites["locwindow"].width = 228 if @sprites["locwindow"].width < 228
    @sprites["locwindow"].visible = true
  end
end