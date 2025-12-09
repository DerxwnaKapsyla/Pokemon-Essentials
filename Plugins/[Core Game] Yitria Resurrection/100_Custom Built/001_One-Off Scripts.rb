class Player
  class Pokedex
    def set_owned(species, should_refresh_dexes = true, value = true)
      species_id = GameData::Species.try_get(species)&.species
      return if species_id.nil?
      @owned[species_id] = value
      self.refresh_accessible_dexes if should_refresh_dexes
    end
  end
end

def pbShowPokedexEntry(species)
  $player.pokedex.set_owned(species)
    pbFadeOutIn {
      scene = PokemonPokedexInfo_Scene.new
      screen = PokemonPokedexInfoScreen.new(scene)
      screen.pbDexEntry(species)
    }
  $player.pokedex.set_owned(species, true, false)
end

def set_menu_theme(value)
  $game_temp.old_menu_frame = $PokemonSystem.frame
  MessageConfig.pbSetSystemFrame("Graphics/Windowskins/" + value)
end

def reset_menu_theme
  if $game_temp.old_menu_frame
    $PokemonSystem.frame = $game_temp.old_menu_frame
    MessageConfig.pbSetSystemFrame("Graphics/Windowskins/" + Settings::MENU_WINDOWSKINS[$PokemonSystem.frame])
  end
end

def pbBadgeGet(id)
  id_to_badge = ["Processor", "Crescent", "Nova", "Scorch",
                 "Placeholder", "Spectral", "Genesis", "Shell"]
  $player.badges[id] = true
  badge_name = id_to_badge[id]
  pbMessage("\\me[Badge get.ogg]" + _INTL("{1} received the \\c[1]{2} Badge\\c[0]!", $player.name, badge_name) + "\\wtnp[120]")
  # pbMessage("\\me[Badge get.ogg]" + _INTL("{1} received the <icon=badge{2}> \\c[1]{3} Badge\\c[0]!", $player.name, id + 1, badge_name) + "\\wtnp[120]")
end