#==================================================================
# Touhoumon Asteria - Special Scenes
#==================================================================
# This section is for special gui scenes in Asteria that can't
# really be handled any other way- to my knowledge, at least.
#
# These scenes can be the player selection GUI, or a special
# cutscene, or even a trade where you want to show the recipient's
# Pokemon/Puppets off. Limitless possibilities, endless laziness!!
#==================================================================
# Player Slection GUI
#==================================================================
class PlayerChoiceGUI
  def initialize
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @sprites = {}
    @sel = 0
    @sprites["bg"] = Sprite.new(@viewport)
    @sprites["bg"].bitmap = Bitmap.new("Graphics/Pictures/Intro/IntroBG")
    @sprites["bg"].opacity = 0
    @sprites["renko"] = Sprite.new(@viewport)
    @sprites["renko"].bitmap = Bitmap.new("Graphics/Pictures/Intro/Intro_Renko")
    @sprites["renko"].opacity = 0
    @sprites["mary"] = Sprite.new(@viewport)
    @sprites["mary"].bitmap = Bitmap.new("Graphics/Pictures/Intro/Intro_Maribel")
    @sprites["mary"].opacity = 0
    @sprites["please"] = Sprite.new(@viewport)
    @sprites["please"].bitmap = Bitmap.new("Graphics/Pictures/Intro/Please_Choose")
    @sprites["please"].opacity = 0
    main
  end
  
  def main
    32.times { 
       Graphics.update
       @sprites["bg"].opacity += 8
			 @sprites["renko"].opacity += 8
       @sprites["mary"].opacity += 8
    }
    Kernel.pbMessage(_INTL("\\w[dark]In this game you play as either Renko Usami or Maribel Hearn."))
    Kernel.pbMessage(_INTL("\\w[dark]This decision cannot be changed later, and has no significant impact on the game aside from slight dialogue differences."))
    Kernel.pbMessage(_INTL("\\w[dark]Please choose who you would like to play as.\\wtnp[1]"))
    @sprites["please"].opacity = 255
		@sprites["mary"].opacity = 191
    loop do
      Graphics.update
      Input.update
      if Input.trigger?(Input::RIGHT) && @sel == 0
        @sel = 1
        @sprites["renko"].opacity = 191
        @sprites["mary"].opacity = 255
      end
      if Input.trigger?(Input::LEFT) && @sel == 1
        @sel = 0
        @sprites["renko"].opacity = 255
        @sprites["mary"].opacity = 191
      end
      if Input.trigger?(Input::C)
		@sprites["please"].opacity = 0
        cmd = Kernel.pbConfirmMessage(_INTL("\\w[dark]Are you sure you want to play as #{@sel == 0 ? "Renko Usami" : "Maribel Hearn"}?"))
        if cmd
          pbChangePlayer(@sel+1)
          $game_variables[107] = @sel
          break
        end
	  @sprites["please"].opacity = 255
      end
    end
		@sprites["renko"].opacity = 255
		@sprites["mary"].opacity = 255
		@sprites["please"].opacity = 0
    32.times { 
       Graphics.update
       @sprites["bg"].opacity -= 8
			 @sprites["renko"].opacity -= 8
       @sprites["mary"].opacity -= 8
    }
    dispose
  end
  
  def dispose
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end
end

#==================================================================
# Teacher Polly's trades
#==================================================================
#class TradeSummaryCutsceneGUI
#  def initialize
#	@viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
#    @sprites = {}
#    @sel = 0
#    @sprites["pkmnsummary"] = Sprite.new(@viewport)
#    @sprites["pkmnsummary"].bitmap = Bitmap.new("Graphics/Pictures/Special Scenes/PollyTrade/{1}_1",$game_variables[1])
#    @sprites["pkmnsummary"].opacity = 0
#    main
#  end
  
#  def main
#    32.times { 
#       Graphics.update
#       @sprites["pkmnsummary"].opacity += 8
#    }

#end