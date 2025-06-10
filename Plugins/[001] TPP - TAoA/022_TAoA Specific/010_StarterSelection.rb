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
    8  => :CRINNOSUKE,
    9  => :CAKYUU,
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
  
  
  def pbGiveStarter
    pkmn = @starter_choice
    pkmn.item = :ORANBERRY
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
    pbAddPokemonSilent(pkmn)

  end
end

def pbStarterSelection
  StarterSelection.new.pbChooseStarter
end