#===============================================================================
# Uses a random move that exists. (Metronome)
#
# Special version exclusive to the Final boss battle.
#===============================================================================
class Battle::Move::UseRandomMove_alt < Battle::Move
  def initialize(battle, move)
    super
    @moveBlacklist = [
      "FlinchTargetFailsIfUserNotAsleep",                  # Snore
      "TargetActsNext",                                    # After You
      "TargetActsLast",                                    # Quash
      "TargetUsesItsLastUsedMoveAgain",                    # Instruct
      # Struggle, Belch
      "Struggle",                                          # Struggle
      "FailsIfUserNotConsumedBerry",                       # Belch
      # Moves that affect the moveset
      "ReplaceMoveThisBattleWithTargetLastMoveUsed",       # Mimic
      "ReplaceMoveWithTargetLastMoveUsed",                 # Sketch
      "TransformUserIntoTarget",                           # Transform
	  "UserCopiesMovesWithoutTransforming",			   	   # Recollection
      # Counter moves
      "CounterPhysicalDamage",                             # Counter
      "CounterSpecialDamage",                              # Mirror Coat
      "CounterDamagePlusHalf",                             # Metal Burst        # Not listed on Bulbapedia
      # Helping Hand, Feint (always blacklisted together, don't know why)
      "PowerUpAllyMove",                                   # Helping Hand
      "RemoveProtections",                                 # Feint
      # Protection moves
      "ProtectUser",                                       # Detect, Protect
      "ProtectUserSideFromPriorityMoves",                  # Quick Guard
      "ProtectUserSideFromMultiTargetDamagingMoves",       # Wide Guard
      "UserEnduresFaintingThisTurn",                       # Endure
      "ProtectUserSideFromDamagingMovesIfUserFirstTurn",   # Mat Block
      "ProtectUserSideFromStatusMoves",                    # Crafty Shield
      "ProtectUserFromDamagingMovesKingsShield",           # King's Shield
      "ProtectUserFromDamagingMovesObstruct",              # Obstruct
      "ProtectUserFromTargetingMovesSpikyShield",          # Spiky Shield
      "ProtectUserBanefulBunker",                          # Baneful Bunker
      # Moves that call other moves
      "UseLastMoveUsedByTarget",                           # Mirror Move
      "UseLastMoveUsed",                                   # Copycat
      "UseMoveTargetIsAboutToUse",                         # Me First
      "UseMoveDependingOnEnvironment",                     # Nature Power
      "UseRandomUserMoveIfAsleep",                         # Sleep Talk
      "UseRandomMoveFromUserParty",                        # Assist
      "UseRandomMove",                                     # Metronome
	  "UseRandomMove_alt",                                 # Metronome (alt)
      # Move-redirecting and stealing moves
      "BounceBackProblemCausingStatusMoves",               # Magic Coat         # Not listed on Bulbapedia
      "StealAndUseBeneficialStatusMove",                   # Snatch
      "RedirectAllMovesToUser",                            # Follow Me, Rage Powder
      "RedirectAllMovesToTarget",                          # Spotlight
      # Set up effects that trigger upon KO
      "ReduceAttackerMovePPTo0IfUserFaints",               # Grudge             # Not listed on Bulbapedia
      "AttackerFaintsIfUserFaints",                        # Destiny Bond
      # Held item-moving moves
      "UserTakesTargetItem",                               # Covet, Thief
      "UserTargetSwapItems",                               # Switcheroo, Trick
      "TargetTakesUserItem",                               # Bestow
      # Moves that start focussing at the start of the round
      "FailsIfUserDamagedThisTurn",                        # Focus Punch
      "UsedAfterUserTakesPhysicalDamage",                  # Shell Trap
      "BurnAttackerBeforeUserActs",                        # Beak Blast
      # Event moves that do nothing
      "DoesNothingFailsIfNoAlly",                          # Hold Hands
      "DoesNothingCongratulations",                        # Celebrate
	  # Final Boss Do Not Use These Moves Pls K Thx Bye
	  "OHKO",                                              # Do not call on moves that can OHKO.
	  "SwitchOutTargetStatusMove",                         # Do not call on moves that could end the battle.
	  "SwitchOutTargetDamagingMove",                       # Do not call on moves that could end the battle.
	  "UserFaintsExplosive",                               # Do not call on moves that could KO yourself.
	  "UserFaintsLowerTargetAtkSpAtk2",                    # Do not call on moves that could KO yourself.
	  "UseMoveDependingOnEnvironment",                     # Do not call on moves that allow you to use ATMDOP
	  "UseMoveDependingOnEnvironmentThmn",                 # Do not call on moves that allow you to use ATMDOP
	  "AttackAndSkipNextTurn",                             # Do not call on moves that make you skip a turn.
	  "UserTargetSwapItems",                               # Do not call on moves that could swap items.
	  "ProhibitorySignboard",                              # Do not call on Prohobitory Signboard.
	  "WalpurgisNight",                                    # Do not call on Walpurgis Night.
	  "Lightspeed",                                        # Do not call on Lightspeed.
	  "CreepingMycelium",                                  # Do not call on Creeping Mycelium.
	  "UltimateDream",                                     # I mean this one goes without saying!
	  "MyriadDreams"                                       # Do not call on All The Myriad Dreams of Paradise.
    ]
  end
end