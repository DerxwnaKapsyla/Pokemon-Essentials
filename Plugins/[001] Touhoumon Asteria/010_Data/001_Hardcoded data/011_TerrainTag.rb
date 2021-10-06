# Necessary for the Cerulean City Gym Platforms
module GameData
  class TerrainTag
    attr_reader :jump_platform
	attr_reader :landmine
	
	alias jumpplatform_initialize initialize
    def initialize(hash)
	  jumpplatform_initialize(hash)
      @jump_platform                  = hash[:jump_platform]                  || false
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