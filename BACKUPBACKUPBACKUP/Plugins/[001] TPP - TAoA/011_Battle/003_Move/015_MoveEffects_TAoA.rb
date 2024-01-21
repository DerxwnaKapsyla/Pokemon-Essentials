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
    case @battle.field.terrain
    when :Electric
      @npMove = :THUNDERBOLT18 if GameData::Move.exists?(:THUNDERBOLT18)
    when :Grassy
      @npMove = :ENERGYLIGHT18 if GameData::Move.exists?(:ENERGYLIGHT18)
    when :Misty
      @npMove = :LUNATIC18 if GameData::Move.exists?(:LUNATIC18)
    when :Psychic
      @npMove = :MANABURST18 if GameData::Move.exists?(:MANABURST18)
    else
      try_move = nil
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
      when :Fantasia
        try_move = :MYRIADDREAMS
      end
      @npMove = try_move if GameData::Move.exists?(try_move)
    end
  end

  def pbEffectAgainstTarget(user, target)
    @battle.pbDisplay(_INTL("{1} turned into {2}!", @name, GameData::Move.get(@npMove).name))
    user.pbUseMoveSimple(@npMove, target.index)
  end
end

#===============================================================================
# Hits the foe with a powerful attack. If the move connects, boost all stats 
# by +2, fully restore HP, apply Substitute, maybe more! Imagine!
# (All the Myriad Dreams of Paradise)
#===============================================================================
class Battle::Move::MyriadDreams < Battle::Move

end