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
    "turnCommand"           => "Trigger: 'turnCommand'\nCommand Phase start.",
    "turnAttack"            => "Trigger: 'turnAttack'\nAttack Phase start.",
    "turnEnd"               => "Trigger: 'turnEnd'\nEnd of Round Phase end.",
    #---------------------------------------------------------------------------
    # Move Triggers
    #---------------------------------------------------------------------------
    "attack"                => "Trigger: 'attack'\nYour Pokémon successfully launches a damage-dealing move.",
    "attack_foe"            => "Trigger: 'attack_foe'\nMy Pokémon successfully launches a damage-dealing move.",
    "attack_ally"           => "Trigger: 'attack_ally'\nYour partner's Pokémon successfully launches a damage-dealing move.",
    "status"                => "Trigger: 'status'\nYour Pokémon successfully launches a status move.",
    "status_foe"            => "Trigger: 'status_foe'\nMy Pokémon successfully launches a status move.",
    "status_ally"           => "Trigger: 'status_ally'\nYour partner's Pokémon successfully launches a status move.",
    "superEffective"        => "Trigger: 'superEffective'\nYour Pokémon's attack dealt super effective damage.",
    "superEffective_foe"    => "Trigger: 'superEffective_foe'\nMy Pokémon's attack dealt super effective damage.",
    "superEffective_ally"   => "Trigger: 'superEffective_ally'\nYour partner's Pokémon's attack dealt super effective damage.",
    "notVeryEffective"      => "Trigger: 'notVeryEffective'\nYour Pokémon's attack dealt not very effective damage.",
    "notVeryEffective_foe"  => "Trigger: 'notVeryEffective_foe'\nMy Pokémon's attack dealt not very effective damage.",
    "notVeryEffective_ally" => "Trigger: 'notVeryEffective_ally'\nYour partner's Pokémon's attack dealt not very effective damage.",
    "immune"                => "Trigger: 'immune'\nYour Pokémon's attack was negated or has no effect.",
    "immune_foe"            => "Trigger: 'immune_foe'\nMy Pokémon's attack was negated or has no effect.",
    "immune_ally"           => "Trigger: 'immune_ally'\nYour partner's Pokémon's attack was negated or has no effect.",
    "miss"                  => "Trigger: 'miss'\nYour Pokémon's attack missed.",
    "miss_foe"              => "Trigger: 'miss_foe'\nMy Pokémon's attack missed.",
    "miss_ally"             => "Trigger: 'miss_ally'\nYour partner's Pokémon's attack missed.",
    "criticalHit"           => "Trigger: 'criticalHit'\nYour Pokémon's attack dealt a critical hit.",
    "criticalHit_foe"       => "Trigger: 'criticalHit_foe'\nMy Pokémon's attack dealt a critical hit.",
    "criticalHit_ally"      => "Trigger: 'criticalHit_ally'\nYour partner's Pokémon's attack dealt a critical hit.",
    #---------------------------------------------------------------------------
    # Damage State Triggers
    #---------------------------------------------------------------------------
    "damage"                => "Trigger: 'damage'\nYour Pokémon took damage from an attack.",
    "damage_foe"            => "Trigger: 'damage_foe'\nMy Pokémon took damage from an attack.",
    "damage_ally"           => "Trigger: 'damage_ally'\nYour partner's Pokémon took damage from an attack.",
    "lowhp"                 => "Trigger: 'lowhp'\nYour Pokémon took damage and HP fell to 1/4th max HP or lower.",
    "lowhp_foe"             => "Trigger: 'lowhp_foe'\nMy Pokémon took damage and HP fell to 1/4th max HP or lower.",
    "lowhp_ally"            => "Trigger: 'lowhp_ally'\nYour partner's Pokémon took damage and HP fell to 1/4th max HP or lower.",
    "lowhp_final"           => "Trigger: 'lowhp_final'\nYour final Pokémon took damage and HP fell to 1/4th max HP or lower.",
    "lowhp_final_foe"       => "Trigger: 'lowhp_final_foe'\nMy final Pokémon took damage and HP fell to 1/4th max HP or lower.",
    "lowhp_final_ally"      => "Trigger: 'lowhp_final_ally'\nYour partner's final Pokémon took damage and HP fell to 1/4th max HP or lower.",
    "fainted"               => "Trigger: 'fainted'\nYour Pokémon fainted.",
    "fainted_foe"           => "Trigger: 'fainted_foe'\nMy Pokémon fainted.",
    "fainted_ally"          => "Trigger: 'fainted_ally'\nYour partner's Pokémon fainted.",
    #---------------------------------------------------------------------------
    # Switch Triggers
    #---------------------------------------------------------------------------
    "recall"                => "Trigger: 'recall'\nYou withdrew an active Pokémon.",
    "recall_foe"            => "Trigger: 'recall_foe'\nI withdrew an active Pokémon.",
    "recall_ally"           => "Trigger: 'recall_ally'\nYour partner withdrew an active Pokémon.",
    "beforeNext"            => "Trigger: 'beforeNext'\nYou intend to send out a Pokémon.",
    "beforeNext_foe"        => "Trigger: 'beforeNext_foe'\nI intend to send out a Pokémon.",
    "beforeNext_ally"       => "Trigger: 'beforeNext_ally'\nYour partner intends to send out a Pokémon.",
    "afterNext"             => "Trigger: 'afterNext'\nYou successfully sent out a Pokémon.",
    "afterNext_foe"         => "Trigger: 'afterNext_foe'\nI successfully sent out a Pokémon.",
    "afterNext_ally"        => "Trigger: 'afterNext_ally'\nYour partner successfully sent out a Pokémon.",
    "beforeLast"            => "Trigger: 'beforeLast'\nYou intend to send out your final Pokémon.",
    "beforeLast_foe"        => "Trigger: 'beforeLast_foe'\nI intend to send out my final Pokémon.",
    "beforeLast_ally"       => "Trigger: 'beforeLast_ally'\nYour partner intends to send out their final Pokémon.",
    "afterLast"             => "Trigger: 'afterLast'\nYou successfully sent out your final Pokémon.",
    "afterLast_foe"         => "Trigger: 'afterLast_foe'\nI successfully sent out my final Pokémon.",
    "afterLast_ally"        => "Trigger: 'afterLast_ally'\nYour partner successfully sent out their final Pokémon.",
    #---------------------------------------------------------------------------
    # Special Action Triggers
    #---------------------------------------------------------------------------
    "item"                  => "Trigger: 'item'\nYou used an item from your inventory.",
    "item_foe"              => "Trigger: 'item_foe'\nI used an item from my inventory.",
    "item_ally"             => "Trigger: 'item_ally'\nYour partner used an item from their inventory.",
    "mega"                  => "Trigger: 'mega'\nYou initiate Mega Evolution.",
    "mega_foe"              => "Trigger: 'mega_foe'\nI initiate Mega Evolution.",
    "mega_ally"             => "Trigger: 'mega_ally'\nYour partner initiates Mega Evolution.",
    "zmove"                 => "Trigger: 'zmove'\nYou initiate a Z-Move.",
    "zmove_foe"             => "Trigger: 'zmove_foe'\nI initiate a Z-Move.",
    "zmove_ally"            => "Trigger: 'zmove_ally'\nYour partner initiates a Z-Move.",
    "ultra"                 => "Trigger: 'ultra'\nYou initiate Ultra Burst.",
    "ultra_foe"             => "Trigger: 'ultra_foe'\nI initiate Ultra Burst.",
    "ultra_ally"            => "Trigger: 'ultra_ally'\nYour partner initiates Ultra Burst.",
    "dynamax"               => "Trigger: 'dynamax'\nYou initiate Dynamax.",
    "dynamax_foe"           => "Trigger: 'dynamax_foe'\nI initiate Dynamax.",
    "dynamax_ally"          => "Trigger: 'dynamax_ally'\nYour partner initiates Dynamax.",
    "zodiac"                => "Trigger: 'zodiac'\nYou initiate a Zodiac Power.",
    "zodiac_foe"            => "Trigger: 'zodiac_foe'\nI initiate a Zodiac Power.",
    "zodiac_ally"           => "Trigger: 'zodiac_ally'\nYour partner initiates a Zodiac Power.",
    "focus"                 => "Trigger: 'focus'\nYour Pokémon harnesses their focus.",
    "focus_foe"             => "Trigger: 'focus_foe'\nMy Pokémon harnesses their focus.",
    "focus_ally"            => "Trigger: 'focus_ally'\nYour partner's Pokémon harnesses their focus.",
    #---------------------------------------------------------------------------
    # Player-only Triggers
    #---------------------------------------------------------------------------
    "beforeCapture"         => "Trigger: 'beforeCapture'\nYou intend to throw a selected Poké Ball.",
    "afterCapture"          => "Trigger: 'afterCapture'\nYou successfully captured the targeted Pokémon.",
    "failedCapture"         => "Trigger: 'failedCapture'\nYou failed to capture the targeted Pokémon.",
    "loss"                  => "Trigger: 'loss'\nYou lost the battle."
  }
  
  
  
  #-----------------------------------------------------------------------------
  # Demo scenario vs. wild Rotom that shifts forms.
  #-----------------------------------------------------------------------------
  DEMO_WILD_ROTOM = {
    "turnCommand" => {
      :text      => [1, "{1} emited a powerful magnetic pulse!"],
      :playsound => "Anim/Paralyze3",
      :text_1    => "Your Poké Balls short-circuited!\nThey cannot be used this battle!"
    },
    "superEffective_repeat" => {
      :battler => :Opposing,
      :form    => [:Random, "{1} possessed a new appliance!"],
      :hp      => 1,
      :status  => :NONE,
      :ability => [:MOTORDRIVE, true],
      :item    => [:CELLBATTERY, "{1} equipped a Cell Battery it found in the appliance!"],
    },
    "lowhp_foe_repeat" => {
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
      :playcry => true,
      :hp      => [2, "{1} is standing its ground!"],
      :stats   => [:DEFENSE, 2, :SPECIAL_DEFENSE, 2]
    },
    "loss" => "Haha...you'll never make it out alive!"
  }
  
  #-----------------------------------------------------------------------------
  # Scene: Red vs. Chibi Chen, Pallet Town
  #-----------------------------------------------------------------------------  
  RED_VS_CHEN = {
	"turnCommand" => {
	  :text		=> ["Professor Oak: Red! Remember what I told you! That Reimu Puppet is just like a Pokémon!", "Command her and she'll fight alongside you!"],
	  },
	"turnCommand_repeat"	=> {
	  :battler	=> 0,
	  :effect	=> [ [PBEffects::Endure, true] ]
	  },
	"lowhp_repeat"		  => {
      :battler => 0,
      :text    => "{1} got her second wind!",
      :hp      => 1
	  },
    }
	
  #-----------------------------------------------------------------------------
  # Scene: Renko & Maribel Vs. Red, Pallet Town
  #-----------------------------------------------------------------------------  
  VS_RED_1 = {
    "turnCommand" => {
	  :text		=> ["Renko: Let's show Red how well we work together as a team, Mary!", "Maribel: I'm right beside you, Renko!", "Red: ..."]
	  },
	#"fainted" => {
	#  :text		=> ["\\PN: Oh no!", "\\v[108]: It's alright, I've got this \\pn!"]
	#  },
	#"fainted_ally" => {
	#  :text		=> ["\\v[108]: Oh no!", "\\pn: It's alright, I've got this \\v[108]!"]
	#  },
	}
	
  #-----------------------------------------------------------------------------
  # Scene: Vs. Chibi Kazami, A Thorny Situation sidequest
  #-----------------------------------------------------------------------------  
  VS_CKAZAMI = {
	"turnCommand" => {
	  :battler		=> 0,
	  :text			=> ["\"So this is the Puppet that all those construction workers are afraid of?\"", "She looks like she's too sleepy to do any harm, but I guess looks can be decieving...\""],
	  :battler		=> 1,
	  :text_2		=> ["CKazami: ..."],
	  :text_3		=> ["The wild CKazami begins to defend itself!"],
	  :stats   		=> [:DEFENSE, 2, :SPECIAL_DEFENSE, 2],
	  :item			=> :STURDYVINE
	},
	
	"lowhp_final_foe" => {
	  :nobgm			=> true,
	  :text				=> "\"Alright, let's finish it off!\"",
	  :playSEnw			=> "Cries/CKAZAMI",
	  :text_1			=> ["CKazami: ...", "The CKazami stood back up!"],
	  :hp      			=> 1,
	  :text_2			=> "\"Wait... what's it doing?\"",
	  :anim				=> "KazamiEvo",
	  :form				=> 1,
	  :anim_2			=> "EmptyAnim",
	  :backdrop2		=> "Forest_Alt1",
	  :anim_3			=> "Shadow",
	  :playSEnw_2		=> "Cries/KAZAMI_Alt",
	  :rename			=> "Kazami",
	  :status  			=> :NONE,
	  :playSE_1			=> "Evolution success",
	  :text_3			=> ["\"No way- Did it just evolve in the middle of battle!?\"", "\"This doesn't bode well!\""],
	  :wait				=> 35,
	  :bgmnw			=> "B-009. Faint Dream ~ Inanimate Dream",
	  :stats   			=> [:ATTACK, 1, :SPECIAL_ATTACK, 1, :SPEED, 1],
	  :text_4			=> "The wild Kazami is now prepared to fight!",
	  #:stats   			=> :Reset,
	  :moves   			=> [:HYPERBEAM18, :LEAFBLADE18, :INGRAIN18, :TAUNT18],
	  :ability 			=> :OVERGROW,
	  :item				=> :MALACHITE,
	  :playSEnw_3		=> "Cries/KAZAMI_Alt",
	  :text_5			=> ["Kazami: !!!"],
	  :switchon			=> 107,
	},	
  }
  
  #-----------------------------------------------------------------------------
  # Scene: Vs. Kazami, A Thorny Situation (If defeated but witnessed CKazami evolve)
  #-----------------------------------------------------------------------------  
  VS_KAZAMI = {
	"turnCommand" => {
	  :battler		=> 0,
	  :text			=> ["\"That last fight caught us off guard, but we won't falter again!\"", "\"Ready yourself, {1}!\""],
	  :crynw		=> true,
	  :text_1		=> ["{1}: !!!"],
	  :text_2		=> ["The wild Kazami takes up a battling stance!"],
	  :battler		=> 1,
	  :stats   		=> [:ATTACK, 1, :SPEED, 1, :SPECIAL_ATTACK, 1],
	  :playSEnw		=> "Cries/KAZAMI_Alt",
	  :text_3		=> ["Kazami: !!!"],
	  :text_4		=> ["The wild Kazami is ready to fight once again!"],
	  :item			=> :MALACHITE
	},
  }
end