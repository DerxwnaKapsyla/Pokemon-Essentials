class DarknessSprite < Sprite
  def initialize(viewport = nil)
    super(viewport)
    @darkness = BitmapWrapper.new(Graphics.width, Graphics.height)
    @radius = radiusMin
    self.bitmap = @darkness
	#if $game_switches[105] == true
	if GameData::MapMetadata.get($game_map.map_id)&.has_flag?("LampreyBlindness")
	  self.z      = 1
	else
	  self.z      = 99998
	end
    refresh
  end
end