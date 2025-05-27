#============================================================================
# Faithful Sheep
#  * When Makura Puppets are on the field, user gains +2 to Def/SpDef
#  * When Makura is targeted, user has a 50% chance to intercept attack.
#    If triggered, user's Attack and Special Attack are boosted by 1.
#============================================================================
Battle::AbilityEffects::OnSwitchIn.add(:FAITHFULSHEEP,
  proc { |ability, battler, battle, switch_in|
    next if !battler.allAllies.any? { |b| b.isSpecies?(:MAKURA) }
	battle.pbDisplay(_INTL("{1} became bolder battling alongside Makura!",battler.pbThis))
	battle.pbHideAbilitySplash(battler)
	showAnim = true
	[:DEFENSE, :SPECIAL_DEFENSE].each do |stat|
	  next if !battler.pbCanRaiseStatStage?(stat, battler)
	  battler.pbRaiseStatStageByAbility(stat, 2, battler, false)
	  showAnim = false
	end
  }
)

Battle::AbilityEffects::OnBeingHit.add(:FAITHFULSHEEP,
  proc { |ability, user, target, move, battle|
    if target.effects[PBEffects::Intercepted] == true
	  echoln "Passed Interception check"
	  showAnim = true
	  battle.pbShowAbilitySplash(target)
      if Battle::Scene::USE_ABILITY_SPLASH
          battle.pbDisplay(_INTL("{1} took the attack intended for its partner!", target.pbThis))
      else
          battle.pbDisplay(_INTL("{1} took the attack intended for its partner!", target.pbThis))
      end
	  battle.pbHideAbilitySplash(target)
	  [:ATTACK, :SPECIAL_ATTACK].each do |stat|
	    next if !user.pbCanRaiseStatStage?(stat, target)
	    target.pbRaiseStatStageByAbility(stat, 1, target, false)
	    showAnim = false
	  end
	target.effects[PBEffects::Intercepted] = false
	end
  } 
)

#============================================================================
# Abyssal Dream
#  * When a foe is asleep, user drains their health to restore HP to all
#    battlers on their side.
#============================================================================
Battle::AbilityEffects::EndOfRoundEffect.add(:ABYSSALDREAM,
  proc { |ability, battler, battle|
	hp_drained = 0
	show_message = true
	p1 = battle.battlers[0]
    p2 = battle.battlers[2]
    battle.allOtherSideBattlers(battler.index).each do |b|
      next if !b.near?(battler) || !b.asleep?
      if show_message == true
	    battle.pbShowAbilitySplash(battler)
        next if !b.takesIndirectDamage?(Battle::Scene::USE_ABILITY_SPLASH)
	    if p1 || p2
          battle.pbDisplay(_INTL("{1} is tormented!", (p1 || p2).pbThis))
	    else
          battle.pbDisplay(_INTL("{1} and {2} are tormented!", p1.pbThis, p2.pbThis))
	    end
		show_message = false
	  end
      battle.pbHideAbilitySplash(battler)
      b.pbTakeEffectDamage(b.totalhp / 8) do |hp_lost|
        hp_drained = hp_drained + hp_lost # Combined hp lost pool
      end
    end
    next if hp_drained < 0
    hp_restored = hp_drained / 2
	if hp_restored > 0
      battle.pbDisplay(_INTL("{1} absorbed their foe's dreams!", battler.pbThis))
      battle.allSameSideBattlers(battler.index).each do |b|
        b.pbRecoverHP(hp_restored)
	  end
    end
  }
)

#============================================================================
# Innocent Cone
#  * User cannot be inflicted with status conditions.
#============================================================================
Battle::AbilityEffects::StatusImmunity.add(:INNOCENTCONE,
  proc { |ability, battler, status|
    next true if status == :SLEEP
	next true if status == :PARALYSIS
	next true if status == :FROZEN
	next true if status == :POISON
	next true if status == :BURN
  }
)

#============================================================================
# Spiral Architect
#  * All contact moves from the user will trap the target.
#============================================================================
Battle::AbilityEffects::OnDealingHit.add(:SPIRALARCHITECT,
  proc { |ability, user, target, move, battle|
    next if target.fainted?
	next if !move.contactMove?
    next if target.effects[PBEffects::MeanLook] >= 0
    battle.pbShowAbilitySplash(user)
    if Battle::Scene::USE_ABILITY_SPLASH
      battle.pbDisplay(_INTL("{1} was ensnared!", target.pbThis))
    else
      battle.pbDisplay(_INTL("{1} ensnared {2} in an inescapable helix!", user.pbThis, target.pbThis(true)))
    end
	target.effects[PBEffects::MeanLook] = user.index
    battle.pbHideAbilitySplash(user)
  }
)

#============================================================================
# Signboard of Hatred
#  * All of the user's moves have a chance to flinch.
#============================================================================
Battle::AbilityEffects::OnDealingHit.add(:SIGNBOARDOFHATRED,
  proc { |ability, user, target, move, battle|
    if rand(100) > 75
	  target.pbFlinch(user)
	end
  }
)

#============================================================================
# Mycelium Melancholy
#  * When a contact move is used against the user, there is a 25% chance to
#    confuse the attacker.
#============================================================================
Battle::AbilityEffects::OnBeingHit.add(:MYCELIUMMELANCHOLY,
  proc { |ability, user, target, move, battle|
    next if !move.pbContactMove?(user)
	next if user.effects[PBEffects::Confusion] > 0 || rand(100) >= 25
    battle.pbShowAbilitySplash(target)
    if user.pbCanConfuse?(target, Battle::Scene::USE_ABILITY_SPLASH) &&
       user.affectedByContactEffect?(Battle::Scene::USE_ABILITY_SPLASH)
      msg = nil
      if !Battle::Scene::USE_ABILITY_SPLASH
        msg = _INTL("{1}'s {2} confused {3}!",
           target.pbThis, target.abilityName, user.pbThis(true))
      end
      user.pbConfuse(target)
    end
    battle.pbHideAbilitySplash(target)
  }
)

#============================================================================
# Daidarabotchi's Night
#  * User's accuracy is raised by 1 stage for every 2 Puppets fallen in battle.
#============================================================================
Battle::AbilityEffects::OnSwitchIn.add(:DAIDARABOTCHI,
  proc { |ability, battler, battle, switch_in|
    ally_fainted = battle.pbParty(battler.index).count {|pkmn| pkmn.fainted? }
	foes_fainted = battle.pbOpposingParty(battler.index).count {|pkmn| pkmn.fainted? }
    echoln ally_fainted
	echoln foes_fainted
    numFainted = [10, ally_fainted + foes_fainted].min
    numFainted = (numFainted / 2).floor
	echoln numFainted
    next if numFainted <= 0
    battle.pbShowAbilitySplash(battler)
    battle.pbDisplay(_INTL("{1} called upon the spirits of the fallen to reinforce her attacks!", battler.pbThis))
    battler.pbRaiseStatStage(:ACCURACY, numFainted, battler)
    battle.pbHideAbilitySplash(battler)
  }
)

#============================================================================
# Benediction
#  * Upon being sent out, the user's side will have doubled speed for four 
#    turns.
#============================================================================
Battle::AbilityEffects::OnSwitchIn.add(:BENEDICTION,
  proc { |ability, battler, battle, switch_in|
    battler.pbOwnSide.effects[PBEffects::Tailwind] = 4
    battle.pbDisplay(_INTL("{1} flew in so fast they brought a tailwind with them!", battler.pbThis))
  }
)

#============================================================================
# Sensory Trickery
#  * All moves have their base accuracy fixed to 85 as long as user is in
#    battle.
#============================================================================
Battle::AbilityEffects::AccuracyCalcFromUser.add(:SENSORYTRICKERY,
  proc { |ability, mods, user, target, move, type|
    mods[:base_accuracy] = 85
	echoln "Applying base accuracy change to user."
  }
)

Battle::AbilityEffects::AccuracyCalcFromTarget.add(:SENSORYTRICKERY,
  proc { |ability, mods, user, target, move, type|
    mods[:base_accuracy] = 85
	echoln "Applying base accuracy change to target."
  }
)

#============================================================================
# Phantasm Dream
#  * User has STAB on all moves. (All phases) - Handled elsewhere
#  * User will have a 75% chance to attack while asleep. (Phase 1) - Handled elsewhere
#  * User become impervious to all attacks regardless of source. (Phase 2)
#  * User will be immune to stat reduction and status conditions. (Phase 3)
#============================================================================
Battle::AbilityEffects::MoveImmunity.add(:PHANTASMDREAM_ALT1,
  proc { |ability, user, target, move, type, battle, show_message|
    if show_message
      battle.pbShowAbilitySplash(target)
      if Battle::Scene::USE_ABILITY_SPLASH
        battle.pbDisplay(_INTL("{1} is completely untouchable!", target.pbThis(true)))
      else
        battle.pbDisplay(_INTL("{1} is completely untouchable in her {2}!", target.pbThis, target.abilityName))
      end
      battle.pbHideAbilitySplash(target)
    end
    next true
  }
)

Battle::AbilityEffects::StatLossImmunity.add(:PHANTASMDREAM_ALT2,
  proc { |ability, battler, stat, battle, showMessages|
    if showMessages
      battle.pbShowAbilitySplash(battler)
      if Battle::Scene::USE_ABILITY_SPLASH
        battle.pbDisplay(_INTL("{1}'s stats cannot be lowered!", battler.pbThis))
      else
        battle.pbDisplay(_INTL("{1}'s {2} prevents stat loss!", battler.pbThis, battler.abilityName))
      end
      battle.pbHideAbilitySplash(battler)
    end
    next true
  }
)

Battle::AbilityEffects::StatusImmunity.add(:PHANTASMDREAM_ALT2,
  proc { |ability, battler, status|
    next true if status == :SLEEP
	next true if status == :PARALYSIS
	next true if status == :FROZEN
	next true if status == :POISON
	next true if status == :BURN
  }
)




#--------------
class Battle::Battler
  alias orig_pbChangeTargets pbChangeTargets
  def pbChangeTargets(move, user, targets)
    targets = orig_pbChangeTargets(move, user, targets)
	target_data = move.pbTarget(user)
    return targets if @battle.switching   # For Pursuit interrupting a switch
    return targets if move.cannotRedirect? || move.targetsPosition?
    return targets if !target_data.can_target_one_foe? || targets.length != 1
    # Dragon Darts already done
    return targets if user.hasActiveAbility?([:PROPELLERTAIL, :STALWART])
    nearOnly = !target_data.can_choose_distant_target?
    # Faithful Sheep
    if targets[0].isSpecies?(:MAKURA)
      targets[0].allAllies.each do |b|
        next if !b.hasActiveAbility?(:FAITHFULSHEEP)
        next if @battle.pbRandom(100) >= 50
        next if nearOnly && !b.near?(user)
        targets.clear
        pbAddTarget(targets, user, b, move, nearOnly)
		b.effects[PBEffects::Intercepted] = true
        break
      end
    end
    return targets
  end
end

class Battle::ActiveSide
  alias intercept_initialize initialize
  def initialize
  	intercept_initialize
	@effects[PBEffects::Intercepted] = false
  end
end

module PBEffects
  Intercepted = 1214
end

