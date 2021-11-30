#==============================================================================#
#\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\#
#==============================================================================#
#                                                                              #
#                          Mid Battle Dialogue and Script                      #
#                                       v1.5                                   #
#                                 By Golisopod User                            #
#                                                                              #
#==============================================================================#
#\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\#
#==============================================================================#
#                                                                              #
# This is the dialogue portion of the script. If for some reason the script    #
# window is too small for you, you can input the dialogue data over here and   #
# call it when needed in Battle. This will keep your events much cleaner.      #
#                                                                              #
# THIS IS ONLY AN OPTIONAL WAY OF INPUTTING BATTLE DIALOGUE,IT'S NOT NECESSARY #
#==============================================================================#

class PokemonTemp
  attr_accessor :bahamut_75_percent_health
  attr_accessor :bahamut_75_percent_gflare
  
  def bahamut_75_percent_health
    @bahamut_75_percent_health = false if !@bahamut_75_percent_health
    return @bahamut_75_percent_health
  end
  
  def bahamut_75_percent_gflare
    @bahamut_75_percent_gflare = false if !@bahamut_75_percent_gflare
    return @bahamut_75_percent_gflare
  end
end

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



  # This is an example of Scene Manipulation where I manipulate the color tone of each individual graphic in the scene to simulate a ""fade to black"
  FRLG_Turn0 = Proc.new{|battle|
                for i in 0...8
                  val = 25+(25*i)
                  battle.scene.sprites["battle_bg"].color=Color.new(-255,-255,-255,val)
                  battle.scene.sprites["base_0"].color=Color.new(-255,-255,-255,val)
                  battle.scene.sprites["base_1"].color=Color.new(-255,-255,-255,val)
                  battle.scene.sprites["dataBox_1"].color=Color.new(-255,-255,-255,val)
                  battle.scene.sprites["dataBox_0"].color=Color.new(-255,-255,-255,val)
                  battle.scene.sprites["pokemon_0"].color=Color.new(-255,-255,-255,val)
                  battle.scene.sprites["pokemon_1"].color=Color.new(-255,-255,-255,val)
                  pbWait(1)
                end
                pbMessage("\\bOh, for Pete's sake...\\nSo pushy, as always.")
                pbMessage("\\b\\PN,\\nYou've never had a Pokémon Battle before, have you?")
                pbMessage("\\bA Pokémon battle is when Trainer's pit their Pokémon against each other.")
                for i in 0...8
                  val = 200 - (25+(25*i))
                  battle.scene.sprites["dataBox_1"].color=Color.new(-255,-255,-255,val)
                  pbWait(1)
                end
                pbMessage("\\bThe Trainer that makes the other Trainer's Pokémon faint by lowering their HP to 0, wins.")
                for i in 0...8
                  val = 25+(25*i)
                  battle.scene.sprites["dataBox_1"].color=Color.new(-255,-255,-255,val)
                  pbWait(1)
                end
                pbMessage("\\bBut rather than talking about it, you'll learn more from experience.")
                pbMessage("\\bTry battling and see for yourself.")
                for i in 0...8
                  val = 200-(25+(25*i))
                  battle.scene.sprites["battle_bg"].color=Color.new(-255,-255,-255,val)
                  battle.scene.sprites["base_0"].color=Color.new(-255,-255,-255,val)
                  battle.scene.sprites["base_1"].color=Color.new(-255,-255,-255,val)
                  battle.scene.sprites["dataBox_1"].color=Color.new(-255,-255,-255,val)
                  battle.scene.sprites["dataBox_0"].color=Color.new(-255,-255,-255,val)
                  battle.scene.sprites["pokemon_0"].color=Color.new(-255,-255,-255,val)
                  battle.scene.sprites["pokemon_1"].color=Color.new(-255,-255,-255,val)
                  pbWait(1)
                end
              }

  FRLG_Damage = Proc.new{|battle|
                  for i in 0...8
                    val = 25+(25*i)
                    battle.scene.sprites["battle_bg"].color=Color.new(-255,-255,-255,val)
                    battle.scene.sprites["base_0"].color=Color.new(-255,-255,-255,val)
                    battle.scene.sprites["base_1"].color=Color.new(-255,-255,-255,val)
                    battle.scene.sprites["dataBox_1"].color=Color.new(-255,-255,-255,val)
                    battle.scene.sprites["dataBox_0"].color=Color.new(-255,-255,-255,val)
                    battle.scene.sprites["pokemon_0"].color=Color.new(-255,-255,-255,val)
                    battle.scene.sprites["pokemon_1"].color=Color.new(-255,-255,-255,val)
                    pbWait(1)
                  end
                  pbMessage("\\bInflicting damage on the foe is the key to winning a battle")
                  for i in 0...8
                    val = 200-(25+(25*i))
                    battle.scene.sprites["battle_bg"].color=Color.new(-255,-255,-255,val)
                    battle.scene.sprites["base_0"].color=Color.new(-255,-255,-255,val)
                    battle.scene.sprites["base_1"].color=Color.new(-255,-255,-255,val)
                    battle.scene.sprites["dataBox_1"].color=Color.new(-255,-255,-255,val)
                    battle.scene.sprites["dataBox_0"].color=Color.new(-255,-255,-255,val)
                    battle.scene.sprites["pokemon_0"].color=Color.new(-255,-255,-255,val)
                    battle.scene.sprites["pokemon_1"].color=Color.new(-255,-255,-255,val)
                    pbWait(1)
                  end
                }

  FRLG_End = Proc.new{|battle|
              battle.scene.pbShowOpponent(0)
              pbMessage("WHAT!\\nUnbelievable!\\nI picked the wrong Pokémon!")
              for i in 0...8
                val = 25+(25*i)
                battle.scene.sprites["trainer_1"].color=Color.new(-255,-255,-255,val)
                battle.scene.sprites["battle_bg"].color=Color.new(-255,-255,-255,val)
                battle.scene.sprites["base_0"].color=Color.new(-255,-255,-255,val)
                battle.scene.sprites["base_1"].color=Color.new(-255,-255,-255,val)
                battle.scene.sprites["dataBox_1"].color=Color.new(-255,-255,-255,val)
                battle.scene.sprites["dataBox_0"].color=Color.new(-255,-255,-255,val)
                battle.scene.sprites["pokemon_0"].color=Color.new(-255,-255,-255,val)
                battle.scene.sprites["pokemon_1"].color=Color.new(-255,-255,-255,val)
                pbWait(1)
              end
              pbMessage("\\bHm! Excellent!")
              pbMessage("\\bIf you win, you will earn prize money and your Pokémon will grow.")
              pbMessage("\\bBattle other Trainers and make your Pokémon strong!")
              for i in 0...8
                val = 200-(25+(25*i));battle.scene.sprites["trainer_1"].color=Color.new(-255,-255,-255,val);
                battle.scene.sprites["battle_bg"].color=Color.new(-255,-255,-255,val)
                battle.scene.sprites["base_0"].color=Color.new(-255,-255,-255,val)
                battle.scene.sprites["base_1"].color=Color.new(-255,-255,-255,val)
                battle.scene.sprites["dataBox_1"].color=Color.new(-255,-255,-255,val)
                battle.scene.sprites["dataBox_0"].color=Color.new(-255,-255,-255,val)
                battle.scene.sprites["pokemon_0"].color=Color.new(-255,-255,-255,val)
                battle.scene.sprites["pokemon_1"].color=Color.new(-255,-255,-255,val)
                pbWait(1)
              end
            }

  Catching_Start = {"text"=>["This is the 1st time you're catching Pokemon right Red?", "Well let me tell you it's surprisingly easy!","1st weaken the Pokemon",
                    "Healthy Pokemon are much harder to catch"],"opp"=>"trainer024"}

  Catching_Catch = Proc.new{|battle|
                      BattleScripting.set("turnStart#{battle.turnCount+1}",Proc.new{|battle|
                        battle.scene.pbShowOpponent(0)
                        # Checking for Status to display different dialogue
                        if battle.battlers[1].pbHasAnyStatus?
                          pbMessage("Nice strategy! Inflicting a status condiition on the Pokémon further increases your chance at catching it.")
                          pbMessage("Now is the perfect time to throw a PokeBall!")
                        else
                          pbMessage("Great work! You're a natural!")
                          pbMessage("Now is the perfect time to throw a PokeBall!")
                        end
                        ball=0
                        battle.scene.pbHideOpponent
                        # Forcefully Opening the Bag and Throwing the Pokevall
                        pbFadeOutIn(99999){
                          scene = PokemonBag_Scene.new
                          screen = PokemonBagScreen.new(scene,$PokemonBag)
                          while ball==0
                            ball = screen.pbChooseItemScreen(Proc.new{|item| pbIsPokeBall?(item) })
                            if pbIsPokeBall?(ball)
                              break
                            end
                          end
                        }
                        battle.pbThrowPokeBall(1,ball,300,false)
                      })
                   }
# My Goal here was to have the message appear on the end of the turn after Opal sends out her Pokemon
   Opal_Send1 = Proc.new{|battle|
                  BattleScripting.set("turnEnd#{battle.turnCount}",Proc.new{|battle|
                    battle.scene.appearBar
                    battle.scene.pbShowOpponent(0)
                    pbMessage("Question!")
                    # Choice Box Stuff
                    cmd=0
                    cmd= pbMessage("You...\\nDo you know my nickname?",["The Magic-User","The wizard"],0,nil,0)
                    if cmd == 1
                      pbMessage("\\se[SwShCorrect]Ding ding ding! Congratulations, you are correct!")
                      battle.scene.pbHideOpponent
                      battle.scene.disappearBar
                      battle.battlers[0].pbRaiseStatStage(PBStats::SPEED,1,battle.battlers[0])
                    else
                      pbMessage("\\se[SwShIncorrect]Bzzzzt! Too bad!")
                      battle.scene.pbHideOpponent
                      battle.scene.disappearBar
                      battle.battlers[0].pbLowerStatStage(PBStats::SPEED,1,battle.battlers[0])
                    end
                  })
                }

   Opal_Send2 = Proc.new{|battle|
                  BattleScripting.set("turnEnd#{battle.turnCount+1}",Proc.new{|battle|
                    battle.scene.appearBar
                    battle.scene.pbShowOpponent(0)
                    pbMessage("Question!")
                    cmd=0
                    cmd= pbMessage("What is my favorite color?",["Pink","Purple"],0,nil,0)
                    if cmd == 1
                      pbMessage("\\se[SwShCorrect]Yes, a nice, deep purple... Truly grand, don't you think?")
                      battle.scene.pbHideOpponent
                      battle.scene.disappearBar
                      battle.battlers[0].pbRaiseStatStage(PBStats::DEFENSE,1,battle.battlers[0])
                      battle.battlers[0].pbRaiseStatStage(PBStats::SPDEF,1,battle.battlers[0])
                    else
                      pbMessage("\\se[SwShIncorrect]That's what I like to see in other people, but it's not what I like for myself.")
                      battle.scene.pbHideOpponent
                      battle.scene.disappearBar
                      battle.battlers[0].pbLowerStatStage(PBStats::DEFENSE,1,battle.battlers[0])
                      battle.battlers[0].pbLowerStatStage(PBStats::SPDEF,1,battle.battlers[0])
                    end
                  })
                }

   Opal_Send3 = Proc.new{|battle|
                  BattleScripting.set("turnEnd#{battle.turnCount+1}",Proc.new{|battle|
                    battle.scene.appearBar
                    battle.scene.pbShowOpponent(0)
                    pbMessage("Question!")
                    cmd=0
                    cmd= pbMessage("All righty then... How old am I?",["16 years old","88 years old"],1,nil,1)
                    if cmd == 0
                      pbMessage("\\se[SwShCorrect]Hah! I like your answer!")
                      battle.scene.pbHideOpponent
                      battle.scene.disappearBar
                      battle.battlers[0].pbRaiseStatStage(PBStats::ATTACK,1,battle.battlers[0])
                      battle.battlers[0].pbRaiseStatStage(PBStats::SPATK,1,battle.battlers[0])
                    else
                      pbMessage("\\se[SwShIncorrect]Well, you're not wrong. But you could've been a little more sensitive.")
                      battle.scene.pbHideOpponent
                      battle.scene.disappearBar(battle)
                      battle.battlers[0].pbLowerStatStage(PBStats::ATTACK,1,battle.battlers[0])
                      battle.battlers[0].pbLowerStatStage(PBStats::SPATK,1,battle.battlers[0])
                    end
                  })
                }

   Opal_Last = Proc.new{|battle|
                 battle.scene.appearBar
                 battle.scene.pbShowOpponent(0)
                 TrainerDialogue.changeTrainerSprite("BerthaPlatinum_2",battle.scene)
                 pbMessage("My morning tea is finally kicking in...")
                 TrainerDialogue.changeTrainerSprite("trainer069",battle.scene)
                 pbWait(5)
                 pbMessage("\\xl[Opal]and not a moment too soon!")
                 battle.scene.pbHideOpponent
                 battle.scene.disappearBar
              }

   Opal_Mega = Proc.new{|battle|
                battle.scene.appearBar
                battle.scene.pbShowOpponent(0)
                TrainerDialogue.changeTrainerSprite(["BerthaPlatinum_2"],battle.scene)
                pbMessage("Are you prepared?")
                pbSEPlay("SwShImpact")
                TrainerDialogue.changeTrainerSprite(["BerthaPlatinum_2","trainer069","BerthaPlatinum"],battle.scene,2)
                pbWait(5)
                pbMessage("I'm going to have some fun with this!")
                battle.scene.pbHideOpponent
                TrainerDialogue.changeTrainerSprite(["trainer069"],battle.scene)
                battle.scene.disappearBar
              }

   Opal_LastAttack = Proc.new{|battle|
                      battle.scene.appearBar
                      battle.scene.pbShowOpponent(0)
                      TrainerDialogue.changeTrainerSprite(["BerthaPlatinum_2"],battle.scene)
                      pbMessage("You lack pink! Here, let us give you some.")
                      pbSEPlay("SwShImpact")
                      TrainerDialogue.changeTrainerSprite(["BerthaPlatinum_2","trainer069","BerthaPlatinum"],battle.scene,2)
                      pbWait(16)
                      battle.scene.pbHideOpponent
                      TrainerDialogue.changeTrainerSprite(["trainer069"],battle.scene)
                      battle.scene.disappearBar
                    }

   Brock_LastPlayer = Proc.new{|battle|
                      # Displaying Differen Dialogue if the Pokemon is a Pikachu
                        if battle.battlers[0].isSpecies?(:PIKACHU)
                          battle.scene.pbShowOpponent(0)
                          battle.scene.disappearDatabox
                          pbMessage("It's that Pikachu again.")
                          pbMessage("I honestly feel sorry for it.")
                          pbMessage("Being raised by such a weak and incapable Pokémon Trainer.")
                          pbMessage("Let's show him how weak we are Pikachu.")
                      # Setting the Geodude's typing to Water to allow Pikachu to hit it super Effectively
                          battle.battlers[1].pbChangeTypes(getConst(PBTypes,:WATER))
                          battle.scene.pbHideOpponent
                          battle.scene.appearDatabox
                        elsif battle.battlers[0].isSpecies?(:PIDGEOTTO)
                      # Setting the Geodude's typing to Grass to allow Pidgeotto to hit it super Effectively
                          battle.battlers[1].pbChangeTypes(getConst(PBTypes,:GRASS))
                          battle.battlers[1].pbChangeTypes(getConst(PBTypes,:BUG))
                        end
                      # Using the Laser Focus and Endure Effects to force a Ctitical Hit and make sure that the Player's Pokemon Endures the next hit.
                        battle.battlers[0].effects[PBEffects::LaserFocus] = 2
                        battle.battlers[0].effects[PBEffects::Endure] = true
                      }
   Brock_MockPlayer = Proc.new{|battle|
                        battle.scene.pbShowOpponent(0)
                        battle.scene.disappearDatabox
                        # If the Player starts with a Pidgeotto then show this dialogue, else the other one
                        if battle.battlers[0].pbHasType?(:FLYING)
                          pbMessage("Hmph. Bad Strategy.")
                          pbMessage("Don't you know Flying Types are weak against Rock type.")
                          pbMessage("Ummm... I guess I forgot about that.")
                          pbMessage("C'mon \\PN, use your head.")
                        else
                          pbMessage("Look's like you haven't trained a bit since last time \\PN.")
                          pbMessage("I'm gonna make you eat those words Brock!")
                        end
                        battle.scene.pbHideOpponent
                        battle.scene.appearDatabox
                      }

   Brock_GiveUp = Proc.new{|battle|
                    battle.scene.pbShowOpponent(0)
                    battle.scene.disappearDatabox
                    pbMessage("Are you giving up already, \\PN?")
                    # Forcefully Setting the Fainted Condition to be done so that it doesn't show up later.
                    TrainerDialogue.setDone("fainted")
                    battle.scene.pbHideOpponent
                    battle.scene.appearDatabox
                  }

   Brock_Sprinklers = Proc.new{|battle|
                      # Immedialtely the Next Turn after the Player's HP is less than half, do this
                        BattleScripting.set("turnStart#{battle.turnCount+1}",Proc.new{|battle|
                          battle.pbAnimation(getID(PBMoves,:BIND),battle.battlers[1],battle.battlers[0])
                          battle.pbCommonAnimation("Bind",battle.battlers[0],nil)
                          battle.scene.disappearDatabox
                          battle.pbDisplay(_INTL("Onix constricted its tail around {1}!",battle.battlers[0].pbThis(true)))
                          battle.scene.pbDamageAnimation(battle.battlers[0])
                          battle.pbDisplay(_INTL("{1} struggles to escape Onix' grasp!",battle.battlers[0].pbThis))
                          battle.scene.pbDamageAnimation(battle.battlers[0])
                          pbMessage(_INTL("{1} hang on a little longer!",battle.battlers[0].name))
                          pbMessage("...")
                          pbBGMFade(2)
                          battle.scene.pbShowOpponent(0)
                          pbMessage("Onix stop!")
                          pbMessage("No Brock, I want to play this match till the end.")
                          pbMessage("There's no point in going on, besides, I don't want to hurt your Pokémon more.")
                          pbMessage("Hrgh..")
                          battle.scene.pbHideOpponent
                          pbMessage("...")
                          battle.pbCommonAnimation("Rain",nil,nil)
                          battle.pbDisplay("The sprinklers turned on!")
                          pbPlayCrySpecies(:ONIX,0,70,70)
                          battle.pbDisplay("Onix became soaking wet!")
                          pbBGMPlay("BrockWin")
                          battle.scene.pbShowOpponent(0)
                          battle.scene.disappearDatabox
                          pbMessage("\\PN! Rock Pokemon are weakened by water!")
                          battle.battlers[0].effects[PBEffects::LaserFocus] = 2
                          battle.battlers[1].effects[PBEffects::Endure] = true
                          if battle.battlers[0].isSpecies?(:PIKACHU)
                            # Setting the Geodude's typing to Water to allow Pikachu to hit it super Effectively
                            battle.battlers[1].pbChangeTypes(getConst(PBTypes,:WATER))
                          elsif battle.battlers[0].isSpecies?(:PIDGEOTTO)
                            # Setting the Geodude's typing to Grass to allow Pidgeotto to hit it super Effectively
                            battle.battlers[1].pbChangeTypes(getConst(PBTypes,:GRASS))
                            battle.battlers[1].pbChangeTypes(getConst(PBTypes,:BUG))
                          end
                          pbMessage(_INTL("{1}! Let's get 'em!",battle.battlers[0].pbThis(true)))
                          battle.battlers[1].effects[PBEffects::Flinch]=1
                          battle.scene.appearDatabox
                        })
                      }

   Brock_Forfeit = Proc.new{|battle|
                    battle.scene.disappearDatabox
                    pbMessage(_INTL("Okay {1}! Lets finish him off with a...",battle.battlers[0].name))
                    pbBGMFade(2)
                    pbWait(10)
                    pbBGMPlay("BrockGood")
                    pbMessage("My consience is holding me back!")
                    pbMessage("I can't bring myself to beat Brock!")
                    pbMessage("I'm imagining his little brothers and sisters stopping me from defeating the one person they love!")
                    pbMessage("\\PN, I think you better open your eyes.")
                    pbMessage("Huh!")
                    pbMessage("Stop hurting our brother you big bully!")
                    pbMessage("Believe me kid! I'm no bully.")
                    battle.scene.pbShowOpponent(0)
                    pbMessage("Stop it! Get off, all of you.")
                    pbMessage("This is an official match, and we're gonna finish this no matter what.")
                    pbMessage("But Brock, we know you love you Pokémon so much!")
                    pbMessage("That's why we can't watch Onix suffer from another attack!")
                    pbMessage("...")
                    pbMessage("...")
                    pbMessage(_INTL("{1}! Return!",battle.battlers[0].name))
                    battle.scene.pbRecall(0)
                    pbMessage("What do you think you're doing! This match isn't over yet \\PN.")
                    pbMessage("Those sprinklers going off was an accident. Winning a match because of that wouldn't have proven anything.")
                    pbMessage("Next time we meet, I'll beat you my way, fair and square!")
                    battle.scene.pbHideOpponent
                    battle.pbDisplay("You forfeited the match...")
                    battle.decision=3
                    pbMessage("Hmph! Just when he finally gets a lucky break. He decides to be a nice guy too.")
                  }
# Derx: PokeFantasy XIV content here.
	# --- Scene: Warrior of Light Vs. "Bahamut", the Mega Charizard X
	BahaIntro1	 	 = Proc.new{|battle|
						#battle.battlers[3].name = "Bahamut"
						#battle.scene.sprites["dataBox_1"].refresh
						pbMessage("\\se[]Bahamut and it's thralls descend onto the battlefield!\\wt[10]\nTheir power is overwhelming!")
						battle.battlers[3].moves[0] = PokeBattle_Move.pbFromPBMove(battle,PBMove.new(getConst(PBMoves,:MEGAFLARE)))
						battle.battlers[3].moves[1] = PokeBattle_Move.pbFromPBMove(battle,PBMove.new(getConst(PBMoves,:FLAMEBREATH)))
						battle.battlers[3].moves[2] = PokeBattle_Move.pbFromPBMove(battle,PBMove.new(getConst(PBMoves,:FLATTEN)))
						battle.battlers[3].moves[3] = PokeBattle_Move.pbFromPBMove(battle,PBMove.new(getConst(PBMoves,:EARTHSHAKER)))						
					 }
					 
	Baha75pHP		 = Proc.new{|battle|
						$PokemonTemp.bahamut_75_percent_health = true
						pbBGMPlay("Answers - Segment 2.ogg")
						battle.battlers[3].effects[PBEffects::Protect] = true
						pbMessage("Bahamut put up a barrier that prevents further damage!")
						# Change ability to a clone of Wonder Guard
						# Change Bahamut's type combination to ???/??? to prevent it from having weaknesses
						battle.pbAnimation(getID(PBMoves,:BARRIER),battle.battlers[3],nil)
					  }
					 	
	#Baha75pHP_GFlare	 = Proc.new{|battle|
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