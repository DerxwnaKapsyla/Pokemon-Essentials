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
  :name => _INTL("Easy"),
  :trainers => [
                [:PWT_YOUTH_M,"Shouta","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Human Youth M
                [:PWT_YOUTH_M,"Yuuichi","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Human Youth M
                [:PWT_YOUTH_M,"Osamu","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Human Youth M
                [:PWT_YOUTH_M,"Ryusei","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Human Youth F
                [:PWT_YOUTH_F,"Mirin","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Human Youth F
                [:PWT_YOUTH_F,"Sachie","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Human Youth F
				[:PWT_YOUTH_F,"Yuzu","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Fairy 1
                [:PWT_YOUTH_F,"Azumi","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Fairy 1
                [:PWT_FAIRY_1,"Mirai","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Fairy 1
                [:PWT_FAIRY_1,"Himawari","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Fairy 2
                [:PWT_FAIRY_1,"Koko","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Fairy 2
                [:PWT_FAIRY_2,"Ami","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Fairy 2
                [:PWT_FAIRY_2,"Miru","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor M
				[:PWT_FAIRY_2,"Seles","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor M
				[:PWT_SUPERVISOR_M,"Rolo","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor M
				[:PWT_SUPERVISOR_M,"Kengo","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor F
				[:PWT_SUPERVISOR_F,"Rei","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor F
				[:PWT_SUPERVISOR_F,"Hinoka","Player Victory Dialogue.","Player Lose Dialogue.",100,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor F
				# ---- Gensokyo's Finest
                [:KOKORO,"Hata no Kokoro","Hahaha, t'was a memorable dance indeed!","Though your show ends here, your performance was remarkable!",100,"Lobby Dialogue","Pre-Battle Dialogue","Post-Battle Dialogue","Kokoro"] # Kokoro
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
                [:PWT_YOUTH_M,"Ryusei","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Human Youth M
                [:PWT_YOUTH_M,"Yuuichi","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Human Youth M
                [:PWT_YOUTH_F,"Yuzu","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Human Youth M
                [:PWT_YOUTH_F,"Azumi","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Human Youth F
                [:PWT_VILLAGEACE_M,"Takumi","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Human Youth F
                [:PWT_VILLAGEACE_M,"Shimada","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Human Youth F
				[:PWT_VILLAGEACE_M,"Tatsu","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Fairy 1
                [:PWT_VILLAGEACE_M,"Shinzo","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Fairy 1
                [:PWT_VILLAGEACE_F,"Riko","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Fairy 1
                [:PWT_VILLAGEACE_F,"Yumika","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Fairy 2
                [:PWT_VILLAGEACE_F,"Kairi","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Fairy 2
                [:PWT_VILLAGEACE_F,"Yuriko","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Fairy 2
				[:PWT_FAIRY_1,"Mirai","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Village Ace M
				[:PWT_FAIRY_1,"Koko","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Village Ace M
				[:PWT_FAIRY_2,"Miru","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Village Ace F
				[:PWT_FAIRY_2,"Seles","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Village Ace F
				[:PWT_FAIRY_G,"Callie","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Greater Fairy
                [:PWT_FAIRY_G,"Himawari","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Greater Fairy
				[:PWT_FAIRY_G,"Sugar Satellite","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Greater Fairy
                [:PWT_FAIRY_G,"Maria","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Greater Fairy
                [:PWT_FAIRY_G,"Keri","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor M
				[:PWT_FAIRY_G,"Zima","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor M
				[:PWT_SUPERVISOR_M,"Rolo","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor M
				[:PWT_SUPERVISOR_M,"Kengo","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor F
				[:PWT_SUPERVISOR_F,"Rei","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor F
				[:PWT_SUPERVISOR_F,"Hinoka","Player Victory Dialogue.","Player Lose Dialogue.",200,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor F
				# ---- Gensokyo's Finest
                [:KOKORO,"Hata no Kokoro","Hahaha, t'was a memorable dance indeed!","Though your show ends here, your performance was remarkable!",200,"Lobby Dialogue","Pre-Battle Dialogue","Post-Battle Dialogue","Kokoro"] # Kokoro
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
				[:PWT_VILLAGEACE_M,"Takumi","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Youkai 1
				[:PWT_VILLAGEACE_M,"Shimada","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Youkai 1
				[:PWT_VILLAGEACE_M,"Tatsu","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Youkai 1
				[:PWT_VILLAGEACE_M,"Shinzo","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Youkai 1
				[:PWT_VILLAGEACE_F,"Riko","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Youkai 2
				[:PWT_VILLAGEACE_F,"Yumika","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Youkai 2
				[:PWT_VILLAGEACE_F,"Kairi","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Youkai 2
				[:PWT_VILLAGEACE_F,"Yuriko","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Youkai 2
				[:PWT_FAIRY_G,"Callie","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Village Ace M
				[:PWT_FAIRY_G,"Sugar Satellite","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Village Ace M
				[:PWT_FAIRY_G,"Keri","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Village Ace M
				[:PWT_FAIRY_G,"Zima","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Village Ace M
				[:PWT_FAIRY_Z,"Akane","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Village Ace F
				[:PWT_FAIRY_Z,"Mana","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Village Ace F
				[:PWT_FAIRY_Z,"Reda","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Village Ace F
				[:PWT_FAIRY_Z,"Miyra","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Village Ace F
				[:PWT_FAIRY_Z,"Katou","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Greater Fairy
                [:PWT_FAIRY_Z,"Amira","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Greater Fairy
				[:PWT_YOUKAI_1,"Thelia","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Greater Fairy
				[:PWT_YOUKAI_1,"Shuri","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Zephyr Fairy
				[:PWT_YOUKAI_1,"Minako","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Zephyr Fairy
				[:PWT_YOUKAI_2,"Jun","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Zephyr Fairy
				[:PWT_YOUKAI_2,"Ayana","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Zephyr Fairy
                [:PWT_YOUKAI_2,"Akumo","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor M
				[:PWT_SUPERVISOR_M,"Ryoma","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor M
				[:PWT_SUPERVISOR_M,"Rolo","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor M
				[:PWT_SUPERVISOR_M,"Kengo","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor F
				[:PWT_SUPERVISOR_F,"Rei","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor F
				[:PWT_SUPERVISOR_F,"Hinoka","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor F
				[:PWT_SUPERVISOR_F,"Sakura","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Festival Supervisor F
				# ---- Gensokyo's Finest
                [:KOKORO,"Hata no Kokoro","Hahaha, t'was a memorable dance indeed!","Though your show ends here, your performance was remarkable!",300,"Lobby Dialogue","Pre-Battle Dialogue","Post-Battle Dialogue","Kokoro"], # Kokoro
				[:MINORIKO,"Minoriko Aki","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue","Minoriko"], # Minoriko
				[:NITORI_Tr,"Nitori Kawashiro","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue","Nitori"], # Nitori
				[:HATATE,"Hatate Himekaidou","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue","Hatate"], # Hatate
				[:HINA_T,"Hina Kagiyama","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue","Hina"], # Hina, for real this time
				[:START,"Star Sapphire","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue","Star"], # Star
				[:LUNAT,"Luna Child","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue","Luna"], # Luna
				[:SUNNYT,"Sunny Milk","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue","Sunny"], # Sunny
				# What, you didn't think Medicine would show up, did you?
				[:ELLY,"Elly","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Elly
				[:YUUKA,"Yuuka Kazami","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue","Yuuka"], # Yuuka
				[:HIKARI,"Hikari Hoshizora","Player Victory Dialogue.","Player Lose Dialogue.",300,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue","Hikari"]
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
				[:PWT_VILLAGEACE_M,"Shimada","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Youkai 1
				[:PWT_VILLAGEACE_M,"Tatsu","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Youkai 1
				[:PWT_VILLAGEACE_M,"Shinzo","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Youkai 1
				[:PWT_VILLAGEACE_F,"Yumika","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Youkai 2
				[:PWT_VILLAGEACE_F,"Kairi","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Youkai 2
				[:PWT_VILLAGEACE_F,"Yuriko","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Youkai 2
				[:PWT_FAIRY_Z,"Mana","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Village Ace F
				[:PWT_FAIRY_Z,"Reda","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Village Ace F
				[:PWT_FAIRY_Z,"Miyra","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Village Ace F
				[:PWT_FAIRY_Z,"Katou","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Greater Fairy
				# ---- Gensokyo's Finest
                [:KOKORO,"Hata no Kokoro","Hahaha, t'was a memorable dance indeed!","Though your show ends here, your performance was remarkable!",400,"Lobby Dialogue","Pre-Battle Dialogue","Post-Battle Dialogue","Kokoro"], # Kokoro
				[:MINORIKO,"Minoriko Aki","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue","Minoriko"], # Minoriko
				[:NITORI_Tr,"Nitori Kawashiro","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue","Nitori"], # Nitori
				[:HATATE,"Hatate Himekaidou","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue","Hatate"], # Hatate
				[:HINA_T,"Hina Kagiyama","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue","Hina"], # Hina, for real this time
				[:START,"Star Sapphire","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue","Star"], # Star
				[:LUNAT,"Luna Child","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue","Luna"], # Luna
				[:SUNNYT,"Sunny Milk","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue","Sunny"], # Sunny
				# What, you didn't think Medicine would show up, did you?
				[:ELLY,"Elly","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue"], # Elly
				[:YUUKA,"Yuuka Kazami","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue","Yuuka"], # Yuuka
				[:KEINE,"Keine Kamishirasawa","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue","Keine"], # Keine
				[:MARISA,"Marisa Kirisame","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue","Marisa"], # Marisa
				[:YOUMU,"Youmu Konpaku","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue","Youmu"], # Youmu
				[:LYRICA,"Lyrica Prismriver","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue","Lyrica"], # Lyrica
				[:MYSTIA,"Mystia Lorelei","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue","Mystia"], # Mystia
				[:LUNASA,"Lunasa Prismriver","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue","Lunasa"], # Lunasa
				[:MERLIN,"Merlin Prismriver","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue","Merlin"], # Merlin
				# Bonus Trainers!
				[:ALICE,"Alice Margatroid","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue","Alice"], # Alice
				[:SANAE,"Sanae Kochiya","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue","Sanae"], # Sanae
				[:SUIKA,"Suika Ibuki","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue","Suika"], # Suika
				[:SUMIREKO,"Sumireko Usami","Ghk-! You just got lucky!","Now watch as I unleash my true power- wait, what do you mean I can't crash a Radio Tower into the arena!?",400,"Did you know that the Outside World also has tournaments and battles like this? They're nowhere near as interesting as here though!","Behold the power Sealing Club's first president, Sumireko Usami, as she effortlessly defeats you in a battle!","I may have been defeated, but I will return! Ahahahahaha!","Sumireko"], # Sumireko
				[:GIOVANNI,"Gio","Hmph! I will get my revenge one day.","You never stood a chance against me, child.",400,"I may be trapped in this backwards realm, but my ambitions will never falter. Even with that nefarious teleporting witch watching me.","You will be another stepping stone toward my ultimate goals.","A child like you could never understand the grandness of my goals."], # Gio
				[:FAIRY_ZK,"Amira","As the strongest fairy, I gracefully accept my defeat.","Did you really think you could beat the strongest fairy in all of Infinity?",400,"I saw someone else here with my name! I wonder if they're my twin?","You stand before the strongest fairy in Gensokyo- no, in all of Infinity!","There is only one fate for the strongest- to become stronger."], # Zephyr Amira
				[:KALYPSA,"Kalypsa Kapsyla","My eyes never fail me, you are something else!","Did I get too into it? Whoops!",400,"I stop by Gensokyo every once in a while because it's just so fun here! If you ever wanna take a tour of the Omniverse, just let me know!","You have a certain aura about you... Oh yeah, I can't wait to battle you!","You're gonna go far in life, don't give up on your dreams!","Kalypsa"], # Kalypsa
				[:SCRenko,"Renko Usami","A loss is just a chance for growth!","And that's how it's done! Good battle!",400,"You are an absolute powerhouse! I had a blast fighting you!","As the first champion of the Gensokyo League, I'll show you a real battle!","I'll learn from this battle and challenge you again, be ready for that day!","Renko"], # Renko
				[:SCMary,"Maribel Hearn","We'll get 'em next time, I'm sure of it...!","I knew we could do it! I'm so proud of you all!",400,"My partners and I have been through a lot on our journey, but there's still so much more out there to experience!","I'll put everything I learned on my journey to the test, right here against you, with my closest companions!","It's time for me to bow out, my partners deserve a good rest!","Maribel"], # Maribel
				[:HIKARI,"Hikari Hoshizora","Player Victory Dialogue.","Player Lose Dialogue.",400,"Lobby Dialogue.","Pre-Battle Dialogue.","Post-Battle Dialogue","Hikari"]
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
  :points_won => 8
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