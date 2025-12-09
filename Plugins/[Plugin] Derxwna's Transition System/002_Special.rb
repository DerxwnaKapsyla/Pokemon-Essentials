GYMLEADERS = [:ANDROID, :ASTRONOMER, :FLORIST, :DAREDEVIL,
              :GAMEMASTER, :SPECTRALTWINS, :LOREKEEPER, :STRATEGIST]

ELITEFOUR = [:HEROINE, :BEEKEEPER, :STARGAZER, :SCULPTOR, :PRIEST]

#GRANDLEAGUE = []

SpecialBattleIntroAnimations.register("vs_gymleader_solo", 100,
  proc { |battle_type, foe, location|   # Condition
    next false if ![1, 3].include?(battle_type)   # Trainer battles only
	next false if foe.length != 1 # Single-Battles Only
    tr_type  = foe[0].trainer_type
	next false if !GYMLEADERS.include?(tr_type)
    next pbResolveBitmap("Graphics/Transitions/DTS/PTs/Char_#{tr_type}") # Character cut-in
  },
  proc { |viewport, battle_type, foe, location|   # Animation
	# Determine filenames of graphics to be used
    BAR_DISPLAY_WIDTH = 248
	tr_type        = foe[0].trainer_type
    bg_name        = $game_temp.get_vs_transition_bg
    bg_graphic     = sprintf("DTS/BGs/BG%s", bg_name.to_s) rescue nil
    tr_graphic     = sprintf("DTS/PTs/Char_%s", tr_type.to_s) rescue nil
    black_bars     = sprintf("DTS/BorderBars") rescue nil
    # Set up sprites
	ball_sprites     = dkDisplayBallCount(viewport, foe, 0) # Create the ball count for a trainer
	ball_bar         = Sprite.new(viewport)
    ball_bar.bitmap  = RPG::Cache.transition("DTS/Balls/overlay_lineup.png")
    ball_bar.x       = -440
    ball_bar.y       = 292
	ball_bar.z       = 99998
	# Badge display
	# TO-DO
	
    # Background Graphic
    background              = Sprite.new(viewport)
    background.bitmap       = RPG::Cache.transition(bg_graphic)
    background.z            = 99990
    background.opacity      = 0
    # Character portrait and shadow
    portrait                = Sprite.new(viewport)
    portrait_shadow         = Sprite.new(viewport)
    portrait.bitmap         = RPG::Cache.transition(tr_graphic)
    portrait_shadow.bitmap  = RPG::Cache.transition(tr_graphic)   
    portrait.z              = 99996
    portrait.ox             = portrait.bitmap.width/2
    portrait.x              = Graphics.width/2 + 128
	portrait.oy             = portrait.bitmap.height
	portrait.y              = Graphics.height
    portrait.opacity        = 0
    portrait_shadow.tone    = Tone.new(-255, -255, -255)
    portrait_shadow.opacity = 0
    portrait_shadow.z       = portrait.z - 1
	portrait_shadow.ox      = portrait.bitmap.width/2
	portrait_shadow.x       = Graphics.width/2 + 128
	portrait_shadow.oy      = portrait.bitmap.height
	portrait_shadow.y       = Graphics.height
    # Black bars at the top and bottom of screen
    bartop            = Sprite.new(viewport)
    bartop.bitmap     = RPG::Cache.transition(black_bars)
    barbottom         = Sprite.new(viewport)
    barbottom.bitmap  = RPG::Cache.transition(black_bars)   
    bartop.y          = 0
    bartop.z          = portrait.z - 2
    barbottom.y       = Graphics.height - bartop.height
    barbottom.z       = portrait.z + 2
    bartop.opacity    = 0
    barbottom.opacity = 0   
    # Name graphic
    charname = dkConvertNameToBitmap(viewport, foe, battle_type)
    charname.z = barbottom.z + 2
    charname.opacity = 0
    # Flash graphic
    flash = Sprite.new(viewport)
    flash.bitmap  = RPG::Cache.transition("vsFlash")
    flash.opacity = 0
    flash.z       = 9999999
	
    # Initial screen flashing
	num_flashes = 2
    if num_flashes > 0
      c = (location == 2 || PBDayNight.isNight?) ? 0 : 255   # Dark=black, light=white
      viewport.color = Color.new(c, c, c)   # Fade to black/white a few times
      half_flash_time = 0.2   # seconds
      num_flashes.times do   # 2 flashes
        fade_out = false
        timer_start = System.uptime
        loop do
          if fade_out
            viewport.color.alpha = lerp(255, 0, half_flash_time, timer_start, System.uptime)
          else
            viewport.color.alpha = lerp(0, 255, half_flash_time, timer_start, System.uptime)
          end
          Graphics.update
          pbUpdateSceneMap
          break if fade_out && viewport.color.alpha <= 0
          if !fade_out && viewport.color.alpha >= 255
            fade_out = true
            timer_start = System.uptime
          end
        end
      end
    end
    
    # Fade to black, then fade in the background and black bars, also start shifting background leftward
    flash.tone = Tone.new(-255, -255, -255)   # Make the flash black
	pbWait(0.75) do |delta_t|
      flash.opacity = lerp(0, 255, 0.25, delta_t)   # Fade to black
	end
	
	bartop.opacity    = 230
    barbottom.opacity = 230
	background.opacity = 255
	
	scroll_speed  = -5
	background.x += scroll_speed
	
    pbWait(1) do |delta_t| # There was a 15 frame wait after the start of the background fading in. Is this right?
	  background.x      += scroll_speed
      flash.opacity      = lerp(255, 0, 0.25, delta_t)
    end
    
    # Flash the screen, display the character's shadow portrait
    flash.tone = Tone.new(255, 255, 255)
	pbSEPlay("Vs flash")
	background.x += scroll_speed
    flash.opacity = 255
    
    pbWait(1.5) do |delta_t| # Initial delay was 40 frames after start of shadow showing up.
      background.x           += scroll_speed
	  flash.opacity           = lerp(255, 0, 0.25, delta_t)
      portrait_shadow.opacity = 192
    end
    
    # Flash the screen again, display the character's portrait and name. Begin shifting shadow leftward.
    pbSEPlay("Vs sword")
	background.x += scroll_speed
    flash.opacity = 255
    
    original_x = portrait_shadow.x
    pbWait(4) do |delta_t| # Initial delay was 60 frames after start of portrait showing up.
      background.x     += scroll_speed
	  flash.opacity     = lerp(255, 0, 0.5, delta_t)
      portrait.opacity  = 255
      charname.opacity  = 255
      portrait_shadow.x = lerp(original_x, original_x - 6, 1.5, delta_t)
      ball_sprites.each_with_index do |s,i|
        s.x = lerp(((Settings::MAX_PARTY_SIZE - i) * 32) - (Graphics.width/2), ((Settings::MAX_PARTY_SIZE - i) * 32), 0.4, delta_t)
      end
	  ball_bar.x = lerp(-440, -192, 0.4, delta_t)
    end    
    
    # Fade out all graphics, then change their color tone to black (Is that still necessary?)
    flash.tone = Tone.new(-255, -255, -255)
    pbWait(0.3) do |delta_t|
	  background.x += scroll_speed
	  flash.opacity = lerp(0, 255, 0.25, delta_t)
    end

    # End of animation
    flash.dispose
    charname.dispose
    background.dispose
    portrait.dispose
    portrait_shadow.dispose
    bartop.dispose
    barbottom.dispose
	ball_bar.dispose
	ball_sprites.each {|s| s.dispose}
	$game_temp.vs_name = nil
	$game_temp.transition_animation_data = nil

    viewport.color = Color.black   # Ensure screen is black
  }
)

# Alyssia

# Elite 4 + Champion

# Grand League