#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Adds a check for Freeze that will thaw the user if they use a Touhoumon-
#	  typed Fire move.
#==============================================================================#
class PokeBattle_Battler
  def pbEffectsAfterMove(user,targets,move,numHits)
    # Defrost
    if move.damagingMove?
      targets.each do |b|
        next if b.damageState.unaffected || b.damageState.substitute
        next if b.status != :FROZEN
        # NOTE: Non-Fire-type moves that thaw the user will also thaw the
        #       target (in Gen 6+).
        if (move.calcType == :FIRE || move.calcType == :FIRE18) ||
		   (Settings::MECHANICS_GENERATION >= 6 && move.thawsUser?)
          b.pbCureStatus
        end
      end
    end
    # Destiny Bond
    # NOTE: Although Destiny Bond is similar to Grudge, they don't apply at
    #       the same time (although Destiny Bond does check whether it's going
    #       to trigger at the same time as Grudge).
    if user.effects[PBEffects::DestinyBondTarget]>=0 && !user.fainted?
      dbName = @battle.battlers[user.effects[PBEffects::DestinyBondTarget]].pbThis
      @battle.pbDisplay(_INTL("{1} took its attacker down with it!",dbName))
      user.pbReduceHP(user.hp,false)
      user.pbItemHPHealCheck
      user.pbFaint
      @battle.pbJudgeCheckpoint(user)
    end
    # User's ability
    if user.abilityActive?
      BattleHandlers.triggerUserAbilityEndOfMove(user.ability,user,targets,move,@battle)
    end
    # Greninja - Battle Bond
    if !user.fainted? && !user.effects[PBEffects::Transform] &&
       user.isSpecies?(:GRENINJA) && user.ability == :BATTLEBOND
      if !@battle.pbAllFainted?(user.idxOpposingSide) &&
         !@battle.battleBond[user.index&1][user.pokemonIndex]
        numFainted = 0
        targets.each { |b| numFainted += 1 if b.damageState.fainted }
        if numFainted>0 && user.form==1
          @battle.battleBond[user.index&1][user.pokemonIndex] = true
          @battle.pbDisplay(_INTL("{1} became fully charged due to its bond with its Trainer!",user.pbThis))
          @battle.pbShowAbilitySplash(user,true)
          @battle.pbHideAbilitySplash(user)
          user.pbChangeForm(2,_INTL("{1} became Ash-Greninja!",user.pbThis))
        end
      end
    end
    # Consume user's Gem
    if user.effects[PBEffects::GemConsumed]
      # NOTE: The consume animation and message for Gems are shown immediately
      #       after the move's animation, but the item is only consumed now.
      user.pbConsumeItem
    end
    # Pokémon switching caused by Roar, Whirlwind, Circle Throw, Dragon Tail
    switchedBattlers = []
    move.pbSwitchOutTargetsEffect(user,targets,numHits,switchedBattlers)
    # Target's item, user's item, target's ability (all negated by Sheer Force)
    if move.addlEffect==0 || !user.hasActiveAbility?(:SHEERFORCE)
      pbEffectsAfterMove2(user,targets,move,numHits,switchedBattlers)
    end
    # Some move effects that need to happen here, i.e. U-turn/Volt Switch
    # switching, Baton Pass switching, Parting Shot switching, Relic Song's form
    # changing, Fling/Natural Gift consuming item.
    if !switchedBattlers.include?(user.index)
      move.pbEndOfMoveUsageEffect(user,targets,numHits,switchedBattlers)
    end
    if numHits>0
      @battle.eachBattler { |b| b.pbItemEndOfMoveCheck }
    end
  end
end