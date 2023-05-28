class Battle::Scene::PokemonDataBox < Sprite
  
  def draw_level
    return if $game_switches[103] && @battler.opposes?(0)
	# "Lv" graphic
    pbDrawImagePositions(self.bitmap,
      [["Graphics/Pictures/Battle/overlay_lv", @spriteBaseX + 140, 16]]
    )
    # Level number
    pbDrawNumber(@battler.level, self.bitmap, @spriteBaseX + 162, 16)
  end

end