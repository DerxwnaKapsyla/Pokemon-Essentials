class PokemonGlobalMetadata
  attr_accessor :sake
  attr_accessor :sake_counter
  
  alias lunarsake_initialize initialize
  def initialize
	lunarsake_initialize
	@sake_active = false
	@sake_counter = 0
  end
end

################################################################################
# Event handlers
################################################################################
EventHandlers.add(:on_player_step_taken, :sake_counter,
  proc {
    next if $PokemonGlobal.sake_counter <= 0
    next if $game_player.terrain_tag.ice
    $PokemonGlobal.sake_counter -= 1
    if $PokemonGlobal.sake_counter <= 300 && $PokemonGlobal.sake_active
      pbMessage(_INTL("The sake's effect wore off!"))
      $PokemonGlobal.sake_active = false
    end
  }
)

################################################################################
# Using the Ancient Lunar Sake
################################################################################
def pbCanUseLunarSake?
  # Can't use if a repellant is active
  if $PokemonGlobal.repel > 0
    pbMessage(_INTL("The effects of a repelant are currently lingering."))
    return false
  end
  # Can't use if sake is currently active
  if $PokemonGlobal.sake_active == true
    pbMessage(_INTL("The effect of the sake used earlier is still lingering."))
    return false
  end
  # Debug
  return true if $DEBUG && Input.press?(Input::CTRL)
  # Can't use Lunar Sake if it has run out and needs to refill
  if $PokemonGlobal.sake_counter && $PokemonGlobal.sake_counter > 0
    pbMessage(_INTL("The sake has run out!\nFor it to refill, you need to walk another {1} steps.",
                    $PokemonGlobal.pokeradarBattery))
    return false
  end
  return true
end

def pbUseLunarSake
  return false if !pbCanUseLunarSake?
  $PokemonGlobal.sake_counter = 600
  $PokemonGlobal.sake_active = true
  return true
end

################################################################################
# Item handlers
################################################################################
ItemHandlers::UseInField.add(:ANCIENTLUNARSAKE, proc { |item|
  next pbUseLunarSake
})

ItemHandlers::UseFromBag.add(:ANCIENTLUNARSAKE, proc { |item|
  next (pbCanUseLunarSake?) ? 2 : 0
})