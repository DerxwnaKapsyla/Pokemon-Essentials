class Game_Temp
  attr_accessor :enduredInKazami
  attr_accessor :inertItem

  def enduredInKazami
    @enduredInKazami = false if !@enduredInKazami
    return @enduredInKazami
  end
  
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