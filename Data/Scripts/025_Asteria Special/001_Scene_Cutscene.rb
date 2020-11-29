class PreludeScene
  BASECOLOR = Color.new(248, 248, 248)
  SHADOWCOLOR = Color.new(72, 72, 72)
  TEXT = [
    [
      "Eight years after Red became",
      "Champion of the Kanto League..."
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

class NewGameScene < PreludeScene
  TEXT = [
    [
      "Touhoumon Asteria Version",
      "Developed by: DerxwnaKapsyla",
      "Produced By: ChaoticInfinity Development"
    ],
    :wait, 120,
    :clear,
    :wait, 60,
    [
      "Inspired by the fan-fiction",
      "Touhou Puppt Play ~ A Viewpoint",
      "Written by: Lone Wolf NEO"
    ],
    :wait, 120,
    :clear,
    :wait, 120,
    [
      "Present Day",
      "Pallet Town, Kanto Region"
    ],
    :wait, 60
  ]
end

# ---------------------------

class IntroEnd < PreludeScene
  TEXT = [
    [
      "And so, Renko Usami and Maribel Hearn, the",
      "two heroines from another world, set out on",
      "their journey across the vast world of Monsekai."
    ],
    :wait, 180,
    :clear,
    :wait, 60,
    [
      "What would they discover? Who would the meet?",
      "Would they learn the truth behind the",
      "Sealed Realm?"
    ],
    :wait, 180,
    :clear,
    :wait, 60,
    [
      "Only time would tell...",
    ],
    :wait, 60
  ]
end