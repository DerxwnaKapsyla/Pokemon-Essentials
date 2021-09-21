#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Removed explicit references to Pokemon
#	* Adds a check for Cerulean Gym's hopping puzzle
#==============================================================================#

def pbCheckAllFainted
  if $Trainer.able_pokemon_count == 0
    pbMessage(_INTL("You have no more party members that can fight!\1"))
    pbMessage(_INTL("You blacked out!"))
    pbBGMFade(1.0)
    pbBGSFade(1.0)
    pbFadeOutIn { pbStartOver }
  end
end

def pbLedge(_xOffset,_yOffset)
  if $game_player.pbFacingTerrainTag.ledge || ($game_player.pbFacingTerrainTag.jump_platform && !$PokemonGlobal.surfing)
    if pbJumpToward(2,true)
      $scene.spriteset.addUserAnimation(Settings::DUST_ANIMATION_ID,$game_player.x,$game_player.y,true,1)
      $game_player.increase_steps
      $game_player.check_event_trigger_here([1,2])
    end
    return true
  end
  return false
end