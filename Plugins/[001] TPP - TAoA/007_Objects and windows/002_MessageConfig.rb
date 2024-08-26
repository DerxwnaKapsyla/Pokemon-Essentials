def pbFadeOutAndHide_alt(sprites)
  duration = 4   # In seconds
  col = Color.new(255, 255, 255, 0)
  visiblesprites = {}
  pbDeactivateWindows(sprites) do
    timer_start = System.uptime
    loop do
      col.alpha = lerp(0, 255, duration, timer_start, System.uptime)
      pbSetSpritesToColor(sprites, col)
      (block_given?) ? yield : pbUpdateSpriteHash(sprites)
      break if col.alpha == 255
    end
  end
  sprites.each do |i|
	next if !i[1]
    next if pbDisposed?(i[1])
    visiblesprites[i[0]] = true if i[1].visible
    i[1].visible = false
  end
  return visiblesprites
end