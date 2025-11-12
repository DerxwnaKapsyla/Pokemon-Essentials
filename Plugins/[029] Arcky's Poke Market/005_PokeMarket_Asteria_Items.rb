# Put in an updated stock when you return to Viridian City after finishing the Kanto Arc or have six badges
def pbViridianMart
	  pbPokemonMart([
      :POKEBALL,
	  :POTION,
	  :ANTIDOTE,:PARALYZEHEAL,:BURNHEAL
    ], useCat: true)
end

def pbViridianMart_Limited
	  pbPokemonMart(["never",
	  [:GREATBALL, 3],
	  [:SUPERPOTION, 1],
	  [:FULLHEAL, 1]
    ], useCat: true)
end

def pbPewterMart
	  pbPokemonMart([
      :POKEBALL,
	  :POTION,
	  :ANTIDOTE,:AWAKENING,:BURNHEAL,:PARALYZEHEAL,
	  :ESCAPEROPE,
	  :REPEL
    ], useCat: true)
end

def pbPewterMart_Limited
	  pbPokemonMart(["never",
	  [:GREATBALL, 5],
	  [:SUPERPOTION, 2],
	  [:FULLHEAL, 2],
    ], useCat: true)
end

# Figure out how to overcharge here.
def pbRoute4Mart
      setPrice(:POKEBALL,250)
      setPrice(:POTION,350)
      setPrice(:ANTIDOTE,150)
      setPrice(:AWAKENING,300)
      setPrice(:BURNHEAL,300)
      setPrice(:PARALYZEHEAL,250)
      setPrice(:REPEL,500)
      setSellPrice(:ESCAPEROPE,0)
	  pbPokemonMart([
      :POKEBALL,
	  :POTION,
	  :ANTIDOTE,:AWAKENING,:BURNHEAL,:PARALYZEHEAL,
	  :REPEL
    ], useCat: true)
end

def pbMtMoonMart
	  pbPokemonMart([
      :FRESHWATER,:LEMONADE,:SODAPOP,
	  :REPEL,:POKEDOLL,
	  :MOONSTONE
    ], useCat: true)
end

def pbCeruleanMart
	  pbPokemonMart([
      :POKEBALL,
	  :POTION,:SUPERPOTION,
	  :ANTIDOTE,:AWAKENING,:BURNHEAL,:PARALYZEHEAL,
	  :ESCAPEROPE,:REPEL
	  # Limited supply
    ], useCat: true)
end

def pbVermillionMart
	  pbPokemonMart([
      :POKEBALL,
	  :POTION,:SUPERPOTION,
	  :ANTIDOTE,:AWAKENING,:BURNHEAL,:PARALYZEHEAL,:ICEHEAL,
	  :ESCAPEROPE,:REPEL
	  # Limited supply
    ], useCat: true)
end

def pbVermillionGiftShop
	  pbPokemonMart([
      :POKEBALL,:GREATBALL,
	  :PEWTERCRUNCHIES,:RAGECANDYBAR,:LAVACOOKIE,
	  :OLDGATEAU,:CASTELIACONE,
	  :RARECANDY,:SWEETHEART,
	  :FRESHWATER,:SODAPOP,:LEMONADE,:MOOMOOMILK,
	  :ESCAPEROPE,:REPEL
	  # Limited supply
    ], useCat: true)
end

def pbLavenderMart
	  pbPokemonMart([
      :POKEBALL,:GREATBALL,
	  :SUPERPOTION,
	  :ANTIDOTE,:AWAKENING,:BURNHEAL,:PARALYZEHEAL,:ICEHEAL,
	  :ESCAPEROPE,:REPEL,:SUPERREPEL
	  # Limited supply
    ], useCat: true)
end

def pbTalismanShop
	  pbPokemonMart([
      :OCCAPENDANT,:PASSHOPENDANT,:WACANPENDANT,:RINDOPENDANT,:YACHEPENDANT,:CHOPLEPENDANT,
      :KEBIAPENDANT,:SHUCAPENDANT,:COBAPENDANT,:PAYAPAPENDANT,:TANGAPENDANT,:CHARTIPENDANT,
      :KASIBPENDANT,:HABANPENDANT,:COLBURPENDANT,:BABIRIPENDANT,:CHILANPENDANT,
      :ANTIMETAL,:ANTIEARTH,:ANTIBEAST,:ANTINATURE,:ANTIHEART,:ANTIUMBRAL,
      :ANTIWIND,:ANTIMIASMA,:ANTIHYDRO,:ANTIAERO,:ANTICRYO,:ANTINETHER,
      :ANTIREASON,:ANTIPYRO,:ANTIILLUSION,:ANTIFAITH,:ANTIDREAM
    ], useCat: true)
end

def pbCeladonDept1A
	  pbPokemonMart([
      :SC05,:SC28,:SC31,
	  :SC43,:SC45,
	  :SCBLANK
    ], useCat: true)
end

def pbCeladonDept1B
	  pbPokemonMart([
      :GREATBALL,
	  :SUPERPOTION,:HYPERPOTION,
	  :ANTIDOTE,:AWAKENING,:BURNHEAL,:PARALYZEHEAL,:ICEHEAL,
	  :SUPERREPEL
    ], useCat: true)
end

def pbCeladonDept3
	  pbPokemonMart([
      :POKEDOLL,
	  :TECHSHARD,:POWERSHARD,:DEFENSESHARD,
	  :SWIFTSHARD,:SUPPORTSHARD,:SOLARSHARD,
	  :FIRESTONE,:WATERSTONE,:LEAFSTONE,
	  :THUNDERSTONE,:DUSKSTONE,:DAWNSTONE,
	  :SHINYSTONE,:MOONSTONE,:ICESTONE
    ], useCat: true)
end

def pbCeladonDept4A
	  pbPokemonMart([
      :HPUP,:PROTEIN,:IRON,
	  :CALCIUM,:ZINC,:CARBOS
    ], useCat: true)
end

def pbCeladonDept4B
	  pbPokemonMart([
      :XATTACK,:XDEFENSE,:XSPEED,
	  :XSPATK,XSPDEF,:XACCURACY,
	  :GUARDSPEC,:DIREHIT
    ], useCat: true)
end

def pbCeladonDeptRoof
	  pbPokemonMart([
      :PLAINRIBBON,:ORDINARYPENDANT,
	  :ORDINARYHAIRPIN
    ], useCat: true)
end

def pbGameCornerB1F1
	  pbPokemonMart([
      :MAGMARIZER,:ELCTRIZER,:RAZORCLAW,
      :RAZORFANG,:REAPERCLOTH,:DRAGONSCALE,
	  :METALCOAT,:PROTECTOR,:PRISMSCALE
    ], speech: "GameCorner", useCat: true, currency: "Coins")
end

def pbGameCornerB1F2
	  pbPokemonMart([
      :NETBALL,:DIVEBALL,:NESTBALL,:REPEATBALL,
	  :TIMERBALL,:LUXURYBALL,:DUSKBALL,:QUICKBALL
    ], speech: "GameCorner", useCat: true, currency: "Coins")
end

def pbCeladonFlorist
	  pbPokemonMart([
      :GROWTHMULCH,:DAMPMULCH,
	  :STABLEMULCH,:GOOEYMULCH,
      :ORANBERRY,:CHERIBERRY,:CHESTOBERRY,
	  :PECHABERRY,:RAWSTBERRY,:ASPEARBERRY,:PERSIMBERRY,
      :MIRACLESEED,:ABSORBBULB,:ROSEINCENSE,
	  :MENTALHERB,:WHITEHERB,:POWERHERB,:BIGROOT
    ], useCat: true)
end

def pbSaffronMart
	  pbPokemonMart([
      :GREATBALL,:ULTRABALL,
	  :SUPERPOTION,:HYPERPOTION,:REVIVE,
	  :ANTIDOTE,:AWAKENING,:BURNHEAL,
	  :PARALYZEHEAL,:ICEHEAL,:FULLHEAL,
	  :ESCAPEROPE,:SUPERREPEL,:MAXREPEL
    ], useCat: true)
end

def pbSilphCoMart
	  pbPokemonMart([
      :MASTERBALL,:GLITTERBALL,
	  :LINKSTONE,
	  :LIQUIDREVIVE,
	  :ABILITYCAPSULE,:ABILITYPATCH
    ], speech: "SilphCoMart", useCat: true)
end

def pbSaffronGymMart
	  pbPokemonMart([
      :SUPERPOTION,:HYPERPOTION,
      :REVIVE,:ETHER,
      :XSPATK,:XDEFENSE,
      :ODDINCENSE,:TWISTEDSPOON
    ], speech: "SaffronGymMart", useCat: true)
end

def pbFuschiaMart
	  pbPokemonMart([
      :GREATBALL,:ULTRABALL,
	  :SUPERPOTION,:HYPERPOTION,:REVIVE,
	  :FULLHEAL,
	  :SUPERREPEL,:ESCAPEROPE
    ], useCat: true)
end

def pbCinnabarMart
	  pbPokemonMart([
      :GREATBALL,:ULTRABALL,
	  :HYPERPOTION,:REVIVE,
	  :ETHER,
	  :FULLHEAL,
	  :MAXREPEL,:ESCAPEROPE
    ], useCat: true)
end

def pbCinnabarImportShop
	  pbPokemonMart([
      :RAGECANDYBAR,:MOOMOOMILK,
	  :LAVACOOKIE,:OLDGATEAU,
	  :CASTELIACONE
    ], useCat: true)
end

def pbIndigoVillageMart
	  pbPokemonMart([
      :ULTRABALL,
	  :HYPERPOTION,:MAXPOTION,
	  :FULLRESTORE,:REVIVE,
	  :ETHER,
	  :FULLHEAL,
	  :MAXREPEL,
    ], useCat: true)
end

def pbPWTMart
	  pbPokemonMart([
      :PUPPETORB,:GREATORB,:ULTRAORB,:MOONBALL,
      :POTION,:SUPERPOTION,:HYPERPOTION,:SAKE,:BEER,:ONIKILLERSAKE,
      :REVIVE,:MAXREVIVE,
      :FULLHEAL,:FULLRESTORE,
      :ETHER,:MAXETHER,:ELIXIR,:MAXELIXIR,
      :REPEL,:SUPERREPEL,:MAXREPEL,
      :PPUP,:RARECANDY,
      :POWERSHARD,:DEFENSESHARD,:TECHSHARD,
      :SWIFTSHARD,:SUPPORTSHARD,:SOLARSHARD,
      :CHROMESHARD
    ], speech: "PWTMart", useCat: true, currency: "BP")
end

def pbPortExilianMart
	  pbPokemonMart([
      :POKEBALL,:GREATBALL,:ULTRABALL,
	  :HYPERPOTION,:MAXPOTION,
	  :FULLRESTORE,:REVIVE,
	  :ETHER,:MAXETHER,
	  :SUPERREPEL,:MAXREPEL,
	  :RARECANDY,
	  :SWIMSUIT,:KIMONO,:PRIESTESS,
	  :GOTHIC,:WITCH,
	  # Limited supply
	  [:DUSKBALL,4],
	  [:MAXREVIVE, 6],
	  [:ELIXIR, 4],
	  [:MAXELIXIR, 2],
	  [:PPUP, 3]
    ], useCat: true)
end