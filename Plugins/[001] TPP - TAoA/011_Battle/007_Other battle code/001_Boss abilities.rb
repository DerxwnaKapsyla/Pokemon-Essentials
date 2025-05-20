#============================================================================
# Faithful Sheep
#  * When Makura Puppets are on the field, user gains +2 to Def/SpDef
#  * When Makura is targeted, user has a 50% chance to intercept attack.
#    If triggered, user's Attack and Special Attack are boosted by 1.
#============================================================================


#============================================================================
# Abyssal Dream
#  * When a foe is asleep, user drains their health to restore HP to all
#    battlers on their side.
#============================================================================
Battle::AbilityEffects::EndOfRoundEffect.add(:ABYSSALDREAM,
  proc { |ability, battler, battle|
    battle.allOtherSideBattlers(battler.index).each do |b|
      next if !b.near?(battler) || !b.asleep?
      battle.pbShowAbilitySplash(battler)
      next if !b.takesIndirectDamage?(Battle::Scene::USE_ABILITY_SPLASH)
	  hp_drained = 0
      b.pbTakeEffectDamage(b.totalhp / 8) do |hp_lost|
        if Battle::Scene::USE_ABILITY_SPLASH
          battle.pbDisplay(_INTL("{1} is tormented!", b.pbThis))
        else
          battle.pbDisplay(_INTL("{1} is trapped in {2}'s {3}!",b.pbThis, battler.pbThis(true), battler.abilityName))
        end
        hp_drained = hp_drained + hp_lost # Combined hp lost pool
        battle.pbHideAbilitySplash(battler)
      end
    end
    next if hp_drained < 0
    hp_restored = hp_drained / 2
    battle.pbDisplay(_INTL("{1} absorbed their foe's dreams!", battler.pbThis(true)))
    battle.allSameSideBattlers(battler.index).each do |b|
      battler.pbRecoverHP(hp_restored)
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
    next if user.fainted?
	next if !move.contactMove?
    next if target.effects[PBEffects::MeanLook] 
    battle.pbShowAbilitySplash(user)
    if Battle::Scene::USE_ABILITY_SPLASH
      battle.pbDisplay(_INTL("{1} was ensnared!", user.pbThis))
    else
      battle.pbDisplay(_INTL("{1} ensnared {2} in an inescapable helix!", user.pbThis, target.pbThis(true)))
    end
	target.effects[PBEffects::MeanLook] = user.index
    battle.pbHideAbilitySplash(target)
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
    next if user.confused? || battle.pbRandom(100) >= 30
    battle.pbShowAbilitySplash(target)
    if user.pbCanConfuse?(target, Battle::Scene::USE_ABILITY_SPLASH) &&
       user.affectedByContactEffect?(Battle::Scene::USE_ABILITY_SPLASH)
      msg = nil
      if !Battle::Scene::USE_ABILITY_SPLASH
        msg = _INTL("{1}'s {2} confused {3}!",
           target.pbThis, target.abilityName, user.pbThis(true))
      end
      user.pbConfuse(target, msg)
    end
    battle.pbHideAbilitySplash(target)
  }
)

#============================================================================
# Daidarabotchi's Night
#  * User's accuracy is raised by 1 stage for every 2 Puppets fallen in battle.
#============================================================================
Battle::AbilityEffects::DamageCalcFromUser.add(:DAIDARABOTCHINIGHT,
  proc { |ability, user, target, move, mults, baseDmg, type|
    bonus = user.effects[PBEffects::DaidarabotchiNight]
    next if bonus <= 0
    mults[:power_multiplier] *= (1 + (0.1 * bonus))
  }
)

Battle::AbilityEffects::OnSwitchIn.add(:DAIDARABOTCHINIGHT,
  proc { |ability, battler, battle, switch_in|
    numFainted = [5, battler.num_fainted_allies].min
	numFainted = numFainted + [5, battler.num_fainted_foes].min
	numFainted = (numFainted / 2).floor
    next if numFainted <= 0
    battle.pbShowAbilitySplash(battler)
    battle.pbDisplay(_INTL("{1} gained strength from the fallen!", battler.pbThis))
    battler.effects[PBEffects::DaidarabotchiNight] = numFainted
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
    @battle.pbDisplay(_INTL("{1} flew in so fast they brought a tailwind with them!", battler.pbTeam(true)))
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
  }
)

Battle::AbilityEffects::AccuracyCalcFromTarget.add(:SENSORYTRICKERY,
  proc { |ability, mods, user, target, move, type|
    mods[:base_accuracy] = 85
  }
)

#============================================================================
# Ultimate Dream
#  * User has STAB on all moves. (All phases) - Handled elsewhere
#  * User will have a 75% chance to attack while asleep. (Phase 1) - Handled elsewhere?
#  * User become impervious to all attacks regardless of source. (Phase 2)
#  * User will be immune to stat reduction and status conditions. (Phase 3)
#============================================================================
Battle::AbilityEffects::MoveImmunity.add(:ULTIMATEDREAM_2,
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

Battle::AbilityEffects::StatLossImmunity.add(:ULTIMATEDREAM_3,
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

Battle::AbilityEffects::StatusImmunity.add(:ULTIMATEDREAM_3,
  proc { |ability, battler, status|
    next true if status == :SLEEP
	next true if status == :PARALYSIS
	next true if status == :FROZEN
	next true if status == :POISON
	next true if status == :BURN
  }
)