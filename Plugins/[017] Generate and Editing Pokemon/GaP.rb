def gap(level,maxdex,random=true,banlist=[0]) #Generate a Pokémon by dex number
  if random==true
    value=0
    while banlist.include?(value)
      value = rand(maxdex)
      value+=1
    end
  else
    value = 0
    params = ChooseNumberParams.new
    params.setDefaultValue(value)
    params.setMaxDigits(3)
    params.setNegativesAllowed(false)
    while banlist.include?(value)
      value = pbMessageChooseNumber(_INTL("Just tell me the ID of the Species you want and we'll be on our way.",1),params)
      if banlist.include?(value)
        pbMessage("This species is banned. Chose another one.")
      end
    end
  end
  if value>0 && value<maxdex
    species = GameData::Species.get(value)
    pkmn = Pokemon.new(species,level)
    formcmds = [[], []]
    GameData::Species.each do |sp| #Generating the form list for the selected species
      next if sp.species != pkmn.species
      form_name = sp.form_name
      form_name = _INTL("Unnamed form") if !form_name || form_name.empty?
      form_name = sprintf("%d: %s", sp.form, form_name)
      formcmds[0].push(sp.form)
      formcmds[1].push(form_name)
    end
    for i in formcmds[0]
      formname=formcmds[1][i]
      if formname.include? "Alolan" 
          cmd=1
          cmd= pbMessage("Do you want to generate the Alolan form instead?",["Yes","No"],0,nil,0)
          if cmd == 0
            pkmn.form=i
          end
      end
      if formname.include? "Galarian" 
          cmd=1
          cmd= pbMessage("Do you want to generate the Galarian form instead?",["Yes","No"],0,nil,0)
          if cmd == 0
            pkmn.form=i
          end
      end
      if formname.include? "Female" 
          cmd=1
          cmd= pbMessage("Do you want to generate the Female form instead?",["Yes","No"],0,nil,0)
          if cmd == 0
            pkmn.form=i
          end
      end
    end
    pkmn.iv[:DEFENSE]=31
    pkmn.iv[:ATTACK]=31
    pkmn.iv[:HP]=31
    pkmn.iv[:SPECIAL_ATTACK]=31
    pkmn.iv[:SPECIAL_DEFENSE]=31
    pkmn.iv[:SPEED]=31
    pkmn.calc_stats
	if $game_switches[31] = true
	  pkmn.make_shiny
	end
    pbAddPokemon(pkmn)
  end
end

def gap2(level,banlist=[]) #Generate a Pokémon by species
  selection = 0
  pbListScreenBlock(_INTL("Generate a Species"),SpeciesLister.new(selection,false)) { |button,species|
    if button==Input::USE
      species = GameData::Species.get(species)
      pkmn = Pokemon.new(species,level)
      formcmds = [[], []]
      GameData::Species.each do |sp| #Generating the form list for the selected species
        next if sp.species != pkmn.species
        form_name = sp.form_name
        form_name = _INTL("Unnamed form") if !form_name || form_name.empty?
        form_name = sprintf("%d: %s", sp.form, form_name)
        formcmds[0].push(sp.form)
        formcmds[1].push(form_name)
      end
      for i in formcmds[0]
        formname=formcmds[1][i]
        if formname.include? "Alolan" 
            cmd=1
            cmd= pbMessage("Do you want to generate the Alolan form instead?",["Yes","No"],0,nil,0)
            if cmd == 0
              pkmn.form=i
            end
        end
        if formname.include? "Galarian" 
            cmd=1
            cmd= pbMessage("Do you want to generate the Galarian form instead?",["Yes","No"],0,nil,0)
            if cmd == 0
              pkmn.form=i
            end
        end
        if formname.include? "Female" 
          cmd=1
          cmd= pbMessage("Do you want to generate the Female form instead?",["Yes","No"],0,nil,0)
          if cmd == 0
            pkmn.form=i
          end
        end
      end
	  pkmn.iv[:DEFENSE]=31
	  pkmn.iv[:ATTACK]=31
	  pkmn.iv[:HP]=31
	  pkmn.iv[:SPECIAL_ATTACK]=31
	  pkmn.iv[:SPECIAL_DEFENSE]=31
	  pkmn.iv[:SPEED]=31
      pkmn.calc_stats
      if !banlist.include?(pkmn.speciesName)
        pbAddPokemon(pkmn)
      else
        pbMessage(_INTL("{1} is banned.",pkmn.speciesName))
      end
    end
  }
end


def changeNature(pkmn)
    commands = []
    ids = []
    GameData::Nature.each do |nature|
      if nature.stat_changes.length == 0
        commands.push(_INTL("{1} (---)", nature.real_name))
      else
        plus_text = ""
        minus_text = ""
        nature.stat_changes.each do |change|
          if change[1] > 0
            plus_text += "/" if !plus_text.empty?
            plus_text += GameData::Stat.get(change[0]).name_brief
          elsif change[1] < 0
            minus_text += "/" if !minus_text.empty?
            minus_text += GameData::Stat.get(change[0]).name_brief
          end
        end
        commands.push(_INTL("{1} (+{2}, -{3})", nature.real_name, plus_text, minus_text))
      end
      ids.push(nature.id)
    end
    cmd=0
    cmd= pbMessage("What kind of nature would you like them to have?",commands,0,nil,0)
    pkmn.nature = ids[cmd]
    pbMessage(_INTL("And there! Through my practices, they are now more {1}!",pkmn.nature.real_name))
end

def changeeV(pkmn)
  cmd=6
  cmd= pbMessage("Which type of role do you want your Pokémon to have?",["Physical damage dealer","Special damage dealer","Defensive","Specially defensive","Mixed defenses","Leave"],5,nil,0)
  cmd2=0
  if cmd==0
    cmd2=pbMessage("Which one do you prefer?",["Max Atk and Speed","Max Atk and HP","Leave"],2,nil,0)
    if cmd2==0
        pkmn.ev[:ATTACK]=0
        pkmn.ev[:DEFENSE]=0
        pkmn.ev[:HP]=0
        pkmn.ev[:SPEED]=0
        pkmn.ev[:SPECIAL_ATTACK]=0
        pkmn.ev[:SPECIAL_DEFENSE]=0
        pkmn.ev[:ATTACK]=252
        pkmn.ev[:SPEED]=252
        pkmn.ev[:DEFENSE]=4
    end
    if cmd2==1
        pkmn.ev[:ATTACK]=0
        pkmn.ev[:DEFENSE]=0
        pkmn.ev[:HP]=0
        pkmn.ev[:SPEED]=0
        pkmn.ev[:SPECIAL_ATTACK]=0
        pkmn.ev[:SPECIAL_DEFENSE]=0
        pkmn.ev[:ATTACK]=252
        pkmn.ev[:HP]=252
        pkmn.ev[:DEFENSE]=4   
    end
  end
  if cmd==1
    cmd2=pbMessage("Which one do you prefer?",["Max SPAtk and Speed","Max SPAtk and HP","Leave"],2,nil,0)
    if cmd2==0
        pkmn.ev[:ATTACK]=0
        pkmn.ev[:DEFENSE]=0
        pkmn.ev[:HP]=0
        pkmn.ev[:SPEED]=0
        pkmn.ev[:SPECIAL_ATTACK]=0
        pkmn.ev[:SPECIAL_DEFENSE]=0
        pkmn.ev[:SPECIAL_ATTACK]=252
        pkmn.ev[:SPEED]=252
        pkmn.ev[:DEFENSE]=4
    end
    if cmd2==1
        pkmn.ev[:ATTACK]=0
        pkmn.ev[:DEFENSE]=0
        pkmn.ev[:HP]=0
        pkmn.ev[:SPEED]=0
        pkmn.ev[:SPECIAL_ATTACK]=0
        pkmn.ev[:SPECIAL_DEFENSE]=0
        pkmn.ev[:SPECIAL_ATTACK]=252
        pkmn.ev[:HP]=252
        pkmn.ev[:DEFENSE]=4   
    end
  end
  if cmd ==2
    pkmn.ev[:ATTACK]=0
    pkmn.ev[:DEFENSE]=0
    pkmn.ev[:HP]=0
    pkmn.ev[:SPEED]=0
    pkmn.ev[:SPECIAL_ATTACK]=0
    pkmn.ev[:SPECIAL_DEFENSE]=0
    pkmn.ev[:HP]=252
    pkmn.ev[:DEFENSE]=252   
    pkmn.ev[:SPEED]=4
  end
  if cmd ==3
    pkmn.ev[:ATTACK]=0
    pkmn.ev[:DEFENSE]=0
    pkmn.ev[:HP]=0
    pkmn.ev[:SPEED]=0
    pkmn.ev[:SPECIAL_ATTACK]=0
    pkmn.ev[:SPECIAL_DEFENSE]=0
    pkmn.ev[:HP]=252
    pkmn.ev[:SPECIAL_DEFENSE]=252   
    pkmn.ev[:SPEED]=4
  end
  if cmd ==4
    pkmn.ev[:ATTACK]=0
    pkmn.ev[:DEFENSE]=0
    pkmn.ev[:HP]=0
    pkmn.ev[:SPEED]=0
    pkmn.ev[:SPECIAL_ATTACK]=0
    pkmn.ev[:SPECIAL_DEFENSE]=0
    pkmn.ev[:HP]=248
    pkmn.ev[:SPECIAL_DEFENSE]=152  
    pkmn.ev[:DEFENSE]=92
    pkmn.ev[:SPEED]=16
  end
end

def setabil(pkmn)
  abils = pkmn.getAbilityList
  ability_commands = []
  abil_cmd = 0
  for i in abils
    ability_commands.push(((i[1] < 2) ? "" : "(H) ") + GameData::Ability.get(i[0]).name)
    #abil_cmd = ability_commands.length - 1 if pkmn.ability_id == i[0]
  end
  cmd= pbMessage("Which ability do yo want for your Pokémon?",ability_commands,0,nil,0)
  #abil_cmd = screen.pbShowCommands(_INTL("Choose an ability."), ability_commands, abil_cmd)
  pkmn.ability = abils[cmd][0]
  #pkmn.ability = nil
end

def saveitem
  itemlist=[nil,nil,nil,nil,nil,nil]
  for i in 0...$Trainer.party_count
    pkmn=$Trainer.pokemon_party[i]
    if pkmn.item!=nil
      itemlist[i]=pkmn.item_id
    end
  end
  $game_variables[33]=itemlist  
end


def restoreitem
  itemlist=$game_variables[33]
  for i in 0...$Trainer.party_count
    pkmn=$Trainer.pokemon_party[i]
    pkmn.item=itemlist[i]
  end
end

def fillbag(qty)
itemlist=[]
itemlist.push(:AGUAVBERRY)          
itemlist.push(:ASSAULTVEST)          
itemlist.push(:CHOICEBAND)          
itemlist.push(:CHOICESCARF)          
itemlist.push(:CHOICESPECS)          
itemlist.push(:EVIOLITE)          
itemlist.push(:EXPERTBELT)          
itemlist.push(:FIGYBERRY)          
itemlist.push(:FOCUSSASH)          
itemlist.push(:HEAVYDUTYBOOTS)          
itemlist.push(:IAPAPABERRY)          
itemlist.push(:LEFTOVERS)          
itemlist.push(:LIFEORB)          
itemlist.push(:MAGOBERRY)          
itemlist.push(:MENTALHERB)           
itemlist.push(:POWERHERB)           
itemlist.push(:ROCKYHELMET)           
itemlist.push(:SALACBERRY)           
itemlist.push(:WIKIBERRY)           
itemlist.push(:ABSORBBULB)           
itemlist.push(:ADRENALINEORB)           
itemlist.push(:AIRBALLOON)           
itemlist.push(:APICOTBERRY)           
itemlist.push(:BABIRIBERRY)           
itemlist.push(:BERRYJUICE)           
itemlist.push(:BLACKBELT)           
itemlist.push(:BLACKGLASSES)           
itemlist.push(:BLACKSLUDGE)          
itemlist.push(:BLUNDERPOLICY)          
itemlist.push(:BRIGHTPOWDER)          
itemlist.push(:CELLBATTERY)          
itemlist.push(:CHARCOAL)          
itemlist.push(:CHARTIBERRY)          
itemlist.push(:CHESTOBERRY)          
itemlist.push(:CHILANBERRY)          
itemlist.push(:CHOPLEBERRY)          
itemlist.push(:COBABERRY)          
itemlist.push(:COLBURBERRY)          
itemlist.push(:CUSTAPBERRY)          
itemlist.push(:DAMPROCK)          
itemlist.push(:DRAGONFANG)          
itemlist.push(:EJECTBUTTON)          
itemlist.push(:EJECTPACK)          
itemlist.push(:ELECTRICSEED)          
itemlist.push(:FLAMEORB)          
itemlist.push(:FULLINCENSE)          
itemlist.push(:GANLONBERRY)          
itemlist.push(:GRASSYSEED)          
itemlist.push(:GREPABERRY)          
itemlist.push(:GRIPCLAW)          
itemlist.push(:HABANBERRY)          
itemlist.push(:HARDSTONE)          
itemlist.push(:HEATROCK)          
itemlist.push(:ICYROCK)          
itemlist.push(:KASIBBERRY)          
itemlist.push(:KEBIABERRY)          
itemlist.push(:KEEBERRY)          
itemlist.push(:KINGSROCK)          
itemlist.push(:LAGGINGTAIL)          
itemlist.push(:LANSATBERRY)          
itemlist.push(:LEPPABERRY)          
itemlist.push(:LIECHIBERRY)          
itemlist.push(:LIGHTCLAY)          
itemlist.push(:LUMBERRY)          
itemlist.push(:LUMINOUSMOSS)          
itemlist.push(:MAGNET)          
itemlist.push(:MARANGABERRY)          
itemlist.push(:METALCOAT)          
itemlist.push(:METRONOME)          
itemlist.push(:MICLEBERRY)          
itemlist.push(:MIRACLESEED)          
itemlist.push(:MISTYSEED)          
itemlist.push(:MYSTICWATER)          
itemlist.push(:NEVERMELTICE)          
itemlist.push(:NORMALGEM)          
itemlist.push(:OCCABERRY)          
itemlist.push(:ODDINCENSE)          
itemlist.push(:PASSHOBERRY)          
itemlist.push(:PAYAPABERRY)          
itemlist.push(:PETAYABERRY)          
itemlist.push(:LIFEORB)          
itemlist.push(:POISONBARB)          
itemlist.push(:PROTECTIVEPADS)          
itemlist.push(:PSYCHICSEED)          
itemlist.push(:QUICKCLAW)          
itemlist.push(:RAZORCLAW)          
itemlist.push(:REDCARD)          
itemlist.push(:RINDOBERRY)          
itemlist.push(:ROCKINCENSE)          
itemlist.push(:ROOMSERVICE)          
itemlist.push(:ROSEINCENSE)          
itemlist.push(:ROSELIBERRY)          
itemlist.push(:SAFETYGOGGLES)          
itemlist.push(:SCOPELENS)          
itemlist.push(:SEAINCENSE)          
itemlist.push(:SHARPBEAK)          
itemlist.push(:SHEDSHELL)          
itemlist.push(:SHELLBELL)          
itemlist.push(:SHUCABERRY)          
itemlist.push(:SILKSCARF)          
itemlist.push(:SILVERPOWDER)          
itemlist.push(:SITRUSBERRY)          
itemlist.push(:SMOOTHROCK)          
itemlist.push(:SNOWBALL)          
itemlist.push(:SOFTSAND)          
itemlist.push(:SPELLTAG)          
itemlist.push(:STARFBERRY)          
itemlist.push(:STICKYBARB)          
itemlist.push(:TANGABERRY)          
itemlist.push(:TERRAINEXTENDER)          
itemlist.push(:THROATSPRAY)          
itemlist.push(:TOXICORB)          
itemlist.push(:TWISTEDSPOON)          
itemlist.push(:UTILITYUMBRELLA)          
itemlist.push(:WACANBERRY)          
itemlist.push(:WAVEINCENSE)          
itemlist.push(:WEAKNESSPOLICY)          
itemlist.push(:WHITEHERB)          
itemlist.push(:WIDELENS)          
itemlist.push(:WISEGLASSES)          
itemlist.push(:YACHEBERRY)          
itemlist.push(:ZOOMLENS)          
itemlist.push(:ADAMANTORB)          
itemlist.push(:BUGMEMORY)          
itemlist.push(:BURNDRIVE)          
itemlist.push(:CHILLDRIVE)          
itemlist.push(:DARKMEMORY)          
itemlist.push(:DEEPSEASCALE)          
itemlist.push(:DEEPSEATOOTH)          
itemlist.push(:DOUSEDRIVE)          
itemlist.push(:DRAGONMEMORY)          
itemlist.push(:ELECTRICMEMORY)          
itemlist.push(:FAIRYMEMORY)          
itemlist.push(:FIGHTINGMEMORY)          
itemlist.push(:FIREMEMORY)          
itemlist.push(:FLYINGMEMORY)          
itemlist.push(:GHOSTMEMORY)          
itemlist.push(:GRASSMEMORY)          
itemlist.push(:GRISEOUSORB)          
itemlist.push(:GROUNDMEMORY)          
itemlist.push(:ICEMEMORY)          
itemlist.push(:LEEK)          
itemlist.push(:LIGHTBALL)          
itemlist.push(:LUSTROUSORB)          
itemlist.push(:POISONMEMORY)          
itemlist.push(:PSYCHICMEMORY)          
itemlist.push(:ROCKMEMORY)          
itemlist.push(:RUSTEDSHIELD)          
itemlist.push(:RUSTEDSWORD)          
itemlist.push(:SHOCKDRIVE)          
itemlist.push(:SOULDEW)          
itemlist.push(:STEELMEMORY)          
itemlist.push(:THICKCLUB)          
itemlist.push(:WATERMEMORY)          
itemlist.push(:PIXIEPLATE)          
itemlist.push(:DRACOPLATE)          
itemlist.push(:DREADPLATE)          
itemlist.push(:EARTHPLATE)          
itemlist.push(:FISTPLATE)          
itemlist.push(:FLAMEPLATE)          
itemlist.push(:ICICLEPLATE)          
itemlist.push(:INSECTPLATE)          
itemlist.push(:IRONPLATE)          
itemlist.push(:MEADOWPLATE)          
itemlist.push(:MINDPLATE)          
itemlist.push(:SKYPLATE)          
itemlist.push(:SPLASHPLATE)          
itemlist.push(:SPOOKYPLATE)          
itemlist.push(:STONEPLATE)          
itemlist.push(:TOXICPLATE)          
itemlist.push(:ZAPPLATE)          
itemlist.push(:VENUSAURITE)          
itemlist.push(:CHARIZARDITEX)          
itemlist.push(:CHARIZARDITEY)          
itemlist.push(:BLASTOISINITE)          
itemlist.push(:BEEDRILLITE)          
itemlist.push(:PIDGEOTITE)          
itemlist.push(:ALAKAZITE)          
itemlist.push(:SLOWBRONITE)          
itemlist.push(:GENGARITE)          
itemlist.push(:KANGASKHANITE)          
itemlist.push(:PINSIRITE)          
itemlist.push(:GYARADOSITE)          
itemlist.push(:AERODACTYLITE)          
itemlist.push(:MEWTWONITEX)          
itemlist.push(:MEWTWONITEY)          
itemlist.push(:AMPHAROSITE)          
itemlist.push(:STEELIXITE)          
itemlist.push(:SCIZORITE)          
itemlist.push(:HERACRONITE)          
itemlist.push(:HOUNDOOMINITE)          
itemlist.push(:TYRANITARITE)          
itemlist.push(:SCEPTILITE)          
itemlist.push(:BLAZIKENITE)          
itemlist.push(:SWAMPERTITE)          
itemlist.push(:GARDEVOIRITE)          
itemlist.push(:SABLENITE)          
itemlist.push(:MAWILITE)          
itemlist.push(:AGGRONITE)          
itemlist.push(:MEDICHAMITE)          
itemlist.push(:MANECTITE)          
itemlist.push(:SHARPEDONITE)          
itemlist.push(:CAMERUPTITE)          
itemlist.push(:ALTARIANITE)          
itemlist.push(:BANETTITE)          
itemlist.push(:ABSOLITE)          
itemlist.push(:GLALITITE)          
itemlist.push(:SALAMENCITE)          
itemlist.push(:METAGROSSITE)          
itemlist.push(:LATIASITE)          
itemlist.push(:LATIOSITE)          
itemlist.push(:LOPUNNITE)          
itemlist.push(:GARCHOMPITE)          
itemlist.push(:LUCARIONITE)          
itemlist.push(:ABOMASITE)          
itemlist.push(:GALLADITE)          
itemlist.push(:AUDINITE)          
itemlist.push(:DIANCITE)          
itemlist.push(:REDORB)          
itemlist.push(:BLUEORB)          
itemlist.push(:GRACIDEA)          
itemlist.push(:DNASPLICERS)          
itemlist.push(:REVEALGLASS)          
itemlist.push(:NLUNARIZER)          
itemlist.push(:NSOLARIZER)          
itemlist.push(:PRISONBOTTLE)          
itemlist.push(:MEGARING)          
itemlist.push(:ZYGARDECUBE)          
itemlist.push(:ROTOMCATALOG)
itemlist.sort! { |a, b| a <=> b }   # Sort alphabetically   
for i in 0...itemlist.length   
	$PokemonBag.pbStoreItem(itemlist[i],qty)
end
end
