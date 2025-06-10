class Game_Temp
  attr_accessor :inertItem
  attr_accessor :old_menu_frame
  
  def inertItem
	@inertItem = false if !@inertItem
	return @inertItem
  end
end

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

def initialize_pwt_stats
  $stats.pwt_wins = {} if $stats.pwt_wins.nil? || $stats.pwt_wins.is_a?(Array)
  $stats.pwt_loss = {} if $stats.pwt_loss.nil? || $stats.pwt_loss.is_a?(Array)
  $stats.pwt_win_streak = {} if $stats.pwt_win_streak.nil? || $stats.pwt_win_streak.is_a?(Array)
  
    GameData::PWTTournament.each do |t|
      $stats.pwt_wins[t.id] = 0 if $stats.pwt_wins[t.id].nil?
	end
	
    GameData::PWTTournament.each do |t|
      $stats.pwt_loss[t.id] = 0 if $stats.pwt_loss[t.id].nil?
    end
	
    GameData::PWTTournament.each do |t|
      $stats.pwt_win_streak[t.id] = 0 if $stats.pwt_win_streak[t.id].nil?
    end
  
  $stats.pwt_wins[:Easy_Diff]       = 0
  $stats.pwt_loss[:Easy_Diff]       = 0
  $stats.pwt_win_streak[:Easy_Diff] = 0
  
  $stats.pwt_wins[:Normal_Diff]       = 0
  $stats.pwt_loss[:Normal_Diff]       = 0
  $stats.pwt_win_streak[:Normal_Diff] = 0
  
  $stats.pwt_wins[:Hard_Diff]       = 0
  $stats.pwt_loss[:Hard_Diff]       = 0
  $stats.pwt_win_streak[:Hard_Diff] = 0
  
  $stats.pwt_wins[:Lunatic_Diff]       = 0
  $stats.pwt_loss[:Lunatic_Diff]       = 0
  $stats.pwt_win_streak[:Lunatic_Diff] = 0
  
  $stats.pwt_wins[:Extra_Mode]       = 0
  $stats.pwt_loss[:Extra_Mode]       = 0
  $stats.pwt_win_streak[:Extra_Mode] = 0
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