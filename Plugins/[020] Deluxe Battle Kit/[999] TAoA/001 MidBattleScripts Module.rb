module MidbattleScripts
  #-----------------------------------------------------------------------------
  # The Adventures of Ayaka
  #-----------------------------------------------------------------------------
  # The Mansion of Mystery
  #-----------------------------------------------------------------------------  
  # Scene: Night Blindness in battle
  #		* When Lamprey is not active, all Puppets have -1 Accuracy
  #-----------------------------------------------------------------------------  
  
  
  #-----------------------------------------------------------------------------  
  # Scene: Super Lamprey
  #		* When the Full Lamprey Dish is consumed, all Puppets have +1 Accuracy
  #-----------------------------------------------------------------------------  
  
 
  #-----------------------------------------------------------------------------
  # The Festival of Curses
  #-----------------------------------------------------------------------------   
  # Scene: Possessed Puppets in Youkai Woods
  #		* Possessed Puppets gain +1 to Attack and Sp.Atk at battle start
  #-----------------------------------------------------------------------------  
  VS_CURSED_PUPPETS = {
	"RoundStartCommand_1_player" => {
	  "setBattler"      => :Self,
	  "speech"          => "I think that's one of those Possessed Puppets that Miss Kagiyama told me to find!",
	  "setBattler_A"    => :Opposing,
	  "playAnim"        => [:GRUDGE, :Self],
	  "playCry"         => :Self,
	  "text"            => "{1} gains power from being possessed!",
	  "battlerStats"    => [:ATTACK, 1, :SPECIAL_ATTACK, 1]
	}
  }
  #-----------------------------------------------------------------------------  
  # Scene: Malevolent Spirit Ringleader battle
  #		* Possessed Puppets gain +1 to Attack and Sp.Atk
  #		* When a Possessed Puppet is defeated, the Player's Puppets get
  #		  possessed and take a hit to Attack and Sp.Atk (-1)
  #		* Final Puppet gains +2 to both Attacks and Defenses
  #----------------------------------------------------------------------------- 
  VS_FAKE_HINA = {
    "RoundStartCommand_1_player" => {
	  "setBattler"        => :Opposing,
	  "playAnim"          => [:GRUDGE, :Self],
	  "playCry"           => :Self,
	  "text"              => "{1} gains power from being possessed!",
	  "battlerStats"      => [:ATTACK, 1, :SPECIAL_ATTACK, 1]
	},
	
	"BattlerFainted_foe_repeat" => {
	  "setBattler"              => :Self,
	  "speech"                  => "...~",
	  "text"                    => "The malevolent spirit ejected from the fainted Puppet and latched onto yours!",
	  "setBattler_A"            => :Opposing,
	  "playAnim"                => [:GRUDGE, :Self],
	  "battlerStats"            => [:ATTACK, 1, :SPECIAL_ATTACK, 1],
      "battlerEffects"          => [:Curse, true],
      "battlerStatus"           => :CONFUSION
	},
	
	"AfterLastSendOut_foe" => {
	  "setBattler"        => :Self,
	  "playAnim"          => [:GRUDGE, :Self],
	  "playCry"           => :Self,
	  "text"              => "{1} gains power from being possessed!",
	  "battlerStats"      => [:ATTACK, 2, :SPECIAL_ATTACK, 2, :DEFENSE, 2, :SPECIAL_DEFENSE, 2]
	}
  }
	
  #-----------------------------------------------------------------------------  
  # Scene: Three Fairies of Light
  #		* The Three Fairies taunt the Player
  #-----------------------------------------------------------------------------  
  VS_THREE_FAIRIES = {
    "RoundStartCommand_1_player" => {
	  "speech"            => "Hey, wait! Doesn't three against one seem kinda unfair?!",
	  "setSpeaker_A"      => :STAR,
	  "editWindow_A"      => "Star Sapphire",
	  "speech_A"          => "Nuh uh! It's totally fair!",
	  "editSpeaker_B"     => :LUNA,
	  "editWindow_B"      => "Luna Child",
	  "speech_B"          => "You've beat us individually. That's only one third of our total strength!",
	  "editSpeaker_C"     => :SUNNY,
	  "editWindow_C"      => "Sunny Milk",
	  "speech_C"          => "This time we'll fight you all together-",
	  "editSpeaker_D"     => :Opposing,
	  "editWindow_D"      => "Three Fairies of Light",
	  "speech_D"          => "-one on one!",
	  "setSpeaker_E"     => :Self,
	  "speech_E"          => "That-... That logic doesn't make any sense! But fine, we'll play by your rules! And when I win, you'll tell me everything you know!"
	}
  }
  
  #-----------------------------------------------------------------------------
  # The Kingdom of Lunacy
  #-----------------------------------------------------------------------------  
  # Scene: Vs. Boss Puppet
  #		* Boss Puppet gains a +2 Omniboost
  #----------------------------------------------------------------------------- 
  
  
  
  #----------------------------------------------------------------------------- 
  # Scene: Vs. Junko
  #		* Each of Junko's Puppets gets a unique +2 to one of their stats
  #-----------------------------------------------------------------------------  
  VS_JUNKO = {
    "AfterSwitchIn_foe_AMOKOU" => {
	  "setBattler"              => :Opposing,
	  "text"                    => "Junko reached out and purified her Puppet's power!",
	  "battlerStats"            => [:SPECIAL_ATTACK, 2],
	},
	
	"AfterSwitchIn_TPARSEE" => {
	  "setBattler"              => :Opposing,
	  "text"                    => "Junko reached out and purified her Puppet's power!",
	  "battlerStats"            => [:DEFENSE, 2],
	},
	
	"AfterSwitchIn_ASUWAKO" => {
	  "setBattler"              => :Opposing,
	  "text"                    => "Junko reached out and purified her Puppet's power!",
	  "battlerStats"            => [:ATTACK, 2],
	},
	
	"AfterSwitchIn_JUNKO" => {
	  "setBattler"              => :Opposing,
	  "text"                    => "Junko reached out and purified her Puppet's power!",
	  "battlerStats"            => [:ATTACK, 2],
	},
	
	"AfterSwitchIn_DARKALICE" => {
	  "setBattler"              => :Opposing,
	  "text"                    => "Junko reached out and purified her Puppet's power!",
	  "battlerStats"            => [:SPECIAL_ATTACK, 2],
	}
  }
end