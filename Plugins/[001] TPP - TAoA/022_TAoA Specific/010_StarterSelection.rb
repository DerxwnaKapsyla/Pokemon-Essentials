class StarterSelection
  attr_accessor :character_choice
  attr_accessor :starter_choice
  
  CHARACTER_TO_STARTER = {
    0  => :CREIMU,
    1  => :CMARISA,
    2  => :CSAKUYA,
    3  => :CALICE,
    4  => :CYOUMU,
    5  => :CKEINE,
    6  => :CREISEN,
    7  => :CMOKOU,
    8  => :RINNOSUKE,
    9  => :AKYUU,
    10 => :CAYA,
    11 => :CSANAE,
    12 => :CKOISHI,
    13 => :CKOGASA,
    14 => :CFUTO,
    15 => :CSEKIBANKI,
    16 => :CKAGEROU,
    17 => :CKOSUZU,
    18 => :CKOKORO,
    19 => :CSUMIREKO
  }

  def pbChooseStarter
    pbMessage(_INTL("\\w[dark]Before we start, you'll need to answer a couple of questions."))
    loop do
      @character_choice = choose_favorite_character
      break if confirm_starter_selection
    end
	pbGiveStarter
  end

  def choose_favorite_character
    characters = [
	  _INTL("Reimu Hakurei"), _INTL("Marisa Kirisame"), _INTL("Sakuya Izayoi"), 
      _INTL("Alice Margatroid"), _INTL("Youmu Konpaku"), _INTL("Keine Kamishirasawa"),
	  _INTL("Reisen U. Inaba"), _INTL("Fujiwara no Mokou"), _INTL("Rinnosuke Morichika"),
	  _INTL("Hieda no Akyuu"), _INTL("Aya Shameimaru"), _INTL("Sanae Kochiya"),
	  _INTL("Koishi Komeiji"), _INTL("Kogasa Tatara"), _INTL("Mononobe no Futo"),
	  _INTL("Sekibanki"), _INTL("Kagerou Imaizumi"), _INTL("Kosuzu Motoori"),
	  _INTL("Hata no Kokoro"), _INTL("Sumireko Usami"), _INTL("None of these")
	]
    pbMessage(_INTL("\\w[dark]Firstly, if you had to pick, who is your favorite Touhou Project character from this list?"))
    return pbMessage(_INTL("\\w[dark]Choose a character:"), characters, characters.length)
  end
  
  def confirm_starter_selection
    if @character_choice == 20
	  pbMessage(_INTL("\\w[dark]Understandable. This is a very limiting list, or you might not know any of these characters."))
	  pbMessage(_INTL("\\w[dark]That being said, with this option you leave your destiny up to chance."))
	  if pbConfirmMessage(_INTL("\\w[dark]Is that acceptable?"))
	    id = CHARACTER_TO_STARTER.values.sample
		@starter_choice = Pokemon.new(id, 20)
		echoln "Selected Starter: #{id}"
		return true
      else
	    return false
      end
	end
	
	characters = [
	  "Reimu Hakurei", "Marisa Kirisame", "Sakuya Izayoi",
	  "Alice Margatroid", "Youmu Konpaku", "Keine Kamishirasawa",
	  "Reisen U. Inaba", "Fujiwara no Mokou", "Rinnosuke Morichika",
	  "Hieda no Akyuu", "Aya Shameimaru", "Sanae Kochiya",
	  "Koishi Komeiji", "Kogasa Tatara", "Mononobe no Futo",
	  "Sekibanki", "Kagerou Imaizumi", "Kosuzu Motoori",
	  "Hata no Kokoro", "Sumireko Usami"
	]
	name = _INTL(characters[@character_choice])
	if pbConfirmMessage(_INTL("\\w[dark]Is {1} your favorite?", name))
	  id = CHARACTER_TO_STARTER[@character_choice]
	  @starter_choice = Pokemon.new(id, 20)
	  case @character_choice
	  when 9 # Hieda no Akyuu
	    pbMessage(_INTL("\\w[dark]Good luck."))
	  when 12 # Koishi Komeiji
	    pbMessage(_INTL("\\w[dark]Berigoo!"))
	  when 19 # Sumireko Usami
	    pbMessage(_INTL("\\w[dark]Welcome to the club!"))
	  end
	  echoln "Selected Starter: #{id}"
	  return true
	else
	  return false
	end
  end
  
  def determine_starting_moves(pkmn)
    case CHARACTER_TO_STARTER[@character_choice]
    when :CREIMU
      pkmn.learn_move(:BARRAGE18)
	  pkmn.learn_move(:DECISION18)
	  pkmn.learn_move(:FORESIGHT18)
	  pkmn.learn_move(:RAZORWIND18)
    when :CMARISA
      pkmn.learn_move(:SHOCKWAVE18)
	  pkmn.learn_move(:MIMIC18)
	  pkmn.learn_move(:THIEF18)
	  pkmn.learn_move(:AURORABEAM18)
    when :CSAKUYA
      pkmn.learn_move(:KNIFETHROW18)
	  pkmn.learn_move(:DETECT18)
	  pkmn.learn_move(:DOUBLEKICK18)
	  pkmn.learn_move(:THIEF18)
    when :CALICE
      pkmn.learn_move(:PSYBEAM1818)
	  pkmn.learn_move(:MAGICKNIFE18)
	  pkmn.learn_move(:AURORABEAM18)
	  pkmn.learn_move(:MAGICALLEAF18)
    when :CYOUMU
      pkmn.learn_move(:NIGHTSLASH18)
	  pkmn.learn_move(:FURCUTTER18)
	  pkmn.learn_move(:DOUBLETEAM18)
	  pkmn.learn_move(:RAZORWIND18)
    when :CKEINE
      pkmn.learn_move(:PSYBEAM18)
	  pkmn.learn_move(:HEADBUTT18)
	  pkmn.learn_move(:SHARPEN18)
	  pkmn.learn_move(:DECISION18)
    when :CREISEN
      pkmn.learn_move(:CHARGEBEAM18)
	  pkmn.learn_move(:MINDBOMB18)
	  pkmn.learn_move(:CONFUSERAY18)
	  pkmn.learn_move(:PSYBEAM18)
    when :CMOKOU
      pkmn.learn_move(:FLAMEWHEEL18)
	  pkmn.learn_move(:LEER18)
	  pkmn.learn_move(:DOUBLEKICK18)
	  pkmn.learn_move(:BRICKBREAK18)
    when :RINNOSUKE
      pkmn.learn_move(:CHARGEBEAM18)
	  pkmn.learn_move(:SHADOWHIT18)
	  pkmn.learn_move(:RECYCLE18)
	  pkmn.learn_move(:SECRETPOWER18)
    when :AKYUU
      pkmn.learn_move(:SKETCH18)
	  pkmn.learn_move(:MIMIC18)
	  pkmn.learn_move(:SLEEPPOWDER18)
	  pkmn.learn_move(:RECOLLECTION18)
    when :CAYA
      pkmn.learn_move(:WINGATTACK18)
	  pkmn.learn_move(:WHIRLWIND18)
	  pkmn.learn_move(:GALE18)
	  pkmn.learn_move(:TWISTER18)
    when :CSANAE
      pkmn.learn_move(:WATERPULSE18)
	  pkmn.learn_move(:DECISION18)
	  pkmn.learn_move(:NATUREPOWER18)
	  pkmn.learn_move(:GUST18)
    when :CKOISHI
      pkmn.learn_move(:CONVERSION18)
	  pkmn.learn_move(:MIRRORSHOT18)
	  pkmn.learn_move(:PSYSHOT18)
	  pkmn.learn_move(:DREAMEATER18)
    when :CKOGASA
      pkmn.learn_move(:TWISTER18)
	  pkmn.learn_move(:POWDERSNOW18)
	  pkmn.learn_move(:WATERPULSE18)
	  pkmn.learn_move(:SHADOWHIT18)
    when :CFUTO
      pkmn.learn_move(:WATERGUN18)
	  pkmn.learn_move(:FOCUSENERGY18)
	  pkmn.learn_move(:DECISION18)
	  pkmn.learn_move(:COMETPUNCH18)
    when :CSEKIBANKI
      pkmn.learn_move(:BLACKRIPPLE18)
	  pkmn.learn_move(:SCARYFACE18)
	  pkmn.learn_move(:HEADBUTT18)
	  pkmn.learn_move(:WILLOWISP18)
    when :CKAGEROU
      pkmn.learn_move(:HOWL18)
	  pkmn.learn_move(:BITE18)
	  pkmn.learn_move(:FURYSWIPES18)
	  pkmn.learn_move(:PURSUIT18)
    when :CKOSUZU
	  pkmn.learn_move(:METRONOME18)
      pkmn.learn_move(:FLAIL18)
	  pkmn.learn_move(:SKETCH18)
	  pkmn.learn_move(:MINDBOMB18)
    when :CKOKORO
      pkmn.learn_move(:PSYCHOCUT18)
	  pkmn.learn_move(:SCARYFACE18)
	  pkmn.learn_move(:SHADOWHIT18)
	  pkmn.learn_move(:PERISHSONG18)
    when :CSUMIREKO
      pkmn.learn_move(:PSYBEAM18)
	  pkmn.learn_move(:WATERGUN18)
	  pkmn.learn_move(:KNOCKOFF18)
	  pkmn.learn_move(:YAWN18)
    else
      return
    end
  end
  
  def pbGiveStarter
    pkmn = @starter_choice
    pkmn.item = :SITRUSBERRY
    pkmn.poke_ball = :PUPPETORB
    pkmn.obtain_text = "Gensokyo Wilderness"
	
	pkmn.iv[:HP] = 31
    pkmn.iv[:ATTACK] = 31
    pkmn.iv[:DEFENSE] = 31
    pkmn.iv[:SPECIAL_ATTACK] = 31
    pkmn.iv[:SPECIAL_DEFENSE] = 31
    pkmn.iv[:SPEED] = 31
    pkmn.calc_stats
    pkmn.reset_moves
	determine_starting_moves(pkmn)
    pbAddPokemonSilent(pkmn)
  end
end

def pbStarterSelection
  StarterSelection.new.pbChooseStarter
end