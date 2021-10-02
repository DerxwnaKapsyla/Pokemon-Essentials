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

  MAX_MONEY            = 9_999_999
  MAX_COINS            = 999_999
  
  POISON_IN_FIELD       = true
  POISON_FAINT_IN_FIELD = false 
  FISHING_AUTO_HOOK     = true
  
  FIELD_MOVES_COUNT_BADGES = false

  BADGE_FOR_FLASH     = 1
  BADGE_FOR_CUT       = 2
  BADGE_FOR_FLY       = 3
  BADGE_FOR_STRENGTH  = 4
  BADGE_FOR_SURF      = 5
  BADGE_FOR_ROCKSMASH = 6
  BADGE_FOR_DIVE      = -1
  BADGE_FOR_WATERFALL = 8
  
  ALT_BADGE_FOR_FLASH     = 9
  ALT_BADGE_FOR_CUT       = 10
  ALT_BADGE_FOR_STRENGTH  = 11
  ALT_BADGE_FOR_SURF      = 12
  ALT_BADGE_FOR_FLY       = 13
  ALT_BADGE_FOR_ROCKSMASH = 14
  BADGE_FOR_WHIRLPOOL	  = 15
  ALT_BADGE_FOR_WATERFALL = 16
  
  TAUGHT_MACHINES_KEEP_OLD_PP          = false
  FLUTES_CHANGE_WILD_ENCOUNTER_LEVELS  = true
  REPEL_COUNTS_FAINTED_POKEMON         = true
  RAGE_CANDY_BAR_CURES_STATUS_PROBLEMS = true
  
  NUM_STORAGE_BOXES = 45
  
  def self.bag_pocket_names
    return ["",
      _INTL("Items"),
      _INTL("Medicine"),
      _INTL("Capture Devices"),
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