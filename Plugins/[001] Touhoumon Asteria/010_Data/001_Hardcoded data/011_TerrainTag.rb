# Necessary for the Cerulean City Gym Platforms
module GameData
  class TerrainTag
    attr_reader :jump_platform
	
	alias jumpplatform_initialize initialize
    def initialize(hash)
	  jumpplatform_initialize(hash)
      @jump_platform                  = hash[:jump_platform]                  || false
	end
  end
end

GameData::TerrainTag.register({
  :id                     => :Platform,
  :id_number              => 17,
  :shows_reflections	  => true,
  :can_surf				  => true,
  :jump_platform          => true
})

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