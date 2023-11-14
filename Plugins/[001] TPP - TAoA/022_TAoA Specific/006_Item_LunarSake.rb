ItemHandlers::UseInField.add(:ANCIENTLUNARSAKE, proc { |item|
  if $PokemonGlobal.sake > 0
    pbMessage(_INTL("The effect of the sake used earlier is still lingering."))
    return false
  end
  if $PokemonGlobal.repel > 0
    pbMessage(_INTL("The effect of a repelant are currently in effect."))
    return false
  end
  pbUseItemMessage(item)
  $PokemonGlobal.sake = steps
  return true
end

class PokemonGlobalMetadata
  attr_accessor :sake
  attr_accessor :sake_refill
end

################################################################################
# Event handlers
################################################################################
EventHandlers.add(:on_player_step_taken, :sake_counter,
  proc {
    if ($PokemonGlobal.sake && $PokemonGlobal.sake_refill < 0) || !$game_player.terrain_tag.ice
	  $PokemonGlobal.sake_refill -= 1
	  if $PokemonGlobal.sake_refill == 300
	    pbMessage(_INTL("The sake's effect wore off!"))
	  elsif $PokemonGlobal.sake_refill <= 0
	    $PokemonGlobal.sake = false
	  end
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
  if $PokemonGlobal.sake == true
    pbMessage(_INTL("The effect of the sake used earlier is still lingering."))
    return false
  end
  # Debug
  return true if $DEBUG && Input.press?(Input::CTRL)
  # Can't use Lunar Sake if it has run out and needs to refill
  if $PokemonGlobal.sake_refill && $PokemonGlobal.sake_refill > 0
    pbMessage(_INTL("The sake has run out!\nFor it to refill, you need to walk another {1} steps.",
                    $PokemonGlobal.pokeradarBattery))
    return false
  end
  return true
end

def pbUseLunarSake
  return false if !pbCanUseLunarSake?
  $PokemonGlobal.sake_refill = 600
  $PokemonGlobal.sake = true
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