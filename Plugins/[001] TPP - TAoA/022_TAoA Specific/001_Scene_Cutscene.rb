class Scene_Cutscene
  BASECOLOR = Color.new(248, 248, 248)
  SHADOWCOLOR = Color.new(72, 72, 72)
  TEXT = [

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
        for i in 0...32
          Graphics.update
          Input.update
          @text.opacity -= 8
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

class TMoMIntroScene
  BASECOLOR = Color.new(248, 248, 248)
  SHADOWCOLOR = Color.new(72, 72, 72)
  TEXT = [
    [
      "Touhou Puppet Play ~ The Mansion of Mystery",
      "Developed by: DerxwnaKapsyla"
    ],
    :wait, 120,
    :clear,
    :wait, 60,
    [	
	  "Made for the PokeCommunity \"Blinded by ",
	  "the Fright\" Game Jam"
    ],
    :wait, 120,
    :clear,
    :wait, 120,
    [
      "Spring, Season 130 of the Gensokyo Calendar",
      "Human Village, Evening"
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
        (Graphics.frame_rate/10 * 8).times do
          Graphics.update
          Input.update
          @text.opacity -= 255/(Graphics.frame_rate/10 * 8)
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
            [-64, -32, 0, 32],
			[-80, -48, -16, 16, 48],
			[-96, -64, -32, 0, 32, 64]
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

class CreditsIntro_TMoM
  BASECOLOR = Color.new(248, 248, 248)
  SHADOWCOLOR = Color.new(72, 72, 72)
  TEXT = [
    [
      "Touhou Puppet Play",
      "The Mansion of Mystery",
	  "",
	  "Credits"
    ],
    :wait, 160,
    :clear,
    :wait, 60,
    [
      "--- TMoM Team Members ---",
      "DerxwnaKapsyla",
	  "FionaKaenbyou"
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
        for i in 0...32
          Graphics.update
          Input.update
          @text.opacity -= 8
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

class CreditsNames
  BASECOLOR = Color.new(248, 248, 248)
  SHADOWCOLOR = Color.new(72, 72, 72)
  TEXT = [
    [
      "Mr. Unknown | a-TTTempo | Uda-Shi",
	  "KecleonTencho | brawlman9876 | Jesslejohn",
	  "Paradarx | Danmaq | Amane",
    ],
    :wait, 120,
    :clear,
    :wait, 60,
    [
      "U2 Akiyama | Hitomi Sato | Junichi Masuda",
	  "Go Ichinose | Masayoshi Soken | Jesslejohn",
	  "U2 Akiyama | ZUN | DerxwnaKapsyla",
	  "Ludwig van Beethoven",
    ],
    :wait, 120,
    :clear,
    :wait, 60,
    [
      "DerxwnaKapsyla | DerxwnaKapsyla",
      "FionaKaenbyou",
    ],
    :wait, 120,
    :clear,
    :wait, 60,
    [
      "HemoglobinA1C | Stuffman",
	  "Reimufate | BluShell",
      "EXSariel | Masa",
	  "Mille Marteaux",
    ],
    :wait, 120,
    :clear,
    :wait, 60,
    [
      "DoesntKnowHowToPlay",
	  "DerxwnaKapsyla",
    ],
    :wait, 120,
    :clear,
    :wait, 60,
    [
      "Team Shanghai Alice",
    ],
    :wait, 120,
    :clear,
    :wait, 60,
    [
      "HemoglobinA1C |  Alicia | BluShell",
	  "Stuffman | Spyro | Irakuy",
	  "SoulfulLex | zero_breaker | Reimufate",
	  "Love_Albatross | Uda-shi | KecleonTencho",
    ],
    :wait, 40,
    :clear,
    :wait, 60,
    [
      "AmethystRain & Reborn Dev Team",
	  "DerxwnaKapsyla",
    ],
    :wait, 120,
    :clear,
    :wait, 60,
    [
      "bo4p5687: Multiple Saves",
	  "Marin & Phantombass: Better Speed Up",
	  "Amethyst, Kurotsune, ENLS: Easy Text Skip",
	  "Mr. Gela & Vendily: Name Boxes",
    ],
    :wait, 120,
    :clear,
    :wait, 60,
    [
      "aiyinsi & DerxwnaKapsyla: Change BGMs",
	  "Mej71: Adjustable Dark Circle",
	  "Grogro: Clone Trainer",
	  "NettoHikari: EMXP Event Exporter",
    ],
    :wait, 120,
    :clear,
    :wait, 60,
    [
      "= Marin =",
	  "Marin's Scripting Utilities",
	  "Marin's Map Exporter",
	  "Marin's Enhanced Jukebox",
    ],
    :wait, 120,
    :clear,
    :wait, 60,
    [
      "DerxwnaKapsyla",
	  "ChaoticInfinity Development",
	  "Overseer Household",
    ],
    :wait, 120,
    :clear,
    :wait, 60,
    [
      "HemoglobinA1C: Developer of Touhou Puppet Play",
	  "Alicia: Developer of the Pokéxtractor Tools",
	  "Mille & EXSariel: Localization of Thmn. 1.812",
	  "DoesntKnowHowToPlay: Dev. of Thmn.Unnamed",
    ],
    :wait, 120,
    :clear,
    :wait, 60,
    [
      "Reimufate: Developer of Thmn Reimufate Version",
	  "Fo.Lens & GNGekidan: GNE Asset Pack",
	  "FionaKaenbyou: Writing every trainer's dialogue",
    ],
    :wait, 120,
    :clear,
    :wait, 60,
    [
      "Floofgear: Emotional support and motivation",
	  "Relic Castle: For putting up with my absurdity",
    ],
    :wait, 120,
    :clear,
    :wait, 60,
    [
      "Flameguru: Initial developer of Essentials",
	  "Poccil (Peter O.): Developer of Essentials",
	  "Maruno: Current developer of Essentials",
	  "The \"Pokémon Essentials\" Development Team",
    ],
    :wait, 120,
    :clear,
    :wait, 60,
    [
      "Enterbrain: Devs and Producers of \"RPG Maker XP\"",
	  "Game Freak: Developers of \"Pokémon\"",
	  "FocasLens: Developers of \"Gensou Ningyou Enbu\"",
	  "ZUN: Head Developer of \"Touhou Project\"",
    ],
    :wait, 120,
    :clear,
    :wait, 60,
    [
      "",
	  "",
	  "And YOU...",
    ],
    :wait, 120,
    :clear,
    :wait, 60,
    [
      "\"mkxp-z\" by",
	  "Roza",
	  "Based on \"mkxp\" by Ancurio et al.",
    ],
    :wait, 120,
    :clear,
    :wait, 60,
    [
      "\"RPG Maker XP\" by",
	  "Enterbrain",
    ],
    :wait, 120,
    :clear,
    :wait, 60,
    [
      "Pokémon is owned by:",
	  "The Pokémon Company",
	  "Nintendo",
	  "Affiliated with Game Freak",
    ],
    :wait, 120,
    :clear,
    :wait, 60,
    [
      "This is a non-profit fan-made game.",
	  "No copyright infringments intended",
	  "Please support the official games!",
	  "If you've paid for this, you've been had!",
    ],
    :wait, 120,
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

class CreditsOutro_TMoM
  BASECOLOR = Color.new(248, 248, 248)
  SHADOWCOLOR = Color.new(72, 72, 72)
  TEXT = [
    [
      "Touhou Puppet Play",
      "The Mansion of Mystery",
	  "",
	  "2021-2024         DerxwnaKapsyla ",
	  "2021-2021          ChaoticInfinity",
	  "2021-2024   Overseer Household",
    ],
    :wait, 160,
    :clear,
    :wait, 60,
    [
      "Touhoumon Essentials",
      "",
	  "2011-2024         DerxwnaKapsyla ",
	  "2011-2021          ChaoticInfinity",
	  "2020-2024   Overseer Household",
    ],
    :wait, 160,
    :clear,
    :wait, 60,
    [
      "Pokemon Essentials",
      "",
	  "2007-2010        Peter O.",
	  "2010-2024          Maruno",
	  "Based on work by Flameguru",
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

class TFoCIntroScene1 < TMoMIntroScene
  TEXT = [
    [
      "Touhou Puppet Play ~ The Festival of Curses",
      "Developed by: DerxwnaKapsyla",
	  "",
	  "Made for the Relic Castle Winter Game Jam"
    ],
    :wait, 120,
    :clear,
    :wait, 60
  ]
end

# ---------------------------

class TFoCIntroScene2
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

class TFoCPostgameScene < TFoCIntroScene2
  TEXT = [
    [
      "Autumn, Season 132 of the Gensokyo Calendar",
      "Fifth Day of the Harvest Festival"
    ],
    :wait, 60
  ]
end

# ---------------------------

class CreditsNames_TFoC < CreditsNames
  TEXT = [
    [
      "Marin & Phantombass: Better Speed Up",
	  "Amethyst, Kurotsune, ENLS: Easy Text Skip",
	  "Mr. Gela & Vendily: Name Boxes",
	  "NettoHikari: RMXP Event Exporter",
    ],
    :wait, 120,
    :clear,
    :wait, 60,
    [
      "grogro: Clone Trainer",
	  "DerxwnaKapsyla: Coin Shop",
	  "DeoxysPrime: EV/IV Summary Display",
	  "Lucidious89: Essentials DX, Enhanced UI",
    ],
    :wait, 120,
    :clear,
    :wait, 60,
  ]
end

# ---------------------------

class CreditsIntro_TFoC < CreditsIntro_TMoM
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
end

# ---------------------------

class CreditsOutro_TFoC < CreditsOutro_TMoM
  TEXT = [
    [
      "Touhou Puppet Play",
      "The Festival of Curses",
	  "",
	  "2021-2024         DerxwnaKapsyla ",
	  "2021-2021          ChaoticInfinity",
	  "2021-2024   Overseer Household",
    ],
    :wait, 160,
    :clear,
    :wait, 60,
    [
      "Touhoumon Essentials",
      "",
	  "2011-2024         DerxwnaKapsyla ",
	  "2011-2021          ChaoticInfinity",
	  "2020-2024   Overseer Household",
    ],
    :wait, 160,
    :clear,
    :wait, 60,
    [
      "Pokemon Essentials",
      "",
	  "2007-2010        Peter O.",
	  "2010-2024          Maruno",
	  "Based on work by Flameguru",
    ],
    :wait, 160,
    :clear,
	:wait, 60,
  ]
end

# ---------------------------

class TKoLIntroScene1 < TMoMIntroScene
  TEXT = [
    [
      "Touhou Puppet Play ~ The Kingdom of Lunacy",
      "Developed by: DerxwnaKapsyla"
    ],
    :wait, 120,
    :clear,
    :wait, 120,
    [
      "Summer, Season 133 of the Gensokyo Calendar",
      "Human Village, Second Full Moon"
    ],
    :wait, 60
  ]
end

# ---------------------------

class CreditsIntro_TKoL < CreditsIntro_TMoM
  TEXT = [
    [
      "Touhou Puppet Play",
      "The Kingdom of Lunacy",
	  "",
	  "Credits"
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
end

# ---------------------------

class CreditsOutro_TKoL < CreditsOutro_TMoM
  TEXT = [
    [
      "Touhou Puppet Play",
      "The Kingdom of Lunacy",
	  "",
	  "2021-2024         DerxwnaKapsyla ",
	  "2021-2021          ChaoticInfinity",
	  "2021-2024   Overseer Household",
    ],
    :wait, 160,
    :clear,
    :wait, 60,
    [
      "Touhoumon Essentials",
      "",
	  "2011-2024         DerxwnaKapsyla ",
	  "2011-2021          ChaoticInfinity",
	  "2020-2024   Overseer Household",
    ],
    :wait, 160,
    :clear,
    :wait, 60,
    [
      "Pokemon Essentials",
      "",
	  "2007-2010        Peter O.",
	  "2010-2024          Maruno",
	  "Based on work by Flameguru",
    ],
    :wait, 160,
    :clear,
	:wait, 60,
  ]
end

# ---------------------------

class TKoLPostgameStinger < TMoMIntroScene
  TEXT = [
    [
      "Meanwhile, 380000 kilometers above the Earth..."
    ],
    :wait, 60
  ]
end

# ---------------------------

class TKoLPostgameScene < TMoMIntroScene
  TEXT = [
    [
      "Summer, Season 133 of the Gensokyo Calendar",
      "Human Village, New Moon"
    ],
    :wait, 60
  ]
end

# ---------------------------

class TLAIntroScene < TMoMIntroScene
  TEXT = [
	[
      "Touhou Puppet Play ~ The Adventures of Ayaka",
	  "The Last Adventure",
	  "",
      "Developed by: DerxwnaKapsyla"
    ],
    :wait, 160,
    :clear,
    :wait, 60,
    [
      "With enough effort, one can change their",
	  "dreams into reality..."
    ],
    :wait, 160,
    :clear,
    :wait, 60
  ]
end

class MeimuOutro < TMoMIntroScene
  BASECOLOR = Color.new(80, 80, 88)
  SHADOWCOLOR = Color.new(160, 160, 168)
  TEXT = [
	[
      "In the end, I just couldn't pull it off..."
    ],
    :wait, 160,
    :clear,
    :wait, 60,
    [
      "What a fool I was to think I was strong enough...",
    ],
    :wait, 160,
    :clear,
    :wait, 60,
    [
      "...Goodbye, Lady Mima...",
    ],
    :wait, 160,
    :clear,
    :wait, 60,
    [
      "...Goodbye, Ayaka...",
    ],
    :wait, 160,
    :clear,
    :wait, 60,
    [
      "I am so sorry for all the trouble I caused...",
    ],
    :wait, 160,
    :clear,
    :wait, 60
  ]
end

class CreditsIntro_TAoA < CreditsIntro_TFoC
  TEXT = [
    [
      "Touhou Puppet Play",
      "The Adventures of Ayaka",
	  "",
	  "Credits"
    ],
    :wait, 160,
    :clear,
    :wait, 100,
    [
      "--- The Mansion of Mystery ---",
	  "--- Development Team and Testers ---",
      "DerxwnaKapsyla",
	  "FionaKaenbyou",
	  "Akiraita"
    ],
    :wait, 160,
    :clear,
    :wait, 100,
    [
      "--- The Festival of Curses ---",
	  "--- Development Team and Testers ---",
      "DerxwnaKapsyla",
	  "Jelo",
	  "KarlGrogsluper"
    ],
    :wait, 160,
    :clear,
    :wait, 100,
    [
      "--- The Kingdom of Lunacy ---",
	  "--- Development Team and Testers ---",
      "DerxwnaKapsyla",
	  "Chirei"
    ],
    :wait, 160,
    :clear,
    :wait, 100,
    [
      "--- The Last Adventure ---",
	  "--- Development Team and Testers ---",
      "DerxwnaKapsyla",
	  "Chirei"
    ],
    :wait, 400,
    :clear,
  ]
end