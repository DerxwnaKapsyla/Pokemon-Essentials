class Splash_Devs_1 < EventScene
  BASECOLOR = Color.new(248, 248, 248)
  SHADOWCOLOR = Color.new(72, 72, 72)
  TEXT = [
    [
      "Touhoumon Essentials",
      "2011-2023 DerxwnaKapsyla",
	  "2011-2022 ChaoticInfinity",
	  "2020-2023 Overseer Household"
    ],
    :wait, 140,
    :clear,
    :wait, 8,
    [
      "Pokémon Essentials",
	  "2011-2023 Maruno",
	  "2007-2010 Peter O.",
	  "Based on work by Flameguru"
    ],
    :wait, 140,
    :clear,
    :wait, 6,
    [
      "mkxp-z",
	  "",
	  "Roza",
	  "Based on mkxp by Ancurio et al."
    ],
    :wait, 140,
    :clear,
	:wait, 60,
	[
	  "Kyoto, Japan",
	  "June 27th, 2xxx"
	],
    :wait, 140,
    :clear,
  ]

  def initialize
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport.z = 999999999
    @text = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
    pbSetSystemFont(@text.bitmap)
    @idx = 0
	@skipped = false
  end

  def main
    while @idx < self.class::TEXT.size
      if self.class::TEXT[@idx] == :wait
        wait_time = (self.class::TEXT[@idx + 1] * (Graphics.frame_rate/40.0)).to_i
        wait_time.times do
          return @skipped if update_or_skip
        end
        @idx += 2
      elsif self.class::TEXT[@idx] == :clear
        (Graphics.frame_rate/10 * 4).times do
          return @skipped if update_or_skip
          @text.opacity -= 255/(Graphics.frame_rate/10 * 4)
        end
        @text.opacity = 0
        @idx += 1
      elsif self.class::TEXT[@idx].is_a?(Array)
        @text.opacity = 0
        lines = self.class::TEXT[@idx]
        @text.bitmap.clear
        for i in 0...lines.size
          y = [
            nil,
            [-16],
            [-26, 6],
            [-48, -16, 16],
            [-64, -32, 0, 32]
          ][lines.size][i]
          pbDrawTextPositions(@text.bitmap, [[
            lines[i],
            Graphics.width / 2,
            Graphics.height / 2 + y,
            2,
            self.class::BASECOLOR,
            self.class::SHADOWCOLOR
          ]])
        end
        (Graphics.frame_rate/10 * 8).times do
          return @skipped if update_or_skip
          @text.opacity += 255/(Graphics.frame_rate/10 * 8)
        end
        @text.opacity = 255
        @idx += 1
      end
    end
    (Graphics.frame_rate/10 * 8).times do
      return @skipped if update_or_skip
      @text.opacity -= 255/(Graphics.frame_rate/10 * 8)
    end
    @text.opacity = 0
    dispose
	Graphics.play_movie("Videos/Intro.ogv", 80, true)
	  return @skipped
  end

  def update_or_skip
    if Input.press?(Input::USE)
      @text.opacity = 0
      dispose
	    @skipped = true
      return true
    else
      Input.update
      Graphics.update
      return false
    end
  end

  def dispose
    @text.dispose
    @viewport.dispose
  end
end

# ---------------------------

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
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport.z = 999999999
    @text = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
    pbSetSystemFont(@text.bitmap)
    @idx = 0
    main
  end

  def main
    while @idx < self.class::TEXT.size
      if self.class::TEXT[@idx] == :wait
        wait_time = (self.class::TEXT[@idx + 1] * (Graphics.frame_rate/40.0)).to_i
        wait_time.times do
          Graphics.update
          Input.update
        end
        @idx += 2
      elsif self.class::TEXT[@idx] == :clear
        (Graphics.frame_rate/10 * 4).times do
          Graphics.update
          Input.update
          @text.opacity -= 255/(Graphics.frame_rate/10 * 4)
        end
        @text.opacity = 0
        @idx += 1
      elsif self.class::TEXT[@idx].is_a?(Array)
        @text.opacity = 0
        lines = self.class::TEXT[@idx]
        @text.bitmap.clear
        for i in 0...lines.size
          y = [
            nil,
            [-16],
            [-26, 6],
            [-48, -16, 16],
            [-64, -32, 0, 32]
          ][lines.size][i]
          pbDrawTextPositions(@text.bitmap, [[
            lines[i],
            Graphics.width / 2,
            Graphics.height / 2 + y,
            2,
            self.class::BASECOLOR,
            self.class::SHADOWCOLOR
          ]])
        end
        (Graphics.frame_rate/10 * 8).times do
          Graphics.update
          Input.update
          @text.opacity += 255/(Graphics.frame_rate/10 * 8)
        end
        @text.opacity = 255
        @idx += 1
      end
    end
    (Graphics.frame_rate/10 * 8).times do
      Graphics.update
      Input.update
      @text.opacity -= 255/(Graphics.frame_rate/10 * 8)
    end
    @text.opacity = 0
    dispose
  end

  def dispose
    @text.dispose
    @viewport.dispose
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
      "Touhou Puppet Play ~ A Viewpoint",
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
      "What would they discover? Who would they meet?",
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

# ---------------------------

class Preview < PreludeScene
  TEXT = [
    [
      "To be continued..."
    ],
    :wait, 180,
  ]
end

# ---------------------------

class NextMorning < PreludeScene
  TEXT = [
    [
      "The next morning..."
    ],
    :wait, 180,
  ]
end

# ---------------------------

class Act1End_Maribel < PreludeScene
  TEXT = [
    [
      "With their battle concluded, Maribel set out",
      "to the west for the Johto Region, to follow",
      "up on a new clue to the Sealed Realm."
    ],
    :wait, 180,
    :clear,
    :wait, 60,
    [
      "But still, there was the looming specter of",
      "Team Rocket's plans. Whatever they were",
      "up to, Maribel couldn't be sure."
    ],
    :wait, 180,
    :clear,
    :wait, 60,
    [
      "Mysteries within mysteries awaited on the",
	  "horizon. Maribel was sure that, in due time,",
	  "she would be able to make sense of it all."
    ],
    :wait, 60
  ]
end

# ---------------------------

class Act1End_Renko < PreludeScene
  TEXT = [
    [
      "With their battle concluded, Renko set out",
      "to the west for the Johto Region, to follow",
      "up on a new clue to the Sealed Realm."
    ],
    :wait, 180,
    :clear,
    :wait, 60,
    [
      "But still, there was the looming specter of",
      "Team Rocket's plans. Whatever they were",
      "up to, Renko couldn't be sure."
    ],
    :wait, 180,
    :clear,
    :wait, 60,
    [
      "Mysteries within mysteries awaited on the",
	  "horizon. Renko was sure that, in due time,",
	  "she would be able to make sense of it all."
    ],
    :wait, 60
  ]
end