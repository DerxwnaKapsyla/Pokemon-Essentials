# Just ensures that @real_x and @real_y are floats, to avoid rounding errors.

class Game_Character
  def screen_x
    ret = ((@real_x.to_f - self.map.display_x) / Game_Map::X_SUBPIXELS).round
    ret += @width * Game_Map::TILE_WIDTH / 2
    return ret
  end

  def screen_y_ground
    ret = ((@real_y.to_f - self.map.display_y) / Game_Map::Y_SUBPIXELS).round
    ret += Game_Map::TILE_HEIGHT
    return ret
  end
end
