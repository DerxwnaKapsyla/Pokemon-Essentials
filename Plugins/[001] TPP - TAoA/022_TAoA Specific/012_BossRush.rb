module BossRush
  BOSS_FIGHT_VARIABLE = 145
end

VALUE_TO_FIGHT = [
  # The Mansion of Mystery Bosses
  ":KEINE, \"Keine Kamishirasawa\", 500",
  ":MARISA, \"Marisa Kirisame\", 500",
  ":YOUMU, \"Youmu Konpaku\", 500",
  ":LYRICA, \"Lyrica Prismriver\", 500",
  ":MYSTIA, \"Mystia Lorelei\", 500",
  ":PRISMRIVER, \"Prismriver Sisters\", 500",
  ":NUE, \"Nue Houjuu\", 500",
  ":KOGASA, \"Kogasa Tarara\", 500",
  ":LAYLA, \"Layla Prismriver\", 500",
  # The Festival of Curses Bosses
  ":KOKORO, \"Hata no Kokoro\", 500",
  ":MINORIKO, \"Minoriko Aki\", 500",
  ":NITORI_Tr, \"Nitori Kawashiro\", 500",
  ":HATATE, \"Hatate Himekaidou\", 500",
  ":HINA_F, \"Hina Kagiyama\", 500",
  ":THREEFAIRY, \"of Light\", 500",
  ":MEDICINE_Tr, \"Medicine Melancholy\", 500",
  ":ELLY, \"Elly\", 500",
  ":YUUKA, \"Yuuka Kazami\", 500",
  # The Kingdom of Lunacy Bosses
  ":REISEN, \"Reisen U. Inaba\", 500, :EIRIN, \"Eirin Yagokoro\", 500",
  ":SEIRAN, \"Seiran\", 500",
  ":RINGO, \"Ringo\", 500",
  ":DOREMY, \"Doremy Sweet\", 500",
  ":CLOWNPIECET, \"Clownpiece\", 500",
  ":JUNKO, \"Junko\", 500",
  ":HECATIA, \"Hecatia Lapislazuli\", 500, :JUNKO, \"Junko\", 500",
  ":REISEN2, \"Rei'sen\", 500",
  ":SAGUME, \"Sagume Kishin\", 500",
  ":TOYOHIME, \"Watatsuki no Toyohime\", 500, :YORIHIME, \"Watatsuki no Yorihime\", 500",  
  # The Last Adventure Bosses
  ":MIMA, \"Mima\", 500",
  ":MEIMU, \"Meimu\", 500",
  ":MEIMU, \"Meimu\", 501",
  ":MEIMU, \"Meimu\", 502",
  ":MEIMU, \"Meimu\", 503"
]

def activate_trainer_sprites
  index = $game_variables[BossRush::BOSS_FIGHT_VARIABLE]
  
  case index
  when 5, 14 # Prismrivers, Fairies of Light
    pbSetSelfSwitch2(152,5,"A",true)
	pbSetSelfSwitch2(152,6,"A",true)
  when 18, 24, 27
    pbSetSelfSwitch2(152,4,"A",true)
    pbSetSelfSwitch2(152,5,"A",true)
	pbSetSelfSwitch2(152,6,"A",true)
  end
end

def deactivate_trainer_sprites
  pbSetSelfSwitch2(152,4,"A",false)
  pbSetSelfSwitch2(152,5,"A",false)
  pbSetSelfSwitch2(152,6,"A",false)
end

def dkBossRush
  setBattleRule("canLose")
  index = $game_variables[BossRush::BOSS_FIGHT_VARIABLE]
  $game_temp.vs_transition_bg = "Elite"
  setBattleRule("setSlideSprite", "still")
  # Vs. Transition Name Override
  case index
  when 13 then $game_temp.vs_name = "Vs. Hina Doppelganger"
  when 18 then $game_temp.vs_name = "Vs. Eirin & Reisen"
  when 24 then $game_temp.vs_name = "Vs. Junko & Hecatia Lapislazuli"
  when 27 then $game_temp.vs_name = "Vs. Watatsuki Sisters"
  end
  # Special battle rules
  case index
  when 5 # Prismriver Sisters
    setBattleRule("double")
  when 14 # Three Fairies of Light
    setBattleRule("2v3")
  when 18, 24, 27, 32  # Eirin & Reisen / Junko & Hecatia / Watatsuki Sisters / Meimu fight 4
    if !pbCanDoubleBattle?
	  setBattleRule("1v2")
	else
	  setBattleRule("2v2")
	end
	if index == 24
	  $PokemonGlobal.nextBattleBGM = "B-037. Pandemonic Furies.ogg"
	end
  when 33 # Final Meimu Fight
    final_meimu_switches = [158, 159, 160]
    final_meimu_switches.each do |s|
      $game_switches[s] = false
    end
    $game_switches[103] = true # Hide AI Level

    setBattleRule("backdrop", "meimu")
    setBattleRule("base", "meimu")
    setBattleRule("databoxStyle", :Basic)
    $game_variables[70] = $PokemonSystem.battlescene
    $PokemonSystem.battlescene = 0
    setBattleRule("editWildPokemon", {
      :hp_level => 3,
      :immunities => [:OHKO, :ITEMREMOVAL, :POISON, :ATTRACT, :PPLOSS, :TYPECHANGE, :ABILITYREMOVAL,:INDIRECT, :DISABLE, :SELFKO, :TRANSFORM, :ESCAPE],
      :gender => 1,
      :shiny => false,
      :iv => 31,
      :ev => 252
      }
	 )	 
    setBattleRule("cannotRun")
    setBattleRule("disablePokeBalls")
    setBattleRule("battleIntroText", "This is the end.")
    setBattleRule("victoryBGM", "")
    setBattleRule("midbattleScript", :vs_meimu_bossrush)
	$PokemonGlobal.nextBattleBGM = "B-044. Finale ~ For The End.ogg"
	$game_switches[Settings::SPECIAL_BATTLE_SWITCH] = true
	pbSet(Settings::SPECIAL_BATTLE_VARIABLE,5)
  end
  
  if index < VALUE_TO_FIGHT.length
    trainer_string = VALUE_TO_FIGHT[index]
    if eval("TrainerBattle.start(#{trainer_string})")
      $game_variables[BossRush::BOSS_FIGHT_VARIABLE] += 1
	else
	  $game_variables[BossRush::BOSS_FIGHT_VARIABLE] = 99
    end
  else # Once all trainer battles are finished, start the final Meimu battle
    if eval("WildBattle.start(:MEIMU, 100)")
	  $game_variables[BossRush::BOSS_FIGHT_VARIABLE] += 1
	else
	  $game_variables[BossRush::BOSS_FIGHT_VARIABLE] = 99
    end
  end
  pbTrainerEnd
end

def bossrush_intermission
  index = $game_variables[BossRush::BOSS_FIGHT_VARIABLE]
  # Heal the player after finishing each arc of bosses and before Final Meimu.
  case index
    when 9, 18, 28, 33
	  $player.heal_party
      pbMessage(_INTL("\\wm\\w[dark]Your party has been healed."))
	end
	set_menu_theme("dark")
	if pbConfirmMessage(_INTL("\\wm\\w[dark]Would you like to access the menu before your next battle?"))
      $game_temp.menu_calling = true
    end
  reset_menu_theme
end