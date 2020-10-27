#-------------------------------------------------------------------------------
# Boon's Terrain Tag Side Stairs
# v1.1
# By Boonzeet
#-------------------------------------------------------------------------------
# Sideways stairs with pseudo 'depth' effect. Please credit if used
#-------------------------------------------------------------------------------
# v1.1 - Added v18 support
#-------------------------------------------------------------------------------

PluginManager.register({
  :name => "Terrain Tag Side Stairs",
  :version => "1.1",
  :credits => ["Boonzeet"],
  :link => "https://reliccastle.com/resources/397/"
})

#-------------------------------------------------------------------------------
# Config
#-------------------------------------------------------------------------------
module PBTerrain
  StairLeft       = 21  # Set these to the terrain tags you'd like to use
  StairRight      = 20
end

#-------------------------------------------------------------------------------
# Existing Class Extensions
#-------------------------------------------------------------------------------
def pbTurnTowardEvent(event,otherEvent)
  sx = 0; sy = 0
  if $MapFactory
    relativePos=$MapFactory.getThisAndOtherEventRelativePos(otherEvent,event)
    sx = relativePos[0]
    sy = relativePos[1]
  else
    sx = event.x - otherEvent.x
    sy = event.y - otherEvent.y
  end
  return if sx == 0 and sy == 0
  if sx.abs >= sy.abs #added
    (sx > 0) ? event.turn_left : event.turn_right
  else
    (sy > 0) ? event.turn_up : event.turn_down
  end
end

class Game_Character
  alias initialize_stairs initialize
  attr_accessor :offset_x
  attr_accessor :offset_y
  attr_accessor :real_offset_x
  attr_accessor :real_offset_y
 
  def initialize(*args)
    @offset_x = 0
    @offset_y = 0
    @real_offset_x = 0
    @real_offset_y = 0
    initialize_stairs(*args)
  end
 
  alias screen_x_stairs screen_x
  def screen_x
    @real_offset_x = 0 if @real_offset_x == nil
    return screen_x_stairs + @real_offset_x
  end
   
  alias screen_y_stairs screen_y
  def screen_y
    @real_offset_y = 0 if @real_offset_y == nil
    return screen_y_stairs + @real_offset_y
  end

  alias updatemovestairs update_move
  def update_move
    # compatibility with existing saves
    if @real_offset_x == nil || @real_offset_y == nil || @offset_y == nil || @offset_x == nil
      @real_offset_x = 0
      @real_offset_y = 0
      @offset_x = 0
      @offset_y = 0
    end
    
    if @real_offset_x != @offset_x || @real_offset_y != @offset_y
      @real_offset_x = @real_offset_x-2 if  @real_offset_x>@offset_x
      @real_offset_x = @real_offset_x+2 if  @real_offset_x<@offset_x
      @real_offset_y = @real_offset_y+2 if  @real_offset_y<@offset_y
      @real_offset_y = @real_offset_y-2 if  @real_offset_y>@offset_y
    end
    updatemovestairs
  end
  
  alias movetostairs moveto
  def moveto(x,y)
    @real_offset_x = 0
    @real_offset_y = 0
    @offset_x = 0
    @offset_y = 0
    movetostairs(x,y)
  end

end

class Game_Character
   alias move_left_stairs move_left
   def move_left(turn_enabled = true)
    move_left_stairs(turn_enabled)
    if self.map.terrain_tag(@x,@y) == PBTerrain::StairLeft || self.map.terrain_tag(@x,@y) == PBTerrain::StairRight
      @offset_y = -16
    else
      @offset_y = 0
    end
  end
 
  alias move_right_stairs move_right
  def move_right(turn_enabled = true)
    move_right_stairs(turn_enabled)
    if self.map.terrain_tag(@x,@y) == PBTerrain::StairLeft || self.map.terrain_tag(@x,@y) == PBTerrain::StairRight
      @offset_y = -16
    else
      @offset_y = 0
    end
  end
end

class Game_Player 
  alias move_left_stairs move_left
   def move_left(turn_enabled = true)
    old_tag = self.map.terrain_tag(@x, @y)
    old_through = self.through
    old_x = @x
    if old_tag == PBTerrain::StairLeft
      if passable?(@x-1, @y+1, 4) && self.map.terrain_tag(@x-1,@y+1) == PBTerrain::StairLeft
        @y += 1
        self.through = true
      end
    elsif old_tag == PBTerrain::StairRight
      if passable?(@x-1, @y-1, 6)
        @y -= 1
        self.through = true
      end
    end
    move_left_stairs(turn_enabled)
    new_tag = self.map.terrain_tag(@x, @y)
    if old_x != @x
      if old_tag != PBTerrain::StairLeft && new_tag == PBTerrain::StairLeft ||
        old_tag != PBTerrain::StairRight && new_tag == PBTerrain::StairRight
        self.offset_y = -16
        @y += 1 if new_tag == PBTerrain::StairLeft
      elsif old_tag == PBTerrain::StairLeft && new_tag != PBTerrain::StairLeft ||
        old_tag == PBTerrain::StairRight && new_tag != PBTerrain::StairRight
        self.offset_y = 0
      end
    end
    self.through = old_through
  end
 
  alias move_right_stairs move_right
  def move_right(turn_enabled = true)
    old_tag = self.map.terrain_tag(@x, @y)
    old_through = self.through
    old_x = @x
    if old_tag == PBTerrain::StairLeft && passable?(@x+1, @y-1, 4)
      @y -= 1
      self.through = true
    elsif old_tag == PBTerrain::StairRight && passable?(@x+1, @y+1, 6)&& self.map.terrain_tag(@x+1,@y+1) == PBTerrain::StairRight
      @y += 1
      self.through = true
    end
    move_right_stairs(turn_enabled)
    new_tag = self.map.terrain_tag(@x, @y)
    if old_x != @x
      if old_tag != PBTerrain::StairLeft && new_tag == PBTerrain::StairLeft ||
        old_tag != PBTerrain::StairRight && new_tag == PBTerrain::StairRight
        self.offset_y = -16
        @y += 1 if new_tag == PBTerrain::StairRight
      elsif old_tag == PBTerrain::StairLeft && new_tag != PBTerrain::StairLeft ||
        old_tag == PBTerrain::StairRight && new_tag != PBTerrain::StairRight
        self.offset_y = 0
      end
    end
    self.through = old_through
  end
 
  alias center_stairs center
  def center(x,y)
    center_stairs(x,y)
    self.map.display_x = self.map.display_x + (@offset_x || 0)
    self.map.display_y = self.map.display_y + (@offset_y || 0)
  end
 
  def passable?(x, y, d)
    # Get new coordinates
    new_x = x + (d == 6 ? 1 : d == 4 ? -1 : 0)
    new_y = y + (d == 2 ? 1 : d == 8 ? -1 : 0)
    # If coordinates are outside of map
    unless $game_map.validLax?(new_x, new_y)
      # Impassable
      return false
    end
    if !$game_map.valid?(new_x, new_y)
      return false if !$MapFactory
      return $MapFactory.isPassableFromEdge?(new_x, new_y)
    end
    # If debug mode is ON and ctrl key was pressed
    if $DEBUG and Input.press?(Input::CTRL)
      # Passable
      return true
    elsif d == 8 && new_y > 0 # prevent player moving up past the top of the stairs
      if $game_map.terrain_tag(new_x, new_y) == PBTerrain::StairLeft &&
        $game_map.terrain_tag(new_x, new_y-1) != PBTerrain::StairLeft
        return false
      elsif $game_map.terrain_tag(new_x, new_y) == PBTerrain::StairRight &&
        $game_map.terrain_tag(new_x, new_y-1) != PBTerrain::StairRight
        return false
      end
    end
    super
  end
end

