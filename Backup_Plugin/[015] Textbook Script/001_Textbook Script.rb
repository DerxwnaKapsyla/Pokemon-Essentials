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

MewtwoProject = [
"Project M-No. #002: Overview","Project Head: Dr. Fuji, head of Cinnabar Island Lab\nHead Assistant: Blaine\nProject Benefactor: -------\n\nThis journal's purpose is to document the process involved with Project M-No. #002, henceforth refered to as \"The Mewtwo Project\".",
"Project M-No. #002: Entry 1","February 6th, 19xx.\nOur efforts finally bore fruit today! The eyelash we managed to find within the ruins located in the jungles of Kikoto has produced a healthy specimen! The eyelash strand, confirmed to be one from the mythical Pokémon, Mew, contained just enough DNA for us to do a full replication procedure on it. Though I documented this months ago in the journal of the failed Project #001", 
"Project M-No. #002: Entry 1","it is today that we finally have a stable offspring of Mew! We shall call this new Pokémon, the clone of Mew, a fitting name- Mewtwo. We now have something we can report back to our benefactor as good news. From here, things can only go up!",
"Project M-No. #002: Entry 2","February 15th, 19xx.\nOur benefactor is pleased with our results, and he has given us enough funding to get us through the next few months. We will be meeting up with him and his associates for celebratory drinks- he even offered to pay for all drinks. What a generous man! Onto the Mewtwo Project itself, all signs are good. Mewtwo's rowth rate is accelerating, he may need to be moved to a new tank sometime",
"Project M-No. #002: Entry 2","soon. Several scientists have run simulations and we've concluded that Mewtwo's power will rival even an Alakazam in terms of psychokinetic potential. My head assistant on this project, Blaine, has suggested that we create a focusing item for Mewtwo, preferably a large spoon. While it is a good idea, we should focus on making sure we keep Mewtwo stabilized and prevent cellular degradation like our past attempts.",
"Project M-No. #002: Entry 2","Ah, it's almost 6 pm. I should get ready to head out for drinks shortly!",
"Project M-No. #002: Entry 3","February 25th, 19xx.\nMewtwo is showing signs of heightened awareness; he is capable of understanding what we're doing. Though he makes no physical response, we are picking up active brain waves in response to things we say and do. At such an early stage of development, we did not expect this to be possible! This just goes to show the potential of Mewtwo! Our benefactor is more than pleased with the",
"Project M-No. #002: Entry 3","results we're giving him. He states that we can procede to \"Phase 2\" soon. I'm not entirely aware of what Phase 2 is, but it is by his generocity that we are able to remain a functioning station and continue our research into cloning. Mewtwo will be our grand project to show the world just what the potential prowess of cloning can accomplish!",
"Project M-No. #002: Entry 4","March 18th, 19xx.\nMewtwo's initial storange tank finally cracked today. We've moved him to a larger one, which should contain his growth until it reaches its peak. Our benefactor has funneled even more money to us, and has tasked us with further enhancing Mewtwo's abilities. I'm not sure why we would need to go much further, current simulations show Mewtwo as able to stand toe-to-toe with an Alakazam.",
"Project M-No. #002: Entry 3","I am concerned that if we go through with that, Mewtwo could begin to degrade similar to past experiments. However, we are not in a position to say no to him. I just hope Mewtwo can survive the additional recompilements...",
"Project M-No. #002: Entry 4","April 23rd, 19xx.\nWe began the process of recompiling Mewtwo's genetic structure and abilities The results are... We aren't sure what to make of them. On one hand, Mewtwo is surviving the procedures and being strengthened as a result. Current calculations have projected Mewtwo's power scaling far beyond revised expectations. Forget Alakazam, Mewtwo's power will reach uncharted territories- there is nothing even",
"Project M-No. #002: Entry 4","remotely close to its projected power level. I submited my findings to our benefactor yesterday, and he was enthralled... and told us to push Mewtwo even further. Something doesn't seem right about this. It almost- no, it definitely feels like we're torturing Mewtwo. We shouldn't be doing this. I need to address these concerns to the benefactor. He has been generous so far, surely he must understand that Mewtwo's current state is",
"Project M-No. #002: Entry 4","uncomparable, and we can allow it to rest and grow naturally.",
"Project M-No. #002: Entry 5","May 30th, 19xx.\nI spoke to the benefactor recently and addressed the concerns that myself and our team were having. The response was... far from what I was hoping for. No, it was much worse. In no simple terms, he told us to press forward with the procedures, and put Mewtwo's well being out of our minds. He had no regard for the life that we had created, and was content with the suffering we were",
"Project M-No. #002: Entry 5","forcing it to endure. His heartless and dismissive responsive has given me second thoughts about him now. I informed my team about this, and we are hesitant to continue doing anything in regards to Mewtwo, but we don't have much choice in the matter. I'm starting to feel less like a scientist and more like a monster.",
"Project M-No. #002: Entry 6","July 11th, 19xx.\nI have learned a terrible truth; after hiring an expert private investigator to look into the matter, we have discovered what \"Phase 2\" of our benefactor's plan is, and I understand now the grave mistake we have made. Phase 2 is an attempt to create a Superweapon in the form of a Pokémon, the first of its kind.",
"Project M-No. #002: Entry 6","He wants to use this project to conquer others without a chance of retaliation, to keep them under his bootheel. This... This isn't what we wanted. Our goals were to showcase the potentials of cloning! It's positive aspects and benefits! Instead, all we've done is create a weapon to destroy! This is not how it should be- Pokémon are not tools meant for conquerting others!",
"Project M-No. #002: Entry 6","I do not think I can keep working on this project in all good conscience anymore. The rest of the team is showing hesitation constantly, knowing all that we know now. Is this something any of us can continue doing? Even if it means our facility gets shut down, and all our life's work goes up in smoke? What is the right choice: sacrificing our morality for the sake of science? Or sacrifice everything we've done,",
"Project M-No. #002: Entry 6","everything we could ever do, to spare the world from the nightmare we've created.\n\nWe will need to think on this. A lot.",
"Project M-No. #002: Entry 7","August 8th, 19xx.\nWe have made our choice- the choice to shut down the project prematurely. To bring an end to Mewtwo's life before the Benefactor could ever lay their hands on it.\n\nIt failed.",
"Project M-No. #002: Entry 7","When we unplugged the life support system, Mewtwo's brainwaves went ballistic almost instantly. It could tell what we were doing and was actively fighting against it. Any normal creature would have perished by that point. But not Mewtwo, no. We made it better than that. A \"success\". Mewtwo's will allowed it to survive and thrive. Even now, as I write this entry, Mewtwo's power level is rising exponentially.",
"Project M-No. #002: Entry 7","At the rate its scaling, we expect it to become fully concious in a matter of weeks. All we can do is wait for the inevitable day when it breaks its shackles. Perhaps we can develop suppressants in the meanwhile, but I highly doubt that will work. Regardless, we have all agreed to not let the Benefactor know any of this. The less he knows, the better off we'll be. It's a matter of time before this explodes in our faces.",
"Project M-No. #002: Entry 8","September 1st, 19xx.\nToday was the day Mewtwo woke up. Immediately upon waking, it broke from containment and managed to escape the lab while we tried to suppress it. Several scientists were injured in the process. At this point, we have no idea where it is. I have no doubt that Giovanni's associates will learn of this failure shortly. He will more than likely have our heads the moment he learns of it. ",
"Project M-No. #002: Entry 8","As such, I've instructed my fellow scientists to go into hiding as best they can. However, I have no idea how effective that'll be. Thanks to the private investigator I hired, I learned that Giovanni and his associates have most of Kanto in their grasp- apparently he controls the criminal underworld of Kanto.",
"Project M-No. #002: Entry 8","Some of us should be fine though. Blaine is a Gym Leader, if something happened to him, the entire public would be suspicious of something. As for me, I shall be taking refuge in the place where I spent my youth. Maybe I'll start a facility that takes in mistreated and abandoned Pokémon. It's the least I can do to make up for these mistakes that I'll never be able to atone for.",
"Project M-No. #002: Entry 8","This shall be my last entry as head scientist of Cinnabar Lab. If you end up finding this lab, this journal, I implore you- please, do not make the same mistakes we did. This is my final message to you, future reader:\n\nWe were tasked to create the world's strongest Pokémon.\nAnd we succeeded.\n\n- Dr. Fuji, Ex-Head of Cinnabar Mansion",
]

FailedClone = [
"Project M-No. #000: Overview","Project Head: Dr. Fuji, head of Cinnabar Island Lab\nHead Assistant: Blaine\n\nThis journal's purpose is to document the process involved with Project M-No. #000, a failed clone of Mew.",
"Project M-No. #000: Overview","Project Goal: Produce a clone of the Mythical Pokémon, Mew.\nHow: By using the fragmented remains of a strand of hair, we believe we can replictae Mew's entire DNA structure.\nWhy: To show the scientific community, and the world thereafter, the positive aspects and benefits of genetic replication.\nEnd result: Failure",
"Project M-No. #000: Summary","October 19th, 19xx.\nEarlier this year, my research team and I had heard reports of Mew, the Mythical Pokémon, showing up within the jungles of the Kikoto continent. When we arrived at the destination, all we could find was one solitary fragment of hair. To date, we aren't sure if this strand actually contained Mew's DNA in any capacity.",
"Project M-No. #000: Summary","We were able to isolate a strand of DNA within the fragment, and from it we were able to produce something. Something small, but still progress nonetheless we figured. We gave it the codename M0, as we weren't entirely sure if it was Mew's DNA contributing to it. M0, unfortunately, did not stay stable long. It quickly began to engage in cellular degradation. The extent of the damage to itself was severe. ",
"Project M-No. #000: Summary","In an effort to try and stabilize it, we placed it in a special containment unit, quarantined off from the rest of the facility for special observation, in the hopes that maybe it would stabilize. Unfortunately, it never did- rather, the degradation got worse with each passing day. Something interesting to note was that it managed to develop some unique abilities of its own. One of these abilities seems to be some form of flawless matter replication.",
"Project M-No. #000: Summary","One day we had accidentally left a portable data drive in it's isolated chamber, and when a scientist went back to retrieve it, they discovered that the room was filled with data drives, all containing the exact same data, completely unaltered. We tested it further and noticed that it was able to duplicate every sixth item we present it with. It's a cruel form of irony that it developed this power.",
"Project M-No. #000: Summary","Another thing we've noticed is that it seems to have an affect on electronics surounding it. It's been difficult to procure readings on it as a result. Fortunately, it doesn't seem too severe right now. It is possible that, as it continues to degrade, its affect on electronics may grow worse. It's possible that, if left unchecked, it could develop the ability to disorient entire communication networks. ",
"Project M-No. #000: Summary","Hopefully we'll be able to address that before it gets that bad. For now though, keeping it in its containment corner should be measure enough.\nOfficial Status of Experiment M-No. #000: Project terminated, leaving in quarantined observation. Locking mechanism requires two people to depower the containment device.",
]

Books = [
	SeiraDiary,
	GensouKyouEdict,
	Puppetmaster,
	MewtwoProject,
	FailedClone
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

ItemHandlers::UseInField.add(:MEWTWOPROJECT,proc { |item|
  textbook(3)
  next 1
})

ItemHandlers::UseInField.add(:FAILEDCLONE,proc { |item|
  textbook(4)
  next 1
})