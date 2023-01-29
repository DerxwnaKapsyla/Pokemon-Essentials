#books
FCoBT4 = [
"Final Coil of Bahamut - Turn 4","\n\n\n\nRestored to his senses in defeat, Louisoix uses his final moments to send your party to the main bridge of the final internment hulk, there to banish Bahamut once and for all. Yet though the end of your arduous",
"Final Coil of Bahamut - Turn 4","\n\n\n\njourney is in sight, doubt not but that the cornered primal will lash out with his unbridled rage. If you are to overcome this terrible foe, you and your partners must be of one purpose.",
"Final Coil of Bahamut - Turn 4","\n\n\n\nJoin now your hearts and minds, and sally forth to bring the Seventh Umbral Era to its true conclusion- for the future of Eorzea!"
]

FCoBT4_Savage = [
"Final Coil of Bahamut - Turn 4","\n\n\n\nRestored to his senses in defeat, Louisoix uses his final moments to send your party to the main bridge of the final internment hulk, there to banish Bahamut once and for all. Yet though the end of your arduous",
"Final Coil of Bahamut - Turn 4","\n\n\n\njourney is in sight, doubt not but that the cornered primal will lash out with his unbridled rage. If you are to overcome this terrible foe, you and your partners must be of one purpose.",
"Final Coil of Bahamut - Turn 4","\n\n\n\nJoin now your hearts and minds, and sally forth to bring the Seventh Umbral Era to its true conclusion- for the future of Eorzea!"
]

Books = [
		 FCoBT4,
		 FCoBT4_Savage
		]

def textbook(book)
    scene = Textbook_Scene.new
    screen = TextbookScreen.new(scene)
    screen.pbStartTextbookScreen(book)
    yield if block_given?
    pbFadeInAndShow(@sprites)
end


class TextbookScreen
  def initialize(scene)
    @scene = scene
  end

  def pbStartTextbookScreen(book)
    @scene.pbStartTextbookScene(book)
    ret = @scene.pbTextbookScene
    @scene.pbEndScene
    return ret
  end

end


class Textbook_Scene

  def pbUpdate
    pbUpdateSpriteHash(@sprites)
  end

  def pbStartTextbookScene(book)
    @viewport = Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z = 99999
    @page = 0
    @book = book
    @bookarray= Books[book]
    @max=Books[book].length#)+4)/2
    #@max+=4
    #@max/=2
    @sprites = {}
    @sprites["background"] = IconSprite.new(0,0,@viewport)
    @sprites["overlay"] = BitmapSprite.new(Graphics.width,Graphics.height,@viewport)
    pbSetSystemFont(@sprites["overlay"].bitmap)
    @sprites["leftarrow"] = AnimatedSprite.new("Graphics/Pictures/leftarrow",8,40,28,2,@viewport)
    @sprites["leftarrow"].x       = -4
    @sprites["leftarrow"].y       = 10
    @sprites["leftarrow"].play
    @sprites["rightarrow"] = AnimatedSprite.new("Graphics/Pictures/rightarrow",8,40,28,2,@viewport)
    @sprites["rightarrow"].x       = (Graphics.width)-36
    @sprites["rightarrow"].y       = 10
    @sprites["rightarrow"].visible = (!@choosing || numfilledpockets>1)
    @sprites["rightarrow"].play
    drawTextbookPage(@page)
    pbFadeInAndShow(@sprites) { pbUpdate }
  end

  def pbEndScene
    pbFadeOutAndHide(@sprites) { pbUpdate }
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end


  def drawTextbookPage(page)
    book   = @book
    @sprites["leftarrow"].visible = (@page>0)
    @sprites["rightarrow"].visible = (@page+3<@max)
    overlay = @sprites["overlay"].bitmap
    overlay.clear
    base   = Color.new(0,0,0)
    # Set background image
    @sprites["background"].setBitmap("Graphics/Pictures/textbookbg")
    imagepos=[]
    # Write various bits of text
    pagename = @bookarray[page]
    textpos = [
       [pagename,Graphics.width/2,12,2,base]
    ]
    #For title size
    @sprites["overlay"].bitmap.font.size=32
    pbDrawTextPositions(overlay,textpos)
    @sprites["overlay"].bitmap.font.size=26
    text=@bookarray[page+1]
    drawFormattedTextEx(overlay,25,55,Graphics.width-40,text,base)
  end


  def pbTextbookScene
    loop do
      Graphics.update
      Input.update
      pbUpdate
      dorefresh = false
      if Input.trigger?(Input::BACK)
        pbPlayCloseMenuSE
        break
      elsif Input.trigger?(Input::LEFT)
        oldpage = @page
        @page -= 2
        @page = 0 if @page<0
        if @page!=oldpage   # Move to next page
          pbSEPlay("GUI summary change page")
          dorefresh = true
        end
      elsif Input.trigger?(Input::RIGHT)
        oldpage = @page
        @page += 2
        @page = @max-2 if @page+3>@max
        if @page!=oldpage   # Move to next page
          pbSEPlay("GUI summary change page")
          dorefresh = true
        end
      end
      if dorefresh
        drawTextbookPage(@page)
      end
    end
  end
end