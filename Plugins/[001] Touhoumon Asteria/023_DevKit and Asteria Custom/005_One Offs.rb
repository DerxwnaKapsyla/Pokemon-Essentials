# A file for a bunch of random one-offs for Asteria

class PokemonTemp
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

def pbFillBox
    added = 0
    box_qty = $PokemonStorage.maxPokemon(0)
    completed = true
    GameData::Species.each do |species_data|
      sp = species_data.species
      f = species_data.form
      # Record each form of each species as seen and owned
      if f == 0
        if [:AlwaysMale, :AlwaysFemale, :Genderless].include?(species_data.gender_ratio)
          g = (species_data.gender_ratio == :AlwaysFemale) ? 1 : 0
          $Trainer.pokedex.register(sp, g, f, false)
        else   # Both male and female
          $Trainer.pokedex.register(sp, 0, f, false)
          $Trainer.pokedex.register(sp, 1, f, false)
        end
        $Trainer.pokedex.set_owned(sp, false)
      elsif species_data.real_form_name && !species_data.real_form_name.empty?
        g = (species_data.gender_ratio == :AlwaysFemale) ? 1 : 0
        $Trainer.pokedex.register(sp, g, f, false)
      end
      # Add Pokémon (if form 0, i.e. one of each species)
      next if f != 0
      if added >= Settings::NUM_STORAGE_BOXES * box_qty
        completed = false
        next
      end
      added += 1
      $PokemonStorage[(added - 1) / box_qty, (added - 1) % box_qty] = Pokemon.new(sp, 50)
    end
    $Trainer.pokedex.refresh_accessible_dexes
    pbMessage(_INTL("Storage boxes were filled with one Pokémon of each species."))
    if !completed
      pbMessage(_INTL("Note: The number of storage spaces ({1} boxes of {2}) is less than the number of species.",
         Settings::NUM_STORAGE_BOXES, box_qty))
    end
end