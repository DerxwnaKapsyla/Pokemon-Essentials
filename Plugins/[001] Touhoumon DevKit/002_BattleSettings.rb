#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Feel free to Add, Remove, or Change anything here at your leisure.
# Use the BattleSettings script section to get an example of what is and isn't
# available to modify.
# - DerxwnaKapsyla
#==============================================================================#
module Settings
  MOVE_CATEGORY_PER_MOVE                      = true
  FIXED_DURATION_WEATHER_FROM_ABILITY         = true
  
  X_STAT_ITEMS_RAISE_BY_TWO_STAGES = false
  NEW_POKE_BALL_CATCH_RATES        = true
  
  SCALED_EXP_FORMULA        = true
  SPLIT_EXP_BETWEEN_GAINERS = true
  ENABLE_CRITICAL_CAPTURES  = true
  GAIN_EXP_FOR_CAPTURE      = true
  CHECK_EVOLUTION_AFTER_ALL_BATTLES   = true
  
  SPECIAL_BATTLE_SWITCH			= 102	# Used for when you want to trigger a battle with special text for the encounter. (Ie; "N's Zoroark", "The aggressive Igglybuff", etc.)
  SPECIAL_BATTLE_VARIABLE		= 102	# Used in conjunction with the switch above. Determines the stringset to run. You can find existing ones by searching for these lines.
end