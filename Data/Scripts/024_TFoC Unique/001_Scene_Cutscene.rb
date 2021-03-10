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

class NewGameScene1 < PreludeScene
  TEXT = [
    [
      "Touhou Puppet Play ~ The Festival of Curses",
      "Developed by: DerxwnaKapsyla",
      "",
	  "Made for the Relic Castle Winter Game Jam",
    ],
    :wait, 120,
    :clear,
    :wait, 60
#    [
#      "Autumn, Season 132 of the Gensokyo Calendar",
#      "First Day of the Harvest Festival"
#    ],
#    :wait, 60
  ]
end

# ---------------------------

class NewGameScene2
  BASECOLOR = Color.new(248, 152, 24)
  SHADOWCOLOR = Color.new(72, 72, 72)
  TEXT = [
    [
      "Autumn, Season 132 of the Gensokyo Calendar",
      "First Day of the Harvest Festival"
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

class PostgameScene < NewGameScene2
  TEXT = [
    [
      "Autumn, Season 132 of the Gensokyo Calendar",
      "Fifth Day of the Harvest Festival"
    ],
    :wait, 60
  ]
end

# ---------------------------

class CreditsIntro
  BASECOLOR = Color.new(248, 248, 248)
  SHADOWCOLOR = Color.new(72, 72, 72)
  TEXT = [
    [
      "Touhou Puppet Play",
      "The Festival of Curses",
	  "",
	  "Credits"
    ],
    :wait, 160,
    :clear,
    :wait, 60,
    [
      "--- TFoC Team Members ---",
      "DerxwnaKapsyla",
	  "Jelo",
	  "Karl Grogslurper"
    ],
    :wait, 160,
    :clear,
    :wait, 60,
    [
      "--- Director of Development & World Building---",
      "DerxwnaKapsyla"
    ],
    :wait, 160,
    :clear,
  ]
  
  def initialize
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
  end
end

# ---------------------------

class CreditsNames_Audio
  BASECOLOR = Color.new(248, 248, 248)
  SHADOWCOLOR = Color.new(72, 72, 72)
  TEXT = [
    [
      "",
	  "",
	  "And YOU...",
    ],
    :wait, 160,
    :clear
  ]
  
  def initialize
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
            #[-16],
            #[-26, 6],
            #[-48, -16, 16],
            #[-64, -32, 0, 32]
			[82],
			[82, 108],
			[82, 108, 134],
			[82, 108, 134, 160]
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
  end
end

# ---------------------------

class CreditsOutro
  BASECOLOR = Color.new(248, 248, 248)
  SHADOWCOLOR = Color.new(72, 72, 72)
  TEXT = [
    [
      "Touhou Puppet Play",
      "The Festival of Curses",
	  "",
	  "2021-2021         DerxwnaKapsyla ",
	  "2021-2021          ChaoticInfinity",
	  "2021-2021   Overseer Household",
    ],
    :wait, 160,
    :clear,
    :wait, 60,
    [
      "Touhoumon Essentials",
      "",
	  "2011-2021         DerxwnaKapsyla ",
	  "2011-2021          ChaoticInfinity",
	  "2020-2021   Overseer Household",
    ],
    :wait, 160,
    :clear,
    :wait, 60,
    [
      "Pokemon Essentials",
      "",
	  "2007-2010        Peter O.",
	  "2010-2019          Maruno",
	  "Based in work by Flameguru",
    ],
    :wait, 160,
    :clear,
	:wait, 60,
  ]
  
  def initialize
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
            [-64, -32, 0, 32],
			[-80, -48, -16, 16, 48],
			[-96, -64, -32, 0, 32, 64]
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
  end
end

# ---------------------------

class CreditsFin
  BASECOLOR = Color.new(248, 248, 248)
  SHADOWCOLOR = Color.new(72, 72, 72)
  TEXT = [
    [
      "                                                               Fin.",
    ],
    :wait, 160,
    :clear,
  ]
  
  def initialize
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
			[160],
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
  end
end

# ---------------------------