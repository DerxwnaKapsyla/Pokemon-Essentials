#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Removed explicit references to Pokemon.
#==============================================================================#

def pbRelicStone
  if !$Trainer.party.any? { |pkmn| pkmn.purifiable? }
    pbMessage(_INTL("You have nothing that can be purified."))
    return
  end
  pbMessage(_INTL("There's someone that may open the door to its heart!"))
  # Choose a purifiable Pokemon
  pbChoosePokemon(1, 2,proc { |pkmn|
    pkmn.able? && pkmn.shadowPokemon? && pkmn.heart_gauge == 0
  })
  if $game_variables[1] >= 0
    pbRelicStoneScreen($Trainer.party[$game_variables[1]])
  end
end

class PokeBattle_Battle
  alias __shadow__pbCanUseItemOnPokemon? pbCanUseItemOnPokemon?

  def pbCanUseItemOnPokemon?(item,pkmn,battler,scene,showMessages=true)
    ret = __shadow__pbCanUseItemOnPokemon?(item,pkmn,battler,scene,showMessages)
    if ret && pkmn.hyper_mode && ![:JOYSCENT, :EXCITESCENT, :VIVIDSCENT].include?(item)
      scene.pbDisplay(_INTL("This item can't be used on them."))
      return false
    end
    return ret
  end
end