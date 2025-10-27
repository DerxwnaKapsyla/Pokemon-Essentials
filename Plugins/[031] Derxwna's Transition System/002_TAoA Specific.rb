#===============================================================================
# Dedicated Transitions
#===============================================================================
# Vs. Clownpiece (Double Battle, single trainer shows up)
#===============================================================================
SpecialBattleIntroAnimations.register("vs_clownpiece", 100,   # Priority 100
  proc { |battle_type, foe, location|   # Condition
    next false if battle_type != 3   # Trainer battles only
	tr_type   = foe[0].trainer_type
	next false if tr_type != :CLOWNPIECET # Only execute if Foe 0 is Clownpiece
    #next false if battle_type != 3 && foe.length != 2 # ONLY execute if Clownpiece is with her partner
    next pbResolveBitmap("Graphics/Transitions/DTS/PTs/Char_#{tr_type}") # Character cut-in
  },
  proc { |viewport, battle_type, foe, location|   # Animation
	#$game_temp.vs_name = dkGetTrainerName(foe)
	# Determine filenames of graphics to be used
    BAR_DISPLAY_WIDTH = 248
	tr_type        = foe[0].trainer_type
    bg_name        = $game_temp.get_vs_transition_bg
    bg_graphic     = sprintf("DTS/BGs/BG%s", bg_name.to_s) rescue nil
    tr_graphic     = sprintf("DTS/PTs/Char_%s", tr_type.to_s) rescue nil
    black_bars     = sprintf("DTS/BorderBars") rescue nil
    # Set up sprites
	ball_sprites     = dkDisplayBallCount(viewport, foe, 0) # Create the ball count for trainer 0
ball_sprites2    = dkDisplayBallCount(viewport, foe, 1) # Create the ball count for trainer 1
ball_bar         = Sprite.new(viewport)
    ball_bar.bitmap  = RPG::Cache.transition("DTS/Balls/overlay_lineup.png")
    ball_bar.x       = -440
    ball_bar.y       = 292
	ball_bar.z       = 99998
	ball_bar2        = Sprite.new(viewport)
    ball_bar2.bitmap = ball_bar.bitmap
    ball_bar2.x      = ball_bar.x
    ball_bar2.y      = ball_bar.y - 46
	ball_bar2.z      = ball_bar.z
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
    portrait.x              = Graphics.width/2
	portrait.oy             = portrait.bitmap.height
	portrait.y              = Graphics.height
    portrait.opacity        = 0
    portrait_shadow.tone    = Tone.new(-255, -255, -255)
    portrait_shadow.opacity = 0
    portrait_shadow.z       = portrait.z - 1
    portrait_shadow.ox      = portrait.bitmap.width/2
	portrait_shadow.x       = Graphics.width/2
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
    
    # Fade to black, then fade in the background and black bars
    flash.tone = Tone.new(-255, -255, -255)   # Make the flash black
	pbWait(0.75) do |delta_t|
      flash.opacity = lerp(0, 255, 0.25, delta_t)   # Fade to black
	end
	
	bartop.opacity    = 230
    barbottom.opacity = 230
	background.opacity = 255
    pbWait(1) do |delta_t| # There was a 15 frame wait after the start of the background fading in. Is this right?
      flash.opacity      = lerp(255, 0, 0.25, delta_t)
	  #background.opacity = lerp(0, 255, 0.25, delta_t)
    end
    
    # Flash the screen, display the character's shadow portrait
    flash.tone = Tone.new(255, 255, 255)
	pbSEPlay("Vs flash")
    flash.opacity = 255
    
    pbWait(1.5) do |delta_t| # Initial delay was 40 frames after start of shadow showing up.
      flash.opacity           = lerp(255, 0, 0.25, delta_t)
      portrait_shadow.opacity = 192
    end
    
    # Flash the screen again, display the character's portrait and name. Begin shifting shadow leftward.
    pbSEPlay("Vs sword")
    flash.opacity = 255
    
    original_x = portrait_shadow.x
    pbWait(4) do |delta_t| # Initial delay was 60 frames after start of portrait showing up.
      flash.opacity     = lerp(255, 0, 0.5, delta_t)
      portrait.opacity  = 255
      charname.opacity  = 255
      portrait_shadow.x = lerp(original_x, original_x - 6, 1.5, delta_t)
      ball_sprites.each_with_index do |s,i|
        s.x = lerp(((Settings::MAX_PARTY_SIZE - i) * 32) - (Graphics.width/2), ((Settings::MAX_PARTY_SIZE - i) * 32), 0.4, delta_t)
      end
	  ball_sprites2.each_with_index do |s,i|
        s.x = lerp(((Settings::MAX_PARTY_SIZE - i) * 32) - (Graphics.width/2), ((Settings::MAX_PARTY_SIZE - i) * 32), 0.4, delta_t)
      end
	  ball_bar.x  = lerp(-440, -192, 0.4, delta_t)
	  ball_bar2.x = lerp(-440, -192, 0.4, delta_t)
    end    
    
    # Fade out all graphics, then change their color tone to black (Is that still necessary?)
    flash.tone = Tone.new(-255, -255, -255)
    pbWait(0.3) do |delta_t|
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
	ball_bar2.dispose
	ball_sprites.each {|s| s.dispose}
	ball_sprites2.each {|s| s.dispose}
	$game_temp.vs_name = nil
	$game_temp.transition_animation_data = nil

    viewport.color = Color.black   # Ensure screen is black
  }
)

#===============================================================================
# Vs. Meimu (Phase 1-4)
# * Noteworthy difference is that it looks like the normal transition, but
#   shows 28 balls after a few seconds.
#===============================================================================
SpecialBattleIntroAnimations.register("vs_meimu", 100,   # Priority 100
  proc { |battle_type, foe, location|   # Condition
    if !$game_switches[168]
      next false if pbGet(143) != 1   # Meimu's battle variable HAS to be 1. ONLY trigger this once.
	end
    tr_type  = foe[0].trainer_type
	echoln tr_type
	next false if tr_type != :MEIMU # Confirm that we are fighting Meimu here. Sanity check.
    echoln pbResolveBitmap("Graphics/Transitions/DTS/PTs/Char_#{tr_type}") # Character cut-in
	next pbResolveBitmap("Graphics/Transitions/DTS/PTs/Char_#{tr_type}") # Character cut-in
  },
  proc { |viewport, battle_type, foe, location|   # Animation
	#$game_temp.vs_name = dkGetTrainerName(foe)
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
	# Appearance of 24 Orbs
	ball_sprites2         = Sprite.new(viewport)
	ball_sprites2.bitmap  = RPG::Cache.transition("DTS/Balls/icon_ball24.png")
	ball_sprites2.opacity = 0
	ball_sprites2.y       = Graphics.height - 90 - ball_sprites2.bitmap.height - 2
	ball_sprites2.z       = 99999
	
	ball_bar2         = Sprite.new(viewport)
	ball_bar2.bitmap  = RPG::Cache.transition("DTS/Balls/overlay_lineup24.png")
    ball_bar2.opacity = 0
	ball_bar2.y       = ball_bar.y - 96 # Will need adjustments.
	ball_bar2.z       = 99998
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
    portrait.x              = Graphics.width/2
	portrait.oy             = portrait.bitmap.height
	portrait.y              = Graphics.height
    portrait.opacity        = 0
    portrait_shadow.tone    = Tone.new(-255, -255, -255)
    portrait_shadow.opacity = 0
    portrait_shadow.z       = portrait.z - 1
    portrait_shadow.ox      = portrait.bitmap.width/2
	portrait_shadow.x       = Graphics.width/2
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
    
    # Fade to black, then fade in the background and black bars
    flash.tone = Tone.new(-255, -255, -255)   # Make the flash black
	pbWait(0.75) do |delta_t|
      flash.opacity = lerp(0, 255, 0.25, delta_t)   # Fade to black
	end
	
	bartop.opacity    = 230
    barbottom.opacity = 230
	background.opacity = 255
    pbWait(1) do |delta_t| # There was a 15 frame wait after the start of the background fading in. Is this right?
      flash.opacity      = lerp(255, 0, 0.25, delta_t)
	  #background.opacity = lerp(0, 255, 0.25, delta_t)
    end
    
    # Flash the screen, display the character's shadow portrait
    flash.tone = Tone.new(255, 255, 255)
	pbSEPlay("Vs flash")
    flash.opacity = 255
    
    pbWait(1.5) do |delta_t| # Initial delay was 40 frames after start of shadow showing up.
      flash.opacity           = lerp(255, 0, 0.25, delta_t)
      portrait_shadow.opacity = 192
    end
    
    # Flash the screen again, display the character's portrait and name. Begin shifting shadow leftward.
    pbSEPlay("Vs sword")
    flash.opacity = 255
    
    original_x = portrait_shadow.x
    pbWait(2) do |delta_t| # Initial delay was 60 frames after start of portrait showing up.
      flash.opacity     = lerp(255, 0, 0.5, delta_t)
      portrait.opacity  = 255
      charname.opacity  = 255
      portrait_shadow.x = lerp(original_x, original_x - 6, 1.5, delta_t)
      ball_sprites.each_with_index do |s,i|
        s.x = lerp(((Settings::MAX_PARTY_SIZE - i) * 32) - (Graphics.width/2), ((Settings::MAX_PARTY_SIZE - i) * 32), 0.4, delta_t)
      end
	  ball_bar.x = lerp(-440, -192, 0.4, delta_t)
    end	
    
	if !$game_switches[168]
	  # After some time has passed, flash the screen again, update ball display to show 24 orbs
	  pbSEPlay("Vs sword", 80, 70)
	  flash.opacity = 255
	
	  pbWait(3) do |delta_t|
	    flash.opacity         = lerp(255, 0, 0.5, delta_t)
	    ball_bar.opacity      = 0
	    ball_sprites2.x       = 32
	    ball_sprites2.z       = 99999
	    ball_sprites2.opacity = 255
	    ball_bar2.opacity     = 255
	  end
	end
	
    # Fade out all graphics, then change their color tone to black (Is that still necessary?)
    flash.tone = Tone.new(-255, -255, -255)
    pbWait(0.3) do |delta_t|
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
	ball_bar2.dispose
	ball_sprites2.dispose
	$game_temp.vs_name = nil
	$game_temp.transition_animation_data = nil

    viewport.color = Color.black   # Ensure screen is black
  }
)

#===============================================================================
# Vs. Meimu (Phase 2-4)
# * No transition. Immediate jump to battle.
#===============================================================================
SpecialBattleIntroAnimations.register("vs_meimu2", 100,   # Priority 100
  proc { |battle_type, foe, location|   # Condition
    next false if ![1, 3].include?(battle_type)   # Trainer battles only
	next false if pbGet(143) < 2   # Only trigger if Meimu's battle variable is 2 or greater.
	next false if foe[0].trainer_type != :MEIMU # Confirm that we are fighting Meimu here. Sanity check.
	next true
  },
  proc { |viewport, battle_type, foe, location|   # Animation
    # Flash graphic
    flash = Sprite.new(viewport)
    flash.bitmap  = RPG::Cache.transition("vsFlash")
    flash.opacity = 0
    flash.z       = 9999999

   # Fade to black, then fade in the background and black bars
    flash.tone = Tone.new(-255, -255, -255)   # Make the flash black
	pbWait(0.75) do |delta_t|
      flash.opacity = lerp(0, 255, 0.25, delta_t)   # Fade to black
	end
	
    # End of animation
    flash.dispose
    viewport.color = Color.black   # Ensure screen is black
  }
)

#===============================================================================
# Vs. Meimu (Phase 5)
# * Noteworthy difference is that it shows Meimu off to the side, and has her 
#   title in the top left corner.
#===============================================================================
SpecialBattleIntroAnimations.register("vs_meimu_final", 100,   # Priority 100
  proc { |battle_type, foe, location|   # Condition
	next false if ![0, 2].include?(battle_type)
	if !$game_switches[168]
	  next false if pbGet(142) != 7   # TLA Plot variable HAS to be 7. ONLY trigger this during the Final Battle.
	end
    species  = foe[0].species
	echoln species
	next false if species != :MEIMU # Confirm that we are fighting Meimu here. Sanity check.
    echoln pbResolveBitmap("Graphics/Transitions/DTS/PTs/Wild_#{species}") # Character cut-in
	next pbResolveBitmap("Graphics/Transitions/DTS/PTs/Wild_#{species}") # Character cut-in
  },
  proc { |viewport, battle_type, foe, location|   # Animation
	$game_temp.transition_animation_data = [foe[0].species, foe[0].form]
    # Determine filenames of graphics to be used
    bg_graphic     = "DTS/BGs/BGWorldOfFantasy"
	if pbGet(BossRush::BOSS_FIGHT_VARIABLE) == 33 && $game_switches[168]
	  wld_graphic    = "DTS/PTs/Char_MEIMU"
	else
	  wld_graphic    = "DTS/PTs/Wild_MEIMU"
	end
    wld_name       = "DTS/Names/Name_MEIMU_W"
    black_bars     = "DTS/BorderBars"
	wld_title      = "DTS/Names/Title_MEIMU"
    # Set up sprites
    # Background Graphic
    background              = Sprite.new(viewport)
    background.bitmap       = RPG::Cache.transition(bg_graphic)
    background.z            = 99990
    background.opacity      = 0
    # Character portrait and shadow
    portrait                = Sprite.new(viewport)
    portrait_shadow         = Sprite.new(viewport)
    portrait.bitmap         = RPG::Cache.transition(wld_graphic)
    portrait_shadow.bitmap  = RPG::Cache.transition(wld_graphic)   
    portrait.z              = 99996
    portrait.ox             = portrait.bitmap.width/2
    portrait.x              = Graphics.width/2 + 96
	portrait.oy             = portrait.bitmap.height
	portrait.y              = Graphics.height 
    portrait.opacity        = 0
    portrait_shadow.tone    = Tone.new(-255, -255, -255)
    portrait_shadow.opacity = 0
    portrait_shadow.z       = portrait.z - 1
    portrait_shadow.ox      = portrait.bitmap.width/2
	portrait_shadow.x       = Graphics.width/2  + 96
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
    wildname         = dkConvertNameToBitmap(viewport, foe, battle_type)
    wildname.z       = barbottom.z += 2
    wildname.opacity = 0    
	
	wildtitle         = Sprite.new(viewport)
	wildtitle.bitmap  = RPG::Cache.transition(wld_title)
	wildtitle.opacity = 0
	wildtitle.z       = 99999
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
    
   # Fade to black, then fade in the background and black bars
    flash.tone = Tone.new(-255, -255, -255)   # Make the flash black
	pbWait(0.75) do |delta_t|
      flash.opacity = lerp(0, 255, 0.25, delta_t)   # Fade to black
	end
	
	bartop.opacity    = 230
    barbottom.opacity = 230
	background.opacity = 255
    pbWait(1) do |delta_t| # There was a 15 frame wait after the start of the background fading in. Is this right?
      flash.opacity      = lerp(255, 0, 0.25, delta_t)
	  #background.opacity = lerp(0, 255, 0.25, delta_t)
    end
    
    # Flash the screen, display the character's shadow portrait
    flash.tone = Tone.new(255, 255, 255)
	pbSEPlay("Vs flash")
    flash.opacity = 255
    
    pbWait(1.5) do |delta_t| # Initial delay was 40 frames after start of shadow showing up.
      flash.opacity           = lerp(255, 0, 0.25, delta_t)
      portrait_shadow.opacity = 192
    end
    
    # Flash the screen again, display the character's portrait. Begin shifting shadow leftward.
    pbSEPlay("Vs sword")
    flash.opacity = 255
    
    original_x = portrait_shadow.x
    pbWait(4) do |delta_t| # Initial delay was 60 frames after start of portrait showing up.
      flash.opacity      = lerp(255, 0, 0.5, delta_t)
      portrait.opacity   = 255
      wildname.opacity   = 255
	  wildtitle.opacity  = 255
      portrait_shadow.x  = lerp(original_x, original_x - 6, 1.5, delta_t)
    end    
    
    # Fade out all graphics, then change their color tone to black (Is that still necessary?)
    flash.tone = Tone.new(-255, -255, -255)
    pbWait(0.3) do |delta_t|
      flash.opacity = lerp(0, 255, 0.25, delta_t)
    end

    # End of animation
    flash.dispose
    wildname.dispose
	wildtitle.dispose
    background.dispose
    portrait.dispose
    portrait_shadow.dispose
    bartop.dispose
    barbottom.dispose
	$game_temp.vs_name = nil
	$game_temp.transition_animation_data = nil

    viewport.color = Color.black   # Ensure screen is black
  }
)

#===============================================================================
# Vs. Three Fairies of Light (Triple Battle, text during transition)
#===============================================================================
SpecialBattleIntroAnimations.register("vs_threefairies", 100,   # Priority 100
  proc { |battle_type, foe, location|   # Condition
    next false if ![1, 3].include?(battle_type)
	next true if foe[0].trainer_type == :THREEFAIRY
  },
  proc { |viewport, battle_type, foe, location|   # Animation
    #$game_temp.vs_name = dkGetTrainerName(foe)
    # Determine filenames of graphics to be used
    BAR_DISPLAY_WIDTH = 248
	#tr_type  = foe[0].trainer_type
    bg_name        = $game_temp.get_vs_transition_bg
    bg_graphic     = sprintf("DTS/BGs/BG%s", bg_name.to_s) rescue nil
	tr1_graphic    = sprintf("DTS/PTs/Char_SUNNYT") rescue nil
	tr2_graphic    = sprintf("DTS/PTs/Char_START") rescue nil
	tr3_graphic    = sprintf("DTS/PTs/Char_LUNAT") rescue nil
    black_bars     = sprintf("DTS/BorderBars") rescue nil
    # Set up sprites
	ball_sprites     = dkDisplayBallCount(viewport, foe, 0) # Create the ball count for trainer 0
	ball_sprites2    = dkDisplayBallCount(viewport, foe, 0) # Create the ball count for trainer 1
	ball_sprites3    = dkDisplayBallCount(viewport, foe, 0) # Create the ball count for trainer 2
	ball_bar         = Sprite.new(viewport)
    ball_bar.bitmap  = RPG::Cache.transition("DTS/Balls/overlay_lineup.png")
    ball_bar.x       = -440
    ball_bar.y       = 292
	ball_bar.z       = 99998
    # Background Graphic
    background              = Sprite.new(viewport)
    background.bitmap       = RPG::Cache.transition(bg_graphic)
    background.z            = 99990
    background.opacity      = 0
    # Trainer 1 portrait and shadow
    portrait                = Sprite.new(viewport)
    portrait_shadow         = Sprite.new(viewport)
    portrait.bitmap         = RPG::Cache.transition(tr1_graphic)
    portrait_shadow.bitmap  = RPG::Cache.transition(tr1_graphic)   
    portrait.z              = 99997
    portrait.ox             = portrait.bitmap.width/2
    portrait.x              = Graphics.width/2
	portrait.oy             = portrait.bitmap.height
	portrait.y              = Graphics.height
    portrait.opacity        = 0
    portrait_shadow.tone    = Tone.new(-255, -255, -255)
    portrait_shadow.opacity = 0
    portrait_shadow.z       = portrait.z - 1
    portrait_shadow.ox      = portrait.bitmap.width/2
	portrait_shadow.x       = Graphics.width/2
	portrait_shadow.oy      = portrait.bitmap.height
	portrait_shadow.y       = Graphics.height
    # Trainer 2 portrait and shadow
    portrait2                = Sprite.new(viewport)
    portrait2_shadow         = Sprite.new(viewport)
    portrait2.bitmap         = RPG::Cache.transition(tr2_graphic)
    portrait2_shadow.bitmap  = RPG::Cache.transition(tr2_graphic)   
    portrait2.z              = 99996
    portrait2.ox             = portrait2.bitmap.width/2
    portrait2.x              = Graphics.width/2 - 128
	portrait2.oy             = portrait2.bitmap.height
	portrait2.y              = Graphics.height
    portrait2.opacity        = 0
    portrait2_shadow.tone    = Tone.new(-255, -255, -255)
    portrait2_shadow.opacity = 0
    portrait2_shadow.z       = portrait2.z - 1
	portrait2_shadow.ox      = portrait2.bitmap.width/2
	portrait2_shadow.x       = Graphics.width/2 - 128
	portrait2_shadow.oy      = portrait2.bitmap.height
	portrait2_shadow.y       = Graphics.height
	# Trainer 3 portrait and shadow
    portrait3                = Sprite.new(viewport)
    portrait3_shadow         = Sprite.new(viewport)
    portrait3.bitmap         = RPG::Cache.transition(tr3_graphic)
    portrait3_shadow.bitmap  = RPG::Cache.transition(tr3_graphic)   
    portrait3.z              = 99996
    portrait3.ox             = portrait3.bitmap.width/2
    portrait3.x              = Graphics.width/2 + 192
	portrait3.oy             = portrait3.bitmap.height
	portrait3.y              = Graphics.height
    portrait3.opacity        = 0
    portrait3_shadow.tone    = Tone.new(-255, -255, -255)
    portrait3_shadow.opacity = 0
    portrait3_shadow.z       = portrait3.z - 1
	portrait3_shadow.ox      = portrait3.bitmap.width/2
	portrait3_shadow.x       = Graphics.width/2 + 192
	portrait3_shadow.oy      = portrait3.bitmap.height
	portrait3_shadow.y       = Graphics.height
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
    
    # Fade to black, then fade in the background and black bars
    flash.tone = Tone.new(-255, -255, -255)   # Make the flash black
	pbWait(0.75) do |delta_t|
      flash.opacity = lerp(0, 255, 0.25, delta_t)   # Fade to black
	end
	
	bartop.opacity    = 230
    barbottom.opacity = 230
	background.opacity = 255
    pbWait(0.2) do |delta_t| # There was a 15 frame wait after the start of the background fading in. Is this right?
      flash.opacity      = lerp(255, 0, 0.25, delta_t)
	  #background.opacity = lerp(0, 255, 0.25, delta_t)
    end
    
    # Flash the screen, display Luna's shadow portrait
    flash.tone = Tone.new(255, 255, 255)
	pbSEPlay("Vs flash", 80, 100)
    flash.opacity = 255
    
    pbWait(0.15) do |delta_t| # Initial delay was 40 frames after start of shadow showing up.
      flash.opacity            = lerp(255, 0, 0.15, delta_t)
	  portrait3_shadow.opacity = 192
    end
	if !$game_switches[168]
	  pbMessage(_INTL("\\w[]\\se[]\\ts[]<i>Star light...</i>\\wtnp[30]"))
	else
	  pbWait(1.5)
	end
	
    # Flash the screen, Hide Luna, display Star's shadow portrait
    flash.tone = Tone.new(255, 255, 255)
	pbSEPlay("Vs flash", 80, 120)
    flash.opacity = 255
    
    pbWait(0.25) do |delta_t| # Initial delay was 40 frames after start of shadow showing up.
      flash.opacity           = lerp(255, 0, 0.25, delta_t)
      portrait2_shadow.opacity = 192
	  portrait3_shadow.opacity = 0
    end	
	if !$game_switches[168]
	  pbMessage(_INTL("\\w[]\\se[]\\ts[]<ar><i>Star bright...</i></ar>\\wtnp[24]"))
	else
	  pbWait(1.3)
	end
	
    # Flash the screen, hide Star, display Sunny's shadow portrait
    flash.tone = Tone.new(255, 255, 255)
	pbSEPlay("Vs flash", 80, 80)
    flash.opacity = 255
    
    pbWait(0.25) do |delta_t| # Initial delay was 40 frames after start of shadow showing up.
      flash.opacity           = lerp(255, 0, 0.25, delta_t)
      portrait2_shadow.opacity = 0
	  portrait_shadow.opacity = 192
    end
	if !$game_switches[168]
	  pbMessage(_INTL("\\w[]\\se[]\\ts[]<ac>\\l[3]<i>We're the three brightest stars in the sky tonight!</i></ac>\\wtnp[45]"))
	else
	  pbWait(2.5)
	end
	
	
    # Flash the screen, display all character's shadow portrait
    flash.tone = Tone.new(255, 255, 255)
	pbSEPlay("Vs flash", 80, 100)
    flash.opacity = 255
    
    pbWait(0.25) do |delta_t| # Initial delay was 40 frames after start of shadow showing up.
      flash.opacity           = lerp(255, 0, 0.25, delta_t)
      portrait_shadow.opacity = 192
	  portrait2_shadow.opacity = 192
	  portrait3_shadow.opacity = 192
    end
	if !$game_switches[168]
	  pbMessage(_INTL("\\w[]\\se[]\\ts[]<ac><i>Ready, let's settle this once and for all!</ac></i>\\wtnp[137]"))
	else
	  pbWait(6)
	end
    
    # Flash the screen again, display the character's portrait. Begin shifting shadow leftward.
    pbSEPlay("Vs sword")
    flash.opacity = 255
    
    original_x = portrait_shadow.x
	original2_x = portrait2_shadow.x
	original3_x = portrait3_shadow.x
    pbWait(4) do |delta_t| # Initial delay was 60 frames after start of portrait showing up.
      flash.opacity     = lerp(255, 0, 0.5, delta_t)
      portrait.opacity  = 255
	  portrait2.opacity  = 255
	  portrait3.opacity  = 255
      charname.opacity  = 255
      portrait_shadow.x = lerp(original_x, original_x - 6, 1.5, delta_t)
	  portrait2_shadow.x = lerp(original2_x, original2_x - 6, 1.5, delta_t)
	  portrait3_shadow.x = lerp(original3_x, original3_x - 6, 1.5, delta_t)
      ball_sprites.each_with_index do |s,i|
        s.x = lerp(((Settings::MAX_PARTY_SIZE - i) * 32) - (Graphics.width/2), ((Settings::MAX_PARTY_SIZE - i) * 32), 0.4, delta_t)
      end
	  ball_bar.x = lerp(-440, -192, 0.4, delta_t)
    end    
    
    # Fade out all graphics, then change their color tone to black (Is that still necessary?)
    flash.tone = Tone.new(-255, -255, -255)
    pbWait(0.3) do |delta_t|
      flash.opacity = lerp(0, 255, 0.25, delta_t)
    end

    # End of animation
    flash.dispose
    charname.dispose
    background.dispose
    portrait.dispose
    portrait_shadow.dispose
	portrait2.dispose
    portrait2_shadow.dispose
	portrait3.dispose
    portrait3_shadow.dispose
    bartop.dispose
    barbottom.dispose
	ball_bar.dispose
	ball_sprites.each {|s| s.dispose}
	$game_temp.vs_name = nil
	$game_temp.transition_animation_data = nil

    viewport.color = Color.black   # Ensure screen is black
  }
)

#===============================================================================
# Vs. Prismriver Sisters (Double Battle, staggered portraits during transition)
#===============================================================================
SpecialBattleIntroAnimations.register("vs_prismrivers", 100,   # Priority 80
  proc { |battle_type, foe, location|   # Condition
    next false if ![1, 3].include?(battle_type)
	next true if foe[0].trainer_type == :PRISMRIVER
  },
  proc { |viewport, battle_type, foe, location|   # Animation
	#$game_temp.vs_name = dkGetTrainerName(foe)
	# Determine filenames of graphics to be used
    BAR_DISPLAY_WIDTH = 248
	#tr_type        = foe[0].trainer_type
    bg_name        = $game_temp.get_vs_transition_bg
    bg_graphic     = sprintf("DTS/BGs/BG%s", bg_name.to_s) rescue nil
	tr1_graphic    = sprintf("DTS/PTs/Char_LUNASA") rescue nil
	tr2_graphic    = sprintf("DTS/PTs/Char_LYRICA") rescue nil
	tr3_graphic    = sprintf("DTS/PTs/Char_MERLIN") rescue nil
    black_bars     = sprintf("DTS/BorderBars") rescue nil
    # Set up sprites
	ball_sprites     = dkDisplayBallCount(viewport, foe, 0) # Create the ball count for a trainer
	ball_bar         = Sprite.new(viewport)
    ball_bar.bitmap  = RPG::Cache.transition("DTS/Balls/overlay_lineup.png")
    ball_bar.x       = -440
    ball_bar.y       = 292
	ball_bar.z       = 99998
    # Background Graphic
    background              = Sprite.new(viewport)
    background.bitmap       = RPG::Cache.transition(bg_graphic)
    background.z            = 99990
    background.opacity      = 0
    # Trainer 1 portrait and shadow
    portrait                = Sprite.new(viewport)
    portrait_shadow         = Sprite.new(viewport)
    portrait.bitmap         = RPG::Cache.transition(tr1_graphic)
    portrait_shadow.bitmap  = RPG::Cache.transition(tr1_graphic)   
    portrait.z              = 99997
    portrait.ox             = portrait.bitmap.width/2
    portrait.x              = Graphics.width/2 + 35
	portrait.oy             = portrait.bitmap.height
	portrait.y              = Graphics.height
    portrait.opacity        = 0
    portrait_shadow.tone    = Tone.new(-255, -255, -255)
    portrait_shadow.opacity = 0
    portrait_shadow.z       = portrait.z - 1
    portrait_shadow.ox      = portrait.bitmap.width/2
	portrait_shadow.x       = Graphics.width/2 + 35
	portrait_shadow.oy      = portrait.bitmap.height
	portrait_shadow.y       = Graphics.height
    # Trainer 2 portrait and shadow
    portrait2                = Sprite.new(viewport)
    portrait2_shadow         = Sprite.new(viewport)
    portrait2.bitmap         = RPG::Cache.transition(tr2_graphic)
    portrait2_shadow.bitmap  = RPG::Cache.transition(tr2_graphic)   
    portrait2.z              = 99996
    portrait2.ox             = portrait2.bitmap.width/2
    portrait2.x              = Graphics.width/2 - 171
	portrait2.oy             = portrait2.bitmap.height
	portrait2.y              = Graphics.height
    portrait2.opacity        = 0
    portrait2_shadow.tone    = Tone.new(-255, -255, -255)
    portrait2_shadow.opacity = 0
    portrait2_shadow.z       = portrait2.z - 1
	portrait2_shadow.ox      = portrait2.bitmap.width/2
	portrait2_shadow.x       = Graphics.width/2 - 171
	portrait2_shadow.oy      = portrait2.bitmap.height
	portrait2_shadow.y       = Graphics.height
	# Trainer 3 portrait and shadow
    portrait3                = Sprite.new(viewport)
    portrait3_shadow         = Sprite.new(viewport)
    portrait3.bitmap         = RPG::Cache.transition(tr3_graphic)
    portrait3_shadow.bitmap  = RPG::Cache.transition(tr3_graphic)   
    portrait3.z              = 99996
    portrait3.ox             = portrait3.bitmap.width/2
    portrait3.x              = Graphics.width/2 + 140
	portrait3.oy             = portrait3.bitmap.height
	portrait3.y              = Graphics.height
    portrait3.opacity        = 0
    portrait3_shadow.tone    = Tone.new(-255, -255, -255)
    portrait3_shadow.opacity = 0
    portrait3_shadow.z       = portrait3.z - 1
	portrait3_shadow.ox      = portrait3.bitmap.width/2
	portrait3_shadow.x       = Graphics.width/2 + 140
	portrait3_shadow.oy      = portrait3.bitmap.height
	portrait3_shadow.y       = Graphics.height
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
    
    # Fade to black, then fade in the background and black bars
    flash.tone = Tone.new(-255, -255, -255)   # Make the flash black
	pbWait(0.75) do |delta_t|
      flash.opacity = lerp(0, 255, 0.25, delta_t)   # Fade to black
	end
	
	bartop.opacity    = 230
    barbottom.opacity = 230
	background.opacity = 255
    pbWait(1) do |delta_t| # There was a 15 frame wait after the start of the background fading in. Is this right?
      flash.opacity      = lerp(255, 0, 0.25, delta_t)
	  #background.opacity = lerp(0, 255, 0.25, delta_t)
    end
    
    # Flash the screen, display Merlin's shadow portrait
    flash.tone = Tone.new(255, 255, 255)
	pbSEPlay("Vs flash", 80, 100)
    flash.opacity = 255
    
    pbWait(1.5) do |delta_t| # Initial delay was 40 frames after start of shadow showing up.
      flash.opacity            = lerp(255, 0, 0.25, delta_t)
	  portrait3_shadow.opacity = 192
    end
	
    # Flash the screen, Hide Merlin, display Lyrica's shadow portrait
    flash.tone = Tone.new(255, 255, 255)
	pbSEPlay("Vs flash", 80, 120)
    flash.opacity = 255
    
    pbWait(1.5) do |delta_t| # Initial delay was 40 frames after start of shadow showing up.
      flash.opacity           = lerp(255, 0, 0.25, delta_t)
      portrait2_shadow.opacity = 192
	  portrait3_shadow.opacity = 0
    end	
	
    # Flash the screen, hide Lyrica, display Lunasa's shadow portrait
    flash.tone = Tone.new(255, 255, 255)
	pbSEPlay("Vs flash", 80, 80)
    flash.opacity = 255
    
    pbWait(1.5) do |delta_t| # Initial delay was 40 frames after start of shadow showing up.
      flash.opacity           = lerp(255, 0, 0.25, delta_t)
      portrait2_shadow.opacity = 0
	  portrait_shadow.opacity = 192
    end
	
	
    # Flash the screen, display all character's shadow portrait
    flash.tone = Tone.new(255, 255, 255)
	pbSEPlay("Vs flash", 80, 100)
    flash.opacity = 255
    
    pbWait(1.5) do |delta_t| # Initial delay was 40 frames after start of shadow showing up.
      flash.opacity           = lerp(255, 0, 0.25, delta_t)
      portrait_shadow.opacity = 192
	  portrait2_shadow.opacity = 192
	  portrait3_shadow.opacity = 192
    end
    
    # Flash the screen again, display the character's portrait and name. Begin shifting shadow leftward.
    pbSEPlay("Vs sword")
    flash.opacity = 255
    
    original_x = portrait_shadow.x
	original2_x = portrait2_shadow.x
	original3_x = portrait3_shadow.x
    pbWait(4) do |delta_t| # Initial delay was 60 frames after start of portrait showing up.
      flash.opacity     = lerp(255, 0, 0.5, delta_t)
      portrait.opacity  = 255
	  portrait2.opacity  = 255
	  portrait3.opacity  = 255
      charname.opacity  = 255
      portrait_shadow.x = lerp(original_x, original_x - 6, 1.5, delta_t)
	  portrait2_shadow.x = lerp(original2_x, original2_x - 6, 1.5, delta_t)
	  portrait3_shadow.x = lerp(original3_x, original3_x - 6, 1.5, delta_t)
      ball_sprites.each_with_index do |s,i|
        s.x = lerp(((Settings::MAX_PARTY_SIZE - i) * 32) - (Graphics.width/2), ((Settings::MAX_PARTY_SIZE - i) * 32), 0.4, delta_t)
      end
	  ball_bar.x = lerp(-440, -192, 0.4, delta_t)
    end    
    
    # Fade out all graphics, then change their color tone to black (Is that still necessary?)
    flash.tone = Tone.new(-255, -255, -255)
    pbWait(0.3) do |delta_t|
	  flash.opacity = lerp(0, 255, 0.25, delta_t)
    end

    # End of animation
    flash.dispose
    charname.dispose
    background.dispose
    portrait.dispose
    portrait_shadow.dispose
	portrait2.dispose
    portrait2_shadow.dispose
	portrait3.dispose
    portrait3_shadow.dispose
    bartop.dispose
    barbottom.dispose
	ball_bar.dispose
	ball_sprites.each {|s| s.dispose}
	$game_temp.vs_name = nil
	$game_temp.transition_animation_data = nil

    viewport.color = Color.black   # Ensure screen is black
  }
)

