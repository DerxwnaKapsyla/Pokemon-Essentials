#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Addition of Bloomers and Power Ribbon to AI checks for Choice Items
#	* Addition of Lucid Dreaming to checks for moves to use while asleep
#==============================================================================#
class PokeBattle_AI
  def pbGetMoveScore(move,user,target,skill=100)
    skill = PBTrainerAI.minimumSkill if skill<PBTrainerAI.minimumSkill
    score = 100
    score = pbGetMoveScoreFunctionCode(score,move,user,target,skill)
    # A score of 0 here means it absolutely should not be used
    return 0 if score<=0
    if skill>=PBTrainerAI.mediumSkill
      # Prefer damaging moves if AI has no more Pokémon or AI is less clever
      if @battle.pbAbleNonActiveCount(user.idxOwnSide)==0
        if !(skill>=PBTrainerAI.highSkill && @battle.pbAbleNonActiveCount(target.idxOwnSide)>0)
          if move.statusMove?
            score /= 1.5
          elsif target.hp<=target.totalhp/2
            score *= 1.5
          end
        end
      end
      # Don't prefer attacking the target if they'd be semi-invulnerable
      if skill>=PBTrainerAI.highSkill && move.accuracy>0 &&
         (target.semiInvulnerable? || target.effects[PBEffects::SkyDrop]>=0)
        miss = true
        miss = false if user.hasActiveAbility?(:NOGUARD) || target.hasActiveAbility?(:NOGUARD)
        if miss && pbRoughStat(user,:SPEED,skill)>pbRoughStat(target,:SPEED,skill)
          # Knows what can get past semi-invulnerability
          if target.effects[PBEffects::SkyDrop]>=0
            miss = false if move.hitsFlyingTargets?
          else
            if target.inTwoTurnAttack?("0C9","0CC","0CE")   # Fly, Bounce, Sky Drop
              miss = false if move.hitsFlyingTargets?
            elsif target.inTwoTurnAttack?("0CA")          # Dig
              miss = false if move.hitsDiggingTargets?
            elsif target.inTwoTurnAttack?("0CB")          # Dive
              miss = false if move.hitsDivingTargets?
            end
          end
        end
        score -= 80 if miss
      end
      # Pick a good move for the Choice items
      if user.hasActiveItem?([:CHOICEBAND,:CHOICESPECS,:CHOICESCARF,:BLOOMERS,:POWERRIBBON])
        if move.baseDamage>=60;     score += 60
        elsif move.damagingMove?;   score += 30
        elsif move.function=="0F2"; score += 70   # Trick
        else;                       score -= 60
        end
      end
      # If user is asleep, prefer moves that are usable while asleep
      if user.status == :SLEEP && !move.usableWhenAsleep? && !user.hasActiveAbility?(:LUCIDDREAMING)
        user.eachMove do |m|
          next unless m.usableWhenAsleep?
          score -= 60
          break
        end
      end
      # If user is frozen, prefer a move that can thaw the user
      if user.status == :FROZEN
        if move.thawsUser?
          score += 40
        else
          user.eachMove do |m|
            next unless m.thawsUser?
            score -= 60
            break
          end
        end
      end
      # If target is frozen, don't prefer moves that could thaw them
      if target.status == :FROZEN
        user.eachMove do |m|
          next if m.thawsUser?
          score -= 60
          break
        end
      end
    end
    # Adjust score based on how much damage it can deal
    if move.damagingMove?
      score = pbGetMoveScoreDamage(score,move,user,target,skill)
    else   # Status moves
      # Don't prefer attacks which don't deal damage
      score -= 10
      # Account for accuracy of move
      accuracy = pbRoughAccuracy(move,user,target,skill)
      score *= accuracy/100.0
      score = 0 if score<=10 && skill>=PBTrainerAI.highSkill
    end
    score = score.to_i
    score = 0 if score<0
    return score
  end
end