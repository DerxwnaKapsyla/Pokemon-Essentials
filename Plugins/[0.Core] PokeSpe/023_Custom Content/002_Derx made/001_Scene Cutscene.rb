class Game_Boot_Scene_1
  BASECOLOR = Color.new(248, 248, 248)
  SHADOWCOLOR = Color.new(72, 72, 72)
  TEXT = [
    [
      "Pallet Town. The one place on Earth where",
      "Pokémon aren't threatened by pollution."
    ],
    :wait, 120,
    :clear,
    :wait, 60,
    [
      "In the history of the Pokémon League,",
      "every single winner of the championship",
	  "has been a trainer from Pallet Town."
    ],
    :wait, 140,
    :clear,
    :wait, 80,
    [
      "The question is..."
    ],
    :wait, 140,
    :clear
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

class Game_Boot_Scene_2 < EventScene
  BASECOLOR = Color.new(248, 248, 248)
  SHADOWCOLOR = Color.new(72, 72, 72)
  TEXT = [
    [
      "Who will it be this year?"
    ],
    :wait, 150
  ]
  
  def initialize(viewport = nil)
    super(viewport)
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport.z = 999999999
    @hero_pic = addImage(0, 0, "")
    @hero_pic.setOpacity(0, 0)        # set opacity to 0 after waiting 0 frames
    @text = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
    pbSetSystemFont(@text.bitmap)
    @idx = 0
    main
  end

  def main
    @hero_pic.name = "Graphics/Titles/splash_hero"
	@hero_pic.moveOpacity(0, 8, 255)
	pictureWait
	pbWait(20)
	while @idx < self.class::TEXT.size
      if self.class::TEXT[@idx] == :wait
        wait_time = (self.class::TEXT[@idx + 1] * (Graphics.frame_rate/40.0)).to_i
        wait_time.times do
          return if update_or_skip
        end
        @idx += 2
      elsif self.class::TEXT[@idx] == :clear
        (Graphics.frame_rate/10 * 4).times do
          return if update_or_skip
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
          return if update_or_skip
          @text.opacity += 255/(Graphics.frame_rate/10 * 8)
        end
        @text.opacity = 255
        @idx += 1
      end
    end
    (Graphics.frame_rate/10 * 8).times do
      return if update_or_skip
      @text.opacity -= 255/(Graphics.frame_rate/10 * 8)
    end
    @text.opacity = 0
    @hero_pic.moveOpacity(0, 8, 0)
    pictureWait
    dispose
  end

  def update_or_skip
    if Input.press?(Input::USE)
      @text.opacity = 0
      @hero_pic.moveOpacity(0, 8, 0) # Remove this
      pictureWait                    # if not necessary
      dispose
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

class NewGameScene < Game_Boot_Scene_1
  TEXT = [
    [
      "Pokémon Special: Kanto Adventures",
      "",
	  "Developed by: DerxwnaKapsyla"
    ],
    :wait, 60,
    :clear,
    :wait, 60,
    [
      "Based off the Pokémo Adventures manga",
	  "Written by Hidenori Kusaka",
	  "And published by VIZ Media"
    ],
    :wait, 60
  ]
end

# ---------------------------