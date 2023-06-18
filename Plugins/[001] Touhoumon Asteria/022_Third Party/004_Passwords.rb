if defined?(PluginManager) && !PluginManager.installed?("Passwords in Events")
  PluginManager.register({                                                 
    :name    => "Passwords in Events",                                        
    :version => "1.0",                                                     
    :link    => "https://reliccastle.com/resources/18/",             
    :credits => "Mr. Gela"
  })
end

class Player < Trainer
  attr_accessor :cute_charm_kyouko
  attr_accessor :idol_yamame
  attr_accessor :dlwruukoto
  attr_accessor :koishibuff
  attr_accessor :desolate_marisa_omega
  attr_accessor :frozen_yuyuko_omega
  attr_accessor :arid_devas_omega
  attr_accessor :primordial_kanako_omega
  attr_accessor :ultra_instinct_reimu_omega
  attr_accessor :seraphic_sariel_omega
  attr_accessor :shadow_lugia
  attr_accessor :bolt_beak_saya
  attr_accessor :fisheous_rend_fish
  attr_accessor :draco_meteor_tori
  attr_accessor :agility_cyoshika
  attr_accessor :delta_stream_tori
  attr_accessor :cherish_balls_50
  attr_accessor :glitter_balls_50
  attr_accessor :jumpstart_items
  attr_accessor :field_healing_item
  attr_accessor :portable_pc
  attr_accessor :power_item_pack
  attr_accessor :shiny_charm
  attr_accessor :player_ivs_maxed
  attr_accessor :enemy_ivs_maxed
  attr_accessor :enemy_evs_maxed
  attr_accessor :disable_exp_gain
  attr_accessor :disable_ev_gain
  attr_accessor :disable_item_use
  attr_accessor :disable_cash_gain
  attr_accessor :enable_item_drops
  attr_accessor :next_wild_shiny
end

class Game_Temp
  attr_accessor	:just_koishi
  attr_accessor	:just_basiney
  #attr_accessor :next_wild_shiny
end

def pbPasswordCheck(helptext = "Input Password", minlength = 0, maxlength = 12, casesensitive = false)
  passwords = [
  # --- Pokemon and Puppet Distributions ---
	"cutedoggo",			# Cute Charm CKyouko
	"idolspidr",			# Idol Yamame
	"retribution",			# Dark Last Word Ruukoto, Plot Activated Only
	"bigigbiff",			# Tickle Igglybuff and Chibi Koishi
	"pwrofasun",			# Desolate Land Marisa Omega
	"icestronk",			# Frozen World Yuyuko Omega
	"superdeva",			# Arid Wastes OniDevas Omega
	"windyrain",			# Primordial Sea Kanako Omega
	"finalmiko",			# Delta Stream/Fantasy Nature++ Reimu Omega
	"1truegod",				# Seraph Wings++ Sariel Omega
	"truewaifu",			# Shadow Lugia with special movepool
	"superbird",			# Bolt Beak Speed Aya
	"superfish",			# Fisheous Rend Namazu/Wakasagi 
	"chirpchirp",			# Draco Meteor Tori
	"speeddemon",			# Agility CYoshika
	"birdquest",			# Delta Stream Tori
	
  # --- Item Distributions ---
	"cherishem",			# 50 Cherish Balls  
	"shinyem",				# 50 Glitter Balls
	"jumpstart",			# 20 Pokeballs, 10 Great Balls, 5 Ultra Balls, 20 Potions, 10 Super Potions, 5 Hyper Potions, 10 Lava Cookies, 6 Ability Capsules, 10k Cash
	"fieldheal",			# Portable Healing Device
	"billspride",			# Portable PC
	"poweredup",			# Full Power Item set
	"shinypls",				# Shiny Charm
	
  # --- Utility and Quality of Life ---
	"moreshiny",			# Next Wild Encounter is shiny
	"debmodeon",			# Enables Debug Mode
	"debmodeoff",			# Disables Debug Mode
	"debmodestate",			# Toggles the activation state of Debug Mode
	"perfection",			# All Wild/Traded/Gifted Pokemon have 31 IVs in all stats
	
  # --- Difficulty Altering ---
	"worthyfight",			# All trainers have 31^6 IVs
	"whatthefuck",			# All trainers have 252^6 EVs
	"rebornmode",			# All trainers have 31^6 IVs and 252^6 EVs
	"noexp",				# Removes EXP Gain from all battles
	"noevs",				# Removes EV Gain from all battles
	"noitems",				# Removes item use from all battles
	"nocash",				# Removes cash gain from all battles
	"tpdpmode",				# Removes cash gain from all battles, but makes it so battles have a chance to drop items to sell
	"scuffedaf",			# All trainers have 31^6 IVs and 252^6 EVs, restricts items in battle, removes EXP, EV, and Money gain
	
  # --- Shenanigans ---
	"justkoi",				# Replaces all Pokemon and Puppets with Koishi
	#"2cakesman",			# Triggers a special fight against the Five Magic Stones
	#"justbasin"			# Replaces all Pokemon and Puppets with Basiney
  ]    
  code = pbEnterText(helptext, minlength, maxlength)
  if passwords.include?(code)
  #if code == password || (casesensitive == false && code.downcase == password.downcase)
    case code
	# --- Cute Charm CKyouko ---
	when "cutedoggo"
	  if $player.cute_charm_kyouko
		pbMessage(_INTL("\\bThe Kyouko with Cute Charm has already been distributed. This code cannot be used again."))
		return false
	  else
		pbMessage(_INTL("\\bThis code will add a Chibi Kyouko with it's Hidden Ability, Cute Charm, to your party. If your party is full, it will be sent to your box."))
		pbMessage(_INTL("\\bOnce claimed, you will not be able to renew this code again."))
		if pbConfirmMessage(_INTL("\\bAre you capable of recieving this gift?"))
		  pkmn=Pokemon.new(:CKYOUKO,10)
		  pkmn.item = :GREENUFO
		  pkmn.ability = :CUTECHARM
		  pkmn.happiness = 255
		  pkmn.iv[:HP]=15
		  pkmn.iv[:ATTACK]=15
		  pkmn.iv[:DEFENSE]=15
		  pkmn.iv[:SPECIAL_ATTACK]=15
		  pkmn.iv[:SPECIAL_DEFENSE]=15
		  pkmn.iv[:SPEED]=15
		  pkmn.calc_stats
		  pbAddPokemon(pkmn)
		  $player.cute_charm_kyouko = true
		  return true
		else
		  return false
		end
	  end
	# --- Idol Yamame ---
	when "idolspidr"
	  if $player.idol_yamame
		pbMessage(_INTL("\\bThe Yamame with Idol has already been distributed. This code cannot be used again."))
		return false
	  else
		pbMessage(_INTL("\\bThis code will add an Evolved Yamame with it's Hidden Ability, Idol, to your party. If your party is full, it will be sent to your box."))
		pbMessage(_INTL("\\bOnce claimed, you will not be able to renew this code again."))
		if pbConfirmMessage(_INTL("\\bAre you capable of recieving this gift?"))
		  pkmn=Pokemon.new(:YAMAME,30)
		  pkmn.item = :BLUEUFO
		  pkmn.ability = :DIVA
		  pkmn.happiness = 255
		  pkmn.iv[:HP]=15
		  pkmn.iv[:ATTACK]=15
		  pkmn.iv[:DEFENSE]=15
		  pkmn.iv[:SPECIAL_ATTACK]=15
		  pkmn.iv[:SPECIAL_DEFENSE]=15
		  pkmn.iv[:SPEED]=15
		  pkmn.calc_stats
		  pkmn.learn_move(:PERFORMANCE18)
		  pkmn.learn_move(:CROSSPOISON18)
		  pkmn.learn_move(:MUDSHOT18)
		  pkmn.learn_move(:STUNSPORE18)
		  pkmn.record_first_moves
		  pbAddPokemon(pkmn)
		  $player.idol_yamame = true
		  return true
		else
		  return false
		end
	  end
	# --- DLwRuukoto ---
	when "retribution"
	  if $player.dlwruukoto
		pbMessage(_INTL("...\\wt[20]No response."))
		return false
	  else
		$game_player.animation_id = 003
		pbMessage(_INTL("\\bWARNING. CORRUPT DATA LOADED. PLEASE CONTACT SILPH CO. FOR EMERGENCY MAINT-\\wtnp[1]"))
		pbWait(20)
		pbSEPlay("PC open")
		pbMessage(_INTL("\\rSystem rebooted. Remote control granted. Please enter trainer ID."))
		pbWait(20)
		pbMessage(_INTL("\\rID confirmed. Distributing gift, \"The Destructor\". Please ensure you have room in your party or box before accepting."))
		if pbConfirmMessage(_INTL("\\rAre you capable of recieving this gift?"))
		  pkmn=Pokemon.new(:RUUKOTO,30)
		  pkmn.name = "DLwRuukoto"
		  pkmn.item = :LEFTOVERS
		  pkmn.form = 1         # DLwRuukoto
		  pkmn.ability = :RETRIBUTION
		  pkmn.nature = :MODEST
		  pkmn.gender = nil
		  pkmn.owner.id = $Trainer.make_foreign_ID
		  pkmn.owner.name = "The Collector"
		  pkmn.iv[:HP]=31
		  pkmn.iv[:ATTACK]=31
		  pkmn.iv[:DEFENSE]=31
		  pkmn.iv[:SPECIAL_ATTACK]=0
		  pkmn.iv[:SPECIAL_DEFENSE]=31
		  pkmn.iv[:SPEED]=31
		  pkmn.calc_stats
		  pkmn.learn_move(:TOXIC18)
		  pkmn.learn_move(:WISH18)
		  pkmn.learn_move(:MAGICCOAT18)
		  pkmn.learn_move(:CHECKMAID)
		  pkmn.record_first_moves
		  pbAddPokemonSilent(pkmn)
		  pbMEPlay("Battle capture success")
		  pbMessage(_INTL("DLwRuukoto joined \\pn's team!\\wtnp[80]"))
		  pbWait(20)
		  pbMessage(_INTL("\\rPlaying additional content. Please stand by."))
		  pbMessage(_INTL("\\xn[???]Well hello there, \\pn."))
		  pbMessage(_INTL("\\xn[???]It's a shame that I couldn't address this to you in person, but this should suffice for now."))
		  pbMessage(_INTL("\\xn[The Collector]My actual name means little to you, but you can refer to me as \"The Collector\"."))
		  pbMessage(_INTL("\\xn[The Collector]I do hope this gift finds you well. After that show you put on for me that I can hold over those corporate megalomaniacal bastards heads you deserve this much."))
		  pbMessage(_INTL("\\xn[The Collector]One day I hope we'll be able to meet in person."))
		  pbMessage(_INTL("\\xn[The Collector]Though technically, we did already meet, but it is understandable if you didn't notice me sitting beside you at the conference."))
		  pbMessage(_INTL("\\xn[The Collector]Nevertheless, please continue your journey with my gift. She needs more combat experience, and I have deemed you as the best way to get it."))
		  pbMessage(_INTL("\\xn[The Collector]Good luck on your journey, \\pn. Until we meet proper."))
		  pbWait(20)
		  pbMessage(_INTL("\\rEnd of additional content. Thank you for using Oracle Encryption Software. Goodbye."))
		  pbSEPlay("PC close")
		  $player.dlwruukoto = true
		  completeQuest(:Quest107)
		  return true
		else
		  return false
		end
	  end	
	# --- Idol Yamame ---
	when "bigigbiff"
	  if $player.koishibuff
		pbMessage(_INTL("\\bMy apologies Chirei, but I am all out of Igglybuffs to give. If you'd like, I can give you a Koikie (Koishi Cookie) instead?"))
		return false
	  else
		pbMessage(_INTL("\\bThis code will add an Igglybuff that knows the move Tickle to your party."))
		pbMessage(_INTL("\\bOnce claimed, you will not be able to renew this code again."))
		if pbConfirmMessage(_INTL("\\bAre you capable of recieving this gift?"))
		  p1=Pokemon.new(:IGGLYBUFF,5)
		  p1.item = :HEARTSCALE
		  p1.happiness = 255
		  p1.iv[:HP]=15
		  p1.iv[:ATTACK]=15
		  p1.iv[:DEFENSE]=15
		  p1.iv[:SPECIAL_ATTACK]=15
		  p1.iv[:SPECIAL_DEFENSE]=15
		  p1.iv[:SPEED]=15
		  p1.calc_stats
		  p1.learn_move(:SING18)
		  p1.learn_move(:CHARM)
		  p1.learn_move(:DEFENSECURL)
		  p1.learn_move(:TICKLE)
		  p1.record_first_moves
		  pbAddPokemon(p1)
		  pkmn=Pokemon.new(:CKOISHI,5)
		  pkmn.item = :HEARTSCALE
		  pkmn.happiness = 255
		  pkmn.iv[:HP]=15
		  pkmn.iv[:ATTACK]=15
		  pkmn.iv[:DEFENSE]=15
		  pkmn.iv[:SPECIAL_ATTACK]=15
		  pkmn.iv[:SPECIAL_DEFENSE]=15
		  pkmn.iv[:SPEED]=15
		  pkmn.calc_stats
		  pbAddPokemonSilent(pkmn)
		  $player.koishibuff = true
		  return true
		else
		  return false
		end
	  end
	# --- Desolate Land Marisa Omega ---
	when "pwrofasun"
	  if $player.desolate_marisa_omega
		pbMessage(_INTL("\\bThe Marisa Ω with Desolate Land has already been distributed. This code cannot be used again."))
		return false
	  else
		pbMessage(_INTL("\\bThis code will add a Marisa Ω that has the ability Desolate Land to your party."))
		pbMessage(_INTL("\\bOnce claimed, you will not be able to renew this code again."))
		if pbConfirmMessage(_INTL("\\bAre you capable of recieving this gift?"))
		  pkmn=Pokemon.new(:MARISAO,50)
		  pkmn.happiness = 0
		  pkmn.iv[:HP]=15
		  pkmn.iv[:ATTACK]=15
		  pkmn.iv[:DEFENSE]=15
		  pkmn.iv[:SPECIAL_ATTACK]=15
		  pkmn.iv[:SPECIAL_DEFENSE]=15
		  pkmn.iv[:SPEED]=15
		  pkmn.calc_stats
		  pkmn.ability = :DESOLATELAND
		  pbAddPokemon(pkmn)
		  $player.desolate_marisa_omega = true
		  return true
		else
		  return false
		end
	  end
	# --- Frozen World Yuyuko Omega ---
	when "icestronk"
	  if $player.frozen_yuyuko_omega
		pbMessage(_INTL("\\bThe Yuyuko Ω with Frozen World has already been distributed. This code cannot be used again."))
		return false
	  else
		pbMessage(_INTL("\\bThis code will add a Yuyuko Ω that has the ability Frozen World to your party."))
		pbMessage(_INTL("\\bOnce claimed, you will not be able to renew this code again."))
		if pbConfirmMessage(_INTL("\\bAre you capable of recieving this gift?"))
		  pkmn=Pokemon.new(:YUYUKOO,50)
		  pkmn.happiness = 0
		  pkmn.iv[:HP]=15
		  pkmn.iv[:ATTACK]=15
		  pkmn.iv[:DEFENSE]=15
		  pkmn.iv[:SPECIAL_ATTACK]=15
		  pkmn.iv[:SPECIAL_DEFENSE]=15
		  pkmn.iv[:SPEED]=15
		  pkmn.calc_stats
		  pkmn.ability = :DEATHLYFROST
		  pbAddPokemon(pkmn)
		  $player.frozen_yuyuko_omega = true
		  return true
		else
		  return false
		end
	  end
	# --- Arid Wastes OniDevas Omega ---
	when "superdeva"
	  if $player.arid_devas_omega
		pbMessage(_INTL("\\bThe OniDevas Ω with Desolate Land has already been distributed. This code cannot be used again."))
		return false
	  else
		pbMessage(_INTL("\\bThis code will add an OniDevas Ω that has the ability Desolate Land to your party."))
		pbMessage(_INTL("\\bOnce claimed, you will not be able to renew this code again."))
		if pbConfirmMessage(_INTL("\\bAre you capable of recieving this gift?"))
		  pkmn=Pokemon.new(:ONIDEVASO,50)
		  pkmn.happiness = 0
		  pkmn.iv[:HP]=15
		  pkmn.iv[:ATTACK]=15
		  pkmn.iv[:DEFENSE]=15
		  pkmn.iv[:SPECIAL_ATTACK]=15
		  pkmn.iv[:SPECIAL_DEFENSE]=15
		  pkmn.iv[:SPEED]=15
		  pkmn.calc_stats
		  pkmn.ability = :ARIDWASTES
		  pbAddPokemon(pkmn)
		  $player.arid_devas_omega = true
		  return true
		else
		  return false
		end
	  end
	# --- Primordial Sea Kanako Omega ---
	when "windyrain"
	  if $player.primordial_kanako_omega
		pbMessage(_INTL("\\bThe Kanako Ω with Primordial Sea has already been distributed. This code cannot be used again."))
		return false
	  else
		pbMessage(_INTL("\\bThis code will add a Kanako Ω that has the ability Primordial Sea to your party."))
		pbMessage(_INTL("\\bOnce claimed, you will not be able to renew this code again."))
		if pbConfirmMessage(_INTL("\\bAre you capable of recieving this gift?"))
		  pkmn=Pokemon.new(:KANAKOO,50)
		  pkmn.happiness = 0
		  pkmn.iv[:HP]=15
		  pkmn.iv[:ATTACK]=15
		  pkmn.iv[:DEFENSE]=15
		  pkmn.iv[:SPECIAL_ATTACK]=15
		  pkmn.iv[:SPECIAL_DEFENSE]=15
		  pkmn.iv[:SPEED]=15
		  pkmn.calc_stats
		  pkmn.ability = :PRIMORDIALSEA
		  pbAddPokemon(pkmn)
		  $player.primordial_kanako_omega = true
		  return true
		else
		  return false
		end
	  end
	# --- Fantasy Nature+ Reimu Omega ---
	when "finalmiko"
	  if $player.ultra_instinct_reimu_omega
		pbMessage(_INTL("\\bThe Reimu Ω with Fantasy Nature+ has already been distributed. This code cannot be used again."))
		return false
	  else
		pbMessage(_INTL("\\bThis code will add a Reimu Ω that has the ability Fantasy Nature+ to your party."))
		pbMessage(_INTL("\\bOnce claimed, you will not be able to renew this code again."))
		if pbConfirmMessage(_INTL("\\bAre you capable of recieving this gift?"))
		  pkmn=Pokemon.new(:REIMUO,50)
		  pkmn.happiness = 0
		  pkmn.iv[:HP]=15
		  pkmn.iv[:ATTACK]=15
		  pkmn.iv[:DEFENSE]=15
		  pkmn.iv[:SPECIAL_ATTACK]=15
		  pkmn.iv[:SPECIAL_DEFENSE]=15
		  pkmn.iv[:SPEED]=15
		  pkmn.calc_stats
		  pkmn.ability = :FANTASYNATURE2
		  pbAddPokemon(pkmn)
		  $player.ultra_instinct_reimu_omega = true
		  return true
		else
		  return false
		end
	  end
	# --- Seraph Wings+ Sariel Omega ---
	when "1truegod"
	  if $player.seraphic_sariel_omega
		pbMessage(_INTL("\\bThe Sariel Ω with Seraph Wings+ has already been distributed. This code cannot be used again."))
		return false
	  else
		pbMessage(_INTL("\\bThis code will add a Sariel Ω that has the ability Seraph Wings+ to your party."))
		pbMessage(_INTL("\\bOnce claimed, you will not be able to renew this code again."))
		if pbConfirmMessage(_INTL("\\bAre you capable of recieving this gift?"))
		  pkmn=Pokemon.new(:SARIELO,50)
		  pkmn.happiness = 0
		  pkmn.iv[:HP]=15
		  pkmn.iv[:ATTACK]=15
		  pkmn.iv[:DEFENSE]=15
		  pkmn.iv[:SPECIAL_ATTACK]=15
		  pkmn.iv[:SPECIAL_DEFENSE]=15
		  pkmn.iv[:SPEED]=15
		  pkmn.calc_stats
		  pkmn.ability = :SERAPHWINGS2
		  pbAddPokemon(pkmn)
		  $player.serpahic_sariel_omega = true
		  return true
		else
		  return false
		end
	  end
	# --- "Shadow" Lugia ---
	when "truewaifu"
	  if $player.shadow_lugia
		pbMessage(_INTL("\\bThe special Shiny Lugia has already been distributed. This code cannot be used again."))
		return false
	  else
		pbMessage(_INTL("\\bThis code will add a special Shiny Lugia to your party."))
		pbMessage(_INTL("\\bOnce claimed, you will not be able to renew this code again."))
		if pbConfirmMessage(_INTL("\\bAre you capable of recieving this gift?"))
		  pkmn=Pokemon.new(:LUGIA,50)
		  pkmn.shiny = true
		  pkmn.form = 1 	# Shadow Lugia
		  pkmn.happiness = 0
		  pkmn.iv[:HP]=31
		  pkmn.iv[:ATTACK]=31
		  pkmn.iv[:DEFENSE]=31
		  pkmn.iv[:SPECIAL_ATTACK]=31
		  pkmn.iv[:SPECIAL_DEFENSE]=31
		  pkmn.iv[:SPEED]=31
		  pkmn.learn_move(:PSYCHOBOOST)
		  pkmn.learn_move(:FEATHERDANCE)
		  pkmn.learn_move(:EARTHQUAKE)
		  pkmn.learn_move(:HYDROPUMP)
		  pkmn.record_first_moves
		  pkmn.calc_stats
		  pbAddPokemon(pkmn)
		  $player.shadow_lugia = true
		  return true
		else
		  return false
		end
	  end
	# --- Bolt Beak SAaya ---
	when "superbird"
	  if $player.bolt_beak_saya
		pbMessage(_INTL("\\bThe Speed Aya with Bolt Beak has already been distributed. This code cannot be used again."))
		return false
	  else
		pbMessage(_INTL("\\bThis code will add a Speed Aya with Bolt Beak to your party."))
		pbMessage(_INTL("\\bOnce claimed, you will not be able to renew this code again."))
		if pbConfirmMessage(_INTL("\\bAre you capable of recieving this gift?"))
		  pkmn=Pokemon.new(:SAYA,50)
		  pkmn.happiness = 75
		  pkmn.iv[:HP]=21
		  pkmn.iv[:ATTACK]=21
		  pkmn.iv[:DEFENSE]=21
		  pkmn.iv[:SPECIAL_ATTACK]=21
		  pkmn.iv[:SPECIAL_DEFENSE]=21
		  pkmn.iv[:SPEED]=21
		  pkmn.learn_move(:BOLTBEAK18)
		  pkmn.learn_move(:TEMPORARYMOVE1)
		  pkmn.learn_move(:TEMPORARYMOVE2)
		  pkmn.learn_move(:TEMPORARYMOVE3)
		  pkmn.record_first_moves
		  pkmn.calc_stats
		  pbAddPokemon(pkmn)
		  pbMessage(_INTL("\\bMay the gods have mercy on us all."))
		  $player.bolt_beak_saya = true
		  return true
		else
		  return false
		end
	  end
	# --- Fisheous Rend [Placeholder] ---
	when "superfish"
	  if $player.fisheous_rend_fish
		pbMessage(_INTL("\\bThe [Placeholder] with Fisheous Rend has already been distributed. This code cannot be used again."))
		return false
	  else
		pbMessage(_INTL("\\bThis code will add a [Placeholder] with Fisheous Rend to your party."))
		pbMessage(_INTL("\\bOnce claimed, you will not be able to renew this code again."))
		if pbConfirmMessage(_INTL("\\bAre you capable of recieving this gift?"))
		  pkmn=Pokemon.new(:NAMAZU,50)
		  pkmn.happiness = 75
		  pkmn.iv[:HP]=21
		  pkmn.iv[:ATTACK]=21
		  pkmn.iv[:DEFENSE]=21
		  pkmn.iv[:SPECIAL_ATTACK]=21
		  pkmn.iv[:SPECIAL_DEFENSE]=21
		  pkmn.iv[:SPEED]=21
		  pkmn.learn_move(:FISHEOUSREND18)
		  pkmn.learn_move(:TEMPORARYMOVE1)
		  pkmn.learn_move(:TEMPORARYMOVE2)
		  pkmn.learn_move(:TEMPORARYMOVE3)
		  pkmn.record_first_moves
		  pkmn.calc_stats
		  pbAddPokemon(pkmn)
		  pbMessage(_INTL("\\bMay the gods have mercy on us all."))
		  $player.fisheous_rend_fish = true
		  return true
		else
		  return false
		end
	  end
	# --- Draco Meteor Tori ---
	when "chirpchirp"
	  if $player.draco_meteor_tori
		pbMessage(_INTL("\\bThe Tori with Draco Meteor has already been distributed. This code cannot be used again."))
		return false
	  else
		pbMessage(_INTL("\\bThis code will add a Speed Aya with Bolt Beak to your party."))
		pbMessage(_INTL("\\bOnce claimed, you will not be able to renew this code again."))
		if pbConfirmMessage(_INTL("\\bAre you capable of recieving this gift?"))
		  pkmn=Pokemon.new(:TORI,10)
		  pkmn.happiness = 255
		  pkmn.iv[:HP]=31
		  pkmn.iv[:ATTACK]=31
		  pkmn.iv[:DEFENSE]=31
		  pkmn.iv[:SPECIAL_ATTACK]=31
		  pkmn.iv[:SPECIAL_DEFENSE]=31
		  pkmn.iv[:SPEED]=31
		  pkmn.learn_move(:DRACOMETEOR18)
		  pkmn.learn_move(:TEMPORARYMOVE1)
		  pkmn.learn_move(:TEMPORARYMOVE2)
		  pkmn.learn_move(:TEMPORARYMOVE3)
		  pkmn.record_first_moves
		  pkmn.calc_stats
		  pbAddPokemon(pkmn)
		  $player.draco_meteor_tori = true
		  return true
		else
		  return false
		end
	  end
	# --- Agility CYoshika ---
	when "speeddemon"
	  if $player.agility_cyoshika
		pbMessage(_INTL("\\bThe CYoshika with Agility has already been distributed. This code cannot be used again."))
		return false
	  else
		pbMessage(_INTL("\\bThis code will add a Speed Aya with Bolt Beak to your party."))
		pbMessage(_INTL("\\bOnce claimed, you will not be able to renew this code again."))
		if pbConfirmMessage(_INTL("\\bAre you capable of recieving this gift?"))
		  pkmn=Pokemon.new(:CYOSHIKA,10)
		  pkmn.happiness = 35
		  pkmn.iv[:HP]=31
		  pkmn.iv[:ATTACK]=31
		  pkmn.iv[:DEFENSE]=31
		  pkmn.iv[:SPECIAL_ATTACK]=31
		  pkmn.iv[:SPECIAL_DEFENSE]=31
		  pkmn.iv[:SPEED]=31
		  pkmn.learn_move(:AGILITY18)
		  pkmn.learn_move(:TEMPORARYMOVE1)
		  pkmn.learn_move(:TEMPORARYMOVE2)
		  pkmn.learn_move(:TEMPORARYMOVE3)
		  pkmn.record_first_moves
		  pkmn.calc_stats
		  pbAddPokemon(pkmn)
		  $player.agility_cyoshika = true
		  return true
		else
		  return false
		end
	  end
	# --- Delta Stream Tori ---
	when "birdquest"
	  if $player.delta_stream_tori
		pbMessage(_INTL("\\bThe Tori with Delta Stream has already been distributed. This code cannot be used again."))
		return false
	  else
		pbMessage(_INTL("\\bThis code will add a Tori with the ability Delta Stream to your party."))
		pbMessage(_INTL("\\bOnce claimed, you will not be able to renew this code again."))
		if pbConfirmMessage(_INTL("\\bAre you capable of recieving this gift?"))
		  pkmn=Pokemon.new(:TORI,50)
		  pkmn.happiness = 255
		  pkmn.iv[:HP]=31
		  pkmn.iv[:ATTACK]=31
		  pkmn.iv[:DEFENSE]=31
		  pkmn.iv[:SPECIAL_ATTACK]=31
		  pkmn.iv[:SPECIAL_DEFENSE]=31
		  pkmn.iv[:SPEED]=31
		  pkmn.ability = :DELTASTREAM
		  pkmn.calc_stats
		  pbAddPokemon(pkmn)
		  $player.delta_stream_tori = true
		  return true
		else
		  return false
		end
	  end
	# --- 50x Cherish Balls ---
	when "cherishem"
	  if $player.cherish_balls_50
		pbMessage(_INTL("\\bYou have already redeemed the code for 50 Cherish Balls. This code cannot be used again."))
		return false
	  else
		pbMessage(_INTL("\\bThis code will give you 50 Cherish Balls."))
		pbMessage(_INTL("\\bOnce claimed, you will not be able to renew this code again."))
		if pbConfirmMessage(_INTL("\\bWould you like to claim this code??"))
		  pbReceiveItem(:CHERISHBALL,50)
		  $player.cherish_balls_50 = true
		  return true
		else
		  return false
		end
	  end
	# --- 50x Glitter Balls ---
	when "shinyem"
	  if $player.glitter_balls_50
		pbMessage(_INTL("\\bYou have already redeemed the code for 50 Glitter Balls. This code cannot be used again."))
		return false
	  else
		pbMessage(_INTL("\\bThis code will give you 50 Glitter Balls.."))
		pbMessage(_INTL("\\bOnce claimed, you will not be able to renew this code again."))
		if pbConfirmMessage(_INTL("\\bWould you like to claim this code??"))
		  pbReceiveItem(:GLITTERBALL,50)
		  $player.glitter_balls_50 = true
		  return true
		else
		  return false
		end
	  end
	# --- Quick Start Items ---
	when "jumpstart"
	  if $player.jumpstart_items
		pbMessage(_INTL("\\bYou have already redeemed the code for the Jumpstart Item Pack. This code cannot be used again."))
		return false
	  else
		pbMessage(_INTL("\\bThis code will give you a pack of items that will help jumpstart your adventures as a Trainer."))
		pbMessage(_INTL("\\bOnce claimed, you will not be able to renew this code again."))
		if pbConfirmMessage(_INTL("\\bWould you like to claim this code??"))
		  pbReceiveItem(:POKEBALL,20)
		  pbReceiveItem(:GREATBALL,10)
		  pbReceiveItem(:ULTRABALL,5)
		  pbReceiveItem(:POTION,20)
		  pbReceiveItem(:SUPERPOTION,10)
		  pbReceiveItem(:HYPERPOTION,5)
		  pbReceiveItem(:LAVACOOKIE,10)
		  pbReceiveItem(:ABILITYCAPSULE,6)
		  pbReceiveItem(:RARECANDY,15)
		  $player.money += 10000
		  pbMessage(_INTL("\\me[Egg get]You also recieved $10,000!"))
		  $player.jumpstart_items = true
		  return true
		else
		  return false
		end
	  end
	# --- Pocket PokeCenter ---
	#when "fieldheal"
	#  if $player.pocket_pokecenter
	#	pbMessage(_INTL("\\bYou have already redeemed the code for the Pocket PokeCenter. This code cannot be used again."))
	#	return false
	#  else
	#	pbMessage(_INTL("\\bThis code will give you a Pocket PokeCenter Item."))
	#	pbMessage(_INTL("\\bOnce claimed, you will not be able to renew this code again."))
	#	if pbConfirmMessage(_INTL("\\bWould you like to claim this code??"))
	#	  pbReceiveItem(:POCKETPOKECENTER)
	#	  $player.pocket_pokecenter = true
	#	  return true
	#	else
	#	  return false
	#	end
	#  end
	# --- Portable PC ---
	when "billspride"
	  if $player.portable_pc || $player.has_box_link
		pbMessage(_INTL("\\bYou have already redeemed the code for the Portable PC. This code cannot be used again."))
		return false
	  else
		pbMessage(_INTL("\\bThis code will give you a Portable PC."))
		pbMessage(_INTL("\\bOnce claimed, you will not be able to renew this code again."))
		if pbConfirmMessage(_INTL("\\bWould you like to claim this code??"))
		  pbReceiveItem(:POKEMONBOXLINK)
		  $player.portable_pc = true
		  $player.has_box_link = true
		  return true
		else
		  return false
		end
	  end
	# --- Full Power Item Set ---
	when "poweredup"
	  if $player.power_item_pack
		pbMessage(_INTL("\\bYou have already redeemed the code for a full set of Power Items. This code cannot be used again."))
		return false
	  else
		pbMessage(_INTL("\\bThis code will give you a full set of Power Items."))
		pbMessage(_INTL("\\bOnce claimed, you will not be able to renew this code again."))
		if pbConfirmMessage(_INTL("\\bWould you like to claim this code??"))
		  pbReceiveItem(:POWERWEIGHT)
		  pbReceiveItem(:POWERBRACER)
		  pbReceiveItem(:POWERBELT)
		  pbReceiveItem(:POWERLENS)
		  pbReceiveItem(:POWERBAND)
		  pbReceiveItem(:POWERANKLET)
		  $player.power_item_pack = true
		  return true
		else
		  return false
		end
	  end
	# --- Shiny Charm ---
	when "shinypls"
	  if $player.shiny_charm
		pbMessage(_INTL("\\bYou have already redeemed the code for a Shiny Charm. This code cannot be used again."))
		return false
	  else
		pbMessage(_INTL("\\bThis code will give you a Shiny Charm."))
		pbMessage(_INTL("\\bOnce claimed, you will not be able to renew this code again."))
		if pbConfirmMessage(_INTL("\\bWould you like to claim this code??"))
		  pbReceiveItem(:SHINYCHARM)
		  $player.shiny_charm = true
		  return true
		else
		  return false
		end
	  end
	# --- Next Wild Encounter is Shiny ---
	when "moreshiny"
	  pbMessage(_INTL("\\bThis code will make the next Wild Encounter be shiny."))
	  pbMessage(_INTL("\\bThis code can be reapplied however many times you like."))
	  if pbConfirmMessage(_INTL("\\bWould you like to claim this code??"))
		pbMessage(_INTL("\\bThe next Wild Encounter will be Shiny."))
		$player.next_wild_shiny = true
		$game_switches[Settings::SHINY_WILD_POKEMON_SWITCH] = true
		return true
	  else
		return false
	  end
	# --- Enable/Disable Debug Mode for Testers ---
	when "debmodestate"
	  pbMessage(_INTL("\\rThis code will toggle Debug Mode on or off."))
	  pbMessage(_INTL("\\rThis code is to be used exclusively by testers."))
	  pbMessage(_INTL("\\rPlease use this code responsibly. If something breaks because of Debug Mode Shenanigans, that is (almost always) not my problem."))
	  if $DEBUG == false
		if pbConfirmMessage(_INTL("\\rWould you like to enable Debug Mode?"))
		  pbMessage(_INTL("\\rDebug Mode has been enabled."))
		  $DEBUG == true
		  return true
		else
		  return false
		end
	  else
	    if pbConfirmMessage(_INTL("\\rWould you like to disable Debug Mode?"))
		  pbMessage(_INTL("\\rDebug Mode has been disabled."))
		  $DEBUG == false
		  return true
		else
		  return false
		end
	  end
	# --- All Player-Obtained Pokemon have 31 IVs in all stats ---
	when "perfection"
	  if $player.player_ivs_maxed
		pbMessage(_INTL("\\bThe code for 31 IVs on all Player-Obtained Pokémon and Puppets is currently active."))
		if pbConfirmMessage(_INTL("\\bWould you like to disable this code?"))
		  pbMessage(_INTL("\\bThe code for 31 IVs on all Player-Obtained Pokémon and Puppets has been turned off."))
		  $player.player_ivs_maxed = false
		  return true
		else
		  return false
		end
	  else
		pbMessage(_INTL("\\bThe code for 31 IVs on all Player-Obtained Pokémon and Puppets is currently inactive."))
		if pbConfirmMessage(_INTL("\\bWould you like to enable this code?"))
		  pbMessage(_INTL("\\bThe code for 31 IVs on all Player-Obtained Pokémon and Puppets has been turned on."))
		  $player.player_ivs_maxed = true
		  return true
		else
		  return false
		end
	  end
	# --- All Enemy Trainers have 31 IVs in all stats ---
	when "worthyfight"
	  if $player.enemy_ivs_maxed
		pbMessage(_INTL("\\bThe code for 31 IVs on all Enemy Trainer's Pokémon and Puppets is currently active."))
		if pbConfirmMessage(_INTL("\\bWould you like to disable this code?"))
		  pbMessage(_INTL("\\bThe code for 31 IVs on all Enemy Trainer's Pokémon and Puppets has been turned off."))
		  $player.enemy_ivs_maxed = false
		  return true
		else
		  return false
		end
	  else
		pbMessage(_INTL("\\bThe code for 31 IVs on all Enemy Trainer's Pokémon and Puppets is currently inactive."))
		if pbConfirmMessage(_INTL("\\bWould you like to enable this code?"))
		  pbMessage(_INTL("\\bThe code for 31 IVs on all Enemy Trainer's Pokémon and Puppets has been turned on."))
		  $player.enemy_ivs_maxed = true
		  return true
		else
		  return false
		end
	  end
	# --- All Enemy Trainers have 252 IVs in all stats ---
	when "whatthefuck"
	  if $player.enemy_evs_maxed
		pbMessage(_INTL("\\bThe code for 252 EVs on all Enemy Trainer's Pokémon and Puppets is currently active."))
		if pbConfirmMessage(_INTL("\\bWould you like to disable this code?"))
		  pbMessage(_INTL("\\bThe code for 252 EVs on all Enemy Trainer's Pokémon and Puppets has been turned off."))
		  $player.enemy_evs_maxed = false
		  return true
		else
		  return false
		end
	  else
		pbMessage(_INTL("\\bThe code for 252 EVs on all Enemy Trainer's Pokémon and Puppets is currently inactive."))
		if pbConfirmMessage(_INTL("\\bWould you like to enable this code?"))
		  pbMessage(_INTL("\\bThe code for 252 EVs on all Enemy Trainer's Pokémon and Puppets has been turned on."))
		  $player.enemy_evs_maxed = true
		  return true
		else
		  return false
		end
	  end
	# --- All Enemy Trainers have 31 IVs and 252 IVs in all stats ---
	when "rebornmode"
	  if $player.enemy_ivs_maxed && $player.enemy_evs_maxed
		pbMessage(_INTL("\\bThe code for 31 IVs and 252 EVs on all Enemy Trainer's Pokémon and Puppets is currently active."))
		if pbConfirmMessage(_INTL("\\bWould you like to disable this code?"))
		  pbMessage(_INTL("\\bThe code for 31 IVs and 252 EVs on all Enemy Trainer's Pokémon and Puppets has been turned off."))
		  $player.enemy_ivs_maxed = false
		  $player.enemy_evs_maxed = false
		  return true
		else
		  return false
		end
	  else
		pbMessage(_INTL("\\bThe code for 31 IVs and 252 EVs on all Enemy Trainer's Pokémon and Puppets is currently inactive."))
		if pbConfirmMessage(_INTL("\\bWould you like to enable this code?"))
		  pbMessage(_INTL("\\bThe code for 31 IVs and 252 EVs on all Enemy Trainer's Pokémon and Puppets has been turned on."))
		  $player.enemy_ivs_maxed = true
		  $player.enemy_evs_maxed = true
		  return true
		else
		  return false
		end
	  end
	# --- Disables the gaining of EXP from all sources ---
	# Battle EXP, Rare Candies, XP Candies, Day Care
	# All of the relevant sections will need to have their code updated to accomidate the new flag
	when "noexp"
	  if $player.disable_exp_gain
		pbMessage(_INTL("\\bThe code for disabling EXP gain from all sources is currently active."))
		if pbConfirmMessage(_INTL("\\bWould you like to disable this code?"))
		  pbMessage(_INTL("\\bThe code for disabling EXP gain from all sources has been turned off."))
		  $player.disable_exp_gain = false
		  return true
		else
		  return false
		end
	  else
		pbMessage(_INTL("\\bThe code for disabling EXP gain from all sources is currently inactive."))
		if pbConfirmMessage(_INTL("\\bWould you like to enable this code?"))
		  pbMessage(_INTL("\\bThe code for disabling EXP gain from all sources has been turned on."))
		  $player.disable_exp_gain = true
		  return true
		else
		  return false
		end
	  end
	# --- Disables the gaining of EVs from all sources ---
	# Battle EVs, Vitamins/Wings, EXP Share
	# All of the relevant sections will need to have their code updated to accomidate the new flag
	when "noevs"
	  if $player.disable_ev_gain
		pbMessage(_INTL("\\bThe code for disabling EV gain from all sources is currently active."))
		if pbConfirmMessage(_INTL("\\bWould you like to disable this code?"))
		  pbMessage(_INTL("\\bThe code for disabling EV gain from all sources has been turned off."))
		  $player.disable_ev_gain = false
		  return true
		else
		  return false
		end
	  else
		pbMessage(_INTL("\\bThe code for disabling EV gain from all sources is currently inactive."))
		if pbConfirmMessage(_INTL("\\bWould you like to enable this code?"))
		  pbMessage(_INTL("\\bThe code for disabling EV gain from all sources has been turned on."))
		  $player.disable_ev_gain = true
		  return true
		else
		  return false
		end
	  end
	# --- Disables the use of Non-Capture Device Items in battle ---
	# All of the relevant sections will need to have their code updated to accomidate the new flag
	when "noitems"
	  if $player.disable_item_use
		pbMessage(_INTL("\\bThe code for preventing Non-Capture Device items in battle is currently active."))
		if pbConfirmMessage(_INTL("\\bWould you like to disable this code?"))
		  pbMessage(_INTL("\\bThe code for preventing Non-Capture Device items in battle has been turned off."))
		  $player.disable_item_use = false
		  return true
		else
		  return false
		end
	  else
		pbMessage(_INTL("\\bThe code for preventing Non-Capture Device items in battle is currently inactive."))
		if pbConfirmMessage(_INTL("\\bWould you like to enable this code?"))
		  pbMessage(_INTL("\\bThe code for preventing Non-Capture Device items in battle has been turned on."))
		  $player.disable_item_use = true
		  return true
		else
		  return false
		end
	  end
	# --- Disables cash gain from all battles ---
	# Should this include Pay Day and its ilk?
	# All of the relevant sections will need to have their code updated to accomidate the new flag
	when "nocash"
	  if $player.disable_cash_gain
		pbMessage(_INTL("\\bThe code for preventing cash gain from battles is currently active."))
		if pbConfirmMessage(_INTL("\\bWould you like to disable this code?"))
		  pbMessage(_INTL("\\bThe code for preventing cash gain from battles has been turned off."))
		  $player.disable_cash_gain = false
		  return true
		else
		  return false
		end
	  else
		pbMessage(_INTL("\\bThe code for preventing cash gain from battles is currently inactive."))
		if pbConfirmMessage(_INTL("\\bWould you like to enable this code?"))
		  pbMessage(_INTL("\\bThe code for preventing cash gain from battles has been turned on."))
		  $player.disable_cash_gain = true
		  return true
		else
		  return false
		end
	  end
	# --- Disables cash gain from all battles, but makes special sellable items drop occasionally ---
	when "tpdpmode"
	  if $player.disable_cash_gain && $player.enable_item_drops
		pbMessage(_INTL("\\bThe code for alternate cash acquisition is currently active."))
		if pbConfirmMessage(_INTL("\\bWould you like to disable this code?"))
		  pbMessage(_INTL("\\bThe code for alternate cash acquisition has been turned off."))
		  $player.disable_cash_gain = false
		  $player.enable_item_drops = false
		  return true
		else
		  return false
		end
	  else
		pbMessage(_INTL("\\bThe code for alternate cash acquisition is currently inactive."))
		if pbConfirmMessage(_INTL("\\bWould you like to enable this code?"))
		  pbMessage(_INTL("\\bThe code for alternate cash acquisition has been turned on."))
		  $player.disable_cash_gain = true
		  $player.enable_item_drops = true
		  return true
		else
		  return false
		end
	  end
	# --- The Ultimate Difficulty Mode ---
	when "scuffedaf"
	  if $player.enemy_ivs_maxed && $player.enemy_evs_maxed && $player.disable_exp_gain && $player.disable_ev_gain && $player.disable_item_use && $player.disable_cash_gain
		pbMessage(_INTL("\\bThe code for Asteria Ultimate Mode is currently active."))
		if pbConfirmMessage(_INTL("\\bWould you like to disable this code?"))
		  pbMessage(_INTL("\\bThe code for Asteria Ultimate Mode has been turned off."))
		  $player.enemy_ivs_maxed = false
		  $player.enemy_evs_maxed = false
		  $player.disable_exp_gain = false
		  $player.disable_ev_gain = false
		  $player.disable_item_use = false
		  $player.disable_cash_gain = false
		  return true
		else
		  return false
		end
	  else
		pbMessage(_INTL("\\bThe code for Asteria Ultimate Mode is currently inactive."))
		if pbConfirmMessage(_INTL("\\bWould you like to enable this code?"))
		  pbMessage(_INTL("\\bThe code for Asteria Ultimate Mode has been turned on."))
		  $player.enemy_ivs_maxed = true
		  $player.enemy_evs_maxed = true
		  $player.disable_exp_gain = true
		  $player.disable_ev_gain = true
		  $player.disable_item_use = true
		  $player.disable_cash_gain = true
		  return true
		else
		  return false
		end
	  end
	# --- Just Koishi. ---
	when "justkoi"
	  if $game_temp.just_koishi
		pbMessage(_INTL("\\bKoishi is currently loose."))
		if pbConfirmMessage(_INTL("\\bContain Koishi?"))
		  pbMessage(_INTL("\\bKoishi is currently being contained."))
		  $game_temp.just_koishi = false
		  #$game_switches[121] = false
		  return true
		else
		  return false
		end
	  else
		pbMessage(_INTL("\\bJust Koishi."))
		if pbConfirmMessage(_INTL("\\bJust Koishi?"))
		  pbMessage(_INTL("\\bJust Koishi."))
		  $game_temp.just_koishi = true
		  $game_switches[121] = true
		  return true
		else
		  return false
		end
	  end
	# --- Just Basiney. ---
	when "justbasin"
	  if $game_temp.just_basiney
		pbMessage(_INTL("\\bBasiney is currently loose."))
		if pbConfirmMessage(_INTL("\\bContain Basiney?"))
		  pbMessage(_INTL("\\bBasiney is currently being contained."))
		  $game_temp.just_basiney = false
		  return true
		else
		  return false
		end
	  else
		pbMessage(_INTL("\\bJust Basiney."))
		if pbConfirmMessage(_INTL("\\bJust Basiney?"))
		  pbMessage(_INTL("\\bJust Basiney."))
		  $game_temp.just_basiney = true
		  return true
		else
		  return false
		end
	  end
	# --- Ask Five Magic Stones: The Battle ---
	when "2cakesman"
	  if $game_switches[xxx]
		pbMessage(_INTL("\\r\\xn[?????]HUMAN. DID YOU FORGET HOW TO GET TO US?"))
		pbMessage(_INTL("\\r\\xn[?????]JUST GO SLEEP IN YOUR BED. WE HAVE NO IDEA IF IT WILL WORK, BUT WON'T IT BE INTERESTING TO FIND OUT?"))
		pbMessage(_INTL("\\r\\xn[?????]...WHAT'S THAT? YOU'D LIKE TO KNOW WHY OUR COMMUNICATION FREQUENCY IS CALLED \"2cakesman\"?"))
		if pbConfirmMessage(_INTL("\\r\\xn[?????]ARE YOU UNFAMILIAR WITH THE STORY OF TWO CAKES?"))
		  pbMessage(_INTL("\\r\\xn[?????]A HUMAN WHO HASN'T HEARD THE STORY OF TWO CAKES? HOW PERPOSTEROUS!"))
		  pbMessage(_INTL("\\r\\xn[?????]ISN'T THAT THE LATEST TREND IN THE OUTSIDE WORLD?"))
		  pbMessage(_INTL("\\r\\xn[?????]REGARDLESS, IT IS A VERY BRIEF STORY."))
		  # --- Come up with some outlandish story that is only vaguely similar to Cakepost
		  return true
		else
		  return false
		end
		return false
	  else
		$game_player.animation_id = 003
		pbMessage(_INTL("\\bWARNING. CORRUPT DATA LOADED. PLEASE CONTACT SILPH CO. FOR EMERGENCY MAINT-\\wtnp[1]"))
		pbWait(20)
		pbSEPlay("PC open")
		pbMessage(_INTL("\\r\\xn[?????]THERE, THAT'S BETTER."))
		pbMessage(_INTL("\\r\\xn[?????]HUMAN. ARE YOU PICKING THIS UP? GOOD."))
		pbMessage(_INTL("\\r\\xn[?????]WE HAVE BEEN TRYING TO GET IN CONTACT WITH YOU FOR A WHILE NOW, HUMAN."))
		pbMessage(_INTL("\\r\\xn[?????]SOMEHOW, ALL OF OUR ATTEMPTS UP UNTIL NOW HAVE BEEN MET WITH ABJECT FAILURE."))
		pbMessage(_INTL("\\r\\xn[?????]MOST LIKELY THE RESULT OF A CERTAIN GAP YOUKAI'S INTERFERENCE."))
		pbMessage(_INTL("\\r\\xn[?????]NEVERTHELESS, WE DESIRE AN AUDIENCE WITH YOU IN PERSON."))
		pbMessage(_INTL("\\r\\xn[?????]WELL, WE SAY IN PERSON, BUT CAN WE TRULY SAY THAT WHEN WE'RE JUST A BUNCH OF STONES?"))
		pbMessage(_INTL("\\r\\xn[?????]QUIET #4. THE PHRASE \"IN PERSON\" JUST MEANS WE WOULD LIKE TO MEET THEM. THERE'S NO NEED TO GET PHILOSOPHICAL ABOUT IT."))
		pbMessage(_INTL("\\r\\xn[?????]SHOULD YOU CHOOSE TO ACCEPT OUR INVITATION, YOU CAN FIND US IN OUR DEMIPLANE: \"STAGE 3\"."))
		pbMessage(_INTL("\\r\\xn[?????]...HOW DO YOU GET THERE? WHAT A FOOLISH QUESTION. HOW DO YOU GET ANYWHERE? BY FLYING!"))
		pbMessage(_INTL("\\r\\xn[?????]#5 YOU FORGET, THIS HUMAN CAN'T FLY. SHE WOULD NEED ANOTHER WAY TO GET HERE."))
		pbMessage(_INTL("\\r\\xn[?????]OH, MY MISTAKE. UHHH, TRY SLEEPING IN YOUR BED THEN? MOST PEOPLE JUST GET TO US BY FLYING."))
		pbMessage(_INTL("\\r\\xn[?????]...WHO AM I? I KNOW WE HAVE SIMILAR VOICES, BUT THERE'S MORE THAN ONE OF US."))
		pbMessage(_INTL("\\r\\xn[?????]WE ARE THE FIVE MAGIC STONES."))
		pbMessage(_INTL("\\r\\xn[?????]WE SHALL AWAIT YOUR ARRIVAL."))
		$game_switches[xxx] # Switch to enable the warp to "Stage 3" from the Player's bed.
	  end
	# --- End of Passwords ---  
	end
  else
    pbMessage(_INTL("Invalid Password. Please try again."))
    return false
  end
end

# Code segment for the "Perfection" Password.
# Makes all Wild Encounters have 31 IVs.
EventHandlers.add(:on_wild_pokemon_created, :perfect_ivs,
  proc { |pkmn|
    next if !$player.player_ivs_maxed
	pkmn.iv[:HP]=31
	pkmn.iv[:ATTACK]=31
	pkmn.iv[:DEFENSE]=31
	pkmn.iv[:SPECIAL_ATTACK]=31
	pkmn.iv[:SPECIAL_DEFENSE]=31
	pkmn.iv[:SPEED]=31
    pkmn.calc_stats
  }
)


EventHandlers.add(:on_trainer_load, :koishi_time_trainer,
  proc { |trainer|
   if trainer   # check if you are facing a trainer
     if $game_temp.just_koishi
       for pkmn in trainer.party
	     fixedLvl = nil
		 fixedLvl = pkmn.level
         if pkmn.level <= 40 
		   pkmn.species = :CKOISHI
		   pkmn.level = fixedLvl
		 else
		   pkmn.species = :KOISHI
		   pkmn.level = fixedLvl
		 end
		 pkmn.reset_moves
		 pkmn.calc_stats
       end
	 $PokemonGlobal.nextBattleBack = "Inverse"
	 $PokemonGlobal.nextBattleBGM = pbStringToAudioFile("X-004. Hartmann's Youkai Girl")
     end
   end
  }
)

EventHandlers.add(:on_wild_pokemon_created, :koishi_time_wild,
  proc { |pkmn|
	fixedLvl = nil
	fixedLvl = pkmn.level
	if $game_temp.just_koishi
      if pkmn.level <= 40
	    pkmn.species = :CKOISHI
		pkmn.level = fixedLvl
	  else
	    pkmn.species = :KOISHI
		pkmn.level = fixedLvl
	  end
	item = :BELUEBERRY
	pkmn.reset_moves
	pkmn.calc_stats
	$PokemonGlobal.nextBattleBack = "Inverse"
	$PokemonGlobal.nextBattleBGM = pbStringToAudioFile("X-004. Hartmann's Youkai Girl")  
	end
  }
)