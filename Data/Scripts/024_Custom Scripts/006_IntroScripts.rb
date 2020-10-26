class PlayerSelGUI
  def initialize
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @sprites = {}
    @sel = 0
    @sprites["bg"] = Sprite.new(@viewport)
    @sprites["bg"].bitmap = Bitmap.new("Graphics/Pictures/introCharSel")
#    @sprites["boy"] = Sprite.new(@viewport)
#    @sprites["boy"].bitmap = Bitmap.new("Graphics/Pictures/introboy")
#    @sprites["boy"].x = 112
#    @sprites["boy"].y = 98
#    @sprites["girl"] = Sprite.new(@viewport)
#    @sprites["girl"].bitmap = Bitmap.new("Graphics/Pictures/introgirl")
#    @sprites["girl"].x = 327
#    @sprites["girl"].y = 102
    @sprites["sel1"] = Sprite.new(@viewport)
    @sprites["sel1"].bitmap = Bitmap.new("Graphics/Pictures/introCharSel1")
#    @sprites["sel1"].x = 128
#    @sprites["sel1"].y = 23
    @sprites["sel2"] = Sprite.new(@viewport)
    @sprites["sel2"].bitmap = Bitmap.new("Graphics/Pictures/introCharSel2")    
    main
  end
  
  def main
    loop do
      Graphics.update
      Input.update
      if Input.trigger?(Input::RIGHT) && @sel == 0
        @sel = 1
        @sprites["sel2"]
      end
      if Input.trigger?(Input::LEFT) && @sel == 1
        @sel = 0
        @sprites["sel1"]
      end
      if Input.trigger?(Input::C)
        cmd = Kernel.pbConfirmMessage(_INTL("Is this the correct photo to upload? This can be changed later at any Pokemon Center if need be."))
        if cmd
          pbChangePlayer(@sel)
          break
        end
      end
    end
    dispose
  end
  
  def dispose
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end
end

def pbPlayerSelect

end