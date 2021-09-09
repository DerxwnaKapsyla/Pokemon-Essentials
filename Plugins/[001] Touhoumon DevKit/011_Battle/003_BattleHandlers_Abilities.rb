#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Additions of the Touhoumon unique abilities
#	* Tweaks to existing abilities to account for Touhoumon mechanics
#	* Addition of duplicate handlers for Touhoumon abilities
#	* Removed explicit references to Pokemon
#==============================================================================#

BattleHandlers::StatusImmunityAbility.copy(:MAGMAARMOR,:FIREVEIL)

BattleHandlers::StatusCureAbility.copy(:MAGMAARMOR,:FIREVEIL)

BattleHandlers::StatLossImmunityAbility.copy(:CLEARBODY,:WHITESMOKE,:HAKUREIMIKO,:BARRIER)

BattleHandlers::StatLossImmunityAbility.copy(:HYPERCUTTER,:HISTRENGTH)

BattleHandlers::MoveImmunityTargetAbility.add(:FLASHFIRE,
  proc { |ability,user,target,move,type,battle|
    next false if user.index==target.index
    next false if type != :FIRE
	next false if type != :FIRE18
    battle.pbShowAbilitySplash(target)
    if !target.effects[PBEffects::FlashFire]
      target.effects[PBEffects::FlashFire] = true
      if PokeBattle_SceneConstants::USE_ABILITY_SPLASH
        battle.pbDisplay(_INTL("The power of {1}'s Fire-type moves rose!",target.pbThis(true)))
      else
        battle.pbDisplay(_INTL("The power of {1}'s Fire-type moves rose because of its {2}!",
           target.pbThis(true),target.abilityName))
      end
    else
      if PokeBattle_SceneConstants::USE_ABILITY_SPLASH
        battle.pbDisplay(_INTL("It doesn't affect {1}...",target.pbThis(true)))
      else
        battle.pbDisplay(_INTL("{1}'s {2} made {3} ineffective!",
           target.pbThis,target.abilityName,move.name))
      end
    end
    battle.pbHideAbilitySplash(target)
    next true
  }
)

BattleHandlers::MoveImmunityTargetAbility.add(:LIGHTNINGROD,
  proc { |ability,user,target,move,type,battle|
    next pbBattleMoveImmunityStatAbility(user,target,move,type,:ELECTRIC,:SPECIAL_ATTACK,1,battle)
	next pbBattleMoveImmunityStatAbility(user,target,move,type,:WIND18,:SPECIAL_ATTACK,1,battle)
  }
)

BattleHandlers::MoveImmunityTargetAbility.add(:SAPSIPPER,
  proc { |ability,user,target,move,type,battle|
    next pbBattleMoveImmunityStatAbility(user,target,move,type,:GRASS,:ATTACK,1,battle)
	next pbBattleMoveImmunityStatAbility(user,target,move,type,:NATURE18,:ATTACK,1,battle)
  }
)

BattleHandlers::MoveImmunityTargetAbility.add(:STORMDRAIN,
  proc { |ability,user,target,move,type,battle|
    next pbBattleMoveImmunityStatAbility(user,target,move,type,:WATER,:SPECIAL_ATTACK,1,battle)
	next pbBattleMoveImmunityStatAbility(user,target,move,type,:WATER18,:SPECIAL_ATTACK,1,battle)
  }
)

BattleHandlers::MoveImmunityTargetAbility.add(:TELEPATHY,
  proc { |ability,user,target,move,type,battle|
    next false if move.statusMove?
    next false if user.index==target.index || target.opposes?(user)
    battle.pbShowAbilitySplash(target)
    if PokeBattle_SceneConstants::USE_ABILITY_SPLASH
      battle.pbDisplay(_INTL("{1} avoids attacks by its ally!",target.pbThis(true)))
    else
      battle.pbDisplay(_INTL("{1} avoids attacks by its ally with {2}!",
         target.pbThis,target.abilityName))
    end
    battle.pbHideAbilitySplash(target)
    next true
  }
)

BattleHandlers::MoveImmunityTargetAbility.add(:VOLTABSORB,
  proc { |ability,user,target,move,type,battle|
    next pbBattleMoveImmunityHealAbility(user,target,move,type,:ELECTRIC,battle)
	next pbBattleMoveImmunityHealAbility(user,target,move,type,:WIND18,battle)
  }
)

BattleHandlers::MoveImmunityTargetAbility.add(:WATERABSORB,
  proc { |ability,user,target,move,type,battle|
    next pbBattleMoveImmunityHealAbility(user,target,move,type,:WATER,battle)
	next pbBattleMoveImmunityHealAbility(user,target,move,type,:WATER18,battle)
  }
)

BattleHandlers::MoveImmunityTargetAbility.copy(:WONDERGUARD,:PLAYGHOST)

BattleHandlers::AccuracyCalcUserAbility.copy(:COMPOUNDEYES,:FOCUS)

BattleHandlers::AccuracyCalcTargetAbility.add(:LIGHTNINGROD,
  proc { |ability,mods,user,target,move,type|
    mods[:base_accuracy] = 0 if (type == :ELECTRIC ||
								 type == :WIND18)
  }
)

BattleHandlers::AccuracyCalcTargetAbility.add(:STORMDRAIN,
  proc { |ability,mods,user,target,move,type|
    mods[:base_accuracy] = 0 if (type == :WATER ||
								 type == :WATER18)
  }
)

BattleHandlers::DamageCalcUserAbility.add(:BLAZE,
  proc { |ability,user,target,move,mults,baseDmg,type|
    if user.hp <= user.totalhp / 3 && (type == :FIRE ||
									   type == :FIRE18)
      mults[:attack_multiplier] *= 1.5
    end
  }
)

BattleHandlers::DamageCalcUserAbility.add(:FLASHFIRE,
  proc { |ability,user,target,move,mults,baseDmg,type|
    if user.effects[PBEffects::FlashFire] && (type == :FIRE ||
											  type == :FIRE18)
      mults[:attack_multiplier] *= 1.5
    end
  }
)

BattleHandlers::DamageCalcUserAbility.copy(:HUGEPOWER,:PUREPOWER,:UNZAN)

BattleHandlers::DamageCalcUserAbility.add(:OVERGROW,
  proc { |ability,user,target,move,mults,baseDmg,type|
    if user.hp <= user.totalhp / 3 && (type == :GRASS
									   type == :NATURE18)
      mults[:attack_multiplier] *= 1.5
    end
  }
)

BattleHandlers::DamageCalcUserAbility.add(:SANDFORCE,
  proc { |ability,user,target,move,mults,baseDmg,type|
    if user.battle.pbWeather == :Sandstorm &&
       [:ROCK, :GROUND, :STEEL, :EARTH18, :BEAST18, :STEEL18].include?(type)
      mults[:base_damage_multiplier] *= 1.3
    end
  }
)

BattleHandlers::DamageCalcUserAbility.add(:INNERPOWER,
  proc { |ability,user,target,move,mults,baseDmg,type|
    if user.hp <= user.totalhp / 3 && type == :DREAM18
      mults[:attack_multiplier] *= 1.5
    end
  }
)

BattleHandlers::DamageCalcUserAbility.add(:TORRENT,
  proc { |ability,user,target,move,mults,baseDmg,type|
    if user.hp <= user.totalhp / 3 && (type == :WATER ||
									   type == :WATER18)
      mults[:attack_multiplier] *= 1.5
    end
  }
)

BattleHandlers::DamageCalcTargetAbility.add(:DRYSKIN,
  proc { |ability,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.25 if (type == :FIRE ||
											   type == :FIRE18)
  }
)

BattleHandlers::DamageCalcTargetAbility.add(:HEATPROOF,
  proc { |ability,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] /= 2 if (type == :FIRE ||
											type == :FIRE18)
  }
)

BattleHandlers::DamageCalcTargetAbility.copy(:MARVELSCALE,:SPRINGCHARM)
#BattleHandlers::DamageCalcTargetAbility.add(:SPRINGCHARM,
#  proc { |ability,user,target,move,mults,baseDmg,type|
#    if target.pbHasAnyStatus? && move.physicalMove?
#      mults[:defense_multiplier] *= 1.5
#    end
#  }
#)

BattleHandlers::DamageCalcTargetAbility.add(:THICKFAT,
  proc { |ability,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] /= 2 if type == :FIRE || type == :ICE ||
										   type == :FIRE18 || type == :ICE18
  }
)

BattleHandlers::DamageCalcTargetAbility.copy(:THICKFAT,:ICEWALL)

BattleHandlers::CriticalCalcTargetAbility.copy(:BATTLEARMOR,:SHELLARMOR,:GUARDARMOR)

BattleHandlers::TargetAbilityOnHit.copy(:EFFECTSPORE,:INFECTIOUS)

BattleHandlers::TargetAbilityOnHit.add(:DOLLWALL,
  proc { |ability,user,target,move,battle|
    next if !move.pbContactMove?(user)
    battle.pbShowAbilitySplash(target)
    if user.takesIndirectDamage?(PokeBattle_SceneConstants::USE_ABILITY_SPLASH) &&
       user.affectedByContactEffect?(PokeBattle_SceneConstants::USE_ABILITY_SPLASH)
      battle.scene.pbDamageAnimation(user)
      user.pbReduceHP(user.totalhp/16,false)
      if PokeBattle_SceneConstants::USE_ABILITY_SPLASH
        battle.pbDisplay(_INTL("{1} is hurt!",user.pbThis))
      else
        battle.pbDisplay(_INTL("{1} is hurt by {2}'s {3}!",user.pbThis,
           target.pbThis(true),target.abilityName))
      end
    end
    battle.pbHideAbilitySplash(target)
  }
)

BattleHandlers::TargetAbilityOnHit.add(:RETRIBUTION,
  proc { |ability,user,target,move,battle|
    next if !move.pbContactMove?(user)
    battle.pbShowAbilitySplash(target)
    if user.takesIndirectDamage?(PokeBattle_SceneConstants::USE_ABILITY_SPLASH) &&
       user.affectedByContactEffect?(PokeBattle_SceneConstants::USE_ABILITY_SPLASH)
      battle.scene.pbDamageAnimation(user)
      user.pbReduceHP((user.pbReduceHP(900)).floor)
      if PokeBattle_SceneConstants::USE_ABILITY_SPLASH
        battle.pbDisplay(_INTL("{1} was not prepared!",user.pbThis))
      else
        battle.pbDisplay(_INTL("{1} was not prepared for {2}'s {3}!",user.pbThis,
           target.pbThis(true),target.abilityName))
      end
    end
    battle.pbHideAbilitySplash(target)
  }
)

BattleHandlers::TargetAbilityOnHit.copy(:POISONPOINT,:POISONBODY)

BattleHandlers::UserAbilityOnHit.add(:POISONTOUCH,
  proc { |ability,user,target,move,battle|
    next if !move.contactMove?
    next if battle.pbRandom(100)>=30
    battle.pbShowAbilitySplash(user)
    if (target.hasActiveAbility?(:SHIELDDUST) ||
		target.hasActiveAbility?(:ADVENT)) && !battle.moldBreaker
      battle.pbShowAbilitySplash(target)
      if !PokeBattle_SceneConstants::USE_ABILITY_SPLASH
        battle.pbDisplay(_INTL("{1} is unaffected!",target.pbThis))
      end
      battle.pbHideAbilitySplash(target)
    elsif target.pbCanPoison?(user,PokeBattle_SceneConstants::USE_ABILITY_SPLASH)
      msg = nil
      if !PokeBattle_SceneConstants::USE_ABILITY_SPLASH
        msg = _INTL("{1}'s {2} poisoned {3}!",user.pbThis,user.abilityName,target.pbThis(true))
      end
      target.pbPoison(user,msg)
    end
    battle.pbHideAbilitySplash(user)
  }
)

BattleHandlers::UserAbilityEndOfMove.add(:MAGICIAN,
  proc { |ability,user,targets,move,battle|
    next if battle.futureSight
    next if !move.pbDamagingMove?
    next if user.item
    next if battle.wildBattle? && user.opposes?
    targets.each do |b|
      next if b.damageState.unaffected || b.damageState.substitute
      next if !b.item
      next if b.unlosableItem?(b.item) || user.unlosableItem?(b.item)
      battle.pbShowAbilitySplash(user)
      if (b.hasActiveAbility?(:STICKYHOLD) || b.hasActiveAbility?(:COLLECTOR))
        battle.pbShowAbilitySplash(b) if user.opposes?(b)
        if PokeBattle_SceneConstants::USE_ABILITY_SPLASH
          battle.pbDisplay(_INTL("{1}'s item cannot be stolen!",b.pbThis))
        end
        battle.pbHideAbilitySplash(b) if user.opposes?(b)
        next
      end
      user.item = b.item
      b.item = nil
      b.effects[PBEffects::Unburden] = true
      if battle.wildBattle? && !user.initialItem && user.item == b.initialItem
        user.setInitialItem(user.item)
        b.setInitialItem(nil)
      end
      if PokeBattle_SceneConstants::USE_ABILITY_SPLASH
        battle.pbDisplay(_INTL("{1} stole {2}'s {3}!",user.pbThis,
           b.pbThis(true),user.itemName))
      else
        battle.pbDisplay(_INTL("{1} stole {2}'s {3} with {4}!",user.pbThis,
           b.pbThis(true),user.itemName,user.abilityName))
      end
      battle.pbHideAbilitySplash(user)
      user.pbHeldItemTriggerCheck
      break
    end
  }
)

BattleHandlers::UserAbilityEndOfMove.add(:GEHABURN,
  proc { |ability,user,targets,move,battle|
    next if battle.pbAllFainted?(user.idxOpposingSide)
    numFainted = 0
    targets.each { |b| numFainted += 1 if b.damageState.fainted }
    next if numFainted==0 || !user.pbCanRaiseStatStage?(:ATTACK,user)
	battle.pbDisplay(_INTL("{1} drew power from {2} by defeating their foes!",user.pbThis,
		user.abilityName))
    user.pbRaiseStatStageByAbility(:ATTACK,numFainted,user)
  }
)

BattleHandlers::TargetAbilityAfterMoveUse.copy(:COLORCHANGE,:MYSTERIOUS)

BattleHandlers::TargetAbilityAfterMoveUse.add(:PICKPOCKET,
  proc { |ability,target,user,move,switched,battle|
    # NOTE: According to Bulbapedia, this can still trigger to steal the user's
    #       item even if it was switched out by a Red Card. This doesn't make
    #       sense, so this code doesn't do it.
    next if battle.wildBattle? && target.opposes?
    next if !move.contactMove?
    next if switched.include?(user.index)
    next if user.effects[PBEffects::Substitute]>0 || target.damageState.substitute
    next if target.item || !user.item
    next if user.unlosableItem?(user.item) || target.unlosableItem?(user.item)
    battle.pbShowAbilitySplash(target)
    if (user.hasActiveAbility?(:STICKYHOLD) || user.hasActiveAbility?(:COLLECTOR))
      battle.pbShowAbilitySplash(user) if target.opposes?(user)
      if PokeBattle_SceneConstants::USE_ABILITY_SPLASH
        battle.pbDisplay(_INTL("{1}'s item cannot be stolen!",user.pbThis))
      end
      battle.pbHideAbilitySplash(user) if target.opposes?(user)
      battle.pbHideAbilitySplash(target)
      next
    end
    target.item = user.item
    user.item = nil
    user.effects[PBEffects::Unburden] = true
    if battle.wildBattle? && !target.initialItem && target.item == user.initialItem
      target.setInitialItem(target.item)
      user.setInitialItem(nil)
    end
    battle.pbDisplay(_INTL("{1} pickpocketed {2}'s {3}!",target.pbThis,
       user.pbThis(true),target.itemName))
    battle.pbHideAbilitySplash(target)
    target.pbHeldItemTriggerCheck
  }
)

BattleHandlers::EORHealingAbility.copy(:SHEDSKIN,:MAINTENANCE)

# Derx: Renamed 1.8 Shadow Tag to Piercing Stare so it doesn't work like Pokemon's Shadow Tag.
BattleHandlers::TrappingTargetAbility.copy(:ARENATRAP,:PIERCINGSTARE)

BattleHandlers::AbilityOnSwitchIn.copy(:AIRLOCK,:CLOUDNINE,:HISOUTEN,:UNCONCIOUS)

BattleHandlers::AbilityOnSwitchIn.add(:LUCIDDREAMING,
  proc { |ability,battler,battle|
    battle.pbShowAbilitySplash(battler)
    battle.pbDisplay(_INTL("{1} is a sleepwalker!",battler.pbThis))
    battle.pbHideAbilitySplash(battler)
  }
)

BattleHandlers::AbilityChangeOnBattlerFainting.add(:POWEROFALCHEMY,
  proc { |ability,battler,fainted,battle|
    next if battler.opposes?(fainted)
    next if fainted.ungainableAbility? ||
       [:POWEROFALCHEMY, :RECEIVER, :TRACE, :WONDERGUARD, :PLAYGHOST].include?(fainted.ability_id)
    battle.pbShowAbilitySplash(battler,true)
    battler.ability = fainted.ability
    battle.pbReplaceAbilitySplash(battler)
    battle.pbDisplay(_INTL("{1}'s {2} was taken over!",fainted.pbThis,fainted.abilityName))
    battle.pbHideAbilitySplash(battler)
  }
)