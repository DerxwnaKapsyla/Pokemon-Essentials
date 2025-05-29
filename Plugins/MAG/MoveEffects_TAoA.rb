#===============================================================================
# Uses a different move depending on the environment. (Hidden Power)
# This is the Touhoumon variant of the move
# NOTE: This code does not support the Gen 5 and older definition of the move
#       where it targets the user. It makes more sense for it to target another
#       Pokémon.
#===============================================================================
class Battle::Move::UseMoveDependingOnEnvironmentThmn < Battle::Move
  def callsAnotherMove?; return true; end

  def pbOnStartUse(user, targets)
    @npMove = :TRIATTACK18
    try_move = nil
	if GameData::MapMetadata.get($game_map.map_id)&.has_flag?("Fantasia")
      try_move = :MYRIADDREAMS
	else
      case @battle.environment
      when :Grass, :TallGrass, :Forest, :ForestGrass
        try_move = :ENERGYLIGHT18
      when :MovingWater, :StillWater, :Underwater
        try_move = :HYDROPUMP18
      when :Puddle
        try_move = :MUDDYWATTER18
      when :Cave
        try_move = :ROCKSLIDE18
      when :Rock, :Sand
        try_move = :EARTHPOWER18
      when :Snow
        try_move = :BLIZZARD18
      when :Ice
        try_move = :ICEBEAM18
      when :Volcano
        try_move = :LAVAPLUME
      when :Graveyard
        try_move = :SHADOWBALL18
      when :Sky
        try_move = :AIRSLASH18
      when :Space
        try_move = :DRACOMETEOR18
      when :UltraSpace
        try_move = :MANABURST18
      end
	end
    @npMove = try_move if GameData::Move.exists?(try_move)
  end
  
  def pbMoveFailed
    if @npMove == :MYRIADDREAMS && pbRandom(1..100) > 50
	echoln "false"
	  return false
	else
	echoln "true"
	  return true
	end
  end

  def pbEffectAgainstTarget(user, target)
    @battle.pbDisplay(_INTL("{1} turned into {2}!", @name, GameData::Move.get(@npMove).name))
    user.pbUseMoveSimple(@npMove, target.index, -1, false)
  end
end

#===============================================================================
# Inflict a random status condition on a foe (50%)
# Drop a random stat by 1 (25%)
# (Spiral Abyss)
#===============================================================================
class Battle::Move::SpiralAbyss < Battle::Move
	def pbFailsAgainstTarget?(user, target, show_message)
		@statArray = []
		GameData::Stat.each_battle do |s|
			@statArray.push(s.id) if target.pbCanLowerStatStage?(s.id, user, self)
		end
		if @statArray.length == 0
			@battle.pbDisplay(_INTL("{1}'s stats won't go any lower!", target.pbThis)) if show_message
			return true
		end
		return false
	end
	
	def pbEffectAgainstTarget(user, target)
		return if target.fainted?
		echoln "Executing stat lowering check"
		if @battle.pbRandom(100) < 25
			stat = @statArray[@battle.pbRandom(@statArray.length)]
			target.pbLowerStatStage(stat, 1, user)
			echoln stat
		end
	end
	
	def pbAdditionalEffect(user, target)
		return if target.fainted?
		return if target.damageState.substitute
		echoln "Executing status infliction check"
		case @battle.pbRandom(5)
			when 0 then target.pbBurn(user) if target.pbCanBurn?(user, false, self)
			when 1 then target.pbFreeze if target.pbCanFreeze?(user, false, self)
			when 2 then target.pbParalyze(user) if target.pbCanParalyze?(user, false, self)
			when 3 then target.pbPoison(user) if target.pbCanPoison?(user, false, self)
			when 4 then target.pbSleep if target.pbCanSleep?(user, false, self)
		end
	end
end

#===============================================================================
# Two turn move. On turn one, enter charge state. On second turn, attack with a
# 50% chance to paralyze the foe.
# If charge is broken, disable the attacker's move.
# (Prohibatory Signboard)
#===============================================================================
class Battle::Move::ProhibitorySignboard < Battle::Move
  def pbDisplayChargeMessage(user)
    user.effects[PBEffects::ProhibitorySignboard] = true
    @battle.pbCommonAnimation("FocusPunch", user)
    @battle.pbDisplay(_INTL("{1} started charging up energy!", user.pbThis))
  end

  def pbDisplayUseMessage(user)
    super if !user.effects[PBEffects::ProhibitorySignboard] || !user.tookMoveDamageThisRound
  end

  def pbFailsAgainstTarget?(user, target, show_message)
    if user.effects[PBEffects::ProhibitorySignboard] && user.tookMoveDamageThisRound
      @battle.pbDisplay(_INTL("{1}'s charge was interupted!", user.pbThis))
	  if target.effects[PBEffects::Disable] > 0 || !target.lastRegularMoveUsed
	    @battle.pbDisplay(_INTL("...But {1} is already disabled!", target.pbThis)) if show_message
		return true
	  else
        canDisable = false
        target.eachMove do |m|
          next if m.id != target.lastRegularMoveUsed
          next if m.pp == 0 && m.total_pp > 0
          canDisable = true
          break
        end
        if !canDisable
          @battle.pbDisplay(_INTL("But it failed!")) if show_message
          return true
		else
          target.effects[PBEffects::Disable] = 5
	      target.effects[PBEffects::DisableMove] = target.lastRegularMoveUsed
	      @battle.pbDisplay(_INTL("{1}'s {2} was disabled as a result of discharged energy!", 
		                          target.pbThis, GameData::Move.get(target.lastRegularMoveUsed).name))
	      target.pbItemStatusCureCheck
        end
	  end
      return true
    end
    return false
  end
  
  def pbAdditionalEffect(user, target)
    if target.pbCanParalyze?(user, false, self)
      target.pbParalyze(user)
    end
  end
end
#===============================================================================
# Hits X times, where X is the number of fainted Pokemon or Puppets in
# in the user's party (not including partner trainers). Fails if X is 0.
# Base power of each hit depends on the base Attack stat for the species of that
# hit's participant. (Walpurgis Night)
#===============================================================================
class Battle::Move::WalpurgisNight < Battle::Move
  def multiHitMove?; return true; end

  def pbMoveFailed?(user, targets)
    @beatUpList = []
    @battle.eachInTeamFromBattlerIndex(user.index) do |pkmn, i|
      next if pkmn.able?
      @beatUpList.push(i)
    end
    if @beatUpList.length == 0
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    return false
  end

  def pbNumHits(user, targets)
    return @beatUpList.length
  end

  def pbBaseDamage(baseDmg, user, target)
    i = @beatUpList.shift   # First element in array, and removes it from array
    atk = @battle.pbParty(user.index)[i].baseStats[:ATTACK]
    return 5 + (atk / 10)
  end
end

#===============================================================================
# Apply attraction regardless of gender/alignment.
# (Enchanting Cone)
#===============================================================================
class Battle::Move::EnchantingCone < Battle::Move
  def ignoresSubstitute?(user); return true; end

	def pbAdditionalEffect(user, target)
	return if target.damageState.substitute
    return if target.fainted?
    target.pbAttract(user) if target.pbCanAttract?(user, false)
	end
end

#===============================================================================
# Clears all stat changes on hit.
# (Fae Trickery)
#===============================================================================
class Battle::Move::FaeTrickery < Battle::Move
  # Clear Smog does this.
end

#===============================================================================
# High-Powered attack. Will damage user if misses.
# (Lightspeed)
#===============================================================================
class Battle::Move::Lightspeed < Battle::Move
  # High-Jump Kick and Jump Kick do this.
end

#===============================================================================
# Creeping Mycelium
#===============================================================================
class Battle::Move::CreepingMycelium < Battle::Move
  def canMagicCoat?; return true; end

  def pbMoveFailed?(user, targets)
    if user.pbOpposingSide.effects[PBEffects::Miasma] && user.pbOwnSide.effects[PBEffects::Miasma]
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    return false
  end

  def pbEffectGeneral(user)
    if user.pbOpposingSide.effects[PBEffects::Miasma] == false
      user.pbOpposingSide.effects[PBEffects::Miasma] = true
      @battle.pbDisplay(_INTL("Spores scatered in the air around {1}!",
                              user.pbOpposingTeam(true)))
    end
    if user.pbOwnSide.effects[PBEffects::Miasma] == false
      user.pbOwnSide.effects[PBEffects::Miasma] = true
      @battle.pbDisplay(_INTL("Spores scattered in the air around {1}!",
                              user.pbTeam(true)))
    end
  end
end

#===============================================================================
# If move is successful, it steals the stat changes of the foe for itself,
# then sets up Substitute.
# If the user is asleep, then the move will instead heal HP equal to half
# the damage dealt and set up Aurora Veil.
# (Ultimate Dream)
#===============================================================================
class Battle::Move::UltimateDream < Battle::Move
  def ignoresSubstitute?(user); return true; end
  def usableWhenAsleep?; return true; end
  def healingMove?; return Settings::MECHANICS_GENERATION >= 6; end

  def pbEffectGeneral(user)
    if !user.asleep?
      if user.effects[PBEffects::Substitute] == 0
	    @subLife = [user.totalhp / 4, 1].max
	    user.effects[PBEffects::Trapping]     = 0
        user.effects[PBEffects::TrappingMove] = nil
        user.effects[PBEffects::Substitute]   = @subLife
        @battle.pbDisplay(_INTL("{1} put in a substitute!", user.pbThis))
	  end
    end
  end

  def pbEffectAgainstTarget(user, target)
    if user.asleep?
      return if target.damageState.hpLost <= 0
      hpGain = (target.damageState.hpLost).round
      user.pbRecoverHPFromDrain(hpGain, target)
      user.pbOwnSide.effects[PBEffects::AuroraVeil] = 5
      user.pbOwnSide.effects[PBEffects::AuroraVeil] = 8 if user.hasActiveItem?(:LIGHTCLAY)
      #@battle.pbDisplay(_INTL("{1} made {2} stronger against physical and special moves!",@name, user.pbTeam(true)))
    end
  end
  
  def pbCalcDamage(user, target, numTargets = 1)
    if !user.asleep?
      if target.hasRaisedStatStages?
		  pbShowAnimation(@id, user, target, 1)   # Stat stage-draining animation
        @battle.pbDisplay(_INTL("{1} stole the target's boosted stats!", user.pbThis))
        showAnim = true
        GameData::Stat.each_battle do |s|
          next if target.stages[s.id] <= 0
          if user.pbCanRaiseStatStage?(s.id, user, self)
            showAnim = false if user.pbRaiseStatStage(s.id, target.stages[s.id], user, showAnim)
          end
          target.statsLoweredThisRound = true
          target.statsDropped = true
          target.stages[s.id] = 0
        end
      end
    end
    super
  end
end

#===============================================================================
# If the move connects, boost user's stats by +2, then apply Focus Energy,
# Aurora Veil, and Dream Aura.
# (All the Myriad Dreams of Paradise)
#===============================================================================
 class Battle::Move::MyriadDreams < Battle::Move::MultiStatUpMove
  def initialize(battle, move)
	super
    @statUp = [:ATTACK, 2, :DEFENSE, 2, :SPECIAL_ATTACK, 2, :SPECIAL_DEFENSE, 2, :SPEED, 2]
  end
  
  def pbAdditionalEffect(user, target)
    return if target.fainted?
    @battle.pbDisplay(_INTL("{1} was blessed by the power of dreams!", user.pbThis))
    @statUp = [:ATTACK, 2, :DEFENSE, 2, :SPECIAL_ATTACK, 2, :SPECIAL_DEFENSE, 2, :SPEED, 2]    
    showAnim = true
    (@statUp.length / 2).times do |i|
      next if !user.pbCanRaiseStatStage?(@statUp[i * 2], user, self)
      if user.pbRaiseStatStage(@statUp[i * 2], @statUp[(i * 2) + 1], user, showAnim)
        showAnim = false
      end
    end
    if !user.effects[PBEffects::DreamAura]
      user.effects[PBEffects::DreamAura] = true
    end
    if user.effects[PBEffects::FocusEnergy] == 0
      user.effects[PBEffects::FocusEnergy] = 1
    end
    if user.pbOwnSide.effects[PBEffects::AuroraVeil] == 0
      user.pbOwnSide.effects[PBEffects::AuroraVeil] = 5
    end
  end
end

#===============================================================================
# Power is doubled if the target is asleep. (Abyss of Chaos)
#===============================================================================
class Battle::Move::DoublePowerIfTargetAsleep < Battle::Move
  def pbBaseDamage(baseDmg, user, target)
    if target.asleep? &&
       (target.effects[PBEffects::Substitute] == 0 || ignoresSubstitute?(user))
      baseDmg *= 2
    end
    return baseDmg
  end
end

#===============================================================================
# Code pulled from other files
#===============================================================================
class Battle::ActiveSide
alias mag_initialize initialize
  def initialize
  	mag_initialize
	@effects[PBEffects::Miasma] = false
	@effects[PBEffects::DreamAura] = false
  end
end

module PBEffects
  Miasma               = 1213
  DreamAura            = 1213
  ProhibitorySignboard = 3000
end

module Battle::DebugVariables
BATTLER_EFFECTS[PBEffects::ProhibitorySignboard] = {
  name: "Prohibitory Signboard active",
  default: false
}

BATTLER_EFFECTS[PBEffects::DreamAura] = {
  name: "Dream Aura applied",
  default: false
}

SIDE_EFFECTS[PBEffects::Miasma] = {
  name: "Miasma exists",
  default: false
}


end

class Battle
  alias mag_pbEntryHazards pbEntryHazards
  def pbEntryHazards(battler)  
  battler_side = battler.pbOwnSide
  mag_pbEntryHazards(battler)
   # Miasma
    if battler_side.effects[PBEffects::Miasma] && !battler.fainted? && !battler.airborne? && !battler.hasActiveItem?(:HEAVYDUTYBOOTS)
	  effect = pbRandom(3)
	  if battler.pbCanBurn?(nil, false) && effect == 0
	    battler.pbBurn(nil, _INTL("{1} was burnt by the cloud of spores!", battler.pbThis))
	  end
	  if battler.pbCanParalyze?(nil, false) && effect == 1
       battler.pbParalyze(nil, _INTL("{1} was paralyzed by the cloud of spores!", battler.pbThis))
	  end
	  if battler.pbCanPoison?(nil, false) && effect == 2
	    battler.pbPoison(nil, _INTL("{1} was poisoned by the cloud of spores!", battler.pbThis))
	  end
	  if battler.pbCanFreeze?(nil, false) && effect == 3
	    battler.pbFreeze(nil, _INTL("{1} was poisoned by the cloud of spores!", battler.pbThis))
	  end
    end
  end
  
  alias thmn_pbEORHealingEffects pbEORHealingEffects
  def pbEORHealingEffects(priority)
    thmn_pbEORHealingEffects(priority)
    # Dream Aura
    priority.each do |battler|
      next if !battler.effects[PBEffects::DreamAura]
      next if !battler.canHeal?
      hpGain = battler.totalhp / 8
      battler.pbRecoverHP(hpGain)
      pbDisplay(_INTL("Dream Aura restored {1}'s HP!", battler.pbThis(true)))
    end
  end
end

