#DON'T DELETE THIS LINE
module DialogueModule


# Format to add new stuff here
# Name = data
#
# To set in a script command
# BattleScripting.setInScript("condition",:Name)
# The ":" is important

#  Joey_TurnStart0 = {"text"=>"Hello","bar"=>true}
#  BattleScripting.set("turnStart0",:Joey_TurnStart0)

                  
##############Custom#########################################################################################
##############General########################################################################################
  Init= Proc.new{|battle|
      battle.battlers[1].pbOwnSide.effects[PBEffects::BossProtect] = 99
	  pbMessage("The opponent is immune to status moves and stat drop.")
      }
      
  Midlife= Proc.new{|battle|
      battle.pbAnimation(getID(PBMoves,:HOWL),battle.battlers[1],battle.battlers[0])
      pbMessage(_INTL("{1} is starting to get mad!",battle.battlers[1].name))
      battle.battlers[0].pbResetStatStages
      battle.battlers[1].pbResetStatStages
      battle.battlers[1].pbRaiseStatStage(:ATTACK,1,battle.battlers[1])
      battle.battlers[1].pbRaiseStatStage(:SPECIAL_ATTACK,1,battle.battlers[1])
      }
  
  Quartlife=Proc.new{|battle|
      battle.pbAnimation(getID(PBMoves,:HOWL),battle.battlers[1],battle.battlers[0])
      pbMessage(_INTL("{1} is in pain!",battle.battlers[1].name))
      battle.battlers[0].pbResetStatStages
      battle.battlers[1].pbResetStatStages
      battle.battlers[1].pbRaiseStatStage(:ATTACK,2,battle.battlers[1])
      battle.battlers[1].pbRaiseStatStage(:SPECIAL_ATTACK,2,battle.battlers[1])
      battle.battlers[0].pbLowerStatStage(:SPECIAL_ATTACK,2,battle.battlers[0])
      battle.battlers[0].pbLowerStatStage(:ATTACK,2,battle.battlers[0])
      }

  Enrage=Proc.new{|battle|
      battle.pbAnimation(getID(PBMoves,:HOWL),battle.battlers[1],battle.battlers[0])
      pbMessage(_INTL("{1} rages!",battle.battlers[1].name))
      battle.battlers[0].pbResetStatStages
      battle.battlers[1].pbResetStatStages
      battle.battlers[1].pbRaiseStatStage(:SPECIAL_ATTACK,6,battle.battlers[1])
      battle.battlers[1].pbRaiseStatStage(:ATTACK,6,battle.battlers[1])
      battle.battlers[1].pbRaiseStatStage(:SPEED,6,battle.battlers[1])
      }

##############Test#######################
	Tinit=Proc.new{|battle|
		battle.battlers[1].effects[PBEffects::Midhp] = true
		}
	Tlow=Proc.new{|battle|
			battle.battlers[1].effects[PBEffects::Midhp] = false
			pbMessage("It's vulnerable!")
		}
	Tdamage=Proc.new{|battle|
		pbMessage("Bim!")
		battle.pbLowerHP(battle.battlers[0],4) 
		}
	Tsprite=Proc.new{|battle|
		TrainerDialogue.changeTrainerSprite("BEAUTY",battle.scene)
		battle.scene.pbShowOpponent(0,false)
		battle.pbCommonAnimation("StatUp",nil,nil)
		battle.pbAnimation(:BARRIER,battle.battlers[1],nil)
		battle.battlers[1].pbOwnSide.effects[PBEffects::BossProtect] = 99
	    pbMessage("The enemy team is cloaked in a mystical veil.")
		battle.pbStartTerrain(battle.battlers[1], :Electric)
		# Setting up Effects on your Side of Field
		battle.pbAnimation(:STEALTHROCK,battle.battlers[1],battle.battlers[0])
		battle.battlers[1].pbOpposingSide.effects[PBEffects::StealthRock]=true
		battle.scene.pbHideOpponent
		}
		
	Tevolve=Proc.new{|battle|
		battle.scene.disappearDatabox
		battle.scene.appearBar
		battle.battlers[1].species=:MAGIKARP
		battle.scene.pbRefresh
		battle.scene.disappearBar
		battle.scene.appearDatabox
		}
		
#------------------------------------------------------------------
# Vs. Dreadwyrm Bahamut, the Mega Charizard X
#------------------------------------------------------------------
	BahaIntro1	 	 = Proc.new{|battle|
						#battle.battlers[3].name = "Bahamut"
						#battle.scene.sprites["dataBox_1"].refresh
						pbMessage("\\se[]Bahamut and it's thralls descend onto the battlefield!\\wt[10]\nTheir power is overwhelming!")
						# --- Move Control ---
						bahamut = battle.battlers[3]
						pkmn_baha = bahamut.pokemon
						pkmn_baha.moves[0] = Pokemon::Move.new(:MEGAFLARE)   # Replaces current/total PP
						bahamut.moves[0] = Battle::Move.from_pokemon_move(battle, pkmn_baha.moves[0])
						pkmn_baha.moves[1] = Pokemon::Move.new(:FLAMEBREATH)   # Replaces current/total PP
						bahamut.moves[1] = Battle::Move.from_pokemon_move(battle, pkmn_baha.moves[0])
						pkmn_baha.moves[2] = Pokemon::Move.new(:FLATTEN)   # Replaces current/total PP
						bahamut.moves[2] = Battle::Move.from_pokemon_move(battle, pkmn_baha.moves[0])
						pkmn_baha.moves[3] = Pokemon::Move.new(:EARTHSHAKER)   # Replaces current/total PP
						bahamut.moves[3] = Battle::Move.from_pokemon_move(battle, pkmn_baha.moves[0])
						# --- Effects Set ---
						bahamut.effects[PBEffects::Highhp] = true
						bahamut.effects[PBEffects::Midhp] = true
						bahamut.effects[PBEffects::Lowhp] = true
						bahamut.pbOwnSide.effects[PBEffects::BossProtect] = 99 # Check and see if I can limit that to just Bahamut
					 }
					 
	BahaPhase1_1	= Proc.new{|battle|
						#$PokemonTemp.bahamut_75_percent_health = true
						pbBGMPlay("Answers - Segment 2.ogg")
						battle.battlers[3].effects[PBEffects::Protect] = true
						pbMessage("Bahamut put up a barrier that prevents further damage!")
						battle.pbAnimation(:IRONDEFENSE,battle.battlers[3],nil)
						# --- Changes form to one with Bahamut Guard as ability and ???/??? as its types. ---
						#battler = battle.battlers[3]
						#pkmn = battler.pokemon
						pkmn_baha.form = 2
					  }
					  
	#BahaPhase1_2	 = Proc.new{|battle|
	#						if $PokemonTemp.bahamut_75_percent_health == true && $PokemonTemp.bahamut_75_percent_gflare == false
	#						  if (battler 1 and battler 5) hp > 0
	#							pbMessage("Bahamut dismisses its thralls!")
	#							battler 1 and battler 5 disappear at this point
	#						  end
	#						  pbMessage("Bahamut unleashes Gigaflare")
	#						  battle.battlers[3].pbUseMoveSimple(PBMoves::GIGAFLARE,0,-1,true)
	#						  $PokemonTemp.bahamut_75_percent_health = false
	#						  $PokemonTemp.bahamut_75_percent_gflare = true
	#						  # Return Bahamut's ability to normal.
	#						  # Return Bahamut's type to Dragon/Fire
	#						end
	#					 }
	
	#BahaSetup2		= Proc.new{|battle|
	#					battle.battlers[1].moves[0] = PokeBattle_Move.pbFromPBMove(battle,PBMove.new(getConst(PBMoves,:MEGAFLARE)))
	#					battle.battlers[1].moves[1] = PokeBattle_Move.pbFromPBMove(battle,PBMove.new(getConst(PBMoves,:FLAMEBREATH)))
	#					battle.battlers[1].moves[2] = PokeBattle_Move.pbFromPBMove(battle,PBMove.new(getConst(PBMoves,:FLARESTAR)))
	#					battle.battlers[1].moves[3] = PokeBattle_Move.pbFromPBMove(battle,PBMove.new(getConst(PBMoves,:DRAGONSWRATH)))
	#				 }
	
	#BahaP2_Adds	= Proc.new{|battle|
	#					(Spawn [Species 1] here)
	#					(Spawn [Species 2] here)
	#					pbMessage("Bahamut's thralls join in the fight!")
	#				}

	#Baha50pHP		 = Proc.new{|battle|
	#					$PokemonTemp.bahamut_50_percent_health = true
	#					battle.battlers[1].effects[PBEffects::Protect] = true
	#					pbMessage("Bahamut put up a barrier that prevents further damage!")
	#					# Change ability to a clone of Wonder Guard
	#					# Change Bahamut's type combination to ???/??? to prevent it from having weaknesses
	#					battle.pbAnimation(getID(PBMoves,:BARRIER),battle.battlers[1],nil)
	#				  }

	#Baha50pHP_GFlare	= Proc.new{|battle|
	#						if $PokemonTemp.bahamut_50_percent_health == true && $PokemonTemp.bahamut_50_percent_gflare == false
	#						  battle.battlers[1].pbUseMoveSimple(PBMoves::GIGAFLARE,0,-1,true)
	#						  (Make a Gigaflare go off here)
	#						  $PokemonTemp.bahamut_50_percent_health = false
	#						  $PokemonTemp.bahamut_50_percent_gflare = true
	#						  # Return Bahamut's ability to normal.
	#						end
	#					 } 
	
	#Baha50pHP_DiveSet	= Proc.new{|battle|
	#						# Make Bahamut fly into the air and become untargetable here.
	#						pbMessage("Bahamut soars into the air and becomes untargetable")
	#					}
	
	#Baha50pHP_Dive		= Proc.new{|battle|
	#						# Handle Flaredive here
	#						pbMessage("Bahamut swoops down with a Flaredive!")
	#						battle.battlers[1].pbUseMoveSimple(PBMoves::FLAREDIVE,0,-1,true)
	#						# Has a counter that checks for whether or not reinforcement sets have been defeated
	#						# Start at 3; when at 3, Dive hits. Counter resets to 0 after each hit.
	#						# Defeating a set bumps the counter up by 1
	#					}
	
	#Baha50pHP_Reinf	= Proc.new{|battle|
	#						# Handle reinforcement set here.
	#						# Spawns reinforcements based on counter. (Different from Flaredrive clounter)
	#					}
	
	#Baha50pHP_Buff		= Proc.new{|battle|
	#						# Check the counter above for the buff to give to the player.
	#						# 3 waves - Def/SDef
	#						# 6 waves - Atk/SAtk
	#						# 7 waves - Speed
	#						# Can possibly be merged into the section above.
	#					}
	
	#Baha50pHP_Charge	= Proc.new{|battle|
	#						# Once wave 7 is cleared, have Bahamut return to the field.
	#						pbBGMPlay("Answers - Segment 3.ogg")
	#						# Bahamut casts protect around itself (Dummy ability.)
	#						# Increment a counter here that, when it hits 3, Teraflare gets cast.
	#					}
	
	#Baha50pHP_TFlare	=Proc.new{|battle|
	#						if (TFlare counter) == 3
	#						  pbMessage("Bahamut unleashes Teraflare")
	#						  battle.battlers[1].pbUseMoveSimple(PBMoves::TERAFLARE,0,-1,true)
	#						  # Return Bahamut's ability to normal (Or give it a new ability).
	#						  pbMessage("Bahamut sets the battlefield ablaze!")
	#						  # change the battle background at this point.
	#						end
	#					 }

	#BahaSetup3		= Proc.new{|battle|
	#					battle.battlers[1].moves[0] = PokeBattle_Move.pbFromPBMove(battle,PBMove.new(getConst(PBMoves,:GIGAFLARE)))
	#					battle.battlers[1].moves[1] = PokeBattle_Move.pbFromPBMove(battle,PBMove.new(getConst(PBMoves,:FLAMEBREATH)))
	#					battle.battlers[1].moves[2] = PokeBattle_Move.pbFromPBMove(battle,PBMove.new(getConst(PBMoves,:TWISTER2)))
	#					battle.battlers[1].moves[3] = PokeBattle_Move.pbFromPBMove(battle,PBMove.new(getConst(PBMoves,:EARTHSHAKER)))
	#				 }	
	
	#Baha_AkhMorn	= Proc.new{|battle|
	#					pbMessage("Bahamut unleashes Akh Morn") 
	#			  	    (Change Bahamut's ability to Skill Link)
	#					battle.battlers[1].pbUseMoveSimple(PBMoves::AKHMORN,0,-1,true)
	#					(Return Bahamut's ability to normal)
	#				}
	
	#Baha10pHP_Charge	= Proc.new{|battle|
	#						# Remove all of Bahamut's moves/Put it in a state where it can't attack
	#						# Set up a 5 turn counter until Enrage Teraflare
	#					}
	
	#Baha10pHP_Enrage	= Proc.new{|battle|
	#						# Have the counter check for if 5 turns have passed.
	#						pbMessage("Bahamut unleashes Teraflare")
	#						battle.battlers[1].pbUseMoveSimple(PBMoves::TERAFLARE_alt,0,-1,true)
	#						# If so, run an unavoidable, fatal Teraflare.
	#						pbMessage("All active battlers took fatal damage!")
	
	#BahaDefeat_1		= Proc.new{|battle|
	#						# Play an animation for Bahamut being defeated.
	#						pbMessage("Bahamut was defeated!")
	#						# Once defeated, give the player the item for beating Bahamut
	#					}
					 

# DONT DELETE THIS END
end