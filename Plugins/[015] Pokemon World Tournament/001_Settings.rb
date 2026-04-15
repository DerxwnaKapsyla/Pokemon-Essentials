module PWTSettings
# Information pertining to the start position on the PWT stage
# Format is as following: [map_id, map_x, map_y]
PWT_MAP_DATA = [22,14,21]
# ID for the event used to move the player and opponents on the map
PWT_MOVE_EVENT = 24
# ID of the opponent event
PWT_OPP_EVENT = 1
# ID of the scoreboard event
PWT_SCORE_BOARD_EVENT = 25
# ID of the lobby trainer event
PWT_LOBBY_EVENT = 59
# ID of the event used to display an optional even if the player wins the PWT
PWT_FANFARE_EVENT = 23
# If marked as true, it will apply a multiplier based on the player's current win streak. Defeault to false.
PWT_STREAK_MULT = true
# If marked as true, it will use DeltaTime, otherwise, it will use the old frame system
PWT_USE_DELTA_TIME = false
# Target framerate. By default it's usually 60 fps with MKXP-Z.
PWT_DEFAULT_FRAMERATE = 60
end

module GameData
  class PWTTournament
    attr_reader :id
    attr_reader :real_name
    attr_reader :trainers
    attr_reader :condition_proc
	attr_reader :points_won

    DATA = {}

    extend ClassMethodsSymbols
    include InstanceMethods

    def self.load; end
    def self.save; end

    def initialize(hash)
      @id             = hash[:id]
      @real_name      = hash[:name]          || "Unnamed"
      @trainers       = hash[:trainers]
      @condition_proc = hash[:condition_proc]
      @rules_proc     = hash[:rules_proc]
      @banned_proc    = hash[:banned_proc]
	  @points_won     = hash[:points_won]    || 3
    end

    # @return [String] the translated name of this nature
    def name
      return _INTL(@real_name)
    end
    
    def call_condition(*args)
      return (@condition_proc) ? @condition_proc.call(*args) : true
    end
    def call_rules(*args)
      return (@rules_proc) ? @rules_proc.call(*args) : PokemonChallengeRules.new
    end
    def call_ban_reason(*args)
      return (@banned_proc) ? @banned_proc.call(*args) : nil
    end
  end
end

##################################################################
# The format for defining individual Tournaments is as follows.
##################################################################
=begin
GameData::PWTTournament.register({
  :id => :Tutorial_Tournament,			# Internal name of the Tournament to be called
  :name => _INTL("Kanto Leaders"),		# Display name of the Tournament in the choice selection box
  :trainers => [						# Array that contains all of the posssible trainers in a Tournament. Must have at least 8.
                [:ID,"Trainer Name","Player Victory Dialogue.","",Variant Number], # Trainer 1
				[:ID,"Trainer Name","Player Victory Dialogue.","",Variant Number]  # Trainer 2, etc
			   ],
										# Trainers follow this exact format. 
										# ID and Trainer Name are mandatory.
										# Victory dialogue will default to "..." if not filled.
										# Lose dialogue will default to "..." is not filled in either here or trainers.txt. If Lose dialogue is filled here, it overrides the defined line from trainers.txt
										# Variant Number will default to 0 if not filled.
										# If there is no Lobby Dialogue they will not appear in the Lobby map
										# Pre- and Post-battle Dialogue is optional and will display nothing if not filled.
  :condition_proc => proc { 			# The conditions under which this Tournament shows up in the choice selection box. Optional.
	next $PokemonGlobal.hallOfFameLastNumber > 0 
  },					
  :rules_proc => proc {|length|			# This defines the rules for the rules for an individual tournament. More rules can be found in the Challenge Rules script sections
	rules = PokemonChallengeRules.new
    rules.addPokemonRule(BannedSpeciesRestriction.new(:MEWTWO,:MEW,:HOOH,:LUGIA,:CELEBI,:KYOGRE,:GROUDON,:RAYQUAZA,
                                                      :DEOXYS,:JIRACHI,:DIALGA,:PALKIA,:GIRATINA,:REGIGIGAS,:HEATRAN,:DARKRAI,
                                                      :SHAYMIN,:ARCEUS,:ZEKROM,:RESHIRAM,:KYUREM,:LANDORUS,:MELOETTA,
                                                      :KELDEO,:GENESECT))
    rules.addPokemonRule(NonEggRestriction.new)
    rules.addPokemonRule(AblePokemonRestriction.new)
    rules.setNumber(length)
    rules.setLevelAdjustment(FixedLevelAdjustment.new(50))
	next rules
  },
  :banned_proc => proc {				# Displays a message when a team is ineligable to be used in a tournament.
	pbMessage(_INTL("Certain exotic species, as well as eggs, are ineligible.\\1"))
  },
  :points_won => 2						# A configurable amount of Battle Points won after a tournament.
})
=end
##################################################################

GameData::PWTTournament.register({
  :id => :Easy_Diff,
  :name => _INTL("Easy"),
  :trainers => [
                [:PWT_YOUTH_M,"Shouta","Aw, drat!","",100], 
                [:PWT_YOUTH_M,"Yuuichi","Oh no, not my Puppets!","",100], 
                [:PWT_YOUTH_M,"Osamu","You're so strong... I wanna be just like you!","",100], 
                [:PWT_YOUTH_M,"Ryusei","You just got lucky! Hmph!","",100], 
                [:PWT_YOUTH_F,"Mirin","I need to get better at handling my Puppets...","",100], 
                [:PWT_YOUTH_F,"Sachie","I wonder if I can find cuter Puppets outside the Village...","",100], 
				[:PWT_YOUTH_F,"Yuzu","I need to head home and give my Puppets a well earned rest!","",100], 
                [:PWT_YOUTH_F,"Azumi","I guess happiness can exist without music.","",100], 
                [:PWT_FAIRY_1,"Mirai","What do you mean I'm not scary!","",100,nil,"I'm a spoooky ghoost~","Maybe I should put on my Zombie Fairy cosplay next time!"], 
                [:PWT_FAIRY_1,"Himawari","It...it IS spring, isn't it?","",100,nil,"It's spring! It's spring!","My Puppets always think it's spring, and I don't want to argue with them..."], 
                [:PWT_FAIRY_1,"Koko","Pretty, and strong as well!","",100,nil,"Those are some pretty Puppets you have! Can I borrow them for a while?","I was going to give them back when I was done looking..."], 
                [:PWT_FAIRY_2,"Ami","Is there a magic spell that prevents me from losing?","",100,nil,"I cast a spell on you! Poof, now you're going to battle me!","I found this book called \"Being a Magician for Dummies\", it's taught me a lot!"], 
                [:PWT_FAIRY_2,"Miru","Wait, I think I got this wrong...","",100,nil,"Would you like to play? <icon=bunnylover.png>\\[ffffffff].","The Pure Love badge is supposed to make me take less damage from enemies if they're girls, right?"], 
				[:PWT_FAIRY_2,"Seles","Happy underappreciated Puppets day!","",100,nil,"'tis the season!","A lot of my friends think that my Puppets are lame..."], 
				[:PWT_SUPERVISOR_M,"Rolo","I should have left sword studying to Kengo...","",100], 
				[:PWT_SUPERVISOR_M,"Kengo","Perhaps I should train more under Rolo...","",100], 
				[:PWT_SUPERVISOR_F,"Rei","A marvelous battle, well done.","",100], 
				[:PWT_SUPERVISOR_F,"Hinoka","Commanding Puppets is an artform, and you look to be a talented artisan","",100], 
				# ---- Gensokyo's Finest
                [:KOKORO,"Hata no Kokoro","Hahaha, t'was a memorable dance indeed!","Though your show ends here, your performance was remarkable!",100,"A performance is ever changing with the times, how shall yours evolve I wonder?","Let us give this crowd a dance that shan't soon forget!","Ohoho, I much look forward to seeing you come back. Having a partner like you would excite me to no end!","Kokoro"] # Kokoro
               ],
  :rules_proc => proc {|length|
    rules = PokemonChallengeRules.new
    rules.addPokemonRule(BannedSpeciesRestriction.new(:MEWTWO,:MEW,:HOOH,:LUGIA,:CELEBI,:KYOGRE,:GROUDON,:RAYQUAZA,
                                                      :DEOXYS,:JIRACHI,:DIALGA,:PALKIA,:GIRATINA,:REGIGIGAS,:HEATRAN,:DARKRAI,
                                                      :SHAYMIN,:ARCEUS,:ZEKROM,:RESHIRAM,:KYUREM,:LANDORUS,:MELOETTA,
                                                      :KELDEO,:GENESECT,:MEIMU))
    rules.addPokemonRule(NonEggRestriction.new)
    rules.addPokemonRule(AblePokemonRestriction.new)
    rules.setNumber(length)
    rules.setLevelAdjustment(FixedLevelAdjustment.new(30))
    next rules
  },
  :banned_proc => proc {
    pbMessage(_INTL("Certain exotic species, as well as eggs, are ineligible.\\1"))
  },
  :points_won => 2
})

GameData::PWTTournament.register({
  :id => :Normal_Diif,
  :name => _INTL("Normal"),
  :trainers => [
                [:PWT_YOUTH_M,"Ryusei","You just got lucky! Hmph!","",200], 
                [:PWT_YOUTH_M,"Yuuichi","Oh no, not my Puppets!","",200], 
                [:PWT_YOUTH_F,"Yuzu","I need to head home and give my Puppets a well earned rest!","",200], 
                [:PWT_YOUTH_F,"Azumi","I guess happiness can exist without music.","",200], 
                [:PWT_VILLAGEACE_M,"Takumi","I'll beat you one day, I'm sure of it!","",200], 
                [:PWT_VILLAGEACE_M,"Shimada","My research must continue, even if I fall here.","",200], 
				[:PWT_VILLAGEACE_M,"Tatsu","I have let you down, father.","",200], 
                [:PWT_VILLAGEACE_M,"Shinzo","Destiny has said I shall fall here today, it would seem.","",200], 
                [:PWT_VILLAGEACE_F,"Riko","I bet Mom and Dad are proud of you, \\pn!","Are you sure you didn't go easy on me, \\pn?",200,nil,"You'll go easy on your big sis, right? No? Good! I wouldn't have it any other way.","I need to get back and help Mom with some of the food, enjoy the rest of the Festival!"], 
                [:PWT_VILLAGEACE_F,"Yumika","Why? Y-not!","",200], 
                [:PWT_VILLAGEACE_F,"Kairi","I've heard the ocean is beautiful, I want to see it one day.","",200], 
                [:PWT_VILLAGEACE_F,"Yuriko","Unforgivable! I'll remember this!","",200], 
				[:PWT_FAIRY_1,"Mirai","What do you mean I'm not scary!","",200,nil,"I'm a spoooky ghoost~","Maybe I should put on my Zombie Fairy cosplay next time!"], 
				[:PWT_FAIRY_1,"Koko","Pretty, and strong as well!","",200,nil,"Those are some pretty Puppets you have! Can I borrow them for a while?","I was going to give them back when I was done looking..."], 
				[:PWT_FAIRY_2,"Miru","Wait, I think I got this wrong...","",200,nil,"Would you like to play? <icon=bunnylover.png>\\[ffffffff].","The Pure Love badge is supposed to make me take less damage from enemies if they're girls, right?"], 
				[:PWT_FAIRY_2,"Seles","Happy underappreciated Puppets day!","",200,nil,"'tis the season!","A lot of my friends think that my Puppets are lame..."], 
				[:PWT_FAIRY_G,"Callie","Guh!","",200,nil,"Behold Gensokyo's first Reaper Fairy!","It's hard breaking into the reaper business... Maybe I should have tried to be a rapper instead."], 
                [:PWT_FAIRY_G,"Himawari","You bested me...!","",200,nil,"A Greater Fairy is a cut above the riff raff! I'll show you just how powerful we are!","Wow... Maybe you're strong enough to go toe to toe with the Zephyr Legions..."], 
				[:PWT_FAIRY_G,"Sugar Satellite","Pain and defeat is proof I exist, right?","",200,nil,"I'll prove I exist, here and now!","I won't rest until people all across Gensokyo recognize me and my powers!"], 
                [:PWT_FAIRY_G,"Maria","But... The might of the Moon!","",200,nil,"Take note! The full might of the Lunar Empire shall fall upon you, puny mortal!","We shall be back to conquer your lands with our airships one day!"], 
                [:PWT_FAIRY_G,"Keri","This is the part where I transform into a super awesome second form, right?","",200,nil,"The Fairy of Death descends upon the battlefield once more!","Aaaany day now..."], 
				[:PWT_FAIRY_G,"Zima","I guess going second has its benefits too, doesn't it?","",200,nil,"Let's play a game! I'll go first!","Even the fastest can learn from those slower than them."], 
				[:PWT_SUPERVISOR_M,"Rolo","I should have left sword studying to Kengo...","",200], 
				[:PWT_SUPERVISOR_M,"Kengo","Perhaps I should train more under Rolo...","",200], 
				[:PWT_SUPERVISOR_F,"Rei","A marvelous battle, well done.","",200], 
				[:PWT_SUPERVISOR_F,"Hinoka","Commanding Puppets is an artform, and you look to be a talented artisan","",200], 
				# ---- Gensokyo's Finest
                [:KOKORO,"Hata no Kokoro","Hahaha, t'was a memorable dance indeed!","Though your show ends here, your performance was remarkable!",200,"A performance is ever changing with the times, how shall yours evolve I wonder?","Let us give this crowd a dance that shan't soon forget!","Ohoho, I much look forward to seeing you come back. Having a partner like you would excite me to no end!","Kokoro"] # Kokoro
               ],
  :rules_proc => proc {|length|
    rules = PokemonChallengeRules.new
    rules.addPokemonRule(BannedSpeciesRestriction.new(:MEWTWO,:MEW,:HOOH,:LUGIA,:CELEBI,:KYOGRE,:GROUDON,:RAYQUAZA,
                                                      :DEOXYS,:JIRACHI,:DIALGA,:PALKIA,:GIRATINA,:REGIGIGAS,:HEATRAN,:DARKRAI,
                                                      :SHAYMIN,:ARCEUS,:ZEKROM,:RESHIRAM,:KYUREM,:LANDORUS,:MELOETTA,
                                                      :KELDEO,:GENESECT,:MEIMU))
    rules.addPokemonRule(NonEggRestriction.new)
    rules.addPokemonRule(AblePokemonRestriction.new)
    rules.setNumber(length)
    rules.setLevelAdjustment(FixedLevelAdjustment.new(45))
    next rules
  },
  :banned_proc => proc {
    pbMessage(_INTL("Certain exotic species, as well as eggs, are ineligible.\\1"))
  },
  :points_won => 4
})

GameData::PWTTournament.register({
  :id => :Hard_Diff,
  :name => _INTL("Hard"),
  :trainers => [
				[:PWT_VILLAGEACE_M,"Takumi","I'll beat you one day, I'm sure of it!","",300], 
                [:PWT_VILLAGEACE_M,"Shimada","My research must continue, even if I fall here.","",300], 
				[:PWT_VILLAGEACE_M,"Tatsu","I have let you down, father.","",300], 
                [:PWT_VILLAGEACE_M,"Shinzo","Destiny has said I shall fall here today, it would seem.","",300], 
                [:PWT_VILLAGEACE_F,"Riko","I bet Mom and Dad are proud of you, \\pn!","",300], 
                [:PWT_VILLAGEACE_F,"Yumika","Why? Y-not!","",300], 
                [:PWT_VILLAGEACE_F,"Kairi","I've heard the ocean is beautiful, I want to see it one day.","",300], 
                [:PWT_VILLAGEACE_F,"Yuriko","Unforgivable! I'll remember this!","",300], 
				[:PWT_FAIRY_G,"Callie","Guh!","",300,nil,"Behold Gensokyo's first Reaper Fairy!","It's hard breaking into the reaper business... Maybe I should have tried to be a rapper instead."], 
				[:PWT_FAIRY_G,"Sugar Satellite","Pain and defeat is proof I exist, right?","",300,nil,"I'll prove I exist, here and now!","I won't rest until people all across Gensokyo recognize me and my powers!"], 
				[:PWT_FAIRY_G,"Keri","This is the part where I transform into a super awesome second form, right?","",300,nil,"The Fairy of Death descends upon the battlefield once more!","Aaaany day now..."], 
				[:PWT_FAIRY_G,"Zima","I guess going second has its benefits too, doesn't it?","",300,nil,"Let's play a game! I'll go first!","Even the fastest can learn from those slower than them."], 
				[:PWT_FAIRY_Z,"Akane","G-Gao...","",300,nil,"I'm the predator your parents warned you about! Rawr!","Maybe I should try a new approach. I wonder how fangs would look?"], 
				[:PWT_FAIRY_Z,"Mana","Best two out of three?","",300,nil,"I call upon the mystic powers of the gods... So I can kick your ass in Smash!","I heard Humans in the Village talk like this... Tell me, what is dash canceling?"], 
				[:PWT_FAIRY_Z,"Reda","Perhaps a class change is in order.","",300,nil,"Halt! As the Fairy of Light, I can't allow your deeds to go unchecked any longer!","I can switch between any role I want! Samurai, Dark Knight, Dragoon. Even Blue Mage!"], 
				[:PWT_FAIRY_Z,"Miyra","Is there something else I should work into my regiment?","",300,nil,"Punch, punch, punch. Kick, kick, kick! Our workout regiment is never over!","Punch, punch, punch. Kick, kick, kick..."], 
				[:PWT_FAIRY_Z,"Katou","Yes, yes this is perfect!","",300,nil,"Hold still! I have inspiration for my next piece!","Were you surprised by my Puppets moves? Akyuu is quite versatile and creative!"], 
                [:PWT_FAIRY_Z,"Amira","As the strongest, I graciously accept my defeat.","",300,"I'm the stongest fairy in all of the realms! Fight me!","There is but only one fate for the strongest. To get stronger."], 
				[:PWT_YOUKAI_1,"Thelia","Ow, ow! It was a joke! You don't have to be so mean!","",300,nil,"Ohoho? Now what's a little human like you doing here? You look good enough to eat...~","Sorry, sorry! Most Youkai here in the forest have given up on eating random Humans if they aren't a threat."], 
				[:PWT_YOUKAI_1,"Shuri","A strong human at that!","",300,nil,"Whohoho! A Human here in the Forest? That's unexpected!","Gotta say, we don't see your kind come around here often!"], 
				[:PWT_YOUKAI_1,"Minako","At least, that's what I'd like to believe...","",300,nil,"Did you know, I almost caused an incident once!","Maybe one day I will start an incident! You never know!"], 
				[:PWT_YOUKAI_2,"Jun","Perhaps a tournament isn't the best time to get reading in.","",300,nil,"I just got to the good part of my book, don't interupt me now!","The forest is probably a better spot for me to get reading in, I suppose."], 
				[:PWT_YOUKAI_2,"Ayana","So, shall I put you down as a maybe?","",300,nil,"Have you heard of Makai? Great tourist destination!","We don't see very many people come to Makai these days, I wonder why..."], 
                [:PWT_YOUKAI_2,"Akumo","Eep! Too bright!","",300,nil,"Behold the terrors of the night!","The night is full of terrors, but not if you're not scared of them..."], 
				[:PWT_SUPERVISOR_M,"Ryoma","My team of crimson powerhouses was felled quite easily at your hand.","",300], 
				[:PWT_SUPERVISOR_M,"Rolo","I should have left sword studying to Kengo...","",300], 
				[:PWT_SUPERVISOR_M,"Kengo","Perhaps I should train more under Rolo...","",300], 
				[:PWT_SUPERVISOR_F,"Rei","A marvelous battle, well done.","",300], 
				[:PWT_SUPERVISOR_F,"Hinoka","Commanding Puppets is an artform, and you look to be a talented artisan","",300], 
				[:PWT_SUPERVISOR_F,"Sakura","There's something soothing about being surounded by Shrine Maidens...","",300], 
				# ---- Gensokyo's Finest
                [:KOKORO,"Hata no Kokoro","Hahaha, t'was a memorable dance indeed!","Though your show ends here, your performance was remarkable!",300,"A performance is ever changing with the times, how shall yours evolve I wonder?","Let us give this crowd a dance that shan't soon forget!","Ohoho, I much look forward to seeing you come back. Having a partner like you would excite me to no end!","Kokoro"],
				[:MINORIKO,"Minoriko Aki","My word, you are quite the strong Puppet handler!","Oh, did I go too hard on you? My bad!",300,nil,"Are you ready to give the crowd a show befiting the stage of this Harvest Festival?","You are quite the battler! I look forward to challenging you again."],
				[:NITORI_Tr,"Nitori Kawashiro","Remarkable! This will be excellent data!","Remarkable! This will be excellent data!",300,nil,"I need to get some data for my new inventions. Can you help me with that?","Your assistance is appreciated in furthering the ambitions of science!"],
				[:HATATE,"Hatate Himekaidou","This battle would make for great news material!","Maybe because I beat you, I'll outdo the Bunbunmaru in sales!",300,"I've gotta get back to the mountain and start working on my next article!","If I beat you, you have to give me an interview!","Well... Can you still give me one? I need something good for my paper!"],
				[:HINA_T,"Hina Kagiyama","You deal with misfortune quite well.","I can help you deal with your misfortune if you need it.",300,nil,"I shouldn't linger in the Village for too long, lest misfortune curse the Village, so let us resolve this battle quick!","Thank you for indulging my fancies, I must return to the woods to ensure that no malevolence escapes from it."], # Hina, for real this time
				[:START,"Star Sapphire","Eek! This Villager is powerful!","I won! ...I won?",300,nil,"I'll predict your Puppets movements before you even give them a command!","Maybe things would have gone different if I was battling alongside Luna and Sunny..."],
				[:LUNAT,"Luna Child","My prank backfired!","And that's why you never mess with a fairy~",300,nil,"How well can you command your Puppets if I take away their ability to hear things?","If Star and Sunny were here, this would have been an entirely different story!"],
				[:SUNNYT,"Sunny Milk","Time to get the sun in your eyes while I run away!","What's the matter, can't handle a little light?",300,nil,"Hehe, you look like a fun target! C'mon, let me dazzle you with my light show!","Puppet handlers sure are strong, but when I'm with Luna and Star, we can't ever be beaten!"],
				# What, you didn't think Medicine would show up, did you?
				[:ELLY,"Elly","Ow- Haven't had a battle like that in a long time!","I guess I'm not losing my touch after all!",300,nil,"I am here while my mistress achieves whatever it is shes here for!","Lady Yuuka wanted to come see this year's Harvest Festival, but she never told me why..."],
				[:YUUKA,"Yuuka Kazami","I can see it now, you will blossom into a remarkable flower...~","If you can't handle me now, I look forward to a rematch in the future.",300,nil,"I suppose I can indulge myself while I am here, can you give me a good time?","Perhaps I shall see you again one day, I would quite enjoy battling you again~."],
				[:HIKARI,"Hikari Hoshizora","No gods or legends can stand against you, t'would seem!","And that's why I'm a legend!",300,"I should get back to the Yama 'fore she notices I've slipped out.","D'you have what it takes to stand against a Legend Hunter?","I wonder if an Avatar woulda made a difference here... Oh well!"]
               ],
  :condition_proc => proc {
	$game_switches[121] || $game_switches[107]
  },
  :rules_proc => proc {|length|
    rules = PokemonChallengeRules.new
    rules.addPokemonRule(BannedSpeciesRestriction.new(:MEWTWO,:MEW,:HOOH,:LUGIA,:CELEBI,:KYOGRE,:GROUDON,:RAYQUAZA,
                                                      :DEOXYS,:JIRACHI,:DIALGA,:PALKIA,:GIRATINA,:REGIGIGAS,:HEATRAN,:DARKRAI,
                                                      :SHAYMIN,:ARCEUS,:ZEKROM,:RESHIRAM,:KYUREM,:LANDORUS,:MELOETTA,
                                                      :KELDEO,:GENESECT,:MEIMU))
    rules.addPokemonRule(NonEggRestriction.new)
    rules.addPokemonRule(AblePokemonRestriction.new)
    rules.setNumber(length)
    rules.setLevelAdjustment(FixedLevelAdjustment.new(60))
    next rules
  },
  :banned_proc => proc {
    pbMessage(_INTL("Certain exotic species, as well as eggs, are ineligible.\\1"))
  },
  :points_won => 6
})

GameData::PWTTournament.register({
  :id => :Lunatic_Diff,
  :name => _INTL("Lunatic"),
  :trainers => [
				[:PWT_VILLAGEACE_M,"Shimada","My research must continue, even if I fall here.","",400], 
				[:PWT_VILLAGEACE_M,"Tatsu","I have let you down, father.","",400], 
                [:PWT_VILLAGEACE_M,"Shinzo","Destiny has said I shall fall here today, it would seem.","",400], 
				[:PWT_VILLAGEACE_F,"Yumika","Why? Y-not!","",400], 
                [:PWT_VILLAGEACE_F,"Kairi","I've heard the ocean is beautiful, I want to see it one day.","",400], 
                [:PWT_VILLAGEACE_F,"Yuriko","Unforgivable! I'll remember this!","",400], 
				[:PWT_FAIRY_Z,"Mana","Best two out of three?","",400,nil,"I call upon the mystic powers of the gods... So I can kick your ass in Smash!","I heard Humans in the Village talk like this... Tell me, what is dash canceling?"], 
				[:PWT_FAIRY_Z,"Reda","Perhaps a class change is in order.","",400,nil,"Halt! As the Fairy of Light, I can't allow your deeds to go unchecked any longer!","I can switch between any role I want! Samurai, Dark Knight, Dragoon. Even Blue Mage!"], 
				[:PWT_FAIRY_Z,"Miyra","Is there something else I should work into my regiment?","",400,nil,"Punch, punch, punch. Kick, kick, kick! Our workout regiment is never over!","Punch, punch, punch. Kick, kick, kick..."], 
				[:PWT_FAIRY_Z,"Katou","Yes, yes this is perfect!","",400,nil,"Hold still! I have inspiration for my next piece!","Were you surprised by my Puppets moves? Akyuu is quite versatile and creative!"], 
				# ---- Gensokyo's Finest
                [:KOKORO,"Hata no Kokoro","Hahaha, t'was a memorable dance indeed!","Though your show ends here, your performance was remarkable!",400,"A performance is ever changing with the times, how shall yours evolve I wonder?","Let us give this crowd a dance that shan't soon forget!","Ohoho, I much look forward to seeing you come back. Having a partner like you would excite me to no end!","Kokoro"],
				[:MINORIKO,"Minoriko Aki","My word, you are quite the strong Puppet handler!","Oh, did I go too hard on you? My bad!",400,nil,"Are you ready to give the crowd a show befiting the stage of this Harvest Festival?","You are quite the battler! I look forward to challenging you again."],
				[:NITORI_Tr,"Nitori Kawashiro","Remarkable! This will be excellent data!","Remarkable! This will be excellent data!",400,nil,"I need to get some data for my new inventions. Can you help me with that?","Your assistance is appreciated in furthering the ambitions of science!"],
				[:HATATE,"Hatate Himekaidou","This battle would make for great news material!","Maybe because I beat you, I'll outdo the Bunbunmaru in sales!",400,"I've gotta get back to the mountain and start working on my next article!","If I beat you, you have to give me an interview!","Well... Can you still give me one? I need something good for my paper!"],
				[:HINA_T,"Hina Kagiyama","You deal with misfortune quite well.","I can help you deal with your misfortune if you need it.",400,nil,"I shouldn't linger in the Village for too long, lest misfortune curse the Village, so let us resolve this battle quick!","Thank you for indulging my fancies, I must return to the woods to ensure that no malevolence escapes from it."], # Hina, for real this time
				[:START,"Star Sapphire","Eek! This Villager is powerful!","I won! ...I won?",400,nil,"I'll predict your Puppets movements before you even give them a command!","Maybe things would have gone different if I was battling alongside Luna and Sunny..."],
				[:LUNAT,"Luna Child","My prank backfired!","And that's why you never mess with a fairy~",400,nil,"How well can you command your Puppets if I take away their ability to hear things?","If Star and Sunny were here, this would have been an entirely different story!"],
				[:SUNNYT,"Sunny Milk","Time to get the sun in your eyes while I run away!","What's the matter, can't handle a little light?",400,nil,"Hehe, you look like a fun target! C'mon, let me dazzle you with my light show!","Puppet handlers sure are strong, but when I'm with Luna and Star, we can't ever be beaten!"],
				# What, you didn't think Medicine would show up, did you?
				[:ELLY,"Elly","Ow- Haven't had a battle like that in a long time!","I guess I'm not losing my touch after all!",400,nil,"I am here while my mistress achieves whatever it is shes here for!","Lady Yuuka wanted to come see this year's Harvest Festival, but she never told me why..."],
				[:YUUKA,"Yuuka Kazami","I can see it now, you will blossom into a remarkable flower...~","If you can't handle me now, I look forward to a rematch in the future.",400,nil,"I suppose I can indulge myself while I am here, can you give me a good time?","Perhaps I shall see you again one day, I would quite enjoy battling you again~."],
				[:KEINE,"Keine Kamishirasawa","You've grown quite adept at handling your Puppets!","Perhaps you need after-school lesson in Puppet Handling.",400,nil,"Have you been making sure to care for your Puppets responsibly?","I must return to my stand, but do seek me out if you wish to take your hand at a different kind of battle."],
				[:MARISA,"Marisa Kirisame","Well, 'ow 'bout that, eh? You're real good at Puppet Handling!","Ehehe, ain't no way you were gonna beat me at my best!",400,"Seein' all these folks using Puppets is wild. T'think they weren't even a thing 'til a year ago.","Oh hey, I remember you from that time in the Forest! 've you gotten any stronger since then? Heh, let's go!","Jus' how it goes I s'pose! Gotta get stronger if I wanna go toe-to-toe with you."],
				[:YOUMU,"Youmu Konpaku","We need to sharpen our skills more, clearly.","The swords my Puppets wield can cut through any foe!",400,"I asked Lady Yuyuko if she wanted to come this year, but she said she was looking into something elsewhere.","Our last battle ended in your victory, but this time I'll show you the true power of my words!","You may not be a ghost, but your strength is definitely supernatural in nature!"],
				[:LYRICA,"Lyrica Prismriver","You don't miss a single beat!","If you'd like, my sisters and I can give you some pointers later!",400,nil,"Would you help me produce a melody that can move this crowd?","That was such a musical battle! You should team up with my sisters and I to put on an unforgetable show!"],
				[:MYSTIA,"Mystia Lorelei","Aw, I can never seem to beat humans when it matters!","Should have kept your wits about you when stumbling through the dark~.",400,"I should have opened a branch of my izakaya here, I could have soild a bunch of food to the spectators!","Do you fear the dark? You should! I'll show you what makes creatures of the night so terrifying!","Well, if you worked up an appetite, can you at least swing by my izakaya later? I'll give you half off for winning!"],
				[:LUNASA,"Lunasa Prismriver","You command your Puppets with such a tender yet powerful harmony!","Ahaha, was the somber harmony from my violin too overwhelming?",400,nil,"You might be good at high energy battles, but how about melancholic battles?","High or low, you know your way around battling. I wish to perform with you again one day!"],
				[:MERLIN,"Merlin Prismriver","You and your Puppets are perfectly in-tune with one another!","Whoops! Was my trumpeting too chaotic for you?",400,nil,"I'll show you that Puppet Battles are just as complex and involved as playing a Trumpet!","Some people say that playing a trumpet is easy, just blow into it. You should help me prove them wrong by battling alongisde me one day!"],
				# Bonus Trainers!
				[:ALICE,"Alice Margatroid","Remarkable, it looks as if even I have some more to learn about puppetry.","Your strings were cut by a true master of Puppets!",400,"Alice",nil,"The original Puppeteer versus the new generation... Who shall win, I wonder?","Your performance has given me ideas for my own Puppets. I'm feeling inspired!"],
				[:SANAE,"Sanae Kochiya","The rumors about you weren't mistaken, you are really strong!","Huh, was I mistaken?",400,nil,"I've heard about you! Aren't you that really powerful trainer from the Village? Let's make this a good fight!","If you'd like to bring out your Puppets true potential, you should come visit the Moriya Talisman stall in the Festival Grounds!"],
				[:SUIKA,"Suika Ibuki","Ahahaha, you're quite a strong Handler, lady!","Bring on the next one, I can go all night, *hic*!",400,"Of course I'd go wherever a party is happening! We oni can't stay away from a good time, *hic*!","You all were going to have a huge tournament and not invite me? I'll show you all a battle you'll never forget!","I'm gonna go lie down now so I can continue to party later! Cya 'round human, *hic*!"],
				[:SEIJA,"Seija Kijin","Grr, I'll be back, don't you forget it! I won't rest until I'm atop it all!.","Behold, as your time in Gensokyo's limeliight comes to an end!",400,nil,"Behold my impossibly crafted team! I'm <i>sure</i> you'll be able to beat it, kyahahah!","One day I'll reverse Gensokyo's power system, and you'll all be below me, kyeheheh!"],
				[:SUMIREKO,"Sumireko Usami","Ghk-! You just got lucky!","Now watch as I unleash my true power- wait, what do you mean I can't crash a Radio Tower into the arena!?",400,"Did you know that the Outside World also has tournaments and battles like this? They're nowhere near as interesting as here though!","Behold the power Sealing Club's first president, Sumireko Usami, as she effortlessly defeats you in a battle!","I may have been defeated, but I will return! Ahahahahaha!","Sumireko"],
				[:GIOVANNI,"Gio","Hmph! I will get my revenge one day.","You never stood a chance against me, child.",400,"I may be trapped in this backwards realm, but my ambitions will never falter. Even with that nefarious teleporting witch watching me.","You will be another stepping stone toward my ultimate goals.","A child like you could never understand the grandness of my goals."],
				[:FAIRY_ZK,"Amira","As the strongest fairy, I gracefully accept my defeat.","Did you really think you could beat the strongest fairy in all of Infinity?",400,"I saw someone else here with my name! I wonder if they're my twin?","You stand before the strongest fairy in Gensokyo- no, in all of Infinity!","There is only one fate for the strongest- to become stronger."],
				[:KALYPSA,"Kalypsa Kapsyla","My eyes never fail me, you are something else!","Did I get too into it? Whoops!",400,"I stop by Gensokyo every once in a while because it's just so fun here! If you ever wanna take a tour of the Omniverse, just let me know!","You have a certain aura about you... Oh yeah, I can't wait to battle you!","You're gonna go far in life, don't give up on your dreams!","Kalypsa"],
				[:SCRenko,"Renko Usami","A loss is just a chance for growth!","And that's how it's done! Good battle!",400,"You are an absolute powerhouse! I had a blast fighting you!","As the first champion of the Gensokyo League, I'll show you a real battle!","I'll learn from this battle and challenge you again, be ready for that day!","Renko"],
				[:SCMary,"Maribel Hearn","We'll get 'em next time, I'm sure of it...!","I knew we could do it! I'm so proud of you all!",400,"My partners and I have been through a lot on our journey, but there's still so much more out there to experience!","I'll put everything I learned on my journey to the test, right here against you, with my closest companions!","It's time for me to bow out, my partners deserve a good rest!","Maribel"],
				[:HIKARI,"Hikari Hoshizora","No gods or legends can stand against you, t'would seem!","And that's why I'm a legend!",400,"I should get back to the Yama 'fore she notices I've slipped out.","D'you have what it takes to stand against a Legend Hunter?","I wonder if an Avatar woulda made a difference here... Oh well!"]
               ],
  :condition_proc => proc {
	$game_switches[123] || $game_switches[107]
  },
  :rules_proc => proc {|length|
    rules = PokemonChallengeRules.new
    rules.addPokemonRule(BannedSpeciesRestriction.new(:MEWTWO,:MEW,:HOOH,:LUGIA,:CELEBI,:KYOGRE,:GROUDON,:RAYQUAZA,
                                                      :DEOXYS,:JIRACHI,:DIALGA,:PALKIA,:GIRATINA,:REGIGIGAS,:HEATRAN,:DARKRAI,
                                                      :SHAYMIN,:ARCEUS,:ZEKROM,:RESHIRAM,:KYUREM,:LANDORUS,:MELOETTA,
                                                      :KELDEO,:GENESECT,:MEIMU))
    rules.addPokemonRule(NonEggRestriction.new)
    rules.addPokemonRule(AblePokemonRestriction.new)
    rules.setNumber(length)
    rules.setLevelAdjustment(FixedLevelAdjustment.new(75))
    next rules
  },
  :banned_proc => proc {
    pbMessage(_INTL("Certain exotic species, as well as eggs, are ineligible.\\1"))
  },
  :points_won => 8
})

GameData::PWTTournament.register({
  :id => :Extra_Mode,
  :name => _INTL("Extra"),
  :trainers => [
                [:ABYSSALSOVEREIGN,"Amira","Wow, what a fun battle! Shame my journey ends here though.","Guess I'll stick around for a bit longer~.",500,nil,"Shhh, don't tell anyone, but I'm not supposed to be here at this time <i>*wink*</i>.","Guess I better get back to my own time and check in with the Administrator!"], # Amira
				[:ABYSSALOBSERVER,"Derxwna","I get knocked down, but I'll get up again.","I see. Perhaps the Overseer was mistaken?",500,nil,"You. You are the focal point of what appears to be a burgeoning distortion. Time to find out if you have the skill to handle it.","It would seem my job here is done. Good luck!"], # Derxwna
				[:PWT_GRAY,"Gray","Oh. Well that happened.","Yes! I won, I won! Woo-hoo!",500,"Man you're actually really strong. I like you! I hope we meet again!","I don't know how either of us got here. But I know one of us ain't leavin'.","Well, guess you ain't leavin' then. Later!"], # Gray
				[:PWT_SUPERVISOR_M,"Dayton","I'm impressed. You sure know how to fight with Puppets.","Ah well... At least you did your best.",500,nil,"I'm actually interested on your skill with Puppets. Show me what you got!","No matter what Puppets you have, you could always come up with different strategies from them."], # ShinyRaichu
				[:PWT_YOUKAI_2,"EeveeMN","I just got counterteamed, pretty unlucky. Next time, things will be different!","Wait, I won? I mean… of course I won! Come back when you get a bit better.",500,nil,"Hey, hey! I don't really know what I'm doing, but let’s have a good fight!"], # The_Eevee_Man
				[:PWT_YOUKAI_1,"Yotai","Oh no I lost.... Oh well....","Byonarada!",500,"Oh it's you ! Did you win or did you lose ? Actualy don't say anything nevermind that ....","I like short and they're confy to wear.... Wait that dosen't sounds quite right dosen't it :) ....\nAnyway enough chit chat it's time to fight!","GG i guess."], # Mr.D
				[:PWT_FAIRY_Z,"Pastelia","EGAD!! I dropped me lucky charms!!!","Leg it before I whack ye with me horseshoe!",500,"Thanks a million for that battle. Got me some more four-leaf clovers after the tourney. Ye sure ye don't want some?","No way I'mma lose! I got all me lucky charms right here!","Fair play to ye. Maybe I needa find me some new charms..."], # Adam
				[:PWT_Z_FAIRY,"Doesnt","Hehehe...what, did you think I'd be any good at battling?","Wait. Damn it.",500,"Hehehe...don't tell anyone I'm here when I should be working.","Hehehe...behold! The power of the nameless and unbordered worlds!","Oh, don't come looking for me across the boundary. I'm never \"home\"."], # Doesnt
				[:PWT_CLERK_M,"Gerard","Whew, down and over.","That was closer than I expected.",500,"That match was very inspiring! I'm looking forward for the next one.","Let's have a bout that'll entrance the crowd!","Amazing performance! Thank you for the match."], # Gerardito
				[:PWT_Z_FAIRY,"Ditz","Argh... I wasn't bright enough...","I can feel myself flying higher already!",500,"Sometimes I can't tell whether I'm dreaming or I'm awake. Though is there even really a difference?","Sometimes I dream of these balls of fire in the night sky. Do you think I could ever reach them?","They sure are pretty, aren't they?"], # Karl
				[:PWT_VILLAGEACE_M,"Ichor","Couldn't quite get there!","We made it work!",500,"It's exciting to see so many different types of folks at a locale like this.","Don't hold back, now, because I certainly don't intend to!","The show must go on, as they say."], # Ichor
				[:PWT_SPIRIT,"Shadowbones","Yer not half bad, for a child...","Judging from yer skill, I reckon ye should try taking up gaming journalism.",500,"Ye've got guts kid. Maybe I'll leave me old crew to ye in me will.","The name's Captain Shadowbones, and I'll be the last name ye'll ever fear.","Many treasures are out there, take in the time to appreciate thee ones ye have."], # Eric
				[:PWT_WRAITH,"Norion","I must find her.","It's not enough.",500] # no@no.com
               ],
  :condition_proc => proc {
	$game_switches[123] || $game_switches[107]
  },
  :rules_proc => proc {|length|
    rules = PokemonChallengeRules.new
    rules.addPokemonRule(BannedSpeciesRestriction.new(:MEWTWO,:MEW,:HOOH,:LUGIA,:CELEBI,:KYOGRE,:GROUDON,:RAYQUAZA,
                                                      :DEOXYS,:JIRACHI,:DIALGA,:PALKIA,:GIRATINA,:REGIGIGAS,:HEATRAN,:DARKRAI,
                                                      :SHAYMIN,:ARCEUS,:ZEKROM,:RESHIRAM,:KYUREM,:LANDORUS,:MELOETTA,
                                                      :KELDEO,:GENESECT,:MEIMU))
    rules.addPokemonRule(NonEggRestriction.new)
    rules.addPokemonRule(AblePokemonRestriction.new)
    rules.setNumber(length)
    rules.setLevelAdjustment(FixedLevelAdjustment.new(100))
    next rules
  },
  :banned_proc => proc {
    pbMessage(_INTL("Certain exotic species, as well as eggs, are ineligible.\\1"))
  },
  :points_won => 10
})