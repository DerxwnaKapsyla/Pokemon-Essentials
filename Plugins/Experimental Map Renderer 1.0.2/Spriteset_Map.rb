class Spriteset_Map
  def initialize(map=nil)
    @map = (map) ? map : $game_map
    $scene.map_renderer.add_tileset(@map.tileset_name)
    @map.autotile_names.each { |filename| $scene.map_renderer.add_autotile(filename) }
#    @tilemap = TilemapLoader.new(@@viewport1)
#    @tilemap.tileset = pbGetTileset(@map.tileset_name)
#    for i in 0...7
#      autotile_name = @map.autotile_names[i]
#      @tilemap.autotiles[i] = pbGetAutotile(autotile_name)
#    end
#    @tilemap.map_data = @map.data
#    @tilemap.priorities = @map.priorities
#    @tilemap.terrain_tags = @map.terrain_tags
    @panorama = AnimatedPlane.new(@@viewport0)
    @fog = AnimatedPlane.new(@@viewport1)
    @fog.z = 3000
    @character_sprites = []
    for i in @map.events.keys.sort
      sprite = Sprite_Character.new(@@viewport1,@map.events[i])
      @character_sprites.push(sprite)
    end
    @weather = RPG::Weather.new(@@viewport1)
    pbOnSpritesetCreate(self,@@viewport1)
    update
  end

  alias _animationSprite_initialize initialize
  def initialize(map=nil)
    @usersprites=[]
    _animationSprite_initialize(map)
  end

  def dispose
#    @tilemap.tileset.dispose
#    for i in 0...7
#      @tilemap.autotiles[i].dispose
#    end
#    @tilemap.dispose
    $scene.map_renderer.remove_tileset(@map.tileset_name)
    @map.autotile_names.each { |filename| $scene.map_renderer.remove_autotile(filename) }
    @panorama.dispose
    @fog.dispose
    for sprite in @character_sprites
      sprite.dispose
    end
    @weather.dispose
#    @tilemap = nil
    @panorama = nil
    @fog = nil
    @character_sprites.clear
    @weather = nil
  end

  def update
    if @panorama_name!=@map.panorama_name || @panorama_hue!=@map.panorama_hue
      @panorama_name = @map.panorama_name
      @panorama_hue  = @map.panorama_hue
      @panorama.setPanorama(nil) if @panorama.bitmap!=nil
      @panorama.setPanorama(@panorama_name,@panorama_hue) if @panorama_name!=""
      Graphics.frame_reset
    end
    if @fog_name!=@map.fog_name || @fog_hue!=@map.fog_hue
      @fog_name = @map.fog_name
      @fog_hue = @map.fog_hue
      @fog.setFog(nil) if @fog.bitmap!=nil
      @fog.setFog(@fog_name,@fog_hue) if @fog_name!=""
      Graphics.frame_reset
    end
    tmox = (@map.display_x/Game_Map::X_SUBPIXELS).round
    tmoy = (@map.display_y/Game_Map::Y_SUBPIXELS).round
#    @tilemap.ox = tmox
#    @tilemap.oy = tmoy
    @@viewport1.rect.set(0,0,Graphics.width,Graphics.height)
    @@viewport1.ox = 0
    @@viewport1.oy = 0
    @@viewport1.ox += $game_screen.shake
#    @tilemap.update
    @panorama.ox = tmox/2
    @panorama.oy = tmoy/2
    @fog.ox         = tmox+@map.fog_ox
    @fog.oy         = tmoy+@map.fog_oy
    @fog.zoom_x     = @map.fog_zoom/100.0
    @fog.zoom_y     = @map.fog_zoom/100.0
    @fog.opacity    = @map.fog_opacity
    @fog.blend_type = @map.fog_blend_type
    @fog.tone       = @map.fog_tone
    @panorama.update
    @fog.update
    for sprite in @character_sprites
      sprite.update
    end
    if self.map!=$game_map
      @weather.fade_in(:None, 0, 20)
    else
      @weather.fade_in($game_screen.weather_type, $game_screen.weather_max, $game_screen.weather_duration)
    end
    @weather.ox   = tmox
    @weather.oy   = tmoy
    @weather.update
    @@viewport1.tone = $game_screen.tone
    @@viewport3.color = $game_screen.flash_color
    @@viewport1.update
    @@viewport3.update
  end

  alias _animationSprite_update update
  def update
#    return if @tilemap.disposed?
#    pbDayNightTint(@tilemap)
    @@viewport3.tone.set(0,0,0,0)
    _animationSprite_update
    for i in 0...@usersprites.length
      @usersprites[i].update if !@usersprites[i].disposed?
    end
  end
end
