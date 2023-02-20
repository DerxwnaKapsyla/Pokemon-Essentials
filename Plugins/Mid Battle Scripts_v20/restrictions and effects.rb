####Boss restrictions####
class Battle::Move::OHKO < Battle::Move::FixedDamageMove 
  def pbFailsAgainstTarget?(user, target, show_message)
    if target.level > user.level || target.pbOwnSide.effects[PBEffects::BossProtect] > 0 #OHKO fails against boss
      @battle.pbDisplay(_INTL("{1} is unaffected!", target.pbThis)) if show_message
      return true
    end
    if target.hasActiveAbility?(:STURDY) && !@battle.moldBreaker
      if show_message
        @battle.pbShowAbilitySplash(target)
        if Battle::Scene::USE_ABILITY_SPLASH
          @battle.pbDisplay(_INTL("But it failed to affect {1}!", target.pbThis(true)))
        else
          @battle.pbDisplay(_INTL("But it failed to affect {1} because of its {2}!",
                                  target.pbThis(true), target.abilityName))
        end
        @battle.pbHideAbilitySplash(target)
      end
      return true
    end
    return false
  end
end

class Battle::Move::LowerTargetHPToUserHP < Battle::Move::FixedDamageMove
  def pbFailsAgainstTarget?(user, target, show_message)
    if user.hp >= target.hp || target.pbOwnSide.effects[PBEffects::BossProtect] > 0 #boss
      @battle.pbDisplay(_INTL("But it failed!")) if show_message
      return true
    end
    return false
  end
end

class Battle::Move::TransformUserIntoTarget < Battle::Move
  def pbMoveFailed?(user, targets)
    if user.effects[PBEffects::Transform]
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    return false
  end

  def pbFailsAgainstTarget?(user, target, show_message)
    if target.effects[PBEffects::Transform] ||
       target.effects[PBEffects::Illusion] || target.pbOwnSide.effects[PBEffects::BossProtect] > 0 #boss
      @battle.pbDisplay(_INTL("But it failed!")) if show_message
      return true
    end
    return false
  end
end

Battle::AbilityEffects::OnSwitchIn.add(:IMPOSTER,
  proc { |ability, battler, battle, switch_in|
    next if !switch_in || battler.effects[PBEffects::Transform] || target.pbOwnSide.effects[PBEffects::BossProtect] > 0 #boss
    choice = battler.pbDirectOpposing
    next if choice.fainted?
    next if choice.effects[PBEffects::Transform] ||
            choice.effects[PBEffects::Illusion] ||
            choice.effects[PBEffects::Substitute] > 0 ||
            choice.effects[PBEffects::SkyDrop] >= 0 ||
            choice.semiInvulnerable?
    battle.pbShowAbilitySplash(battler, true)
    battle.pbHideAbilitySplash(battler)
    battle.pbAnimation(:TRANSFORM, battler, choice)
    battle.scene.pbChangePokemon(battler, choice.pokemon)
    battler.pbTransform(choice)
  }
)

class Battle::Move::StartLeechSeedTarget < Battle::Move

  def pbFailsAgainstTarget?(user, target, show_message)
    if target.effects[PBEffects::LeechSeed] >= 0
      @battle.pbDisplay(_INTL("{1} evaded the attack!", target.pbThis)) if show_message
      return true
    end
    if target.pbHasType?(:GRASS) || target.pbOwnSide.effects[PBEffects::BossProtect] > 0 #boss
      @battle.pbDisplay(_INTL("It doesn't affect {1}...", target.pbThis(true))) if show_message
      return true
    end
    return false
  end
end

class Battle::Move::BindTarget < Battle::Move
  def pbEffectAgainstTarget(user, target)
    return if target.fainted? || target.damageState.substitute || target.pbOwnSide.effects[PBEffects::BossProtect] > 0 #boss
    return if target.effects[PBEffects::Trapping] > 0
    # Set trapping effect duration and info
    if user.hasActiveItem?(:GRIPCLAW)
      target.effects[PBEffects::Trapping] = (Settings::MECHANICS_GENERATION >= 5) ? 8 : 6
    else
      target.effects[PBEffects::Trapping] = 5 + @battle.pbRandom(2)
    end
    target.effects[PBEffects::TrappingMove] = @id
    target.effects[PBEffects::TrappingUser] = user.index
    # Message
    msg = _INTL("{1} was trapped in the vortex!", target.pbThis)
    case @id
    when :BIND
      msg = _INTL("{1} was squeezed by {2}!", target.pbThis, user.pbThis(true))
    when :CLAMP
      msg = _INTL("{1} clamped {2}!", user.pbThis, target.pbThis(true))
    when :FIRESPIN
      msg = _INTL("{1} was trapped in the fiery vortex!", target.pbThis)
    when :INFESTATION
      msg = _INTL("{1} has been afflicted with an infestation by {2}!", target.pbThis, user.pbThis(true))
    when :MAGMASTORM
      msg = _INTL("{1} became trapped by Magma Storm!", target.pbThis)
    when :SANDTOMB
      msg = _INTL("{1} became trapped by Sand Tomb!", target.pbThis)
    when :WHIRLPOOL
      msg = _INTL("{1} became trapped in the vortex!", target.pbThis)
    when :WRAP
      msg = _INTL("{1} was wrapped by {2}!", target.pbThis, user.pbThis(true))
    end
    @battle.pbDisplay(msg)
  end
end

class Battle::Move::AttackerFaintsIfUserFaints < Battle::Move #destiny bond
  def pbMoveFailed?(user, targets)
    if (Settings::MECHANICS_GENERATION >= 7 && user.effects[PBEffects::DestinyBondPrevious]) || targets.pbOwnSide.effects[PBEffects::BossProtect] > 0 #boss
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    return false
  end
end

#===============================================================================
# All current battlers will perish after 3 more rounds. (Perish Song)
#===============================================================================
class Battle::Move::StartPerishCountsForAllBattlers < Battle::Move
  def pbMoveFailed?(user, targets)
    failed = true
    targets.each do |b|
      next if b.effects[PBEffects::PerishSong] > 0   # Heard it before
      failed = false
      break
    end
    if failed || targets.pbOwnSide.effects[PBEffects::BossProtect] > 0 #boss
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    return false
  end
end

class Battle::Move::FixedDamageHalfTargetHP < Battle::Move::FixedDamageMove
  def pbFixedDamage(user, target)
	if target.pbOwnSide.effects[PBEffects::BossProtect] > 0
		return (target.hp / 20.0).round
	else 
		return (target.hp / 2.0).round
	end
  end
end

#####boss protection (mist+safeguard)#######
class Battle
  def pbEOREndSideEffects(side, priority)
    # Reflect
    pbEORCountDownSideEffect(side, PBEffects::Reflect,
                             _INTL("{1}'s Reflect wore off!", @battlers[side].pbTeam))
    # Light Screen
    pbEORCountDownSideEffect(side, PBEffects::LightScreen,
                             _INTL("{1}'s Light Screen wore off!", @battlers[side].pbTeam))
    # Safeguard
    pbEORCountDownSideEffect(side, PBEffects::Safeguard,
                             _INTL("{1} is no longer protected by Safeguard!", @battlers[side].pbTeam))
    # Mist
    pbEORCountDownSideEffect(side, PBEffects::Mist,
                             _INTL("{1} is no longer protected by mist!", @battlers[side].pbTeam))
    # Tailwind
    pbEORCountDownSideEffect(side, PBEffects::Tailwind,
                             _INTL("{1}'s Tailwind petered out!", @battlers[side].pbTeam))
    # Lucky Chant
    pbEORCountDownSideEffect(side, PBEffects::LuckyChant,
                             _INTL("{1}'s Lucky Chant wore off!", @battlers[side].pbTeam))
    # Pledge Rainbow
    pbEORCountDownSideEffect(side, PBEffects::Rainbow,
                             _INTL("The rainbow on {1}'s side disappeared!", @battlers[side].pbTeam(true)))
    # Pledge Sea of Fire
    pbEORCountDownSideEffect(side, PBEffects::SeaOfFire,
                             _INTL("The sea of fire around {1} disappeared!", @battlers[side].pbTeam(true)))
    # Pledge Swamp
    pbEORCountDownSideEffect(side, PBEffects::Swamp,
                             _INTL("The swamp around {1} disappeared!", @battlers[side].pbTeam(true)))
    # Aurora Veil
    pbEORCountDownSideEffect(side, PBEffects::AuroraVeil,
                             _INTL("{1}'s Aurora Veil wore off!", @battlers[side].pbTeam))
	# Boss Protection
	pbEORCountDownSideEffect(side, PBEffects::BossProtect,
                             _INTL("{1} is no longer protected!", @battlers[side].pbTeam))
  end
end

class Battle::Battler
  def pbCanInflictStatus?(newStatus, user, showMessages, move = nil, ignoreStatus = false)
    return false if fainted? 
    selfInflicted = (user && user.index == @index)
    # Already have that status problem
    if self.status == newStatus && !ignoreStatus
      if showMessages
        msg = ""
        case self.status
        when :SLEEP     then msg = _INTL("{1} is already asleep!", pbThis)
        when :POISON    then msg = _INTL("{1} is already poisoned!", pbThis)
        when :BURN      then msg = _INTL("{1} already has a burn!", pbThis)
        when :PARALYSIS then msg = _INTL("{1} is already paralyzed!", pbThis)
        when :FROZEN    then msg = _INTL("{1} is already frozen solid!", pbThis)
        end
        @battle.pbDisplay(msg)
      end
      return false
    end
    # Trying to replace a status problem with another one
    if self.status != :NONE && !ignoreStatus && !selfInflicted
      @battle.pbDisplay(_INTL("It doesn't affect {1}...", pbThis(true))) if showMessages
      return false
    end
    # Trying to inflict a status problem on a Pokémon behind a substitute
    if @effects[PBEffects::Substitute] > 0 && !(move && move.ignoresSubstitute?(user)) &&
       !selfInflicted
      @battle.pbDisplay(_INTL("It doesn't affect {1}...", pbThis(true))) if showMessages
      return false
    end
    # Weather immunity
    if newStatus == :FROZEN && [:Sun, :HarshSun].include?(effectiveWeather)
      @battle.pbDisplay(_INTL("It doesn't affect {1}...", pbThis(true))) if showMessages
      return false
    end
    # Terrains immunity
    if affectedByTerrain?
      case @battle.field.terrain
      when :Electric
        if newStatus == :SLEEP
          if showMessages
            @battle.pbDisplay(_INTL("{1} surrounds itself with electrified terrain!", pbThis(true)))
          end
          return false
        end
      when :Misty
        @battle.pbDisplay(_INTL("{1} surrounds itself with misty terrain!", pbThis(true))) if showMessages
        return false
      end
    end
    # Uproar immunity
    if newStatus == :SLEEP && !(hasActiveAbility?(:SOUNDPROOF) && !@battle.moldBreaker)
      @battle.allBattlers.each do |b|
        next if b.effects[PBEffects::Uproar] == 0
        @battle.pbDisplay(_INTL("But the uproar kept {1} awake!", pbThis(true))) if showMessages
        return false
      end
    end
    # Type immunities
    hasImmuneType = false
    case newStatus
    when :SLEEP
      # No type is immune to sleep
    when :POISON
      if !(user && user.hasActiveAbility?(:CORROSION))
        hasImmuneType |= pbHasType?(:POISON)
        hasImmuneType |= pbHasType?(:STEEL)
      end
    when :BURN
      hasImmuneType |= pbHasType?(:FIRE)
    when :PARALYSIS
      hasImmuneType |= pbHasType?(:ELECTRIC) && Settings::MORE_TYPE_EFFECTS
    when :FROZEN
      hasImmuneType |= pbHasType?(:ICE)
    end
    if hasImmuneType
      @battle.pbDisplay(_INTL("It doesn't affect {1}...", pbThis(true))) if showMessages
      return false
    end
    # Ability immunity
    immuneByAbility = false
    immAlly = nil
    if Battle::AbilityEffects.triggerStatusImmunityNonIgnorable(self.ability, self, newStatus)
      immuneByAbility = true
    elsif selfInflicted || !@battle.moldBreaker
      if abilityActive? && Battle::AbilityEffects.triggerStatusImmunity(self.ability, self, newStatus)
        immuneByAbility = true
      else
        allAllies.each do |b|
          next if !b.abilityActive?
          next if !Battle::AbilityEffects.triggerStatusImmunityFromAlly(b.ability, self, newStatus)
          immuneByAbility = true
          immAlly = b
          break
        end
      end
    end
    if immuneByAbility
      if showMessages
        @battle.pbShowAbilitySplash(immAlly || self)
        msg = ""
        if Battle::Scene::USE_ABILITY_SPLASH
          case newStatus
          when :SLEEP     then msg = _INTL("{1} stays awake!", pbThis)
          when :POISON    then msg = _INTL("{1} cannot be poisoned!", pbThis)
          when :BURN      then msg = _INTL("{1} cannot be burned!", pbThis)
          when :PARALYSIS then msg = _INTL("{1} cannot be paralyzed!", pbThis)
          when :FROZEN    then msg = _INTL("{1} cannot be frozen solid!", pbThis)
          end
        elsif immAlly
          case newStatus
          when :SLEEP
            msg = _INTL("{1} stays awake because of {2}'s {3}!",
                        pbThis, immAlly.pbThis(true), immAlly.abilityName)
          when :POISON
            msg = _INTL("{1} cannot be poisoned because of {2}'s {3}!",
                        pbThis, immAlly.pbThis(true), immAlly.abilityName)
          when :BURN
            msg = _INTL("{1} cannot be burned because of {2}'s {3}!",
                        pbThis, immAlly.pbThis(true), immAlly.abilityName)
          when :PARALYSIS
            msg = _INTL("{1} cannot be paralyzed because of {2}'s {3}!",
                        pbThis, immAlly.pbThis(true), immAlly.abilityName)
          when :FROZEN
            msg = _INTL("{1} cannot be frozen solid because of {2}'s {3}!",
                        pbThis, immAlly.pbThis(true), immAlly.abilityName)
          end
        else
          case newStatus
          when :SLEEP     then msg = _INTL("{1} stays awake because of its {2}!", pbThis, abilityName)
          when :POISON    then msg = _INTL("{1}'s {2} prevents poisoning!", pbThis, abilityName)
          when :BURN      then msg = _INTL("{1}'s {2} prevents burns!", pbThis, abilityName)
          when :PARALYSIS then msg = _INTL("{1}'s {2} prevents paralysis!", pbThis, abilityName)
          when :FROZEN    then msg = _INTL("{1}'s {2} prevents freezing!", pbThis, abilityName)
          end
        end
        @battle.pbDisplay(msg)
        @battle.pbHideAbilitySplash(immAlly || self)
      end
      return false
    end
    # Safeguard immunity
    if (pbOwnSide.effects[PBEffects::Safeguard] > 0 || pbOwnSide.effects[PBEffects::BossProtect] > 0) && !selfInflicted && move &&
       !(user && user.hasActiveAbility?(:INFILTRATOR))
      @battle.pbDisplay(_INTL("{1}'s team is protected by Safeguard!", pbThis)) if showMessages
      return false
    end
    return true
  end
    def pbCanSynchronizeStatus?(newStatus, target)
    return false if fainted?
    # Trying to replace a status problem with another one
    return false if self.status != :NONE
    # Terrain immunity
    return false if @battle.field.terrain == :Misty && affectedByTerrain?
    # Type immunities
    hasImmuneType = false
    case newStatus
    when :POISON
      # NOTE: target will have Synchronize, so it can't have Corrosion.
      if !(target && target.hasActiveAbility?(:CORROSION))
        hasImmuneType |= pbHasType?(:POISON)
        hasImmuneType |= pbHasType?(:STEEL)
      end
    when :BURN
      hasImmuneType |= pbHasType?(:FIRE)
    when :PARALYSIS
      hasImmuneType |= pbHasType?(:ELECTRIC) && Settings::MORE_TYPE_EFFECTS
    end
    return false if hasImmuneType
    # Ability immunity
    if Battle::AbilityEffects.triggerStatusImmunityNonIgnorable(self.ability, self, newStatus)
      return false
    end
    if abilityActive? && Battle::AbilityEffects.triggerStatusImmunity(self.ability, self, newStatus)
      return false
    end
    allAllies.each do |b|
      next if !b.abilityActive?
      next if !Battle::AbilityEffects.triggerStatusImmunityFromAlly(b.ability, self, newStatus)
      return false
    end
    # Safeguard immunity
    if (pbOwnSide.effects[PBEffects::Safeguard] > 0 || pbOwnSide.effects[PBEffects::BossProtect] > 0) &&
       !(user && user.hasActiveAbility?(:INFILTRATOR))
      return false
    end
    return true
  end
  
    def pbCanSleepYawn?
    return false if self.status != :NONE
    if affectedByTerrain? && [:Electric, :Misty].include?(@battle.field.terrain)
      return false
    end
    if !hasActiveAbility?(:SOUNDPROOF) && @battle.allBattlers.any? { |b| b.effects[PBEffects::Uproar] > 0 }
      return false
    end
    if Battle::AbilityEffects.triggerStatusImmunityNonIgnorable(self.ability, self, :SLEEP)
      return false
    end
    # NOTE: Bulbapedia claims that Flower Veil shouldn't prevent sleep due to
    #       drowsiness, but I disagree because that makes no sense. Also, the
    #       comparable Sweet Veil does prevent sleep due to drowsiness.
    if abilityActive? && Battle::AbilityEffects.triggerStatusImmunity(self.ability, self, :SLEEP)
      return false
    end
    allAllies.each do |b|
      next if !b.abilityActive?
      next if !Battle::AbilityEffects.triggerStatusImmunityFromAlly(b.ability, self, :SLEEP)
      return false
    end
    # NOTE: Bulbapedia claims that Safeguard shouldn't prevent sleep due to
    #       drowsiness. I disagree with this too. Compare with the other sided
    #       effects Misty/Electric Terrain, which do prevent it.
    return false if (pbOwnSide.effects[PBEffects::Safeguard] > 0 || pbOwnSide.effects[PBEffects::BossProtect] > 0)
    return true
  end
  
    def pbCanConfuse?(user = nil, showMessages = true, move = nil, selfInflicted = false)
    return false if fainted?
    if @effects[PBEffects::Confusion] > 0
      @battle.pbDisplay(_INTL("{1} is already confused.", pbThis)) if showMessages
      return false
    end
    if @effects[PBEffects::Substitute] > 0 && !(move && move.ignoresSubstitute?(user)) &&
       !selfInflicted
      @battle.pbDisplay(_INTL("But it failed!")) if showMessages
      return false
    end
    # Terrains immunity
    if affectedByTerrain? && @battle.field.terrain == :Misty && Settings::MECHANICS_GENERATION >= 7
      @battle.pbDisplay(_INTL("{1} surrounds itself with misty terrain!", pbThis(true))) if showMessages
      return false
    end
    if (selfInflicted || !@battle.moldBreaker) && hasActiveAbility?(:OWNTEMPO)
      if showMessages
        @battle.pbShowAbilitySplash(self)
        if Battle::Scene::USE_ABILITY_SPLASH
          @battle.pbDisplay(_INTL("{1} doesn't become confused!", pbThis))
        else
          @battle.pbDisplay(_INTL("{1}'s {2} prevents confusion!", pbThis, abilityName))
        end
        @battle.pbHideAbilitySplash(self)
      end
      return false
    end
    if (pbOwnSide.effects[PBEffects::Safeguard] > 0 || pbOwnSide.effects[PBEffects::BossProtect] > 0) && !selfInflicted &&
       !(user && user.hasActiveAbility?(:INFILTRATOR))
      @battle.pbDisplay(_INTL("{1}'s team is protected by Safeguard!", pbThis)) if showMessages
      return false
    end
    return true
  end
  
    def pbCanLowerStatStage?(stat, user = nil, move = nil, showFailMsg = false,
                           ignoreContrary = false, ignoreMirrorArmor = false)
    return false if fainted?
    if !@battle.moldBreaker
      # Contrary
      if hasActiveAbility?(:CONTRARY) && !ignoreContrary
        return pbCanRaiseStatStage?(stat, user, move, showFailMsg, true)
      end
      # Mirror Armor
      if hasActiveAbility?(:MIRRORARMOR) && !ignoreMirrorArmor &&
         user && user.index != @index && !statStageAtMin?(stat)
        return true
      end
    end
    if !user || user.index != @index   # Not self-inflicted
      if @effects[PBEffects::Substitute] > 0 &&
         (ignoreMirrorArmor || !(move && move.ignoresSubstitute?(user)))
        @battle.pbDisplay(_INTL("{1} is protected by its substitute!", pbThis)) if showFailMsg
        return false
      end
      if (pbOwnSide.effects[PBEffects::Mist] > 0 || pbOwnSide.effects[PBEffects::BossProtect] > 0) &&
         !(user && user.hasActiveAbility?(:INFILTRATOR))
        @battle.pbDisplay(_INTL("{1} is protected by Mist!", pbThis)) if showFailMsg
        return false
      end
      if abilityActive?
        return false if !@battle.moldBreaker && Battle::AbilityEffects.triggerStatLossImmunity(
          self.ability, self, stat, @battle, showFailMsg
        )
        return false if Battle::AbilityEffects.triggerStatLossImmunityNonIgnorable(
          self.ability, self, stat, @battle, showFailMsg
        )
      end
      if !@battle.moldBreaker
        allAllies.each do |b|
          next if !b.abilityActive?
          return false if Battle::AbilityEffects.triggerStatLossImmunityFromAlly(
            b.ability, b, self, stat, @battle, showFailMsg
          )
        end
      end
    end
    # Check the stat stage
    if statStageAtMin?(stat)
      if showFailMsg
        @battle.pbDisplay(_INTL("{1}'s {2} won't go any lower!",
                                pbThis, GameData::Stat.get(stat).name))
      end
      return false
    end
    return true
  end
  
    def pbLowerAttackStatStageIntimidate(user)
    return false if fainted?
    # NOTE: Substitute intentionally blocks Intimidate even if self has Contrary.
    if @effects[PBEffects::Substitute] > 0
      if Battle::Scene::USE_ABILITY_SPLASH
        @battle.pbDisplay(_INTL("{1} is protected by its substitute!", pbThis))
      else
        @battle.pbDisplay(_INTL("{1}'s substitute protected it from {2}'s {3}!",
                                pbThis, user.pbThis(true), user.abilityName))
      end
      return false
    end
    if Settings::MECHANICS_GENERATION >= 8 && hasActiveAbility?([:OBLIVIOUS, :OWNTEMPO, :INNERFOCUS, :SCRAPPY])
      @battle.pbShowAbilitySplash(self)
      if Battle::Scene::USE_ABILITY_SPLASH
        @battle.pbDisplay(_INTL("{1}'s {2} cannot be lowered!", pbThis, GameData::Stat.get(:ATTACK).name))
      else
        @battle.pbDisplay(_INTL("{1}'s {2} prevents {3} loss!", pbThis, abilityName,
                                GameData::Stat.get(:ATTACK).name))
      end
      @battle.pbHideAbilitySplash(self)
      return false
    end
    if Battle::Scene::USE_ABILITY_SPLASH
      return pbLowerStatStageByAbility(:ATTACK, 1, user, false)
    end
    # NOTE: These checks exist to ensure appropriate messages are shown if
    #       Intimidate is blocked somehow (i.e. the messages should mention the
    #       Intimidate ability by name).
    if !hasActiveAbility?(:CONTRARY)
      if (pbOwnSide.effects[PBEffects::Mist] > 0 || pbOwnSide.effects[PBEffects::BossProtect] > 0)
        @battle.pbDisplay(_INTL("{1} is protected from {2}'s {3} by Mist!",
                                pbThis, user.pbThis(true), user.abilityName))
        return false
      end
      if abilityActive? &&
         (Battle::AbilityEffects.triggerStatLossImmunity(self.ability, self, :ATTACK, @battle, false) ||
          Battle::AbilityEffects.triggerStatLossImmunityNonIgnorable(self.ability, self, :ATTACK, @battle, false))
        @battle.pbDisplay(_INTL("{1}'s {2} prevented {3}'s {4} from working!",
                                pbThis, abilityName, user.pbThis(true), user.abilityName))
        return false
      end
      allAllies.each do |b|
        next if !b.abilityActive?
        if Battle::AbilityEffects.triggerStatLossImmunityFromAlly(b.ability, b, self, :ATTACK, @battle, false)
          @battle.pbDisplay(_INTL("{1} is protected from {2}'s {3} by {4}'s {5}!",
                                  pbThis, user.pbThis(true), user.abilityName, b.pbThis(true), b.abilityName))
          return false
        end
      end
    end
    return false if !pbCanLowerStatStage?(:ATTACK, user)
    return pbLowerStatStageByCause(:ATTACK, 1, user, user.abilityName)
  end
  
end

class Battle::Move::SwapSideEffects < Battle::Move
  def initialize(battle, move)
    super
    @number_effects = [
      PBEffects::AuroraVeil,
      PBEffects::LightScreen,
      PBEffects::Mist,
      PBEffects::Rainbow,
      PBEffects::Reflect,
      PBEffects::Safeguard,
      PBEffects::SeaOfFire,
      PBEffects::Spikes,
      PBEffects::Swamp,
      PBEffects::Tailwind,
      PBEffects::ToxicSpikes,
	  PBEffects::BossProtect
	  
    ]
    @boolean_effects = [
      PBEffects::StealthRock,
      PBEffects::StickyWeb
    ]
  end
end

