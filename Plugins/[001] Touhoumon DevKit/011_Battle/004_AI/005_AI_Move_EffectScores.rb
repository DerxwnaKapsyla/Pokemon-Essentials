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
class PokeBattle_AI
  alias __ThmnAI__pbGetMoveScoreFunctionCode pbGetMoveScoreFunctionCode
  def pbGetMoveScoreFunctionCode(score,move,user,target,skill=100)
    case move.function
    #---------------------------------------------------------------------------
    when "003"
      if target.pbCanSleep?(user,false)
        score += 30
        if skill>=PBTrainerAI.mediumSkill
          score -= 30 if target.effects[PBEffects::Yawn]>0
        end
        if skill>=PBTrainerAI.highSkill
          score -= 30 if target.hasActiveAbility?(:MARVELSCALE)
		  score -= 30 if target.hasActiveAbility?(:SPRINGCHARM)
        end
        if skill>=PBTrainerAI.bestSkill
          if target.pbHasMoveFunction?("011","0B4")   # Snore, Sleep Talk
            score -= 50
          end
        end
      else
        if skill>=PBTrainerAI.mediumSkill
          score -= 90 if move.statusMove?
        end
      end
    #---------------------------------------------------------------------------
    when "004"
      if target.effects[PBEffects::Yawn]>0 || !target.pbCanSleep?(user,false)
        score -= 90 if skill>=PBTrainerAI.mediumSkill
      else
        score += 30
        if skill>=PBTrainerAI.highSkill
          score -= 30 if target.hasActiveAbility?(:MARVELSCALE)
		  score -= 30 if target.hasActiveAbility?(:SPRINGCHARM)
        end
        if skill>=PBTrainerAI.bestSkill
          if target.pbHasMoveFunction?("011","0B4")   # Snore, Sleep Talk
            score -= 50
          end
        end
      end	
	#---------------------------------------------------------------------------
    when "005", "006", "0BE"
      if target.pbCanPoison?(user,false)
        score += 30
        if skill>=PBTrainerAI.mediumSkill
          score += 30 if target.hp<=target.totalhp/4
          score += 50 if target.hp<=target.totalhp/8
          score -= 40 if target.effects[PBEffects::Yawn]>0
        end
        if skill>=PBTrainerAI.highSkill
          score += 10 if pbRoughStat(target,:DEFENSE,skill)>100
          score += 10 if pbRoughStat(target,:SPECIAL_DEFENSE,skill)>100
          score -= 40 if target.hasActiveAbility?([:GUTS,:MARVELSCALE,:TOXICBOOST,:SPRINGCHARM])
        end
      else
        if skill>=PBTrainerAI.mediumSkill
          score -= 90 if move.statusMove?
        end
      end
	#---------------------------------------------------------------------------
    when "007", "008", "009", "0C5"
      if target.pbCanParalyze?(user,false) &&
         !(skill>=PBTrainerAI.mediumSkill &&
         move.id == :THUNDERWAVE &&
         Effectiveness.ineffective?(pbCalcTypeMod(move.type,user,target)))
        score += 30
        if skill>=PBTrainerAI.mediumSkill
           aspeed = pbRoughStat(user,:SPEED,skill)
           ospeed = pbRoughStat(target,:SPEED,skill)
          if aspeed<ospeed
            score += 30
          elsif aspeed>ospeed
            score -= 40
          end
        end
        if skill>=PBTrainerAI.highSkill
          score -= 40 if target.hasActiveAbility?([:GUTS,:MARVELSCALE,:QUICKFEET,:SPRINGCHARM])
        end
      else
        if skill>=PBTrainerAI.mediumSkill
          score -= 90 if move.statusMove?
        end
      end	
    #---------------------------------------------------------------------------
    when "00A", "00B", "0C6"
      if target.pbCanBurn?(user,false)
        score += 30
        if skill>=PBTrainerAI.highSkill
          score -= 40 if target.hasActiveAbility?([:GUTS,:MARVELSCALE,:QUICKFEET,:FLAREBOOST,:SPRINGCHARM])
        end
      else
        if skill>=PBTrainerAI.mediumSkill
          score -= 90 if move.statusMove?
        end
      end
    #---------------------------------------------------------------------------
    when "00C", "00D", "00E"
      if target.pbCanFreeze?(user,false)
        score += 30
        if skill>=PBTrainerAI.highSkill
          score -= 20 if target.hasActiveAbility?(:MARVELSCALE)
		  score -= 20 if target.hasActiveAbility?(:SPRINGCHARM)
        end
      else
        if skill>=PBTrainerAI.mediumSkill
          score -= 90 if move.statusMove?
        end
      end
    #---------------------------------------------------------------------------
    when "016"
      canattract = true
      agender = user.gender
      ogender = target.gender
      if (agender==2 || ogender==2 || agender==ogender) && !user.hasActiveAbility?(:DIVA)
        score -= 90; canattract = false
      elsif target.effects[PBEffects::Attract]>=0
        score -= 80; canattract = false
      elsif skill>=PBTrainerAI.bestSkill && target.hasActiveAbility?(:OBLIVIOUS)
        score -= 80; canattract = false
      end
      if skill>=PBTrainerAI.highSkill
        if canattract && target.hasActiveItem?(:DESTINYKNOT) &&
           user.pbCanAttract?(target,false)
          score -= 30
        end
      end
    #---------------------------------------------------------------------------
    when "063"
      if target.effects[PBEffects::Substitute]>0
        score -= 90
      elsif skill>=PBTrainerAI.mediumSkill
        if target.unstoppableAbility? || [:TRUANT, :SIMPLE, :FRETFUL].include?(target.ability)
          score -= 90
        end
      end
    #---------------------------------------------------------------------------
    when "064"
      if target.effects[PBEffects::Substitute]>0
        score -= 90
      elsif skill>=PBTrainerAI.mediumSkill
        if target.unstoppableAbility? || [:TRUANT, :INSOMNIA, :FRETFUL].include?(target.ability_id)
          score -= 90
        end
      end
    #---------------------------------------------------------------------------
    when "065"
      score -= 40   # don't prefer this move
      if skill>=PBTrainerAI.mediumSkill
        if !target.ability || user.ability==target.ability ||
           [:MULTITYPE, :RKSSYSTEM].include?(user.ability_id) ||
           [:FLOWERGIFT, :FORECAST, :ILLUSION, :IMPOSTER, :MULTITYPE, :RKSSYSTEM,
            :TRACE, :WONDERGUARD, :ZENMODE, :PLAYGHOST].include?(target.ability_id)
          score -= 90
        end
      end
      if skill>=PBTrainerAI.highSkill
        if target.ability == :TRUANT && user.opposes?(target)
          score -= 90
        elsif target.ability == :SLOWSTART && user.opposes?(target)
          score -= 90
        elsif target.ability == :FRETFUL && user.opposes?(target)
          score -= 90
        end
      end
    #---------------------------------------------------------------------------
    when "066"
      score -= 40   # don't prefer this move
      if target.effects[PBEffects::Substitute]>0
        score -= 90
      elsif skill>=PBTrainerAI.mediumSkill
        if !user.ability || user.ability==target.ability ||
          [:MULTITYPE, :RKSSYSTEM, :TRUANT].include?(target.ability_id) ||
          [:FLOWERGIFT, :FORECAST, :ILLUSION, :IMPOSTER, :MULTITYPE, :RKSSYSTEM,
           :TRACE, :ZENMODE, :FRETFUL].include?(user.ability_id)
          score -= 90
        end
        if skill>=PBTrainerAI.highSkill
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
    when "067"
      score -= 40   # don't prefer this move
      if skill>=PBTrainerAI.mediumSkill
        if (!user.ability && !target.ability) ||
           user.ability==target.ability ||
           [:ILLUSION, :MULTITYPE, :RKSSYSTEM, :WONDERGUARD, :PLAYGHOST].include?(user.ability_id) ||
           [:ILLUSION, :MULTITYPE, :RKSSYSTEM, :WONDERGUARD, :PLAYGHOST].include?(target.ability_id)
          score -= 90
        end
      end
      if skill>=PBTrainerAI.highSkill
        if target.ability == :TRUANT && user.opposes?(target)
          score -= 90
        elsif target.ability == :SLOWSTART && user.opposes?(target)
          score -= 90
        elsif target.ability == :FRETFUL && user.opposes?(target)
          score -= 90
        end
      end
    #---------------------------------------------------------------------------
    when "068"
      if target.effects[PBEffects::Substitute]>0 ||
         target.effects[PBEffects::GastroAcid]
        score -= 90
      elsif skill>=PBTrainerAI.highSkill
        score -= 90 if [:MULTITYPE, :RKSSYSTEM, :SLOWSTART, :TRUANT, :FRETFUL].include?(target.ability_id)
      end
    #---------------------------------------------------------------------------
    when "0DC"
      if target.effects[PBEffects::LeechSeed]>=0
        score -= 90
      elsif skill>=PBTrainerAI.mediumSkill && (target.pbHasType?(:GRASS) ||
											   target.pbHasType?(:NATURE18))
        score -= 90
      else
        score += 60 if user.turnCount==0
      end
    #---------------------------------------------------------------------------
    when "0DD"
      if skill>=PBTrainerAI.highSkill && (target.hasActiveAbility?(:LIQUIDOOZE) ||
										  target.hasActiveAbility?(:STRANGEMIST))
        score -= 70
      else
        score += 20 if user.hp<=user.totalhp/2
      end
    #---------------------------------------------------------------------------
    when "0DE"
      if !target.asleep?
        score -= 100
      elsif skill>=PBTrainerAI.highSkill && (target.hasActiveAbility?(:LIQUIDOOZE) ||
											 target.hasActiveAbility?(:STRANGEMIST))
        score -= 70
      else
        score += 20 if user.hp<=user.totalhp/2
      end
    #---------------------------------------------------------------------------
    when "0EB"
      if target.effects[PBEffects::Ingrain] ||
         (skill>=PBTrainerAI.highSkill && (target.hasActiveAbility?(:SUCTIONCUPS) ||
										   target.hasActiveAbility?(:GATEKEEPER)))
        score -= 90
      else
        ch = 0
        @battle.pbParty(target.index).each_with_index do |pkmn,i|
          ch += 1 if @battle.pbCanSwitchLax?(target.index,i)
        end
        score -= 90 if ch==0
      end
      if score>20
        score += 50 if target.pbOwnSide.effects[PBEffects::Spikes]>0
        score += 50 if target.pbOwnSide.effects[PBEffects::ToxicSpikes]>0
        score += 50 if target.pbOwnSide.effects[PBEffects::StealthRock]
      end
    #---------------------------------------------------------------------------
    when "0EC"
      if !target.effects[PBEffects::Ingrain] &&
         !(skill>=PBTrainerAI.highSkill && (target.hasActiveAbility?(:SUCTIONCUPS) ||
											target.hasActiveAbility?(:GATEKEEPER)))
        score += 40 if target.pbOwnSide.effects[PBEffects::Spikes]>0
        score += 40 if target.pbOwnSide.effects[PBEffects::ToxicSpikes]>0
        score += 40 if target.pbOwnSide.effects[PBEffects::StealthRock]
      end
    #---------------------------------------------------------------------------
    when "0F2"
      if !user.item && !target.item
        score -= 90
      elsif skill>=PBTrainerAI.highSkill && (target.hasActiveAbility?(:STICKYHOLD) ||
											 target.hasActiveAbility?(:COLLECTOR))
        score -= 90
      elsif user.hasActiveItem?([:FLAMEORB,:TOXICORB,:STICKYBARB,:IRONBALL,
                                 :CHOICEBAND,:CHOICESCARF,:CHOICESPECS,
								 :BLOOMERS,:POWERRIBBON])
        score += 50
      elsif !user.item && target.item
        score -= 30 if user.lastMoveUsed &&
                       GameData::Move.get(user.lastMoveUsed).function_code == "0F2"   # Trick/Switcheroo
      end
    #---------------------------------------------------------------------------
    when "0F3"
      if !user.item || target.item
        score -= 90
      else
        if user.hasActiveItem?([:FLAMEORB,:TOXICORB,:STICKYBARB,:IRONBALL,
                                :CHOICEBAND,:CHOICESCARF,:CHOICESPECS,
								:BLOOMERS,:POWERRIBBON])
          score += 50
        else
          score -= 80
        end
      end
    #---------------------------------------------------------------------------
    when "0FD"
      score -= 30
      if target.pbCanParalyze?(user,false)
        score += 30
        if skill>=PBTrainerAI.mediumSkill
           aspeed = pbRoughStat(user,:SPEED,skill)
           ospeed = pbRoughStat(target,:SPEED,skill)
          if aspeed<ospeed
            score += 30
          elsif aspeed>ospeed
            score -= 40
          end
        end
        if skill>=PBTrainerAI.highSkill
          score -= 40 if target.hasActiveAbility?([:GUTS,:MARVELSCALE,:QUICKFEET,:SPRINGCHARM])
        end
      end
    #---------------------------------------------------------------------------
    when "0FE"
      score -= 30
      if target.pbCanBurn?(user,false)
        score += 30
        if skill>=PBTrainerAI.highSkill
          score -= 40 if target.hasActiveAbility?([:GUTS,:MARVELSCALE,:QUICKFEET,:FLAREBOOST,:SPRINGCHARM])
        end
      end
    #---------------------------------------------------------------------------
    when "0FF"
      if @battle.pbCheckGlobalAbility(:AIRLOCK) ||
         @battle.pbCheckGlobalAbility(:CLOUDNINE) ||
		 @battle.pbCheckGlobalAbility(:HISOUTEN) ||
         @battle.pbCheckGlobalAbility(:UNCONCIOUS)
        score -= 90
      elsif @battle.pbWeather == :Sun
        score -= 90
      else
        user.eachMove do |m|
          next if !m.damagingMove? || m.type != (:FIRE || :FIRE18)
          score += 20
        end
      end
    #---------------------------------------------------------------------------
    when "100"
      if @battle.pbCheckGlobalAbility(:AIRLOCK) ||
         @battle.pbCheckGlobalAbility(:CLOUDNINE) ||
		 @battle.pbCheckGlobalAbility(:HISOUTEN) ||
         @battle.pbCheckGlobalAbility(:UNCONCIOUS)
        score -= 90
      elsif @battle.pbWeather == :Rain
        score -= 90
      else
        user.eachMove do |m|
          next if !m.damagingMove? || m.type != (:WATER || :WATER18)
          score += 20
        end
      end
    #---------------------------------------------------------------------------
    when "101"
      if @battle.pbCheckGlobalAbility(:AIRLOCK) ||
         @battle.pbCheckGlobalAbility(:CLOUDNINE) ||
		 @battle.pbCheckGlobalAbility(:HISOUTEN) ||
         @battle.pbCheckGlobalAbility(:UNCONCIOUS)
        score -= 90
      elsif @battle.pbWeather == :Sandstorm
        score -= 90
      end
	#---------------------------------------------------------------------------
    when "102"
      if @battle.pbCheckGlobalAbility(:AIRLOCK) ||
         @battle.pbCheckGlobalAbility(:CLOUDNINE) ||
		 @battle.pbCheckGlobalAbility(:HISOUTEN) ||
         @battle.pbCheckGlobalAbility(:UNCONCIOUS)
        score -= 90
      elsif @battle.pbWeather == :Hail
        score -= 90
      end
    #---------------------------------------------------------------------------
    when "10D"
      if (user.pbHasType?(:GHOST) || user.pbHasType?(:GHOST18))
        if target.effects[PBEffects::Curse]
          score -= 90
        elsif user.hp<=user.totalhp/2
          if @battle.pbAbleNonActiveCount(user.idxOwnSide)==0
            score -= 90
          else
            score -= 50
            score -= 30 if @battle.switchStyle
          end
        end
      else
        avg  = user.stages[:SPEED]*10
        avg -= user.stages[:ATTACK]*10
        avg -= user.stages[:DEFENSE]*10
        score += avg/3
      end
    #---------------------------------------------------------------------------
    when "118"
      if @battle.field.effects[PBEffects::Gravity]>0
        score -= 90
      elsif skill>=PBTrainerAI.mediumSkill
        score -= 30
        score -= 20 if user.effects[PBEffects::SkyDrop]>=0
        score -= 20 if user.effects[PBEffects::MagnetRise]>0
        score -= 20 if user.effects[PBEffects::Telekinesis]>0
        score -= 20 if user.pbHasType?(:FLYING)
		score -= 20 if user.pbHasType?(:FLYING18)
        score -= 20 if user.hasActiveAbility?(:LEVITATE)
        score -= 20 if user.hasActiveItem?(:AIRBALLOON)
        score += 20 if target.effects[PBEffects::SkyDrop]>=0
        score += 20 if target.effects[PBEffects::MagnetRise]>0
        score += 20 if target.effects[PBEffects::Telekinesis]>0
        score += 20 if target.inTwoTurnAttack?("0C9","0CC","0CE")   # Fly, Bounce, Sky Drop
        score += 20 if target.pbHasType?(:FLYING)
		score += 20 if target.pbHasType?(:FLYING18)
        score += 20 if target.hasActiveAbility?(:LEVITATE)
        score += 20 if target.hasActiveItem?(:AIRBALLOON)
      end
    #---------------------------------------------------------------------------
    when "11C"
      if skill>=PBTrainerAI.mediumSkill
        score += 20 if target.effects[PBEffects::MagnetRise]>0
        score += 20 if target.effects[PBEffects::Telekinesis]>0
        score += 20 if target.inTwoTurnAttack?("0C9","0CC")   # Fly, Bounce
        score += 20 if target.pbHasType?(:FLYING)
		score += 20 if target.pbHasType?(:FLYING18)
        score += 20 if target.hasActiveAbility?(:LEVITATE)
        score += 20 if target.hasActiveItem?(:AIRBALLOON)
      end
    #---------------------------------------------------------------------------
    when "127"
      score += 20   # Shadow moves are more preferable
      if target.pbCanParalyze?(user,false)
        score += 30
        if skill>=PBTrainerAI.mediumSkill
           aspeed = pbRoughStat(user,:SPEED,skill)
           ospeed = pbRoughStat(target,:SPEED,skill)
          if aspeed<ospeed
            score += 30
          elsif aspeed>ospeed
            score -= 40
          end
        end
        if skill>=PBTrainerAI.highSkill
          score -= 40 if target.hasActiveAbility?([:GUTS,:MARVELSCALE,:QUICKFEET,:SPRINGCHARM])
        end
      end
    #---------------------------------------------------------------------------
    when "128"
      score += 20   # Shadow moves are more preferable
      if target.pbCanBurn?(user,false)
        score += 30
        if skill>=PBTrainerAI.highSkill
          score -= 40 if target.hasActiveAbility?([:GUTS,:MARVELSCALE,:QUICKFEET,:FLAREBOOST,:SPRINGCHARM])
        end
      end
    #---------------------------------------------------------------------------
    when "129"
      score += 20   # Shadow moves are more preferable
      if target.pbCanFreeze?(user,false)
        score += 30
        if skill>=PBTrainerAI.highSkill
          score -= 20 if target.hasActiveAbility?(:MARVELSCALE)
		  score -= 20 if target.hasActiveAbility?(:SPRINGCHARM)
        end
      end
    #---------------------------------------------------------------------------
    when "131"
      score += 20   # Shadow moves are more preferable
      if @battle.pbCheckGlobalAbility(:AIRLOCK) ||
         @battle.pbCheckGlobalAbility(:CLOUDNINE) ||
		 @battle.pbCheckGlobalAbility(:HISOUTEN) ||
         @battle.pbCheckGlobalAbility(:UNCONCIOUS)
        score -= 90
      elsif @battle.pbWeather == :ShadowSky
        score -= 90
      end
    #---------------------------------------------------------------------------
    when "135"
      if target.pbCanFreeze?(user,false)
        score += 30
        if skill>=PBTrainerAI.highSkill
          score -= 20 if target.hasActiveAbility?(:MARVELSCALE)
		  score -= 20 if target.hasActiveAbility?(:SPRINGCHARM)
        end
      end
    #---------------------------------------------------------------------------
    when "14F"
      if skill>=PBTrainerAI.highSkill && (target.hasActiveAbility?(:LIQUIDOOZE) ||
										  target.hasActiveAbility?(:STRANGEMIST))
        score -= 80
      else
        score += 40 if user.hp<=user.totalhp/2
      end
    #---------------------------------------------------------------------------
    when "159"
      if !target.pbCanPoison?(user,false) && !target.pbCanLowerStatStage?(:SPEED,user)
        score -= 90
      else
        if target.pbCanPoison?(user,false)
          score += 30
          if skill>=PBTrainerAI.mediumSkill
            score += 30 if target.hp<=target.totalhp/4
            score += 50 if target.hp<=target.totalhp/8
            score -= 40 if target.effects[PBEffects::Yawn]>0
          end
          if skill>=PBTrainerAI.highSkill
            score += 10 if pbRoughStat(target,:DEFENSE,skill)>100
            score += 10 if pbRoughStat(target,:SPECIAL_DEFENSE,skill)>100
            score -= 40 if target.hasActiveAbility?([:GUTS,:MARVELSCALE,:TOXICBOOST,:SPRINGCHARM])
          end
        end
        if target.pbCanLowerStatStage?(:SPEED,user)
          score += target.stages[:SPEED]*10
          if skill>=PBTrainerAI.highSkill
            aspeed = pbRoughStat(user,:SPEED,skill)
            ospeed = pbRoughStat(target,:SPEED,skill)
            score += 30 if aspeed<ospeed && aspeed*2>ospeed
          end
        end
      end
    #---------------------------------------------------------------------------
	# Cursed Stab
	#---------------------------------------------------------------------------
    when "0DD"
      if skill>=PBTrainerAI.highSkill && (target.hasActiveAbility?(:LIQUIDOOZE) ||
										  target.hasActiveAbility?(:STRANGEMIST))
        score -= 70
      else
        score += 20 if user.hp<=user.totalhp/2
      end
    #--------------------------------------------------------------------------- VERY END
    else
	  score = __ThmnAI__pbGetMoveScoreFunctionCode(score,move,user,target,skill)
	end
	return score
  end
end