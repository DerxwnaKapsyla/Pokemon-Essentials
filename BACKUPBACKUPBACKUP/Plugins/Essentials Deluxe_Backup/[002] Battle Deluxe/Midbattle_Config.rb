#===============================================================================
# Essentials Deluxe module.
#===============================================================================


#-------------------------------------------------------------------------------
# Set up mid-battle triggers that may be called in a deluxe battle event.
# Add your custom midbattle hash here and you will be able to call upon it with
# the defined symbol, rather than writing out the entire thing in an event.
#-------------------------------------------------------------------------------
module EssentialsDeluxe
  #-----------------------------------------------------------------------------
  # Demonstration of all possible midbattle triggers.
  # Plug this into any Deluxe Battle to get a message describing when each
  # trigger activates.
  #-----------------------------------------------------------------------------
  DEMO_SPEECH = {
    #---------------------------------------------------------------------------
    # Turn Phase Triggers
    #---------------------------------------------------------------------------
    "turnCommand"           => [:Self, "Trigger: 'turnCommand'\nCommand Phase start."],
    "turnAttack"            => [:Self, "Trigger: 'turnAttack'\nAttack Phase start."],
    "turnEnd"               => [:Self, "Trigger: 'turnEnd'\nEnd of Round Phase end."],
    #---------------------------------------------------------------------------
    # Move Triggers
    #---------------------------------------------------------------------------
    "attack"                => [:Self, "Trigger: 'attack'\nYour Pokémon successfully launches a damage-dealing move."],
    "attack_foe"            => [:Self, "Trigger: 'attack_foe'", "{1} successfully launches a damage-dealing move."],
    "attack_ally"           => [:Self, "Trigger: 'attack_ally'\nYour partner's Pokémon successfully launches a damage-dealing move."],
    "status"                => [:Self, "Trigger: 'status'\nYour Pokémon successfully launches a status move."],
    "status_foe"            => [:Self, "Trigger: 'status_foe'", "{1} successfully launches a status move."],
    "status_ally"           => [:Self, "Trigger: 'status_ally'\nYour partner's Pokémon successfully launches a status move."],
    "superEffective"        => [:Self, "Trigger: 'superEffective'\nYour Pokémon's attack dealt super effective damage."],
    "superEffective_foe"    => [:Self, "Trigger: 'superEffective_foe'", "{1}'s attack dealt super effective damage."],
    "superEffective_ally"   => [:Self, "Trigger: 'superEffective_ally'\nYour partner's Pokémon's attack dealt super effective damage."],
    "notVeryEffective"      => [:Self, "Trigger: 'notVeryEffective'\nYour Pokémon's attack dealt not very effective damage."],
    "notVeryEffective_foe"  => [:Self, "Trigger: 'notVeryEffective_foe'", "{1}'s attack dealt not very effective damage."],
    "notVeryEffective_ally" => [:Self, "Trigger: 'notVeryEffective_ally'\nYour partner's Pokémon's attack dealt not very effective damage."],
    "immune"                => [:Self, "Trigger: 'immune'\nYour Pokémon's attack was negated or has no effect."],
    "immune_foe"            => [:Self, "Trigger: 'immune_foe'", "{1}'s attack was negated or has no effect."],
    "immune_ally"           => [:Self, "Trigger: 'immune_ally'\nYour partner's Pokémon's attack was negated or has no effect."],
    "miss"                  => [:Self, "Trigger: 'miss'\nYour Pokémon's attack missed."],
    "miss_foe"              => [:Self, "Trigger: 'miss_foe'", "{1}'s attack missed."],
    "miss_ally"             => [:Self, "Trigger: 'miss_ally'\nYour partner's Pokémon's attack missed."],
    "criticalHit"           => [:Self, "Trigger: 'criticalHit'\nYour Pokémon's attack dealt a critical hit."],
    "criticalHit_foe"       => [:Self, "Trigger: 'criticalHit_foe'", "{1}'s attack dealt a critical hit."],
    "criticalHit_ally"      => [:Self, "Trigger: 'criticalHit_ally'\nYour partner's Pokémon's attack dealt a critical hit."],
    #---------------------------------------------------------------------------
    # Damage State Triggers
    #---------------------------------------------------------------------------
    "damage"                => [:Self, "Trigger: 'damage'\nYour Pokémon took damage from an attack."],
    "damage_foe"            => [:Self, "Trigger: 'damage_foe'", "{1} took damage from an attack."],
    "damage_ally"           => [:Self, "Trigger: 'damage_ally'\nYour partner's Pokémon took damage from an attack."],
    "lowhp"                 => [:Self, "Trigger: 'lowhp'\nYour Pokémon took damage and its HP fell to 1/4th max HP or lower."],
    "lowhp_foe"             => [:Self, "Trigger: 'lowhp_foe'", "{1} took damage and its HP fell to 1/4th max HP or lower."],
    "lowhp_ally"            => [:Self, "Trigger: 'lowhp_ally'\nYour partner's Pokémon took damage and its HP fell to 1/4th max HP or lower."],
    "lowhp_final"           => [:Self, "Trigger: 'lowhp_final'\nYour final Pokémon took damage and its HP fell to 1/4th max HP or lower."],
    "lowhp_final_foe"       => [:Self, "Trigger: 'lowhp_final_foe'", "{1} is the final Pokémon; damage was taken and its HP fell to 1/4th max HP or lower."],
    "lowhp_final_ally"      => [:Self, "Trigger: 'lowhp_final_ally'\nYour partner's final Pokémon took damage and its HP fell to 1/4th max HP or lower."],
    "fainted"               => [:Self, "Trigger: 'fainted'\nYour Pokémon fainted."],
    "fainted_foe"           => [:Self, "Trigger: 'fainted_foe'", "{1} fainted."],
    "fainted_ally"          => [:Self, "Trigger: 'fainted_ally'\nYour partner's Pokémon fainted."],
    #---------------------------------------------------------------------------
    # Switch Triggers
    #---------------------------------------------------------------------------
    "recall"                => [:Self, "Trigger: 'recall'\nYou withdrew an active Pokémon."],
    "recall_foe"            => [:Self, "Trigger: 'recall_foe'\nI withdrew an active Pokémon."],
    "recall_ally"           => [:Self, "Trigger: 'recall_ally'\nYour partner withdrew an active Pokémon."],
    "beforeNext"            => [:Self, "Trigger: 'beforeNext'\nYou intend to send out a Pokémon."],
    "beforeNext_foe"        => [:Self, "Trigger: 'beforeNext_foe'\nI intend to send out a Pokémon."],
    "beforeNext_ally"       => [:Self, "Trigger: 'beforeNext_ally'\nYour partner intends to send out a Pokémon."],
    "afterNext"             => [:Self, "Trigger: 'afterNext'\nYou successfully sent out a Pokémon."],
    "afterNext_foe"         => [:Self, "Trigger: 'afterNext_foe'\nI successfully sent out a Pokémon."],
    "afterNext_ally"        => [:Self, "Trigger: 'afterNext_ally'\nYour partner successfully sent out a Pokémon."],
    "beforeLast"            => [:Self, "Trigger: 'beforeLast'\nYou intend to send out your final Pokémon."],
    "beforeLast_foe"        => [:Self, "Trigger: 'beforeLast_foe'\nI intend to send out my final Pokémon."],
    "beforeLast_ally"       => [:Self, "Trigger: 'beforeLast_ally'\nYour partner intends to send out their final Pokémon."],
    "afterLast"             => [:Self, "Trigger: 'afterLast'\nYou successfully sent out your final Pokémon."],
    "afterLast_foe"         => [:Self, "Trigger: 'afterLast_foe'\nI successfully sent out my final Pokémon."],
    "afterLast_ally"        => [:Self, "Trigger: 'afterLast_ally'\nYour partner successfully sent out their final Pokémon."],
    #---------------------------------------------------------------------------
    # Special Action Triggers
    #---------------------------------------------------------------------------
    "item"                  => [:Self, "Trigger: 'item'\nYou used an item from your inventory."],
    "item_foe"              => [:Self, "Trigger: 'item_foe'\nI used an item from my inventory."],
    "item_ally"             => [:Self, "Trigger: 'item_ally'\nYour partner used an item from their inventory."],
    "mega"                  => [:Self, "Trigger: 'mega'\nYou initiate Mega Evolution."],
    "mega_foe"              => [:Self, "Trigger: 'mega_foe'\nI initiate Mega Evolution."],
    "mega_ally"             => [:Self, "Trigger: 'mega_ally'\nYour partner initiates Mega Evolution."],
	#---------------------------------------------------------------------------
    # Plugin Triggers
    #---------------------------------------------------------------------------
    "zmove"                 => [:Self, "Trigger: 'zmove'\nYou initiate a Z-Move."],
    "zmove_foe"             => [:Self, "Trigger: 'zmove_foe'\nI initiate a Z-Move."],
    "zmove_ally"            => [:Self, "Trigger: 'zmove_ally'\nYour partner initiates a Z-Move."],
    "ultra"                 => [:Self, "Trigger: 'ultra'\nYou initiate Ultra Burst."],
    "ultra_foe"             => [:Self, "Trigger: 'ultra_foe'\nI initiate Ultra Burst."],
    "ultra_ally"            => [:Self, "Trigger: 'ultra_ally'\nYour partner initiates Ultra Burst."],
    "dynamax"               => [:Self, "Trigger: 'dynamax'\nYou initiate Dynamax."],
    "dynamax_foe"           => [:Self, "Trigger: 'dynamax_foe'\nI initiate Dynamax."],
    "dynamax_ally"          => [:Self, "Trigger: 'dynamax_ally'\nYour partner initiates Dynamax."],
	"strongStyle"           => [:Self, "Trigger: 'strongStyle'\nYou initiate Strong Style."],
	"strongStyle_foe"       => [:Self, "Trigger: 'strongStyle_foe'\nOpponent initiates Strong Style."],
	"strongStyle_ally"      => [:Self, "Trigger: 'strongStyle_ally'\nYour partner initiates Strong Style."],
	"agileStyle"            => [:Self, "Trigger: 'agileStyle'\nYou initiate Agile Style."],
	"agileStyle_foe"        => [:Self, "Trigger: 'agileStyle_foe'\nOpponent initiates Agile Style."],
	"agileStyle_ally"       => [:Self, "Trigger: 'agileStyle_ally'\nYour partner initiates Agile Style."],
	"styleEnd"              => [:Self, "Trigger: 'styleEnd'\nYour style cooldown expired."],
	"styleEnd_foe"          => [:Self, "Trigger: 'styleEnd_foe'\nOpponent style cooldown expired."],
	"styleEnd_ally"         => [:Self, "Trigger: 'styleEnd_ally'\nYour partner's style cooldown expired."],
    "zodiac"                => [:Self, "Trigger: 'zodiac'\nYou initiate a Zodiac Power."],
    "zodiac_foe"            => [:Self, "Trigger: 'zodiac_foe'\nI initiate a Zodiac Power."],
    "zodiac_ally"           => [:Self, "Trigger: 'zodiac_ally'\nYour partner initiates a Zodiac Power."],
    "focus"                 => [:Self, "Trigger: 'focus'\nYour Pokémon harnesses its focus."],
    "focus_foe"             => [:Self, "Trigger: 'focus_foe'", "{1} harnesses its focus."],
    "focus_ally"            => [:Self, "Trigger: 'focus_ally'\nYour partner's Pokémon harnesses its focus."],
    "focus_boss"            => [:Self, "Trigger: 'focus_boss'", "{1} harnesses its focus with the Enraged style."],
	"focusEnd"              => [:Self, "Trigger: 'focusEnd'", "Your Pokemon's Focus was used."],
	"focusEnd_foe"          => [:Self, "Trigger: 'focusEnd_foe'", "Opponent Pokemon's Focus was used."],
	"focusEnd_ally"         => [:Self, "Trigger: 'focusEnd_ally'", "Your partner Pokemon's Focus was used."],
    #---------------------------------------------------------------------------
    # Player-only Triggers
    #---------------------------------------------------------------------------
    "beforeCapture"         => [:Self, "Trigger: 'beforeCapture'\nYou intend to throw a selected Poké Ball."],
    "afterCapture"          => [:Self, "Trigger: 'afterCapture'\nYou successfully captured the targeted Pokémon."],
    "failedCapture"         => [:Self, "Trigger: 'failedCapture'\nYou failed to capture the targeted Pokémon."],
    "loss"                  => [:Self, "Trigger: 'loss'\nYou lost the battle."]
  }
  
  
  
  #-----------------------------------------------------------------------------
  # Demo scenario vs. wild Rotom that shifts forms.
  #-----------------------------------------------------------------------------
  DEMO_WILD_ROTOM = {
    "turnCommand" => {
      :text      => [1, "{1} emited a powerful magnetic pulse!"],
      :anim      => [:CHARGE, 1],
      :playsound => "Anim/Paralyze3",
      :text_1    => "Your Poké Balls short-circuited!\nThey cannot be used this battle!"
    },
    "turnEnd_repeat" => {
      :delay   => "superEffective",
      :battler => :Opposing,
      :anim    => [:NIGHTMARE, :Self],
      :form    => [:Random, "{1} possessed a new appliance!"],
      :hp      => 4,
      :status  => :NONE,
      :ability => [:MOTORDRIVE, true],
      :item    => [:CELLBATTERY, "{1} equipped a Cell Battery it found in the appliance!"]
    },
    "superEffective" => {
      :battler => :Self,
      :text    => [:Opposing, "{1} emited an electrical pulse out of desperation!"],
      :status  => [:PARALYSIS, true]
    },
    "damage_foe_repeat" => {
      :delay   => ["halfhp_foe", "lowhp_foe"],
      :effects => [
        [PBEffects::Charge, 5, "{1} began charging power!"],
        [PBEffects::MagnetRise, 5, "{1} levitated with electromagnetism!"],
      ],
      :terrain => :Electric
    }
  }
  
  
  #-----------------------------------------------------------------------------
  # Demo scenario vs. Rocket Grunt in a collapsing cave.
  #-----------------------------------------------------------------------------
  DEMO_COLLAPSING_CAVE = {
    "turnCommand" => {
      :playsound  => "Mining collapse",
      :text    => "The cave ceiling begins to crumble down all around you!",
      :speech  => ["I am not letting you escape!", 
                   "I don't care if this whole cave collapses down on the both of us...haha!"],
      :text_1  => "Defeat your opponent before time runs out!"
    },
    "turnEnd_repeat" => {
      :playsound => "Mining collapse",
      :text      => "The cave continues to collapse all around you!"
    },
    "turnEnd_2" => {
      :battler => 0,
      :text    => "{1} was struck on the head by a falling rock!",
      :anim    => [:ROCKSMASH, 0],
      :hp      => -4,
      :status  => :CONFUSION
    },
    "turnEnd_3" => {
      :text => ["You're running out of time!", 
                "You need to escape immediately!"]
    },
    "turnEnd_4" => {
      :text      => ["You failed to defeat your opponent in time!", 
                     "You were forced to flee the battle!"],
      :playsound => "Battle flee",
      :endbattle => 2
    },
    "lowhp_final_foe" => {
      :speech  => "My {1} will never give up!",
      :anim    => [:BULKUP, :Self],
      :playcry => true,
      :hp      => [2, "{1} is standing its ground!"],
      :stats   => [:DEFENSE, 2, :SPECIAL_DEFENSE, 2]
    },
    "loss" => "Haha...you'll never make it out alive!"
  }
  
  
  #-----------------------------------------------------------------------------
  # Demo trainer speech when triggering ZUD Mechanics.
  #-----------------------------------------------------------------------------
  DEMO_ZUD_MECHANICS = {
    # Z-Moves
    "zmove_foe" => ["Alright, {1}!", "Time to unleash our Z-Power!"],
    # Ultra Burst
    "ultra_foe" => "Hah! Prepare to witness my {1}'s ultimate form!",
    # Dynamax
    "dynamax_foe" => ["No holding back!", "It's time to Dynamax!"]
  }
  
  
  #-----------------------------------------------------------------------------
  # Demo trainer speech when triggering the Focus Meter.
  #-----------------------------------------------------------------------------
  DEMO_FOCUS_METER = {
    # Opponent Focus
    "focus_foe" => "Focus, {1}!\nWe got this!", 
    "focus_foe_repeat" => {
      :delay  => "focusEnd_foe",
      :speech => "Keep your eye on the prize, {1}!"
    },
    # Focused Rage (boss)
    "focus_boss" => "It's time to let loose, {1}!",
    "focus_boss_repeat" => {
      :delay  => "focusEnd_foe",
      :speech => "No mercy! Show them your rage, {1}!"
    }
  }


  #-----------------------------------------------------------------------------
  # Demo trainer speech when triggering PLA Battle Styles.
  #-----------------------------------------------------------------------------
  DEMO_BATTLE_STYLES = {
    # Strong Style
    "strongStyle_foe" => "Let's strike 'em down with all your strength, {1}!",
    "strongStyle_foe_repeat" => {
      :delay  => "styleEnd_foe",
      :speech => ["Let's keep up the pressure!", 
                  "Hit 'em with your Strong Style, {1}!"]
    },
    # Agile Style
    "agileStyle_foe" => "Let's strike 'em down before they know what hit 'em, {1}!",
    "agileStyle_foe_repeat" => {
      :delay  => "styleEnd_foe",
      :speech => ["Let's keep them on their toes!", 
                  "Hit 'em with your Agile Style, {1}!"]
    }
  }
  
  #-----------------------------------------------------------------------------
  # The Adventures of Ayaka
  #-----------------------------------------------------------------------------
  # The Mansion of Mystery
  #-----------------------------------------------------------------------------
  
  #-----------------------------------------------------------------------------
  # The Festival of Curses
  #-----------------------------------------------------------------------------  
  # Scene: Nitori using the Kappa Augment Items
  #-----------------------------------------------------------------------------  
  VS_NITORI = {
	"turnAttack_repeat_random" => {
	  :battler		=> 1,
	  :speech		=> "Attack Augment, activate!",
	  :useitem		=> :KAPPAATTACK,
	},
	
	"halfhp_foe_random" => {
	  :battler		=> 1,
	  :speech		=> "Defense Augment, activate!",
	  :useitem		=> :KAPPADEFENSE,
	}
  }
  
  #-----------------------------------------------------------------------------  
  # Scene: Possessed Puppets in Hina's Domain of the Great Youkai Forest
  #----------------------------------------------------------------------------- 
  VS_CURSED_PUPPETS = {
	"turnCommand" => {
	  :battler			=> 0,
	  :message			=> "{2}: I think that's one of those Possessed Puppets that Miss Kagiyama told me to find!",
	  :battler_1		=> 1,
	  :anim				=> [:GRUDGE,1],
	  :playcry			=> true,
	  :message_1		=> "{1} gains power from being possessed!",
	  :stats			=> [:ATTACK, 1, :SPECIAL_ATTACK, 1],
	}
  }
  #-----------------------------------------------------------------------------  
  # Scene: Ringleader Malevolent Spirit battle in the Great Youkai Forest
  #----------------------------------------------------------------------------- 
  VS_FAKE_HINA = {
	"turnCommand" => {
	  :battler			=> 1,
	  :anim				=> [:GRUDGE,1],
	  :playcry			=> true,
	  :message			=> "{1} gains power from being possessed!",
	  :stats			=> [:ATTACK, 1, :SPECIAL_ATTACK, 1],
	},
	
	"fainted_foe_repeat" => {
	  :battler			=> 1,
	  :speech 			=> "...~",
	  :message			=> "The malevolent spirit ejected from the fainted Puppet and latched onto yours!",
	  :battler_1		=> 0,
	  :anim				=> [:GRUDGE,0],
	  :stats			=> [:ATTACK, 1, :SPECIAL_ATTACK, 1],
	  :effects	 		=> [
        [PBEffects::Curse, true],
      ],
	  :status			=> :CONFUSION
	},
	
	"afterNext_foe" => {
	  :battler			=> 1,
	  :anim				=> [:GRUDGE,1],
	  :playcry			=> true,
	  :message			=> "{1} gains power from being possessed!",
	  :stats			=> [:ATTACK, 1, :SPECIAL_ATTACK, 1],
	},
	
	"afterLast_foe" => {
	  :battler			=> 1,
	  :anim				=> [:GRUDGE,1],
	  :playcry			=> true,
	  :message			=> "{1} gains power from being possessed!",
	  :stats			=> [:ATTACK, 2, :SPECIAL_ATTACK, 2, :DEFENSE, 2, :SPECIAL_DEFENSE, 2],
	}
  }
	  
  #-----------------------------------------------------------------------------  
  # Scene: Va. Three Fairies of Light
  #----------------------------------------------------------------------------- 
  VS_THREE_FAIRIES = {
	"turnCommand" => {
	  :text			=> ["{2}: Wait! Doesn't three against one seem kinda unfair?!", 
						"Star Sapphire: Nuh uh! It's totally fair!", 
						"Luna Child: You've beat us individually! That's only one third of our total strength!", 
						"Sunny Milk: This time we'll fight you all together, one on one!", 
						"{2}: That logic makes no sense! But fine, we'll play by your rules! And when I win, you'll tell me everything you know!"],
	}
  }
  
  #-----------------------------------------------------------------------------  
  # Scene: Suzuran Field Poisoning
  #----------------------------------------------------------------------------- 
  SUZURAN_FIELD = {
	"turnCommand" => {
	  :text				=> "The field is choked in a thick miasma."
	},
	
	"turnEnd_repeat_random" => {
	  :message				=> "{1} begun to get affected by the miasma.",
	  :status 				=> :POISON,
	},
  }
  
  #-----------------------------------------------------------------------------  
  # Scene: Vs. Medicine
  #----------------------------------------------------------------------------- 
  VS_MEDICINE = {
	"turnCommand" => {
	  :battler			=> 0,
	  :speech			=> ["With this Tome of Curses, there's no way you'll be able to beat me!",
							"I call upon this Tome of Curses... smite my enemies!"],
	  :text				=> "Medicine lays a curse upon your party!",
	  :anim				=> [:GRUDGE,0],
	  :effects	 		=> [
        [PBEffects::Curse, true, "{1} was inflicted with a curse!"],
      ],
	  #:text				=> "{1} was inflicted with a curse!",
	  :text_1			=> "The field is choked in a thick miasma.",
	  :effects 			=> [
        [PBEffects::Endure, false],
      ],
	},
	
	"turnCommand_2" => {
	  :battler			=> 1,
	  :speech			=> ["I can do a lot more than just bring harm to my foes! Just watch!",
							"I call upon this Tome of Curses... bless my allies with power!"],
	  :text				=>  "Medicine uses the Tome of Curses to boost her party's strength!",
	  :stats			=>	[:ATTACK, 2, :SPECIAL_ATTACK, 2, :SPEED, 2, :ACCURACY, 2],
	},
	
	"afterNext_foe_repeat" => {
	  :delay			=> "turnCommand_2",
	  :speech			=> ["I call upon this Tome of Curses... Bless my allies with power!"],
	  :battler			=> 1,
	  :message			=> "{1} had its stats boosted by the Tome of Curses!",
	  :stats			=> [:ATTACK, 2, :SPECIAL_ATTACK, 2],
	},
	
	"turnCommand_repeat_five" => {
	  :ignore			=> "lowhp_final_foe",
	  :speech			=> ["I call upon this Tome of Curses... Bless my allies with power!"],
	  :battler			=> 1,
	  :message			=> "{1} had its stats boosted by the Tome of Curses!",
	  :stats			=> [:ATTACK, 1, :SPECIAL_ATTACK, 1],
	},
	
	"turnCommand_10" => {
	  :ignore			=> "lowhp_final_foe",
	  :speech			=> ["I call upon this Tome of Curses... Bless my allies with power!"],
	  :battler			=> 1,
	  :message			=> "{1} had its stats boosted by the Tome of Curses!",
	  :wait				=> 5,
	  :message_1		=> "...Except, the effect rebounded!",
	  :battler_1		=> 0,
	  :stats			=> [:ATTACK, 1, :SPECIAL_ATTACK, 1],
	  :speech_1			=> "No! That wasn't supposed to happen!",
	  :text				=> "{2}: (It's just like Miss Hina said... the effects are rebounding because of her inexperience!",
	},
	
	"turnCommand_20" => {
	  :ignore			=> "lowhp_final_foe",
	  :speech			=> ["I call upon this Tome of Curses... smite my enemies!"],
	  :text				=> "Medicine lays a curse upon your party!",
	  :wait				=> 5,
	  :message_1		=> "...Except, the effect rebounded!",
	  :anim				=> [:GRUDGE,1],
	  :stats			=> [:DEFENSE, -1, :SPECIAL_DEFENSE, -1],
	  :status			=> :CONFUSION,
	  :speech_1			=> "Grr! Why does this keep happening!?",
	},
	
	"fainted_foe_repeat" => {
	  :battler			=> 1,
	  :speech 			=> "Let's see how you feel being weak!",
	  :message			=> "Medicine lays a curse upon your party!",
	  :battler_1		=> 0,
	  :anim				=> [:GRUDGE,0],
	  :stats			=> [:DEFENSE, -1, :SPECIAL_DEFENSE, -1],
	  :effects	 		=> [
        [PBEffects::Curse, true],
      ],
	},
	
	"afterLast_foe" => {
	  :item				=> [:FOCUSRIBBON_ALT, "Test"],
	  :speech			=> ["I will bring an end to this, here and now!",
							"Tome of Curses, grant my allies with unbreakable resolve and power!"],
	  :battler			=> 1,
	  :anim				=> [:HARDEN, 1],
	  :text				=> "{1}'s glows with immense power!",
	  :stats			=> [:DEFENSE, 4, :SPECIAL_DEFENSE, 4, :ATTACK, 4, :SPECIAL_ATTACK, 4],
	  :effects 			=> [
        [PBEffects::Ingrain, true],
      ],
	  :team				=> [
		[PBEffects::AuroraVeil, 99],
      ],

	},	
	
	#"lowhp_foe_repeat" => {
	#  :battler			=> 1,
	#  :speech			=> "Try picking on someone your own size!",
	#  :text				=> "Medicine uses the Tome of Curses to boost her party's defenses!",
	#  :stats			=> [:DEFENSE, 1, :SPECIAL_DEFENSE, 1],
	#},
	
	#"halfhp_final_foe" => {
	#  :speech			=> "It's time, {1}! Spell Card activate!"
	#  :usespecial		=> :ZMove
	#},
	
	#"turnCommand_repeat" => {
	#  :delay			=> "afterLast_foe",
	#  :ignore			=> "lowhp_final_foe",
	#  :battler			=> 1,
	#  :effects 			=> [
    #    [PBEffects::Endure, true],
    #  ],
	#},
	
	"lowhp_final_foe" => {
	  :speech			=> ["I can't... I won't let my kindred down!",
							"Tome of Curses, bring my foe to their knees!"],
	  :battler			=> 0,
	  :text				=> "Medicine calls upon the Tome of Curses one last time!",
	  :nobgm			=> true,
	  :wait				=> 60,
	  :text_1			=> "...Nothing happened.",
	  :bgm				=> "W-017. Seeds of the Incident",
	  :battler_1		=> 1,
	  :item				=> :Remove,
	  :speech_1			=> ["...Let's try that again!",
							"Tome of Curses! Bring my foe to their knees!"],
	  :wait_1			=> 30,
	  :text_2			=> "Nothing happened, again.",
	  :speech_2			=> ["Why... Why aren't you working anymore?!",
							"I call upon the Tome of Curses! Please, bring my foe to their knees!"],
	  :wait_2			=> 30,
	  :text_3			=> "The Tome of Curses reacts!",
	  :wait_3			=> 20,
	  :text_4			=> "...The effect rebounds.",
	  :anim				=> [:GRUDGE, 1],
	  :stats			=> :Reset_Raised,
	  :effects 			=> [
        [PBEffects::Ingrain, false],
      ],
	  :team				=> [
		[PBEffects::AuroraVeil, 0, "All the protections surounding Medicine's team disappeared!"],
      ],
	  :speech_3			=> "N-No! That wasn't supposed to happen! Why is this happening now!?",
	  :battler_2		=> 0,
	  :text_5			=> "{2}: (This is our chance to finish it!)",
	},
	
	"turnEnd_repeat_random" => {
	  :message				=> "{1} begun to get affected by the miasma.",
	  :status 				=> :POISON,
	},
  }	

  
  #-----------------------------------------------------------------------------
  # Scene: Vs. Tenshi Omega
  #-----------------------------------------------------------------------------
  VS_TENSHIO = {
	"turnCommand" => {
	  :battler 		=> 1,
	  :text			=> "{1}'s skin glows with a powerful sheen!",
	  :anim			=> [:IRONDEFENSE,1],
	  :anim_1		=> [:HARDEN, 1],
	  :stats		=> [:DEFENSE, 4, :SPECIAL_DEFENSE, 4],
	  :effects 		=> [
        [PBEffects::Ingrain, true],
      ],
	  :team			=> [
		[PBEffects::Safeguard, 5],
	  	[PBEffects::Mist, 5],
      ],
	  :text_1		=> "{1} has become impervious to most forms of damage!"
	},
	
	"halfhp_foe" => {
	  :battler 		=> 1,
	  :text			=> "{1}'s grows more engaged with the battle! Her sword glows with a radiant aura!",
	  :anim			=> [:SWORDSDANCE,1],
	  :stats_1		=> [:ACCURACY, 2],
	  :text_1		=> "{1} has changed attack patterns!",
	  :moves		=> [:EARTHQUAKE18, :METEORMASH18, :HEARTBREAK18, :SANDSTORM18],
	},
	
	"lowhp_foe" => {
	  :battler 			=> 1,
	  :text				=> "{1}'s looks determined... Her sword glows with a firey aura!",
	  :text_1			=> "{1} swung out with her sword!",
      :anim    			=> [:SACREDSWORD, 0],
	  :battler_1 		=> 0,
      :hp      			=> -4,
	  :battler_2 		=> 1,
	  :moves			=> [:ANCIENTPOWER18, :METEORMASH18, :HYPERBEAM18, :HISOUSWORD],
	  :text_2			=> "{1} has changed attack patterns once again!",
	},  
	
	"turnEnd_repeat_three" => {
	  #:ignore		=> "twohp_foe",
	  :battler 		=> 1,
	  :status    	=> [:NONE, true],
	  :stats		=> :Reset_Defenses,
	  :anim			=> "UltraBurst2",
	  :effects 		=> [
        [PBEffects::Ingrain, false],
      ],
	  :team			=> [
		[PBEffects::Safeguard, 0],
	  	[PBEffects::Mist, 0],
      ],
	  :text			=> "{1}'s sword glows with a radiant aura!",
	  :anim_1		=> [:SWORDSDANCE,1],
	  :form			=> 1,
	  :text_1		=> "{1} has taken up an offensive stance!",
	  :stats_1		=> [:ATTACK, 2, :SPECIAL_ATTACK, 2, :SPEED, 2],
	},
	
	"turnEnd_repeat_six" => {
	  #:ignore		=> "twohp_foe",
	  :battler 		=> 1,
	  :status    	=> [:NONE, true],
	  :text			=> "{1}'s skin glows with a powerful sheen!",
	  :anim			=> [:IRONDEFENSE,1],
	  :anim_1		=> [:HARDEN, 1],
	  :stats		=> [:DEFENSE, 4, :SPECIAL_DEFENSE, 4],
	  :effects 		=> [
        [PBEffects::Ingrain, true],
      ],
	  :team			=> [
		[PBEffects::Safeguard, 5],
	  	[PBEffects::Mist, 5],
      ],
	  :form			=> 0,
	  :text_1		=> "{1} has become impervious to most forms of damage!",
	},
	
	"twohp_foe" => {
	  :battler 		=> 1,
	  :text			=> "{1} is on their last legs!",
	  :ability 		=> :CELESTIALSKIN2,
	  :moves		=> [:ANCIENTPOWER18, :METEORMASH18, :HYPERBEAM18, :HISOUSWORD],
	},
	
	"onehp_foe" => {
	  :effects 		=> [
        [PBEffects::Ingrain, false],
      ],
	  :team			=> [
		[PBEffects::Safeguard, 0],
	  	[PBEffects::Mist, 0],
      ],
	  :anim			=> "GBFDefeat",
	  :battler 		=> 1,
	  :me			=> "win_se_1",
	  :bgmnw		=> "05_gatcha_02",
	  :text			=> "{1} has been defeated -- Quest Cleared!",
	  :wait			=> 480,
	  :endbattle 	=> 1
	}
  }
end