def textbook(book)
   # oldsprites = pbFadeOutAndHide(@sprites)
    scene = Textbook_Scene.new
    screen = TextbookScreen.new(scene)
    screen.pbStartTextbookScreen(book)
    yield if block_given?
    pbFadeInAndShow(@sprites)#,oldsprites)
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


#books
SeiraDiary = [
"Diary of Seira Hakurei","Today was the final day of the meeting between all involved parties, and the council came to a decision. I wasn't able to be there for it, as I was tending to the shrine, but Meira told me the news once she returned. According to her, the council agreed that the best solution was the one proposed by the Youkai Sage- the Youkai and those sympathetic to them would be separated from the world. I wasn't really sure what that meant, so Meira explained it to me. ",
"Diary of Seira Hakurei","With the power of both the Hakurei and the Youkai Sage of Boundaries, a great barrier would be established which would seal Youkai away in a gensou kyou- a land of illusions, where only the phantasmal would reside. Supposedly, while Humans and Youkai are allowed to enter, one of the conditions was that Pokémon not be allowed. Pokémon are to remain outside the barrier, while Youkai inside of it. Given the incidents in the past, I can't say I'm surprised by that condition.",
"Diary of Seira Hakurei","There is one thing about this plan that I don't agree with, though. According to Meira, for it to work, the focal point needs to be our home- the Hakurei Shrine, and that one needs to exist on both sides of the barrier to maintain the seal. That's all fine and dandy, but, for a shrine to exist, it needs a shrine maiden. After our parents died, there are only two left- my twin sister Meira and myself. In order for the plan to work, one of us needs to enter the gensou kyou and upkeep the",
"Diary of Seira Hakurei","shrine on that side, while the other maintains it over here. We're not exactly children anymore, no, but I can't help but feel distressed that Meira and I have to be separated and be unable to see each other ever again. I will talk to her and see if perhaps there's another way, maybe we can brainstorm something. I really don't want to lose the only family I have left, especially not my sister.\n- Seira Hakurei"
]

GensouKyouEdict = [
"The Gensou Kyou Edict: Info","At dusk's rise, we, the members of this council, have come to a decision regarding the series of incidents between Humans, Youkai, and Pokémon caught between them. In three months time, an area of land will be quarantined off with the Hakurei Shrine at its center that shall be the new home of Youkai and the Humans who wish to coexist with them. Said idea was proposed by the Youkai Sage of Boundaries, Yukari Yakumo, who claims that her and her kin have grown tired of fighting,",
"The Gensou Kyou Edict: Info","and would like a place where they can reside in peace and isolation. The local shrine maiden, Meira Hakurei, has seconded the notion, volunteering herself to be the one to enter this quarantined land to serve as the one to upkeep the barrier, while her sister, Seira Hakurei, will make the precautions to ensure it stays stable outside of the barrier. This plan shall henceforth be known as the \"Gensou Kyou edict\".",
"The Gensou Kyou Edict: Info","We, the undersigned, hereby agree to the following terms and conditions of this edict.",
"The Gensou Kyou Edict: Terms","Condition 1: All Youkai must vacate to the quarantined area before the end of the third month. Those who don't will be exterminated.\nCondition 2: All Humans who wish to join the Youkai must vacate to the quarantined area before the end of the third month.\nCondition 3: All Pokémon and Humans with Pokémon are forbidden from entering and residing in the quarantined area.",
"The Gensou Kyou Edict: Terms","Condition 4: All Youkai caught leaving the quarantined area after it has been sealed off will be exterminated on sight.\nCondition 5: All Humans caught leaving the quarantined area after it has been sealed off will be exiled from the nearby villages.",
"The Gensou Kyou Edict: Signed","Meira Hakurei, Shrine Maiden of Hakurei Shrine\nYukari Yakumo, Youkai Sage and representative of Youkai\nKuro Enju, Chief of E. Village and representative of Humans.\nShinako, Ascendant Espeon and Representative of Pokémon"
]

Puppetmaster = [
"Operation Puppetmaster","The following locations of interest are suspected as connected to The Source in some way. Dispatch teams to investigate the following areas.\nKanto Safari Zone - Ruins\nCinnabar Volcano Depths\nAzurine City myth?\nBrass Tower\nWhirl Islands\nMt. Mortar Heights\nJohto's Battle Tower",
"Operation Puppetmaster","This data was obtained when we hacked into the continental network mainframe to scan for abnormalities after the distraction caused by the Power Plant hijacking.\nAn \"abnormality\" in this case is defined as an abnormal energy signature where a great surge of P-class entities are discovered. The Cave of Origin is the known first place of abnormality. Using the data from that, we have compared the energy signatures at the Cave of Origin on that",
"Operation Puppetmaster","day to those across the continent. Provided our theory is correct, these abnormalities should provide a way to access The Source, where more P-class entities are, possibly stronger ones that don't exist here."
]

Books = [
SeiraDiary,
GensouKyouEdict,
Puppetmaster
]

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
    #base = Color.new(255,255,255)
    # Set background image
    @sprites["background"].setBitmap("Graphics/Pictures/textbookbg")
    imagepos=[]
    # Write various bits of text
    pagename = @bookarray[page]
    textpos = [
       [pagename,Graphics.width/2,12,2,base]#,shadow]
    ]
    #For title size
    @sprites["overlay"].bitmap.font.size=32
    pbDrawTextPositions(overlay,textpos)
    @sprites["overlay"].bitmap.font.size=26
    text=@bookarray[page+1]
    drawFormattedTextEx(overlay,25,44,Graphics.width-40,text,base)#,shadow)
  end


  def pbTextbookScene
    loop do
      Graphics.update
      Input.update
      pbUpdate
      dorefresh = false
      if Input.trigger?(Input::B)
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

#########################################
ItemHandlers::UseInField.add(:SEIRADIARY,proc { |item|
  textbook(0)
  next 1
})

ItemHandlers::UseInField.add(:GENSOUEDICT,proc { |item|
  textbook(1)
  next 1
})

ItemHandlers::UseInField.add(:TRBINDER,proc { |item|
  textbook(2)
  next 1
})