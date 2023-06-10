module QuestModule
  
  # You don't actually need to add any information, but the respective fields in the UI will be blank or "???"
  # I included this here mostly as an example of what not to do, but also to show it's a thing that exists
  Quest0 = {
  
  }
  
  # Here's the simplest example of a single-stage quest with everything specified
  Quest1 = {
    :ID => "1",
    :Name => "Journey's Start",
    :QuestGiver => "Main Scenario Quest",
    :Stage1 => "Register for the Yitria League",
    :Location1 => "Pharos City",
    :QuestDescription => "Today is the day I sign up for the Yitria League and follow in Dist's footsteps! I'm sure that one day I'll be just as great of a trainer as he was.",
    :RewardString => nil
  }
  
  Quest2 = {
    :ID => "2",
    :Name => "First Steps",
    :QuestGiver => "Main Scenario Quest",
    :Stage1 => "Head downstairs and talk to Mom.",
	:Location1 => "Pharos City",
    :QuestDescription => "Morgan just called me downstairs to talk to Mom, she probably wants to wish me well on my journey.",
    :RewardString => nil
  }
  
  Quest3 = {
    :ID => "3",
    :Name => "My First Partner",
    :QuestGiver => "Main Scenario Quest",
    :Stage1 => "Head to Professor Hawthorn's Lab.",
	:Stage2 => "Go to Pharos Library and find Professor Hawthorn.",
	:Stage3 => "Pick out your first Pokémon, then talk to Prof. Hawthorn.",
	:Location1 => "Pharos City",
	:Location2 => "Pharos City",
	:Location3 => "Pharos City",
    :QuestDescription => "I need to head over to Professor Hawthorn's lab to obtain my starter Pokémon! His lab is in the northern part of Pharos City.",
    :RewardString => nil
  }
  
  Quest4 = {
    :ID => "4",
    :Name => "Badgequest 20xx",
    :QuestGiver => "Main Scenario Quest",
    :Stage1 => "Beat the Veiskille Gym Leader.",
	:Stage2 => "Beat the Yozora Gym Leader.",
	:Stage3 => "Beat the Kousen Gym Leader.",
	:Stage4 => "Beat the Fotia Gym Leader.",
	:Stage5 => "Beat the Chusei Gym Leader.",
	:Stage6 => "Beat the Fulgum Gym Leader.",
	:Stage7 => "Beat the Kortalan Gym Leader.",
	:Stage8 => "Beat the Pélagite Gym Leader.",
	:Stage9 => "Beat the Yitria Pokémon League.",
	:Stage9 => "Beat the Grand League.",
	:Location1 => "Pharos City",
	:Location2 => "Veiskille City",
	:Location3 => "Yozora Island",
	:Location4 => "Kousen City",
	:Location5 => "Fotia Village",
	:Location6 => "Chusei City",
	:Location7 => "Fulgum Island",
	:Location8 => "Kortalan City",
	:Location9 => "Pélagite City",
	:Location10 => "Pharos City",
    :QuestDescription => "The first stop on my journey to become a Grand Master is to beat the Veiskille City Gym Leader! I don't know much about them, I should try and get intel around the city before fighting them.",
    :RewardString => nil
  }
  
  Quest5 = {
    :ID => "5",
    :Name => "Enigmatic Situation",
    :QuestGiver => "Main Scenario Quest",
    :Stage1 => "Assess the situation at Yozora Observatory.",
	:Location1 => "Yozora Island",
    :QuestDescription => "The Yozora Gym Leader bolted out of the gym after recieving a call from the observatory informing him that something was going on over there. I wonder what's going on over there...",
    :RewardString => nil
  }
  
  # ---- Sidequests ----
  Quest100 = {
    :ID => "100",
    :Name => "A Cherished Gift",
    :QuestGiver => "Sidequest",
    :Stage1 => "Talk to Dad outside the Dunsparce Caves.",
	:Stage2 => "Calm down the rampaging Dunsparce.",
    :Location1 => "Pharos City",
	:Location2 => "Pharos City",
    :QuestDescription => "Morgan stopped me before I left town and told me to check in with Dad before I left, I guess I did forget to say goodbye to him... Time to fix that!",
    :RewardString => nil
  }
  
  Quest101 = {
    :ID => "101",
    :Name => "Treasured Memento",
    :QuestGiver => "Sidequest",
    :Stage1 => "Find the thief.",
	:Stage2 => "Return the stolen item to the kid.",
    :Location1 => "Veiskille City",
	:Location1 => "Route 3",
    :QuestDescription => "A child in Veiskille City told me that one of their precious treasures was stolen. They said they saw the thief on Route 3, I should check there.",
    :RewardString => nil
  }
  
  
  # ---- Pandora's Box Sidequest Chain ----
  Quest300 = {
    :ID => "300",
    :Name => "Grains of Sand",
    :QuestGiver => "Pandora's Box Quest",
    :Stage1 => "Find potential recruits in Veiskille City.",
	:Stage2 => "Report your findings to Pandora.",
	:Stage3 => "Find potential recruits on Yozora Island.",
	:Stage4 => "Report your findings to Pandora.",
	:Location1 => "Pharos City",
	:Location2 => "Veiskille City",
	:Location3 => "Pharos City",
	:Location4 => "Yozora Island",
    :QuestDescription => "A lady in Pharos City said she was opening up \"the ultimate sandbox experience for trainers\". However, she needs asisstants to make her dream a reality, and tasked me to find people. First off is someone who can transport goods... Maybe I can find someone in Veiskille City?",
    :RewardString => nil
  }  

end



def overwriteQuestDesc(quest)
  case quest
  when :Quest3
	if $game_variables[1] == 1
		QuestModule.const_get(quest)[:QuestDescription] = _I("A note attached to Professor Hawthorn's Lab says that he's at the Library assisting with Storytime with the Lorekeepers. I haven't been to one of those in years... I wonder if it's changed any. Let's find out!")
	elsif $game_variables[1] == 2
		QuestModule.const_get(quest)[:QuestDescription] = _I("Now that I've returned to the lab with Professor Hawthorn, I can finally choose my very first Pokémon! This is such an exciting moment, I need to think it over very carefully... When I'm done with that, I should talk to the professor again.")
	end
	
  when :Quest4
	if $game_variables[1] == 1
		QuestModule.const_get(quest)[:QuestDescription] = _I("No calculations can beat sheer determination! I may have gotten my first badge, but it doesn't stop there. If I want to be eligable for the Grand League, I need to get more badges. My next one should be on Yozora Island, across the ocean from Veiskille City.")
	elsif $game_variables[1] == 2
		QuestModule.const_get(quest)[:QuestDescription] = _I("Not even the darkness of the unknown can stop me! After a small hiccup, I now have my second badge! The next one should be over in Kousen City, south of Veiskille City.")
	elsif $game_variables[1] == 3
		QuestModule.const_get(quest)[:QuestDescription] = _I("Three down, five to go; my future's looking bright! The next Gym should be down in Fotia Village. I've heard that gym is a... special one. I should ask around to find out more about it.")	
	elsif $game_variables[1] == 4
		QuestModule.const_get(quest)[:QuestDescription] = _I("No burn heals needed here, I'm literally on fire! Half of the badges are in my pocket, time for the back half of the region. The next one should be over in Chusei City, but how will I cross the river...?")
	elsif $game_variables[1] == 5
		QuestModule.const_get(quest)[:QuestDescription] = _I("After becoming an impromptu Quality Asurance tester, I now have my fifth badge! At this point, my next badge is across the ocean on Fulgum Island... Is there a ferry that'll get me over there?")
	elsif $game_variables[1] == 6
		QuestModule.const_get(quest)[:QuestDescription] = _I("Bustin' sure makes me feel good! Two left, and the next one is over in Kortalan City... and is also helmed by the Grand Lorekeeper herself, Lifrana Sevaria. Beating her really will be a test of my skill.")
	elsif $game_variables[1] == 7
		QuestModule.const_get(quest)[:QuestDescription] = _I("That gym? Ancient history! One more to go, I'm feeling really good! The last gym is located in the undersea colony of Pélagite City... How did they manage to build an entire city under the ocean?")
	elsif $game_variables[1] == 8
		QuestModule.const_get(quest)[:Name] = _I("Rise of a Champion")
		QuestModule.const_get(quest)[:QuestDescription] = _I("The best defense is a good offense, and I sure showed the last gym leader that! All of the badges are now in my possession, and now the final stop on this leg of my journey awaits- atop Charamada Island is Yitria Palace, home of the Elite Four... Time to bring it all home.")
	elsif $game_variables[1] == 9
		QuestModule.const_get(quest)[:Name] = _I("A Grand Gesture")
		QuestModule.const_get(quest)[:QuestDescription] = _I("Looks like Champion Alexander put in a good word for me; Morgan just gave me a letter inviting me to challenge the Grand League! This is it, all I've aspired to do... Nothing will stop me now!")
	end
	
  when :Quest100
	QuestModule.const_get(quest)[:QuestDescription] = _I("The Dunsparce in the caves are acting up again! Dad's called on me to help deal with them.")
	
  when :Quest300
	QuestModule.const_get(quest)[:QuestDescription] = _I("Pandora seems pleased that they have more people helping with their project. However, she said she needs more people to run more facilities. Maybe I can find more help on Yozora Island.")
	
  end
end