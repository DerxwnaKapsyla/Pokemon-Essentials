#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Feel free to Add, Remove, or Change anything here at your leisure.
# Use the Settings script section to get an example of what is and isn't
# available to modify.
# - DerxwnaKapsyla
#==============================================================================#
module Settings
  GAME_VERSION = '3.0.0'
  
  MECHANICS_GENERATION = 5 # Should I change it to 8? Hmm. Research.

  MAX_MONEY            = 9_999_999
  MAX_COINS            = 999_999
  SUPER_SHINY          = true
  
  POISON_IN_FIELD      						 = true
  POISON_FAINT_IN_FIELD						 = false 
  FISHING_AUTO_HOOK     					 = true
  DAY_CARE_POKEMON_GAIN_EXP_FROM_WALKING     = true
  SHOW_NEW_SPECIES_POKEDEX_ENTRY_MORE_OFTEN  = true
  MORE_BONUS_PREMIER_BALLS                   = true
  
  TAUGHT_MACHINES_KEEP_OLD_PP          = false
  MOVE_RELEARNER_CAN_TEACH_MORE_MOVES  = true
  REBALANCED_HEALING_ITEM_AMOUNTS      = true
  RAGE_CANDY_BAR_CURES_STATUS_PROBLEMS = true
  NO_VITAMIN_EV_CAP                    = true
  RARE_CANDY_USABLE_AT_MAX_LEVEL       = true
  USE_MULTIPLE_STAT_ITEMS_AT_ONCE      = true
  
  REPEL_COUNTS_FAINTED_POKEMON             = true
  MORE_ABILITIES_AFFECT_WILD_ENCOUNTERS    = true
  HIGHER_SHINY_CHANCES_WITH_NUMBER_BATTLED = true
  
  FIELD_MOVES_COUNT_BADGES = false

  BADGE_FOR_FLASH     = 0
  BADGE_FOR_CUT       = 1
  BADGE_FOR_FLY       = 2
  BADGE_FOR_STRENGTH  = 3
  BADGE_FOR_SURF      = 4
  BADGE_FOR_ROCKSMASH = 5
  BADGE_FOR_DIVE      = -1
  BADGE_FOR_WATERFALL = 7
  
  ALT_BADGE_FOR_FLASH     = 8
  ALT_BADGE_FOR_CUT       = 9
  ALT_BADGE_FOR_STRENGTH  = 10
  ALT_BADGE_FOR_SURF      = 11
  ALT_BADGE_FOR_FLY       = 12
  ALT_BADGE_FOR_ROCKSMASH = 13
  BADGE_FOR_WHIRLPOOL	  = 14
  ALT_BADGE_FOR_WATERFALL = 15
  
  TAUGHT_MACHINES_KEEP_OLD_PP          = false
  FLUTES_CHANGE_WILD_ENCOUNTER_LEVELS  = true
  REPEL_COUNTS_FAINTED_POKEMON         = true
  RAGE_CANDY_BAR_CURES_STATUS_PROBLEMS = true
  
  NUM_STORAGE_BOXES = 45
  HEAL_STORED_POKEMON = true
  
  def self.bag_pocket_names
    return ["",
      _INTL("Items"),
      _INTL("Medicine"),
      _INTL("Poké Balls"), # Capture Devices was too long iirc
      _INTL("TMs & HMs"),
      _INTL("Berries"),
      _INTL("Mail"),
      _INTL("Battle Items"),
      _INTL("Key Items")
    ]
  end
  
  def self.pokedex_names
    return [
      [_INTL("Pokémon Pokédex"), 0],
      [_INTL("Puppet Pokédex"), 1],
      _INTL("National Pokédex")
    ]
  end
end