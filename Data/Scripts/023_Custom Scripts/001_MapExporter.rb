#===============================================================================
# ■ Fast Map Exporter by KleinStudio V1.1
# http://pokemonfangames.com
#
# ** Keys
# Control + P * Save current map with events and player
# Control + E * Save current map with events
# Alt + M     * Save current map (only the map)
#
# ** Saving not current maps
#   *** While pressing control, type with the numbers keys a map id.
# Control + Map id * Save selected map with events
#    Alt + Map id  * Save selected map (only the map)
#===============================================================================
SAVED_MAP_SCALE =  1
SAVE_REFLECTED_SPRITES = true

# The next settings are for the supported custom scripts, you can find them in
# http://pokemonfangames.com
SAVE_FOOTPRINTS = true
SAVE_SHADOWS = true
SAVE_WATERBUBBLES = true


#===============================================================================
# Zeus81's Bitmap Exporter
# This will allow to save the bitmap
#===============================================================================
class Bitmap
  RtlMoveMemory = Win32API.new('kernel32', 'RtlMoveMemory', 'ppi', 'i')
  def last_row_address
    return 0 if disposed?
    RtlMoveMemory.call(buf=[0].pack('L'), __id__*2+16, 4)
    RtlMoveMemory.call(buf, buf.unpack('L')[0]+8 , 4)
    RtlMoveMemory.call(buf, buf.unpack('L')[0]+16, 4)
    buf.unpack('L')[0]
  end
  def bytesize
    width * height * 4
  end
  def get_data
    data = [].pack('x') * bytesize
    RtlMoveMemory.call(data, last_row_address, data.bytesize)
    data
  end
  def set_data(data)
    RtlMoveMemory.call(last_row_address, data, data.bytesize)
  end
  def get_data_ptr
    data = String.new
    RtlMoveMemory.call(data.__id__*2, [0x2007].pack('L'), 4)
    RtlMoveMemory.call(data.__id__*2+8, [bytesize,last_row_address].pack('L2'), 8)
    def data.free() RtlMoveMemory.call(__id__*2, String.new, 16) end
    return data unless block_given?
    yield data ensure data.free
  end
  def _dump(level)
    get_data_ptr do |data|
      dump = Marshal.dump([width, height, Zlib::Deflate.deflate(data, 9)])
      dump
    end
  end
  def self._load(dump)
    width, height, data = *Marshal.load(dump)
    data.replace(Zlib::Inflate.inflate(data))
    bitmap = new(width, height)
    bitmap.set_data(data)
    bitmap
  end
  def export(filename)
    export_png("#{filename}.png")
  end
  def export_png(filename)
    data, i = get_data, 0
      (0).step(data.bytesize-4, 4) do |i|
        data[i,3] = data[i,3].reverse!
    end
    deflate = Zlib::Deflate.new(9)
      null_char, w4 = [].pack('x'), width*4
      (data.bytesize-w4).step(0, -w4) {|i| deflate << null_char << data[i,w4]}
      data.replace(deflate.finish)
    deflate.close
    File.open(filename, 'wb') do |file|
      def file.write_chunk(chunk)
        write([chunk.bytesize-4].pack('N'))
        write(chunk)
        write([Zlib.crc32(chunk)].pack('N'))
      end
      file.write("\211PNG\r\n\32\n")
      file.write_chunk(['IHDR',width,height,8,6,0,0,0].pack('a4N2C5'))
      file.write_chunk(data.insert(0, 'IDAT'))
      file.write_chunk('IEND')
    end
  end
end

class String
  alias getbyte  []
  alias setbyte  []=
  alias bytesize size
end
 
class Font
  def marshal_dump()     end
  def marshal_load(dump) end
end

module Graphics
    FindWindow             = Win32API.new('user32', 'FindWindow'            , 'pp'       , 'i')
    GetDC                  = Win32API.new('user32', 'GetDC'                 , 'i'        , 'i')
    ReleaseDC              = Win32API.new('user32', 'ReleaseDC'             , 'ii'       , 'i')
    BitBlt                 = Win32API.new('gdi32' , 'BitBlt'                , 'iiiiiiiii', 'i')
    CreateCompatibleBitmap = Win32API.new('gdi32' , 'CreateCompatibleBitmap', 'iii'      , 'i')
    CreateCompatibleDC     = Win32API.new('gdi32' , 'CreateCompatibleDC'    , 'i'        , 'i')
    DeleteDC               = Win32API.new('gdi32' , 'DeleteDC'              , 'i'        , 'i')
    DeleteObject           = Win32API.new('gdi32' , 'DeleteObject'          , 'i'        , 'i')
    GetDIBits              = Win32API.new('gdi32' , 'GetDIBits'             , 'iiiiipi'  , 'i')
    SelectObject           = Win32API.new('gdi32' , 'SelectObject'          , 'ii'       , 'i')
    def self.snap_to_bitmap
      bitmap  = Bitmap.new(width, height)
      info    = [40,width,height,1,32,0,0,0,0,0,0].pack('LllSSLLllLL')
      hDC     = GetDC.call(hwnd)
      bmp_hDC = CreateCompatibleDC.call(hDC)
      bmp_hBM = CreateCompatibleBitmap.call(hDC, width, height)
      bmp_obj = SelectObject.call(bmp_hDC, bmp_hBM)
      BitBlt.call(bmp_hDC, 0, 0, width, height, hDC, 0, 0, 0xCC0020)
      GetDIBits.call(bmp_hDC, bmp_hBM, 0, height, bitmap.last_row_address, info, 0)
      SelectObject.call(bmp_hDC, bmp_obj)
      DeleteObject.call(bmp_hBM)
      DeleteDC.call(bmp_hDC)
      ReleaseDC.call(hwnd, hDC)
      bitmap
  end
    
  class << self
    def hwnd() @hwnd ||= FindWindow.call('RGSS Player', nil) end
    def width()  640 end unless method_defined?(:width)
    def height() 480 end unless method_defined?(:height)
    def export(filename=Time.now.strftime("snapshot %Y-%m-%d %Hh%Mm%Ss #{frame_count}"))
      bitmap = snap_to_bitmap
      bitmap.export(filename)
      bitmap.dispose
    end
    alias save     export
    alias snapshot export
  end
end

#===============================================================================
# Game_Map Edit
#===============================================================================

class Game_Map
  def getMapIdSave
    @mapToSave="" if !@mapToSave

    if Input.pressex?(0x11) 
      @pressedForMap1 = true
      if Input.triggerex?(0x30)
        @mapToSave+="0"
      elsif Input.triggerex?(0x31)
        @mapToSave+="1"
      elsif Input.triggerex?(0x32)
        @mapToSave+="2"
      elsif Input.triggerex?(0x33)
        @mapToSave+="3"
      elsif Input.triggerex?(0x34)
        @mapToSave+="4"
      elsif Input.triggerex?(0x35)
        @mapToSave+="5"
      elsif Input.triggerex?(0x36)
        @mapToSave+="6"
      elsif Input.triggerex?(0x37)
        @mapToSave+="7"
      elsif Input.triggerex?(0x38)
        @mapToSave+="8"
      elsif Input.triggerex?(0x39)
        @mapToSave+="9"
      end
    elsif Input.pressex?(0x12) 
      @pressedForMap2 = true
      if Input.triggerex?(0x30)
        @mapToSave+="0"
      elsif Input.triggerex?(0x31)
        @mapToSave+="1"
      elsif Input.triggerex?(0x32)
        @mapToSave+="2"
      elsif Input.triggerex?(0x33)
        @mapToSave+="3"
      elsif Input.triggerex?(0x34)
        @mapToSave+="4"
      elsif Input.triggerex?(0x35)
        @mapToSave+="5"
      elsif Input.triggerex?(0x36)
        @mapToSave+="6"
      elsif Input.triggerex?(0x37)
        @mapToSave+="7"
      elsif Input.triggerex?(0x38)
        @mapToSave+="8"
      elsif Input.triggerex?(0x39)
        @mapToSave+="9"
      end
    end 

  end
  
  alias klein_savemap_miniupdate update
  def update
    klein_savemap_miniupdate
    if $DEBUG
      # Control + P - Save current map with events and player
      if Input.pressex?(0x11) && Input.triggerex?(0x50) 
        pbSaveMapGraphic($game_map,true,true)
      # Control + E - Save current map with events
      elsif Input.pressex?(0x11) && Input.triggerex?(0x45) 
        pbSaveMapGraphic($game_map,true)
      # Alt + M - Save current map 
      elsif Input.pressex?(0x12) && Input.triggerex?(0x4D) 
        pbSaveMapGraphic($game_map)
      end
      
      getMapIdSave
      
      if !Input.pressex?(0x11) && @pressedForMap1
        if pbRgssExists?(sprintf("Data/Map%03d.rxdata",@mapToSave.to_i))
          map=$MapFactory.getMapNoAdd(@mapToSave.to_i)
          pbSaveMapGraphic(map,true)
        end
        @mapToSave=""
        @pressedForMap1=false
      elsif !Input.pressex?(0x12) && @pressedForMap2
        if pbRgssExists?(sprintf("Data/Map%03d.rxdata",@mapToSave.to_i))
          map=$MapFactory.getMapNoAdd(@mapToSave.to_i)
          pbSaveMapGraphic(map)
        end
        @mapToSave=""
        @pressedForMap2=false
      end
      
    end
  end
end

#===============================================================================
# Support for Klein's Footprints script
#===============================================================================
if defined?(Footsprite)
  class Spriteset_Map
    attr_accessor :footsprites
  end
  
  class Footsprite
    def pbGetSaveMapData
      return false if @disposed
      return [@sprite,@event.x,@event.y] 
    end
  end
end
#===============================================================================
# Support for Klein's Water Bubbles script
#===============================================================================
if defined?(WaterAnim)
  class Spriteset_Map
    attr_accessor :waterSprites
  end

  class WaterAnim
    def pbGetSaveMapData
      return false if @disposed or !isInWaterTileId
      return [@actualBitmap,@event.x,@event.y] 
    end
  
    def pbGetEvent
      return @event 
    end
  end
end
#===============================================================================
# Support for Klein's Overworld Shadows Script
#===============================================================================
if defined?(ShadowSprite)
  class Spriteset_Map
    attr_accessor :shadowSprites
  end
  
  class ShadowSprite
    def pbGetSaveMapData
      return false if @disposed or !@sprite.visible
      return [@sprite.bitmap,@event.x,@event.y,@sprite.opacity] 
    end
  
    def pbGetEvent
      return @event
    end
  end
end

#===============================================================================
# Support for Reflected Sprites
#===============================================================================
if defined?(ReflectedSprite)
  class Spriteset_Map
    attr_accessor :reflectedSprites
  end

  class ReflectedSprite
    def pbGetSaveMapData
      return false if @disposed or @sprite.nil? or !@sprite.visible
      return [@sprite,@event.x,@event.y,@sprite.opacity,@rsprite,@event.tile_id>=384,@event] 
    end
  
    def pbGetEvent
      return @event
    end
  end
end

#===============================================================================
# Function to create the bitmap
#===============================================================================

def pbSaveMapGraphic(realmap,saveEvents=false, savePlayer=false)
  map = load_data(sprintf("Data/Map%03d.rxdata", realmap.map_id))
  bitmap=BitmapWrapper.new(map.width*32,map.height*32)
  tilesets=load_data("Data/Tilesets.rxdata")
  tileset=tilesets[map.tileset_id]  
  priorities=tileset.priorities
  
  helper=TileDrawingHelper.fromTileset(tileset)
  for y in 0...map.height
    for x in 0...map.width
      for z in 0..2
        id=map.data[x,y,z]
        id=0 if !id
        helper.bltTile(bitmap,x*32,y*32,id) if priorities[id]==0
      end
    end
  end
  
  if defined?(Footsprite) && SAVE_FOOTPRINTS
    if realmap==$game_map
      if $scene.spriteset && $scene.spriteset.footsprites
        for sprite in $scene.spriteset.footsprites
          data=sprite.pbGetSaveMapData
          if data
            sp=data[0]
            bitmap.blt((data[1]+1)*32.0-sp.src_rect.width/2-16,(data[2]+1)*32-sp.bitmap.height,sp.bitmap,
            Rect.new(sp.src_rect.x,0,sp.src_rect.width,sp.src_rect.height),sp.opacity)
          end
        end
      end
    end
  end
  
  characters=[]
  for event in realmap.events.values
    characters.push(event)
  end
  
  characters.push($game_player) if savePlayer && realmap==$game_map
  characters.sort!{|a,b| a.y<=>b.y}

  if defined?(ReflectedSprite) && saveEvents && SAVE_REFLECTED_SPRITES
    if realmap==$game_map
      if $scene.spriteset && $scene.spriteset.reflectedSprites
        for sprite in $scene.spriteset.reflectedSprites
          data=sprite.pbGetSaveMapData
          
          if data
            next if data[6]==$game_player && !savePlayer
            sp=data[0]
            plus=sp.y-data[4].y
            
            width = data[5] ? 32 : sp.bitmap.width / 4
            height = data[5] ? 32 : sp.bitmap.height / 4
            
            rbitmap=makeReflectedBitmap(sp,data[5])
            
            bitmap.blt((data[1]+1)*32.0-width/2-16,(data[2]+1)*32-height+plus+height/2,rbitmap,
            Rect.new(0,0,width,height),sp.opacity)
          end
        end
      end
    end
  end
  
  if saveEvents
    for i in 0..characters.length
      if characters[i]
        
        if defined?(ShadowSprite) && SAVE_SHADOWS
          if $scene.spriteset && $scene.spriteset.shadowSprites
            for e in 0...$scene.spriteset.shadowSprites.length
              actual=$scene.spriteset.shadowSprites[e]
              data=actual.pbGetSaveMapData if actual.pbGetEvent==characters[i]
            end
            if data
              sp=data[0]
              bitmap.blt((data[1]+1)*32.0-sp.width/2-16,(data[2]+1)*32-sp.height+4-2,sp,
              Rect.new(0,0,sp.width,sp.height),data[3])
            end
          end
        end

        dollEvent=characters[i]
        if dollEvent.tile_id>=384 # It's a tile, not a Character
          dollBitmap=pbGetTileBitmap(dollEvent.map.tileset_name,
          dollEvent.tile_id,dollEvent.character_hue)
          width = 32
          height = 32
          sx = 0
          sy = 0
        else # Character
          dollBitmap=AnimatedBitmap.new("Graphics/Characters/"+dollEvent.character_name,
          dollEvent.character_hue)
          width = dollBitmap.width / 4
          height = dollBitmap.height / 4
          sx = dollEvent.pattern * width
          sy = (dollEvent.direction - 2) / 2 * height
        end
        
        charBitmap=dollEvent.tile_id>=384 ? dollBitmap : dollBitmap.bitmap
        
        if dollEvent.tile_id<384 && deepBushForSave?(dollEvent.x,dollEvent.y,tileset.passages,tileset.terrain_tags,realmap.data)
          bushBitmap=BushMapBitmap.new(dollBitmap,dollEvent.tile_id>=384,32)
          bitmap.blt((dollEvent.x+1)*32-width/2-16,(dollEvent.y+1)*32-height,bushBitmap.bitmap,Rect.new(sx,sy,width,height))
        elsif dollEvent.tile_id<384 && bushForSave?(dollEvent.x,dollEvent.y,tileset.passages,tileset.terrain_tags,realmap.data)
          bushBitmap=BushMapBitmap.new(dollBitmap,dollEvent.tile_id>=384,12)
          bitmap.blt((dollEvent.x+1)*32-width/2-16,(dollEvent.y+1)*32-height,bushBitmap.bitmap,Rect.new(sx,sy,width,height))
        else
          bitmap.blt((dollEvent.x+1)*32-width/2-16,(dollEvent.y+1)*32-height,charBitmap,Rect.new(sx,sy,width,height))
        end
        
        if defined?(WaterAnim) && SAVE_WATERBUBBLES
          if realmap==$game_map
            if $scene.spriteset && $scene.spriteset.waterSprites
              for e in 0...$scene.spriteset.waterSprites.length
                actual=$scene.spriteset.waterSprites[e]
                if actual.respond_to?("pbGetEvent")
                  dataw=actual.pbGetSaveMapData if actual.pbGetEvent==characters[i]
                end
              end
              if dataw
                sp=dataw[0]
                bitmap.blt((dataw[1]+1)*32.0-sp.width/2-16,(dataw[2]+1)*32-sp.height+4,sp,
                Rect.new(0,0,sp.width,sp.height))
              end
            end
          end
        end
      end
    end
  end
    
  for y in 0...map.height
    for x in 0...map.width
      for z in 0..2
        id=map.data[x,y,z]
        id=0 if !id
        helper.bltTile(bitmap,x*32,y*32,id) if priorities!=nil && priorities[id]!=nil && priorities[id]>0
      end
    end
  end
  
  unless FileTest.directory?("SavedMaps")
    Dir.mkdir("SavedMaps")
  end
    
  scaleBitmap=BitmapWrapper.new(bitmap.width*SAVED_MAP_SCALE,bitmap.height*SAVED_MAP_SCALE)
  scaleBitmap.stretch_blt(Rect.new(0,0,bitmap.rect.width*SAVED_MAP_SCALE,bitmap.rect.height*SAVED_MAP_SCALE),bitmap,bitmap.rect)
  
  fileName=sprintf("#{pbGetMapNameFromId(realmap.map_id)}")
  fileName+=" with events" if saveEvents
  fileName+=" and player" if savePlayer
  scaleBitmap.export(sprintf("SavedMaps/#{fileName}"))
  return scaleBitmap
end

def bushForSave?(x, y, passages, terrains, data)
  for i in [2, 1, 0]
    tile_id = data[x, y, i]
    if tile_id == nil
      return false
    elsif terrains[tile_id]==PBTerrain::Bridge && $PokemonMap &&
      $PokemonMap.bridge>0
      return false
    elsif passages[tile_id] & 0x40 == 0x40
      return true
    end
  end
  return false
end

def deepBushForSave?(x, y, passages, terrains, data)
  for i in [2, 1, 0]
    tile_id = data[x, y, i]
    if tile_id == nil
      return false
    elsif terrains[tile_id]==PBTerrain::Bridge && $PokemonMap &&
      $PokemonMap.bridge>0
      return false
    elsif passages[tile_id] & 0x40 == 0x40 &&
      terrains[tile_id]==PBTerrain::TallGrass
      return true
    end
  end
  return false
end

class BushMapBitmap
  def initialize(bitmap,isTile,depth)
    @bitmaps=[]
    @bitmap=bitmap
    @isTile=isTile
    @isBitmap=@bitmap.is_a?(Bitmap)
    @depth=depth
  end

  def dispose
    for b in @bitmaps
      b.dispose if b
    end
  end

  def bitmap
    thisBitmap=@isBitmap ? @bitmap : @bitmap.bitmap
    current=@isBitmap ? 0 : @bitmap.currentIndex
    if !@bitmaps[current]
      if @isTile
        @bitmaps[current]=Sprite_Character.pbBushDepthTile(thisBitmap,@depth)
      else
        @bitmaps[current]=Sprite_Character.pbBushDepthBitmap(thisBitmap,@depth)
      end
    end
    return @bitmaps[current]
  end
end

class BitmapData
  def initialize(x,y,color)
    @x=x
    @y=y
    @color=color
  end
  def x; return @x; end
  def y; return @y; end
  def color; return @color; end
end
  
def makeReflectedBitmap(sprite,isTile)
  width = isTile ? 32 : sprite.bitmap.width / 4
  height = isTile ? 32 : sprite.bitmap.height / 4

  bitmap=sprite.bitmap
  newBitmap=Bitmap.new(width,height)
  colorBitmap=Bitmap.new(width,height)
  bitmapdata=[]
  
  for x in 0...width
    for y in 0...height
      color=bitmap.get_pixel(sprite.src_rect.x+x,sprite.src_rect.y+y)
      bitmapdata.push(BitmapData.new(x,height-y,color))
    end
  end
    
  for data in bitmapdata
    x=data.x
    y=data.y
    c=data.color
    newBitmap.set_pixel(x,y,c)
    colorBitmap.set_pixel(x,y,Color.new(248,248,248)) if c.alpha!=0
  end
  newBitmap.blt(0,0,colorBitmap,Rect.new(0,0,colorBitmap.width,colorBitmap.height),96)
  return newBitmap
end