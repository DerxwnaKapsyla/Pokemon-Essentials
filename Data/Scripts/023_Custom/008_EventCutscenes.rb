class FinalCoil1
  BASECOLOR = Color.new(232, 208, 32)
  #SHADOWCOLOR = Color.new(248, 232, 136)
  #BASECOLOR = Color.new(248, 248, 248)
  SHADOWCOLOR = Color.new(72, 72, 72)
  TEXT = [
    [
      "Internment Hulk IC-06",
      "Main Bridge - 8872 Yalms",
    ],
    :wait, 60
  ]
  
  def initialize
    showBlk
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport.z = 999999999
    @text = TextSprite.new(@viewport)
    @idx = 0
    main
  end
  
  def main
    while @idx < self.class::TEXT.size
      if self.class::TEXT[@idx] == :wait
        self.class::TEXT[@idx + 1].times do
          Graphics.update
          Input.update
        end
        @idx += 2
      elsif self.class::TEXT[@idx] == :clear
        for i in 0...16
          Graphics.update
          Input.update
          @text.opacity -= 16
        end
        @idx += 1
      elsif self.class::TEXT[@idx].is_a?(Array)
        @text.opacity = 0
        lines = self.class::TEXT[@idx]
        @text.clear
        for i in 0...lines.size
          y = [
            nil,
            [-16],
            [-26, 6],
            [-48, -16, 16],
            [-64, -32, 0, 32]
          ][lines.size][i]
          @text.draw([
            lines[i],
            Graphics.width / 2,
            Graphics.height / 2 + y,
            2,
            self.class::BASECOLOR,
            self.class::SHADOWCOLOR
          ])
        end
        for i in 0...32
          Graphics.update
          Input.update
          @text.opacity += 8
        end
        @idx += 1
      end
    end
    for i in 0...32
      Graphics.update
      Input.update
      @text.opacity -= 8
    end
    dispose
  end
  
  def dispose
    @text.dispose
    @viewport.dispose
    hideBlk
  end
end

# ---------------------------

class FinalCoil2 < FinalCoil1
  TEXT = [
    [
      "???",
      "The Burning Heart",
    ],
    :wait, 60
  ]
end

# ---------------------------