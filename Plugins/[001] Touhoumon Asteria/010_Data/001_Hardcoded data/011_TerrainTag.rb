# Necessary for the Custom Terrain Tags (like in Cerulean and Vermilion Gym)
module GameData
  class TerrainTag
    attr_reader :jump_platform
	attr_reader :landmine
	
	alias asteria_initialize initialize
    def initialize(hash)
	  asteria_initialize(hash)
      @jump_platform                  = hash[:jump_platform]             || false
	  @landmine		                  = hash[:landmine]                  || false
	end
  end
end


# Used for tiles that exist but have no effect, meaning they can
# go over water and grass and not trigger tiles underneath.
# This is coming in a future version of Essentials.
GameData::TerrainTag.register({
  :id                     => :NoEffect,
  :id_number              => 17
})


GameData::TerrainTag.register({
  :id                     => :Platform,
  :id_number              => 30,
  :shows_reflections	  => true,
  :can_surf				  => true,
  :jump_platform          => true
})


GameData::TerrainTag.register({
  :id                     => :Landmine,
  :id_number              => 31,
  :landmine		          => true
})