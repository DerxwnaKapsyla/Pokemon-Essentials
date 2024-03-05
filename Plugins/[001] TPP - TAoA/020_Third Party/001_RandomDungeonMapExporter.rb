#===============================================================================
# Generates an image of a whole map. Optionally draws additional information on
# top of that image.
# Saves the image in the project's main folder.
# Images are generated at a scale of 16x16 pixels per tile.
# mode: 0 = map image only
#       1 = with passability information
#       2 = with priority tile information
#===============================================================================
def marMakePassabilityMapImage(map_data, suffix, tileset_id, mode = 0)
  tileset = $data_tilesets[tileset_id]

  map_priorities = tileset.priorities
  map_terrain_tags = tileset.terrain_tags

  tileset_graphic = pbGetTileset(tileset.tileset_name)
  autotile_graphics = []
  for i in 0...7
    autotile_graphics.push(pbGetAutotile(tileset.autotile_names[i]))
  end

  bitmap = Bitmap.new(map_data.width * 16, map_data.height * 16)
  # Draw the map into the bitmap
  for x in 0...map_data.width
    for y in 0...map_data.height
      # Get tiles from all layers at this position
      tiles = []
      for i in 0...3
        tile_id = map_data.data[x, y, i]
        next if !tile_id || tile_id == 0
        terrain = map_terrain_tags[tile_id] || 0
        tile_priority = map_priorities[tile_id] || 0
        tile_priority -= 10 if GameData::TerrainTag.try_get(terrain).shows_reflections
        tiles.push([tile_priority * 32 + i, tile_id])
      end
      # Sort the tiles by priority
      tiles.sort! { |a, b| a[0] <=> b[0] }
      # Draw tiles onto the bitmap
      tiles.each do |t|
        if t[1] < 384
          # Autotile tile
          graphic = autotile_graphics[(t[1] / 48) - 1]
          next if !graphic
          marDrawTileToBitmap(t[1], x, y, bitmap, graphic)
        else
          # Tileset tile
          marDrawTileToBitmap(t[1], x, y, bitmap, tileset_graphic)
        end
      end
    end
  end

  marDrawPassabilityOntoMapImage(map_data, tileset, bitmap) if mode == 1
  marDrawPriorityOntoMapImage(map_data, tileset, bitmap) if mode == 2

  # Save the map image
  prefix = ["map", "map_passability", "map_priority"][mode]
  bitmap.to_file(sprintf("%s_%03d.png", prefix, suffix))
end

def marDrawTileToBitmap(tile_id, x, y, bitmap, tileset_graphic)
  return if tile_id == 0
  if tile_id < 384
    # Autotile tile
    if tileset_graphic.height == 32
      # Simple autotile
      rect = Rect.new(0, 0, 32, 32)
      bitmap.stretch_blt(Rect.new(x * 16, y * 16, 16, 16), tileset_graphic, rect)
    else
      # Complex autotile; draw quarters
      tile_id %= 48
      tiles = TileDrawingHelper::AUTOTILE_PATTERNS[tile_id >> 3][tile_id & 7]
      src = Rect.new(0, 0, 0, 0)
      for i in 0...4
        tile_position = tiles[i] - 1
        src.set((tile_position % 6) * 16, (tile_position / 6) * 16, 16, 16)
        bitmap.stretch_blt(Rect.new((i % 2) * 8 + x * 16, (i / 2) * 8 + y * 16, 8, 8), tileset_graphic, src)
      end
    end
  else
    # Tileset tile
    rect = Rect.new((tile_id - 384) % 8 * 32, (tile_id - 384) / 8 * 32, 32, 32)
    bitmap.stretch_blt(Rect.new(x * 16, y * 16, 16, 16), tileset_graphic, rect)
  end
end

# Passability numbers:
# 0 = fully passable
# 1-14 = partially passable, sum of the following (if impassible in that dir):
#        1 down, 2 left, 4 right, 8 up
# 15 = fully impassable
# 16 = bridge
# 32 = water
# 64 = waterfall
# 128 = ice
def marDrawPassabilityOntoMapImage(map_data, tileset, bitmap)
  map_priorities = tileset.priorities
  map_passages = tileset.passages
  map_terrain_tags = tileset.terrain_tags

  calc_passabilities = []

  # Calculate all tile passabilities
  for x in 0...map_data.width
    calc_passabilities[x] = []
    for y in 0...map_data.height
      calc_passabilities[x][y] = 0
      for i in [2, 1, 0]
        tile_id = map_data.data[x, y, i]
        next if !tile_id || tile_id == 0
        terrain = map_terrain_tags[tile_id] || 0
        tag = GameData::TerrainTag.try_get(terrain)
        if tag.bridge
          # If bridge tile, remember this and check passability beneath. Make
          # bridges be yellow with either blue/red underneath depending on whether
          # the beneath is water/impassable respectively.
          calc_passabilities[x][y] += 16 if (calc_passabilities[x][y] & 16) == 0
        else
          if tag.can_surf_freely
            calc_passabilities[x][y] += 32 if (calc_passabilities[x][y] & 32) == 0
          elsif tag.waterfall || tag.waterfall_crest
            calc_passabilities[x][y] += 64 if (calc_passabilities[x][y] & 64) == 0
          elsif tag.ice
            calc_passabilities[x][y] += 128 if (calc_passabilities[x][y] & 128) == 0
          elsif !tag.ignore_passability
            passage = map_passages[tile_id] || 0
            priority = map_priorities[tile_id] || 0
            next if passage & 0x0f == 0 && priority > 0
            calc_passabilities[x][y] += passage & 15
          else
            next
          end
          break
        end
      end
    end
  end

  # Draw tile passabilities
  for x in 0...map_data.width
    for y in 0...map_data.height
      passage = calc_passabilities[x][y]
      # Draw terrain tagged tiles
      if (passage & 32) != 0   # Water
        marDrawHashedTile(bitmap, x, y, Color.new(0, 0, 255))
      elsif (passage & 64) != 0   # Waterfall
        marDrawHashedTile(bitmap, x, y, Color.new(0, 255, 255))
      elsif (passage & 128) != 0   # Ice
        marDrawHashedTile(bitmap, x, y, Color.new(255, 255, 255))
      end

      # Draw impassable/partially passable
      if (passage & 15) == 15   # Fully impassable
        marDrawHashedTile(bitmap, x, y, Color.new(192, 0, 0, 192))
#      elsif (passage & 15) != 0   # Partially passable
#        marDrawHashedTile(bitmap, x, y, Color.new(255, 0, 255))
      end

      # Draw borders betwen impassable and partially/fully passable
      if (passage & 15) != 0   # Not fully passable
        if x > 0
          marDrawTileBorder(bitmap, x, y, 4, passage, calc_passabilities[x - 1][y])
        end
        if x < map_data.width - 1
          marDrawTileBorder(bitmap, x, y, 6, passage, calc_passabilities[x + 1][y])
        end
        if y > 0
          marDrawTileBorder(bitmap, x, y, 8, passage, calc_passabilities[x][y - 1])
        end
        if y < map_data.height - 1
          marDrawTileBorder(bitmap, x, y, 2, passage, calc_passabilities[x][y + 1])
        end
      end

      # Draw bridges
      if (passage & 16) != 0   # Bridge
        marDrawHashedTile(bitmap, x, y, Color.new(255, 255, 0), 4)
      end

    end
  end

end

def marDrawPriorityOntoMapImage(map_data, tileset, bitmap)
  map_priorities = tileset.priorities
  # Draw all priority tile locations
  for x in 0...map_data.width
    for y in 0...map_data.height
      for i in [2, 1, 0]
        tile_id = map_data.data[x, y, i]
        next if !tile_id || tile_id == 0
        priority = map_priorities[tile_id] || 0
        next if priority == 0
        marDrawHashedTile(bitmap, x, y, Color.new(255, 0, 255))
        break
      end
    end
  end
end

def marDrawHashedTile(bitmap, x, y, color, density = 2)
  for i in 0...16
    for j in 0...16
      next if (i + j) % density != 0
      bitmap.fill_rect(x * 16 + i, y * 16 + j, 1, 1, color)
    end
  end
end

def marDrawTileBorder(bitmap, x, y, dir, this_passage, other_passage)
  bit = (1 << (dir / 2 - 1)) & 15
  return if (this_passage & bit) == 0   # Is passable in that direction
  inv_bit = (1 << ((10 - dir) / 2 - 1)) & 15

  should_draw = (this_passage & 15) != 15   # Is not completely impassable
  should_draw = (other_passage & 32) != 0 if !should_draw   # Next to water
  if !should_draw
    should_draw = (other_passage & inv_bit) == 0 &&   # Adj tile is passable to this one
                  (other_passage & 15) != 15   # Next to a partially/fully passable tile
  end
  return if !should_draw
  x_offset = [nil, nil, 0,  nil, 0,  nil, 12,  nil, 0][dir]
  y_offset = [nil, nil, 12, nil, 0,  nil, 0,  nil, 0][dir]
  x_width  = [nil, nil, 16, nil, 4,  nil, 4,  nil, 16][dir]
  y_width  = [nil, nil, 4,  nil, 16, nil, 16, nil, 4][dir]
  bitmap.fill_rect(x * 16 + x_offset, y * 16 + y_offset, x_width, y_width,
     Color.new(0, 0, 0))
end

#===============================================================================
# Add this to the debug menu.
#===============================================================================
MenuHandlers.add(:debug_menu, :make_map_image, {
  "name"        => _INTL("Make Map Images"),
  "parent"      => :main,
  "description" => _INTL("Generates a sample set of passability map graphics."),
  "always_show" => false,
  "effect"      => proc {
    number_of_images = 10
    dungeon_area = :forest_tpdp   # Can also be :forest

    dungeon_version = 0   # Don't need to change this
    tileset = { :cave => 7, :forest => 23 , :forest_tpdp => 44 , :cave_tpdp => 45 , :moon => 46}[dungeon_area]
    map = load_data(sprintf("Data/Map%03d.rxdata", 51))
    number_of_images.times do |i|
      # Generate a random dungeon
      tileset_data = GameData::DungeonTileset.try_get(tileset)
      params = GameData::DungeonParameters.try_get(dungeon_area, dungeon_version)
      dungeon = RandomDungeon::Dungeon.new(params.cell_count_x, params.cell_count_y,
                                           tileset_data, params)
      dungeon.generate
      map.width = dungeon.width
      map.height = dungeon.height
      map.data.resize(map.width, map.height, 3)
      dungeon.generateMapInPlace(map)
      # Make the screenshot
      marMakePassabilityMapImage(map, i + 1, tileset, 0)
    end
    pbMessage(_INTL("Done."))
  }
})
