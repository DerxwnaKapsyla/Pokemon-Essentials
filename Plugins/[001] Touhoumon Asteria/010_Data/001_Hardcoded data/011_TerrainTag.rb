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

GameData::TerrainTag.register({
  :id                     => :Platform,
  :id_number              => 17,
  :shows_reflections	  => true,
  :can_surf				  => true,
  :jump_platform          => true
})

GameData::TerrainTag.register({
  :id                     => :Landmine,
  :id_number              => 99,
  :landmine		          => true
})