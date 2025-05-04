class PWTStreak_Scene
  def pbUpdate
    pbUpdateSpriteHash(@sprites)
  end
  
  def pbStartScene
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport.z = 99999
    @sprites = {}
	addBackgroundPlane(@sprites, "bg", "PWT/pwtStreakBoard", @viewport)
    @sprites["overlay"] = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
    pbSetSystemFont(@sprites["overlay"].bitmap)
	pbDrawStreakScreen
	pbFadeInAndShow(@sprites) { pbUpdate }
  end
  
  def pbDrawStreakScreen
    overlay = @sprites["overlay"].bitmap
	overlay.clear
    baseColor   = Color.new(72, 72, 72)
    shadowColor = Color.new(160, 160, 160)

    [:Easy_Diff, :Normal_Diff, :Hard_Diff, :Lunatic_Diff, :Extra_Mode].each do |diff|
      $stats.pwt_wins[diff]       ||= 0
      $stats.pwt_loss[diff]       ||= 0
      $stats.pwt_win_streak[diff] ||= 0
    end	
	
	easywins    = ($stats.pwt_wins[:Easy_Diff]           > 999) ? _INTL("999+") : $stats.pwt_wins[:Easy_Diff]
	easyloss    = ($stats.pwt_loss[:Easy_Diff]           > 999) ? _INTL("999+") : $stats.pwt_loss[:Easy_Diff]
	easystreak  = ($stats.pwt_win_streak[:Easy_Diff]     > 999) ? _INTL("999+") : $stats.pwt_win_streak[:Easy_Diff]
	normwins    = ($stats.pwt_wins[:Normal_Diff]         > 999) ? _INTL("999+") : $stats.pwt_wins[:Normal_Diff]
	normloss    = ($stats.pwt_loss[:Normal_Diff]         > 999) ? _INTL("999+") : $stats.pwt_loss[:Normal_Diff]
	normstreak  = ($stats.pwt_win_streak[:Normal_Diff]   > 999) ? _INTL("999+") : $stats.pwt_win_streak[:Normal_Diff]
	hardwins    = ($stats.pwt_wins[:Hard_Diff]           > 999) ? _INTL("999+") : $stats.pwt_wins[:Hard_Diff]
	hardloss    = ($stats.pwt_loss[:Hard_Diff]           > 999) ? _INTL("999+") : $stats.pwt_loss[:Hard_Diff]
	hardstreak  = ($stats.pwt_win_streak[:Hard_Diff]     > 999) ? _INTL("999+") : $stats.pwt_win_streak[:Hard_Diff]
	lunawins    = ($stats.pwt_wins[:Lunatic_Diff]        > 999) ? _INTL("999+") : $stats.pwt_wins[:Lunatic_Diff]
	lunaloss    = ($stats.pwt_loss[:Lunatic_Diff]        > 999) ? _INTL("999+") : $stats.pwt_loss[:Lunatic_Diff]
	lunastreak  = ($stats.pwt_win_streak[:Lunatic_Diff]  > 999) ? _INTL("999+") : $stats.pwt_win_streak[:Lunatic_Diff]
	exwins      = ($stats.pwt_wins[:Extra_Mode]          > 999) ? _INTL("999+") : $stats.pwt_wins[:Extra_Mode]
	exloss      = ($stats.pwt_loss[:Extra_Mode]          > 999) ? _INTL("999+") : $stats.pwt_loss[:Extra_Mode]
	exstreak    = ($stats.pwt_win_streak[:Extra_Mode]    > 999) ? _INTL("999+") : $stats.pwt_win_streak[:Extra_Mode]
	textPosition = [
	  [_INTL("{1}'s Village Tournament Results",$player.name), 255, 52, :center, baseColor, shadowColor],
	  [_INTL("Cumulative"),     324,  92, :left, baseColor, shadowColor],
	  [_INTL("Difficulty"),      83, 124, :left, baseColor, shadowColor],
	  [_INTL("Wins"),           268, 124, :left, baseColor, shadowColor],
	  [_INTL("Losses"),         328, 124, :left, baseColor, shadowColor],
	  [_INTL("Streak"),         418, 124, :left, baseColor, shadowColor],
	  [_INTL("Easy"),            56, 162, :left, baseColor, shadowColor],
	  [_INTL("Normal"),          56, 200, :left, baseColor, shadowColor],
	  [_INTL("Hard"),            56, 238, :left, baseColor, shadowColor],
	  [_INTL("Lunatic"),         56, 276, :left, baseColor, shadowColor],
	  [_INTL("Extra"),           56, 314, :left, baseColor, shadowColor],
	  [_INTL("(Lv. 30)"),       210, 162, :right, baseColor, shadowColor],
	  [_INTL("(Lv. 45)"),       210, 200, :right, baseColor, shadowColor],
	  [_INTL("(Lv. 60)"),       210, 238, :right, baseColor, shadowColor],
	  [_INTL("(Lv. 75)"),       210, 276, :right, baseColor, shadowColor],
	  [_INTL("(Lv100)"),        210, 314, :right, baseColor, shadowColor],
	  [_INTL("{1}",easywins),   286, 162, :center, baseColor, shadowColor],
	  [_INTL("{1}",easyloss),   363, 162, :center, baseColor, shadowColor],
	  [_INTL("{1}",easystreak), 454, 162, :center, baseColor, shadowColor],
	  [_INTL("{1}",normwins),   286, 200, :center, baseColor, shadowColor],
	  [_INTL("{1}",normloss),   363, 200, :center, baseColor, shadowColor],
	  [_INTL("{1}",normstreak), 454, 200, :center, baseColor, shadowColor],
	  [_INTL("{1}",hardwins),   286, 238, :center, baseColor, shadowColor],
	  [_INTL("{1}",hardloss),   363, 238, :center, baseColor, shadowColor],
	  [_INTL("{1}",hardstreak), 454, 238, :center, baseColor, shadowColor],
	  [_INTL("{1}",lunawins),   286, 276, :center, baseColor, shadowColor],
	  [_INTL("{1}",lunaloss),   363, 276, :center, baseColor, shadowColor],
	  [_INTL("{1}",lunastreak), 454, 276, :center, baseColor, shadowColor],
	  [_INTL("{1}",exwins),     286, 314, :center, baseColor, shadowColor],
	  [_INTL("{1}",exloss),     363, 314, :center, baseColor, shadowColor],
	  [_INTL("{1}",exstreak),   454, 314, :center, baseColor, shadowColor]
	]
	pbDrawTextPositions(overlay, textPosition)
  end
  
  def pbStreakScreen
    pbSEPlay("GUI trainer card open")
	loop do
	  Graphics.update
	  Input.update
	  pbUpdate
	  if Input.trigger?(Input::BACK)
	    pbPlayCloseMenuSE
		break
	  end
	end
  end
  
  def pbEndScene
    pbFadeOutAndHide(@sprites) { pbUpdate }
	pbDisposeSpriteHash(@sprites)
	@viewport.dispose
  end
end

class PWTStreakScreen
  def initialize(scene)
    @scene = scene
  end
  
  def pbStartScreen
    @scene.pbStartScene
    @scene.pbStreakScreen
    @scene.pbEndScene
  end
end