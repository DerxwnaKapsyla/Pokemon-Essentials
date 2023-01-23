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
PWT_STREAK_MULT = false
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
                [:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",Variant Number,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Trainer 1
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",Variant Number,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"]  # Trainer 2, etc
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
  :name => _INTL("Easy Difficulty"),
  :trainers => [
                [:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Human Youth M
                [:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Human Youth M
                [:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Human Youth M
                [:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Human Youth F
                [:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Human Youth F
                [:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Human Youth F
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Fairy 1
                [:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Fairy 1
                [:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Fairy 1
                [:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Fairy 2
                [:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Fairy 2
                [:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Fairy 2
                [:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor M
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor M
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor M
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor F
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor F
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor F
				# ---- Gensokyo's Finest
                [:KOKORO,"Kokoro","Hahaha, t'was a memorable dance indeed!","Though your show ends here, your performance was remarkable!",100] # Kokoro
               ],
  :rules_proc => proc {|length|
    rules = PokemonChallengeRules.new
    rules.addPokemonRule(BannedSpeciesRestriction.new(:MEWTWO,:MEW,:HOOH,:LUGIA,:CELEBI,:KYOGRE,:GROUDON,:RAYQUAZA,
                                                      :DEOXYS,:JIRACHI,:DIALGA,:PALKIA,:GIRATINA,:REGIGIGAS,:HEATRAN,:DARKRAI,
                                                      :SHAYMIN,:ARCEUS,:ZEKROM,:RESHIRAM,:KYUREM,:LANDORUS,:MELOETTA,
                                                      :KELDEO,:GENESECT))
    rules.addPokemonRule(NonEggRestriction.new)
    rules.addPokemonRule(AblePokemonRestriction.new)
    rules.setNumber(length)
    rules.setLevelAdjustment(FixedLevelAdjustment.new(25))
    next rules
  },
  :banned_proc => proc {
    pbMessage(_INTL("Certain exotic species, as well as eggs, are ineligible.\\1"))
  },
  :points_won => 2
})

GameData::PWTTournament.register({
  :id => :Normal_Diif,
  :name => _INTL("Normal Difficulty"),
  :trainers => [
                [:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Human Youth M
                [:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Human Youth M
                [:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Human Youth M
                [:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Human Youth F
                [:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Human Youth F
                [:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Human Youth F
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Fairy 1
                [:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Fairy 1
                [:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Fairy 1
                [:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Fairy 2
                [:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Fairy 2
                [:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Fairy 2
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Village Ace M
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Village Ace M
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Village Ace F
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Village Ace F
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Greater Fairy
                [:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Greater Fairy
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Greater Fairy
                [:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Greater Fairy
                [:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor M
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor M
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor M
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor F
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor F
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor F
				# ---- Gensokyo's Finest
                [:KOKORO,"Kokoro","Hahaha, t'was a memorable dance indeed!","Though your show ends here, your performance was remarkable!",200] # Kokoro
               ],
  :rules_proc => proc {|length|
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
  :banned_proc => proc {
    pbMessage(_INTL("Certain exotic species, as well as eggs, are ineligible.\\1"))
  },
  :points_won => 2
})

GameData::PWTTournament.register({
  :id => :Hard_Diff,
  :name => _INTL("Hard Difficulty"),
  :trainers => [
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Youkai 1
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Youkai 1
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Youkai 1
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Youkai 1
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Youkai 2
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Youkai 2
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Youkai 2
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Youkai 2
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Village Ace M
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Village Ace M
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Village Ace M
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Village Ace M
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Village Ace F
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Village Ace F
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Village Ace F
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Village Ace F
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Greater Fairy
                [:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Greater Fairy
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Greater Fairy
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Greater Fairy
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Zephyr Fairy
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Zephyr Fairy
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Zephyr Fairy
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Zephyr Fairy
                [:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor M
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor M
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor M
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor F
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor F
				[:ID,"Trainer Name","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor F
				# ---- Gensokyo's Finest
                [:KOKORO,"Kokoro","Hahaha, t'was a memorable dance indeed!","Though your show ends here, your performance was remarkable!",300], # Kokoro
				[:MINORIKO,"Minoriko","Player Victory Dialogue.","Player Lose Dialogue.",300], # Minoriko
				[:NITORI,"Nitori","Player Victory Dialogue.","Player Lose Dialogue.",300], # Nitori
				[:HATATE,"Hatate","Player Victory Dialogue.","Player Lose Dialogue.",300], # Hatate
				[:HINA,"Hina","Player Victory Dialogue.","Player Lose Dialogue.",300], # Hina, for real this time
				[:STAR,"Star","Player Victory Dialogue.","Player Lose Dialogue.",300], # Star
				[:LUNA,"Luna","Player Victory Dialogue.","Player Lose Dialogue.",300], # Luna
				[:SUNNY,"Sunny","Player Victory Dialogue.","Player Lose Dialogue.",300], # Sunny
				# What, you didn't think Medicine would show up, did you?
				[:ELLY,"Elly","Player Victory Dialogue.","Player Lose Dialogue.",300], # Elly
				[:YUUKA,"Yuuka","Player Victory Dialogue.","Player Lose Dialogue.",300] # Yuuka
               ],
  :rules_proc => proc {|length|
    rules = PokemonChallengeRules.new
    rules.addPokemonRule(BannedSpeciesRestriction.new(:MEWTWO,:MEW,:HOOH,:LUGIA,:CELEBI,:KYOGRE,:GROUDON,:RAYQUAZA,
                                                      :DEOXYS,:JIRACHI,:DIALGA,:PALKIA,:GIRATINA,:REGIGIGAS,:HEATRAN,:DARKRAI,
                                                      :SHAYMIN,:ARCEUS,:ZEKROM,:RESHIRAM,:KYUREM,:LANDORUS,:MELOETTA,
                                                      :KELDEO,:GENESECT))
    rules.addPokemonRule(NonEggRestriction.new)
    rules.addPokemonRule(AblePokemonRestriction.new)
    rules.setNumber(length)
    rules.setLevelAdjustment(FixedLevelAdjustment.new(75))
    next rules
  },
  :banned_proc => proc {
    pbMessage(_INTL("Certain exotic species, as well as eggs, are ineligible.\\1"))
  },
  :points_won => 2
})

GameData::PWTTournament.register({
  :id => :Lunatic_Diff,
  :name => _INTL("Lunatic Difficulty"),
  :trainers => [
				# ---- Gensokyo's Finest
                [:KOKORO,"Kokoro","Hahaha, t'was a memorable dance indeed!","Though your show ends here, your performance was remarkable!",400], # Kokoro
				[:MINORIKO,"Minoriko","Player Victory Dialogue.","Player Lose Dialogue.",400], # Minoriko
				[:NITORI,"Nitori","Player Victory Dialogue.","Player Lose Dialogue.",400], # Nitori
				[:HATATE,"Hatate","Player Victory Dialogue.","Player Lose Dialogue.",400], # Hatate
				[:HINA,"Hina","Player Victory Dialogue.","Player Lose Dialogue.",400], # Hina, for real this time
				[:STAR,"Star","Player Victory Dialogue.","Player Lose Dialogue.",400], # Star
				[:LUNA,"Luna","Player Victory Dialogue.","Player Lose Dialogue.",400], # Luna
				[:SUNNY,"Sunny","Player Victory Dialogue.","Player Lose Dialogue.",400], # Sunny
				# What, you didn't think Medicine would show up, did you?
				[:ELLY,"Elly","Player Victory Dialogue.","Player Lose Dialogue.",400], # Elly
				[:YUUKA,"Yuuka","Player Victory Dialogue.","Player Lose Dialogue.",400], # Yuuka
				[:KEINE,"Keine","Player Victory Dialogue.","Player Lose Dialogue.",400], # Keine
				[:MARISA,"Marisa","Player Victory Dialogue.","Player Lose Dialogue.",400], # Marisa
				[:YOUMU,"Youmu","Player Victory Dialogue.","Player Lose Dialogue.",400], # Youmu
				[:LYRICA,"Lyrica","Player Victory Dialogue.","Player Lose Dialogue.",400], # Lyrica
				[:MYSTIA,"Mystia","Player Victory Dialogue.","Player Lose Dialogue.",400], # Mystia
				[:LUNASA,"Lunasa","Player Victory Dialogue.","Player Lose Dialogue.",400], # Lunasa
				[:MERLIN,"Merlin","Player Victory Dialogue.","Player Lose Dialogue.",400], # Merlin
				[:ALICE,"Alice","Player Victory Dialogue.","Player Lose Dialogue.",400], # Alice
				[:SANAE,"Sanae","Player Victory Dialogue.","Player Lose Dialogue.",400], # Sanae
				[:SUIKA,"Suika","Player Victory Dialogue.","Player Lose Dialogue.",400], # Suika
				[:SUMIREKO,"Sumireko","Player Victory Dialogue.","Player Lose Dialogue.",400], # Sumireko
				[:LYRICA,"Lyrica","Player Victory Dialogue.","Player Lose Dialogue.",400], # Lyrica
				[:GIO,"Gio","Player Victory Dialogue.","Player Lose Dialogue.",400], # Gio
				[:FAIRY_ZK,"Amira","Player Victory Dialogue.","Player Lose Dialogue.",400], # Zephyr Amira
				[:KALYPSA,"Kalypsa","Player Victory Dialogue.","Player Lose Dialogue.",400], # Kalypsa
				[:SCRenko,"Renko","Player Victory Dialogue.","Player Lose Dialogue.",400], # Renko
				[:SCMary,"Maribel","Player Victory Dialogue.","Player Lose Dialogue.",400] # Maribel
               ],
  :rules_proc => proc {|length|
    rules = PokemonChallengeRules.new
    rules.addPokemonRule(BannedSpeciesRestriction.new(:MEWTWO,:MEW,:HOOH,:LUGIA,:CELEBI,:KYOGRE,:GROUDON,:RAYQUAZA,
                                                      :DEOXYS,:JIRACHI,:DIALGA,:PALKIA,:GIRATINA,:REGIGIGAS,:HEATRAN,:DARKRAI,
                                                      :SHAYMIN,:ARCEUS,:ZEKROM,:RESHIRAM,:KYUREM,:LANDORUS,:MELOETTA,
                                                      :KELDEO,:GENESECT))
    rules.addPokemonRule(NonEggRestriction.new)
    rules.addPokemonRule(AblePokemonRestriction.new)
    rules.setNumber(length)
    rules.setLevelAdjustment(FixedLevelAdjustment.new(100))
    next rules
  },
  :banned_proc => proc {
    pbMessage(_INTL("Certain exotic species, as well as eggs, are ineligible.\\1"))
  },
  :points_won => 2
})

GameData::PWTTournament.register({
  :id => :Extra_Mode,
  :name => _INTL("Extra"),
  :trainers => [
                [:ABYSSALSOVEREIGN,"Amira","Wow, what a fun battle! Shame my journey ends here though.","Guess I'll stick around for a bit longer~.",500,nil,"Shhh, don't tell anyone, but I'm not supposed to be here at this time <i>*wink*</i>.","Guess I better get back to my own time and check in with the Administrator!"], # Amira
				[:ABYSSALOBSERVER,"Derxwna","I get knocked down, but I'll get up again.","I see. Perhaps the Overseer was mistaken?",500,nil,"You. You are the focal point of what appears to be a burgeoning distortion. Time to find out if you have the skill to handle it.","It would seem my job here is done. Good luck!"], # Derxwna
				[:PWT_FAIRY_G,"Gray","Oh. Well that happened.","Yes! I won, I won! Woo-hoo!",500,"Man you're actually really strong. I like you! I hope we meet again!","I don't know how either of us got here. But I know one of us ain't leavin'.","Well, guess you ain't leavin' then. Later!"], # Gray
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
  #:condition_proc => proc {
#	next $game_switches[123]
#  },
  :rules_proc => proc {|length|
    rules = PokemonChallengeRules.new
    rules.addPokemonRule(BannedSpeciesRestriction.new(:MEWTWO,:MEW,:HOOH,:LUGIA,:CELEBI,:KYOGRE,:GROUDON,:RAYQUAZA,
                                                      :DEOXYS,:JIRACHI,:DIALGA,:PALKIA,:GIRATINA,:REGIGIGAS,:HEATRAN,:DARKRAI,
                                                      :SHAYMIN,:ARCEUS,:ZEKROM,:RESHIRAM,:KYUREM,:LANDORUS,:MELOETTA,
                                                      :KELDEO,:GENESECT))
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