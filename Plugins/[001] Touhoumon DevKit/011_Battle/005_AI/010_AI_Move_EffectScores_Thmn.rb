#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Editing various function codes to account for Touhoumon moves/abilities
#
# This section is slated for extreme cleanup and analysis
#==============================================================================#
class Battle::AI
  alias __ThmnAI__pbGetMoveScoreFunctionCode pbGetMoveScoreFunctionCode
  def pbGetMoveScoreFunctionCode(score,move,user,target,skill=100)
    case move.function
    #---------------------------------------------------------------------------
    when "SleepTarget", "SleepTargetChangeUserMeloettaForm"
      if target.pbCanSleep?(user, false)
        score += 30
        if skill >= PBTrainerAI.mediumSkill
          score -= 30 if target.effects[PBEffects::Yawn] > 0
        end
        if skill >= PBTrainerAI.highSkill
          score -= 30 if target.hasActiveAbility?(:MARVELSCALE)
		  score -= 30 if target.hasActiveAbility?(:SPRINGCHARM)
        end
        if skill >= PBTrainerAI.bestSkill
          if target.pbHasMoveFunction?("FlinchTargetFailsIfUserNotAsleep",
                                       "UseRandomUserMoveIfAsleep")   # Snore, Sleep Talk
            score -= 50
          end
        end
      elsif skill >= PBTrainerAI.mediumSkill
        score -= 90 if move.statusMove?
      end
    #---------------------------------------------------------------------------
    when "SleepTargetNextTurn"
      if target.effects[PBEffects::Yawn] > 0 || !target.pbCanSleep?(user, false)
        score -= 90 if skill >= PBTrainerAI.mediumSkill
      else
        score += 30
        if skill >= PBTrainerAI.highSkill
          score -= 30 if target.hasActiveAbility?(:MARVELSCALE)
		  score -= 30 if target.hasActiveAbility?(:SPRINGCHARM)
        end
        if skill >= PBTrainerAI.bestSkill
          if target.pbHasMoveFunction?("FlinchTargetFailsIfUserNotAsleep",
                                       "UseRandomUserMoveIfAsleep")   # Snore, Sleep Talk
            score -= 50
          end
        end
      end
	#---------------------------------------------------------------------------
    when "PoisonTarget", "BadPoisonTarget", "HitTwoTimesPoisonTarget"
      if target.pbCanPoison?(user, false)
        score += 30
        if skill >= PBTrainerAI.mediumSkill
          score += 30 if target.hp <= target.totalhp / 4
          score += 50 if target.hp <= target.totalhp / 8
          score -= 40 if target.effects[PBEffects::Yawn] > 0
        end
        if skill >= PBTrainerAI.highSkill
          score += 10 if pbRoughStat(target, :DEFENSE, skill) > 100
          score += 10 if pbRoughStat(target, :SPECIAL_DEFENSE, skill) > 100
          score -= 40 if target.hasActiveAbility?([:GUTS, :MARVELSCALE, :TOXICBOOST, :SPRINGCHARM])
        end
      elsif skill >= PBTrainerAI.mediumSkill
        score -= 90 if move.statusMove?
      end
	#---------------------------------------------------------------------------
    when "ParalyzeTarget", "ParalyzeTargetIfNotTypeImmune",
         "ParalyzeTargetTrampleMinimize", "ParalyzeTargetAlwaysHitsInRainHitsTargetInSky",
         "ParalyzeFlinchTarget", "TwoTurnAttackParalyzeTarget"
      if target.pbCanParalyze?(user, false) &&
         !(skill >= PBTrainerAI.mediumSkill &&
         move.id == :THUNDERWAVE &&
         Effectiveness.ineffective?(pbCalcTypeMod(move.type, user, target)))
        score += 30
        if skill >= PBTrainerAI.mediumSkill
          aspeed = pbRoughStat(user, :SPEED, skill)
          ospeed = pbRoughStat(target, :SPEED, skill)
          if aspeed < ospeed
            score += 30
          elsif aspeed > ospeed
            score -= 40
          end
        end
        if skill >= PBTrainerAI.highSkill
          score -= 40 if target.hasActiveAbility?([:GUTS, :MARVELSCALE, :QUICKFEET, :SPRINGCHARM])
        end
      elsif skill >= PBTrainerAI.mediumSkill
        score -= 90 if move.statusMove?
      end
    #---------------------------------------------------------------------------
    when "BurnTarget", "BurnFlinchTarget", "TwoTurnAttackBurnTarget"
      if target.pbCanBurn?(user, false)
        score += 30
        if skill >= PBTrainerAI.highSkill
          score -= 40 if target.hasActiveAbility?([:GUTS, :MARVELSCALE, :QUICKFEET, :FLAREBOOST, :SPRINGCHARM])
        end
      elsif skill >= PBTrainerAI.mediumSkill
        score -= 90 if move.statusMove?
      end
    #---------------------------------------------------------------------------
    when "FreezeTarget", "FreezeTargetAlwaysHitsInHail", "FreezeFlinchTarget"
      if target.pbCanFreeze?(user, false)
        score += 30
        if skill >= PBTrainerAI.highSkill
          score -= 20 if target.hasActiveAbility?(:MARVELSCALE)
		  score -= 20 if target.hasActiveAbility?(:SPRINGCHARM)
        end
      elsif skill >= PBTrainerAI.mediumSkill
        score -= 90 if move.statusMove?
      end
    #---------------------------------------------------------------------------
    when "AttractTarget"
      canattract = true
      agender = user.gender
      ogender = target.gender
      if (agender==2 || ogender==2 || agender==ogender) && !user.hasActiveAbility?(:DIVA)
        score -= 90
        canattract = false
      elsif target.effects[PBEffects::Attract] >= 0
        score -= 80
        canattract = false
      elsif skill >= PBTrainerAI.bestSkill && target.hasActiveAbility?(:OBLIVIOUS)
        score -= 80
        canattract = false
      end
      if skill >= PBTrainerAI.highSkill
        if canattract && target.hasActiveItem?(:DESTINYKNOT) &&
           user.pbCanAttract?(target, false)
          score -= 30
        end
      end
    #---------------------------------------------------------------------------
    when "SetTargetAbilityToSimple"
      if target.effects[PBEffects::Substitute] > 0
        score -= 90
      elsif skill >= PBTrainerAI.mediumSkill
        if target.unstoppableAbility? || [:TRUANT, :SIMPLE, :FRETFUL].include?(target.ability)
          score -= 90
        end
      end
    #---------------------------------------------------------------------------
    when "SetTargetAbilityToInsomnia"
      if target.effects[PBEffects::Substitute] > 0
        score -= 90
      elsif skill >= PBTrainerAI.mediumSkill
        if target.unstoppableAbility? || [:TRUANT, :INSOMNIA, :FRETFUL].include?(target.ability_id)
          score -= 90
        end
      end
    #---------------------------------------------------------------------------
    when "SetUserAbilityToTargetAbility"
      score -= 40   # don't prefer this move
      if skill >= PBTrainerAI.mediumSkill
        if !target.ability || user.ability == target.ability ||
           [:MULTITYPE, :RKSSYSTEM].include?(user.ability_id) ||
           [:FLOWERGIFT, :FORECAST, :ILLUSION, :IMPOSTER, :MULTITYPE, :RKSSYSTEM,
            :TRACE, :WONDERGUARD, :ZENMODE, :PLAYGHOST].include?(target.ability_id)
          score -= 90
        end
      end
      if skill >= PBTrainerAI.highSkill
        if target.ability == :TRUANT && user.opposes?(target)
          score -= 90
        elsif target.ability == :SLOWSTART && user.opposes?(target)
          score -= 90
        elsif target.ability == :FRETFUL && user.opposes?(target)
          score -= 90
        end
      end
    #---------------------------------------------------------------------------
    when "SetTargetAbilityToUserAbility"
      score -= 40   # don't prefer this move
      if target.effects[PBEffects::Substitute] > 0
        score -= 90
      elsif skill >= PBTrainerAI.mediumSkill
        if !user.ability || user.ability == target.ability ||
           [:MULTITYPE, :RKSSYSTEM, :TRUANT].include?(target.ability_id) ||
           [:FLOWERGIFT, :FORECAST, :ILLUSION, :IMPOSTER, :MULTITYPE, :RKSSYSTEM,
            :TRACE, :ZENMODE, :FRETFUL].include?(user.ability_id)
          score -= 90
        end
        if skill >= PBTrainerAI.highSkill
          if user.ability == :TRUANT && user.opposes?(target)
            score += 90
          elsif user.ability == :SLOWSTART && user.opposes?(target)
            score += 90
          elsif user.ability == :FRETFUL && user.opposes?(target)
            score += 90
          end
        end
      end
    #---------------------------------------------------------------------------
    when "UserTargetSwapAbilities"
      score -= 40   # don't prefer this move
      if skill >= PBTrainerAI.mediumSkill
        if (!user.ability && !target.ability) ||
           user.ability == target.ability ||
           [:ILLUSION, :MULTITYPE, :RKSSYSTEM, :WONDERGUARD, :PLAYGHOST].include?(user.ability_id) ||
           [:ILLUSION, :MULTITYPE, :RKSSYSTEM, :WONDERGUARD, :PLAYGHOST].include?(target.ability_id)
          score -= 90
        end
      end
      if skill >= PBTrainerAI.highSkill
        if target.ability == :TRUANT && user.opposes?(target)
          score -= 90
        elsif target.ability == :SLOWSTART && user.opposes?(target)
          score -= 90
		elsif target.ability == :FRETFUL && user.opposes?(target)
          score -= 90
        end
      end
    #---------------------------------------------------------------------------
    when "NegateTargetAbility"
      if target.effects[PBEffects::Substitute] > 0 ||
         target.effects[PBEffects::GastroAcid]
        score -= 90
      elsif skill >= PBTrainerAI.highSkill
        score -= 90 if [:MULTITYPE, :RKSSYSTEM, :SLOWSTART, :TRUANT, :FRETFUL].include?(target.ability_id)
      end
    #---------------------------------------------------------------------------
    when "StartLeechSeedTarget"
      if target.effects[PBEffects::LeechSeed] >= 0
        score -= 90
      elsif skill >= PBTrainerAI.mediumSkill && (target.pbHasType?(:GRASS) ||
												 target.pbHasType?(:NATURE18))
        score -= 90
      elsif user.turnCount == 0
        score += 60
      end
    #---------------------------------------------------------------------------
    when "HealUserByHalfOfDamageDone"
      if skill >= PBTrainerAI.highSkill && (target.hasActiveAbility?(:LIQUIDOOZE) ||
											target.hasActiveAbility?(:STRANGEMIST))
        score -= 70
      elsif user.hp <= user.totalhp / 2
        score += 20
      end
    #---------------------------------------------------------------------------
    when "HealUserByHalfOfDamageDoneIfTargetAsleep"
      if !target.asleep?
        score -= 100
      elsif skill >= PBTrainerAI.highSkill && (target.hasActiveAbility?(:LIQUIDOOZE) ||
											   target.hasActiveAbility?(:STRANGEMIST))
        score -= 70
      elsif user.hp <= user.totalhp / 2
        score += 20
      end
    #---------------------------------------------------------------------------
    when "SwitchOutTargetStatusMove"
      if target.effects[PBEffects::Ingrain] ||
         (skill >= PBTrainerAI.highSkill && (target.hasActiveAbility?(:SUCTIONCUPS) ||
											 target.hasActiveAbility?(:GATEKEEPER)))
        score -= 90
      else
        ch = 0
        @battle.pbParty(target.index).each_with_index do |pkmn, i|
          ch += 1 if @battle.pbCanSwitchLax?(target.index, i)
        end
        score -= 90 if ch == 0
      end
      if score > 20
        score += 50 if target.pbOwnSide.effects[PBEffects::Spikes] > 0
        score += 50 if target.pbOwnSide.effects[PBEffects::ToxicSpikes] > 0
        score += 50 if target.pbOwnSide.effects[PBEffects::StealthRock]
      end
    #---------------------------------------------------------------------------
    when "SwitchOutTargetDamagingMove"
      if !target.effects[PBEffects::Ingrain] &&
         !(skill >= PBTrainerAI.highSkill && (target.hasActiveAbility?(:SUCTIONCUPS) ||
											  target.hasActiveAbility?(:GATEKEEPER)))
        score += 40 if target.pbOwnSide.effects[PBEffects::Spikes] > 0
        score += 40 if target.pbOwnSide.effects[PBEffects::ToxicSpikes] > 0
        score += 40 if target.pbOwnSide.effects[PBEffects::StealthRock]
      end
    #---------------------------------------------------------------------------
    when "UserTargetSwapItems"
      if !user.item && !target.item
        score -= 90
      elsif skill >= PBTrainerAI.highSkill && (target.hasActiveAbility?(:STICKYHOLD) ||
											   target.hasActiveAbility?(:COLLECTOR))
        score -= 90
      elsif user.hasActiveItem?([:FLAMEORB, :TOXICORB, :STICKYBARB, :IRONBALL,
                                 :CHOICEBAND, :CHOICESCARF, :CHOICESPECS,
								 :BLOOMERS, :POWERRIBBON])
        score += 50
      elsif !user.item && target.item
        score -= 30 if user.lastMoveUsed &&
                       GameData::Move.get(user.lastMoveUsed).function_code == "UserTargetSwapItems"
      end
    #---------------------------------------------------------------------------
    when "TargetTakesUserItem"
      if !user.item || target.item
        score -= 90
      elsif user.hasActiveItem?([:FLAMEORB, :TOXICORB, :STICKYBARB, :IRONBALL,
                                 :CHOICEBAND, :CHOICESCARF, :CHOICESPECS,
								 :BLOOMERS, :POWERRIBBON])
        score += 50
      else
        score -= 80
      end
    #---------------------------------------------------------------------------
    when "RecoilThirdOfDamageDealtParalyzeTarget"
      score -= 30
      if target.pbCanParalyze?(user, false)
        score += 30
        if skill >= PBTrainerAI.mediumSkill
          aspeed = pbRoughStat(user, :SPEED, skill)
          ospeed = pbRoughStat(target, :SPEED, skill)
          if aspeed < ospeed
            score += 30
          elsif aspeed > ospeed
            score -= 40
          end
        end
        if skill >= PBTrainerAI.highSkill
          score -= 40 if target.hasActiveAbility?([:GUTS, :MARVELSCALE, :QUICKFEET, :SPRINGCHARM])
        end
      end
    #---------------------------------------------------------------------------
    when "RecoilThirdOfDamageDealtBurnTarget"
      score -= 30
      if target.pbCanBurn?(user, false)
        score += 30
        if skill >= PBTrainerAI.highSkill
          score -= 40 if target.hasActiveAbility?([:GUTS, :MARVELSCALE, :QUICKFEET, :FLAREBOOST, :SPRINGCHARM])
        end
      end
    #---------------------------------------------------------------------------
    when "StartSunWeather"
      if @battle.pbCheckGlobalAbility(:AIRLOCK) ||
         @battle.pbCheckGlobalAbility(:CLOUDNINE) ||
		 @battle.pbCheckGlobalAbility(:HISOUTEN) ||
		 @battle.pbCheckGlobalAbility(:UNCONCIOUS)
        score -= 90
      elsif @battle.field.weather == :Sun
        score -= 90
      else
        user.eachMove do |m|
          next if !m.damagingMove? || (m.type != :FIRE || m.type != :FIRE18)
          score += 20
        end
      end
    #---------------------------------------------------------------------------
    when "StartRainWeather"
      if @battle.pbCheckGlobalAbility(:AIRLOCK) ||
         @battle.pbCheckGlobalAbility(:CLOUDNINE) ||
		 @battle.pbCheckGlobalAbility(:HISOUTEN) ||
		 @battle.pbCheckGlobalAbility(:UNCONCIOUS)
        score -= 90
      elsif @battle.field.weather == :Rain
        score -= 90
      else
        user.eachMove do |m|
          next if !m.damagingMove? || (m.type != :WATER || m.type != :WATER18)
          score += 20
        end
      end
    #---------------------------------------------------------------------------
    when "StartSandstormWeather"
      if @battle.pbCheckGlobalAbility(:AIRLOCK) ||
         @battle.pbCheckGlobalAbility(:CLOUDNINE) ||
		 @battle.pbCheckGlobalAbility(:HISOUTEN) ||
		 @battle.pbCheckGlobalAbility(:UNCONCIOUS)
        score -= 90
      elsif @battle.field.weather == :Sandstorm
        score -= 90
      end
	#---------------------------------------------------------------------------
    when "StartHailWeather"
      if @battle.pbCheckGlobalAbility(:AIRLOCK) ||
         @battle.pbCheckGlobalAbility(:CLOUDNINE) ||
		 @battle.pbCheckGlobalAbility(:HISOUTEN) ||
		 @battle.pbCheckGlobalAbility(:UNCONCIOUS)
        score -= 90
      elsif @battle.field.weather == :Hail
        score -= 90
      end
    #---------------------------------------------------------------------------
    when "CurseTargetOrLowerUserSpd1RaiseUserAtkDef1"
      if (user.pbHasType?(:GHOST) || user.pbHasType?(:GHOST18))
        if target.effects[PBEffects::Curse]
          score -= 90
        elsif user.hp <= user.totalhp / 2
          if @battle.pbAbleNonActiveCount(user.idxOwnSide) == 0
            score -= 90
          else
            score -= 50
            score -= 30 if @battle.switchStyle
          end
        end
      else
        avg  = user.stages[:SPEED] * 10
        avg -= user.stages[:ATTACK] * 10
        avg -= user.stages[:DEFENSE] * 10
        score += avg / 3
      end
    #---------------------------------------------------------------------------
    when "StartGravity"
      if @battle.field.effects[PBEffects::Gravity] > 0
        score -= 90
      elsif skill >= PBTrainerAI.mediumSkill
        score -= 30
        score -= 20 if user.effects[PBEffects::SkyDrop] >= 0
        score -= 20 if user.effects[PBEffects::MagnetRise] > 0
        score -= 20 if user.effects[PBEffects::Telekinesis] > 0
        score -= 20 if user.pbHasType?(:FLYING)
		score -= 20 if user.pbHasType?(:FLYING18)
        score -= 20 if user.hasActiveAbility?(:LEVITATE)
        score -= 20 if user.hasActiveItem?(:AIRBALLOON)
        score += 20 if target.effects[PBEffects::SkyDrop] >= 0
        score += 20 if target.effects[PBEffects::MagnetRise] > 0
        score += 20 if target.effects[PBEffects::Telekinesis] > 0
        score += 20 if target.inTwoTurnAttack?("TwoTurnAttackInvulnerableInSky",
                                               "TwoTurnAttackInvulnerableInSkyParalyzeTarget",
                                               "TwoTurnAttackInvulnerableInSkyTargetCannotAct")
        score += 20 if target.pbHasType?(:FLYING)
		score += 20 if target.pbHasType?(:FLYING18)
        score += 20 if target.hasActiveAbility?(:LEVITATE)
        score += 20 if target.hasActiveItem?(:AIRBALLOON)
      end
    #---------------------------------------------------------------------------
    when "HitsTargetInSkyGroundsTarget"
      if skill >= PBTrainerAI.mediumSkill
        score += 20 if target.effects[PBEffects::MagnetRise] > 0
        score += 20 if target.effects[PBEffects::Telekinesis] > 0
        score += 20 if target.inTwoTurnAttack?("TwoTurnAttackInvulnerableInSky",
                                               "TwoTurnAttackInvulnerableInSkyParalyzeTarget")
        score += 20 if target.pbHasType?(:FLYING)
		score += 20 if target.pbHasType?(:FLYING18)
        score += 20 if target.hasActiveAbility?(:LEVITATE)
        score += 20 if target.hasActiveItem?(:AIRBALLOON)
      end
    #---------------------------------------------------------------------------
    #when "127"
    #  score += 20   # Shadow moves are more preferable
    #  if target.pbCanParalyze?(user,false)
    #    score += 30
    #    if skill>=PBTrainerAI.mediumSkill
    #       aspeed = pbRoughStat(user,:SPEED,skill)
    #       ospeed = pbRoughStat(target,:SPEED,skill)
    #      if aspeed<ospeed
    #        score += 30
    #      elsif aspeed>ospeed
    #        score -= 40
    #      end
    #    end
    #    if skill>=PBTrainerAI.highSkill
    #      score -= 40 if target.hasActiveAbility?([:GUTS,:MARVELSCALE,:QUICKFEET,:SPRINGCHARM])
    #    end
    #  end
    #---------------------------------------------------------------------------
    #when "128"
    #  score += 20   # Shadow moves are more preferable
    #  if target.pbCanBurn?(user,false)
    #    score += 30
    #    if skill>=PBTrainerAI.highSkill
    #      score -= 40 if target.hasActiveAbility?([:GUTS,:MARVELSCALE,:QUICKFEET,:FLAREBOOST,:SPRINGCHARM])
    #    end
    #  end
    #---------------------------------------------------------------------------
    #when "129"
    #  score += 20   # Shadow moves are more preferable
    #  if target.pbCanFreeze?(user,false)
    #    score += 30
    #    if skill>=PBTrainerAI.highSkill
    #      score -= 20 if target.hasActiveAbility?(:MARVELSCALE)
	#	  score -= 20 if target.hasActiveAbility?(:SPRINGCHARM)
    #    end
    #  end
    #---------------------------------------------------------------------------
    when "StartShadowSkyWeather"
      score += 20   # Shadow moves are more preferable
      if @battle.pbCheckGlobalAbility(:AIRLOCK) ||
         @battle.pbCheckGlobalAbility(:CLOUDNINE) ||
		 @battle.pbCheckGlobalAbility(:HISOUTEN) ||
		 @battle.pbCheckGlobalAbility(:UNCONCIOUS)
        score -= 90
      elsif @battle.field.weather == :ShadowSky
        score -= 90
      end
    #---------------------------------------------------------------------------
    when "FreezeTargetSuperEffectiveAgainstWater"
      if target.pbCanFreeze?(user, false)
        score += 30
        if skill >= PBTrainerAI.highSkill
          score -= 20 if target.hasActiveAbility?(:MARVELSCALE)
		  score -= 20 if target.hasActiveAbility?(:SPRINGCHARM)
        end
      end
    #---------------------------------------------------------------------------
    when "HealUserByThreeQuartersOfDamageDone"
      if skill >= PBTrainerAI.highSkill && (target.hasActiveAbility?(:LIQUIDOOZE) ||
											target.hasActiveAbility?(:STRANGEMIST))
        score -= 80
      elsif user.hp <= user.totalhp / 2
        score += 40
      end
    #---------------------------------------------------------------------------
    when "PoisonTargetLowerTargetSpeed1"
      if !target.pbCanPoison?(user, false) && !target.pbCanLowerStatStage?(:SPEED, user)
        score -= 90
      else
        if target.pbCanPoison?(user, false)
          score += 30
          if skill >= PBTrainerAI.mediumSkill
            score += 30 if target.hp <= target.totalhp / 4
            score += 50 if target.hp <= target.totalhp / 8
            score -= 40 if target.effects[PBEffects::Yawn] > 0
          end
          if skill >= PBTrainerAI.highSkill
            score += 10 if pbRoughStat(target, :DEFENSE, skill) > 100
            score += 10 if pbRoughStat(target, :SPECIAL_DEFENSE, skill) > 100
            score -= 40 if target.hasActiveAbility?([:GUTS, :MARVELSCALE, :TOXICBOOST, :SPRINGCHARM])
          end
        end
        if target.pbCanLowerStatStage?(:SPEED, user)
          score += target.stages[:SPEED] * 10
          if skill >= PBTrainerAI.highSkill
            aspeed = pbRoughStat(user, :SPEED, skill)
            ospeed = pbRoughStat(target, :SPEED, skill)
            score += 30 if aspeed < ospeed && aspeed * 2 > ospeed
          end
        end
      end
    #---------------------------------------------------------------------------
	# Cursed Stab
	#---------------------------------------------------------------------------
    when "HealUserByHalfOfDamageDoneThmn"
      if skill >= PBTrainerAI.highSkill && (target.hasActiveAbility?(:LIQUIDOOZE) ||
											target.hasActiveAbility?(:STRANGEMIST))
        score -= 70
      elsif user.hp <= user.totalhp / 2
        score += 20
      end
    #---------------------------------------------------------------------------
	# Touhoumon Weather Ball
	#---------------------------------------------------------------------------
    when "TypeAndPowerDependOnWeatherThmn"
    #---------------------------------------------------------------------------
	# Recollection
	#---------------------------------------------------------------------------
    when "UserCopiesMovesWithoutTransforming"
      score -= 70
	#---------------------------------------------------------------------------
	# Touhoumon Rage
	#---------------------------------------------------------------------------
	when "BurnAttackerAtRandom"
    #--------------------------------------------------------------------------- VERY END
    else
	  score = __ThmnAI__pbGetMoveScoreFunctionCode(score,move,user,target,skill)
	end
	return score
  end
end