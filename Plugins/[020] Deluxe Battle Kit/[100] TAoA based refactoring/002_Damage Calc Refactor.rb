#===============================================================================
# Player damage calculation refactoring.
#===============================================================================
# Breaks up and refactors code related to damage calculation to be more easily 
# edited by other plugins to add their own effects. 
#===============================================================================
class Battle::Move

  #-----------------------------------------------------------------------------
  # Calculates damage multipliers from field effects and terrain.
  # * Wind is affected by Mud Sport
  # * Pyro is affected by Water Sport
  # * Nature is affected by Grassy Terrain
  # * Reason is affected by Psychic Terrain
  # * Faith is affected by Misty Terrain
  #-----------------------------------------------------------------------------
  alias dbk_pbCalcDamageMults_Field pbCalcDamageMults_Field
  def pbCalcDamageMults_Field(user, target, numTargets, type, baseDmg, multipliers)
    dbk_pbCalcDamageMults_Field(user, target, numTargets, type, baseDmg, multipliers)
	
	# Mud Sport - Touhoumon Effectiveness
    if type == :WIND18
      if @battle.allBattlers.any? { |b| b.effects[PBEffects::MudSport] }
        multipliers[:power_multiplier] /= 3
      end
      if @battle.field.effects[PBEffects::MudSportField] > 0
        multipliers[:power_multiplier] /= 3
      end
    end
	# Water Sport - Touhoumon Effectiveness
    if type == :FIRE18
      if @battle.allBattlers.any? { |b| b.effects[PBEffects::WaterSport] }
        multipliers[:power_multiplier] /= 3
      end
      if @battle.field.effects[PBEffects::WaterSportField] > 0
        multipliers[:power_multiplier] /= 3
      end
    end
    # Terrain moves
    terrain_multiplier = (Settings::MECHANICS_GENERATION >= 8) ? 1.3 : 1.5
    case @battle.field.terrain
    when :Electric
      if type == :ELECTRIC
        multipliers[:power_multiplier] *= terrain_multiplier if user.affectedByTerrain?
      elsif @function_code == "IncreasePowerInElectricTerrain"
        multipliers[:power_multiplier] *= 1.5 if user.affectedByTerrain?
      end
    when :Grassy
      multipliers[:power_multiplier] *= terrain_multiplier if type == :NATURE18 && user.affectedByTerrain?
    when :Psychic
      multipliers[:power_multiplier] *= terrain_multiplier if type == :REASON18 && user.affectedByTerrain?
    when :Misty
      multipliers[:power_multiplier] /= 2 if type == :FAITH18 && target.affectedByTerrain?
    end
  end
  
  #-----------------------------------------------------------------------------
  # Calculates damage multipliers from weather.
  # * Sun and Rain affect Pyro and Hydro as they would Fire/Water
  # * Sandstorm affects Beast as it would Rock
  # * Hail affects Cryo as it would Ice
  #-----------------------------------------------------------------------------
  alias dbk_pbCalcDamageMults_Weather pbCalcDamageMults_Weather
  def pbCalcDamageMults_Weather(user, target, numTargets, type, baseDmg, multipliers)
    dbk_pbCalcDamageMults_Weather(user, target, numTargets, type, baseDmg, multipliers)
    case user.effectiveWeather
    when :Sun, :HarshSun
      case type
      when :FIRE18
        multipliers[:final_damage_multiplier] *= 1.5
      when :WATER18
        if @function_code = "IncreasePowerInSunWeather"
          multipliers[:final_damage_multiplier] *= 1.5
        else
          multipliers[:final_damage_multiplier] /= 2
        end
      end
    when :Rain, :HeavyRain
      case type
      when :FIRE18
        multipliers[:final_damage_multiplier] /= 2
      when :WATER18
        multipliers[:final_damage_multiplier] *= 1.5
      end
    when :Sandstorm
      if target.pbHasType?(:BEAST18) && specialMove? && @function_code != "UseTargetDefenseInsteadOfTargetSpDef"
        multipliers[:defense_multiplier] *= 1.5
      end
    when :Hail
      if defined?(Settings::HAIL_WEATHER_TYPE) && Settings::HAIL_WEATHER_TYPE > 0 && 
         target.pbHasType?(:ICE18) && (physicalMove? || @function_code == "UseTargetDefenseInsteadOfTargetSpDef")
        multipliers[:defense_multiplier] *= 1.5
      end
	end
  end
  
  #-----------------------------------------------------------------------------
  # Calculates damage multipliers based on typing.
  # * Addition of Phantasm Dream to guarantee always STAB
  # * Phantasm-typed moves never get STAB
  #-----------------------------------------------------------------------------
  def pbCalcDamageMults_Type(user, target, numTargets, type, baseDmg, multipliers)
    # STAB
    if type && user.pbHasType?(type)
      if user.hasActiveAbility?(:ADAPTABILITY)
        multipliers[:final_damage_multiplier] *= 2
      else
        multipliers[:final_damage_multiplier] *= 1.5
      end
	# TAoA Final Boss Ability - STAB regardless of nature
	elsif user.hasActiveAbility?([:PHANTASMDREAM,:PHANTASMDREAM_ALT1,:PHANTASMDREAM_ALT2])
	  multipliers[:final_damage_multiplier] *= 1.5
	# NEVER apply STAB to this type.
	elsif type && user.pbHasType?(:PHANTASM)
	  multipliers[:final_damage_multiplier] *= 1
    end
    # Type effectiveness
    multipliers[:final_damage_multiplier] *= target.damageState.typeMod
  end
end

#===============================================================================
# AI damage calculation refactoring.
#===============================================================================
class Battle::AI::AIMove

  #-----------------------------------------------------------------------------
  # Calculates damage multipliers from other sources.
  # * AI accounts for Charge effect if the move type is Wind
  #-----------------------------------------------------------------------------
  alias dbk_calc_other_mults calc_other_mults
  def calc_other_mults(user, target, base_dmg, calc_type, is_critical, multipliers)
    dbk_calc_other_mults(user, target, base_dmg, calc_type, is_critical, multipliers)
	if @ai.trainer.medium_skill? &&
       user.effects[PBEffects::Charge] > 0 && calc_type == :WIND18
      multipliers[:power_multiplier] *= 2
    end
  end
  
  #-----------------------------------------------------------------------------
  # Calculates damage multipliers from field effects and terrain.
  # * AI accounts for Wind interaction with Mud Sport
  # * AI accounts for Pydro interaction with Water Sport
  # * AI accounts for terrain with relevant types
  #-----------------------------------------------------------------------------
  def calc_field_mults(user, target, base_dmg, calc_type, is_critical, multipliers)
    if @ai.trainer.medium_skill?
      case calc_type
      when :WIND18
        if @ai.battle.allBattlers.any? { |b| b.effects[PBEffects::MudSport] }
          multipliers[:power_multiplier] /= 3
        end
        if @ai.battle.field.effects[PBEffects::MudSportField] > 0
          multipliers[:power_multiplier] /= 3
        end
      when :FIRE18
        if @ai.battle.allBattlers.any? { |b| b.effects[PBEffects::WaterSport] }
          multipliers[:power_multiplier] /= 3
        end
        if @ai.battle.field.effects[PBEffects::WaterSportField] > 0
          multipliers[:power_multiplier] /= 3
        end
      end
    end
    # Terrain moves
    if @ai.trainer.medium_skill?
      terrain_multiplier = (Settings::MECHANICS_GENERATION >= 8) ? 1.3 : 1.5
      case @ai.battle.field.terrain
      when :Electric
        if calc_type == :WIND18
          multipliers[:power_multiplier] *= terrain_multiplier if user.battler.affectedByTerrain?
        elsif function_code == "IncreasePowerInElectricTerrain"
          multipliers[:power_multiplier] *= 1.5 if user_battler.affectedByTerrain?
        end
      when :Grassy
        multipliers[:power_multiplier] *= terrain_multiplier if calc_type == :NATURE18 && user.battler.affectedByTerrain?
      when :Psychic
        multipliers[:power_multiplier] *= terrain_multiplier if calc_type == :REASON18 && user.battler.affectedByTerrain?
      when :Misty
        multipliers[:power_multiplier] /= 2 if calc_type == :FAITH18 && target.battler.affectedByTerrain?
      end
    end
  end
  
  #-----------------------------------------------------------------------------
  # Calculates damage multipliers from weather.
  # * AI properly accounts for weather interaction with Puppet types
  #-----------------------------------------------------------------------------
  alias dbk_calc_weather_mults calc_weather_mults
  def calc_weather_mults(user, target, base_dmg, calc_type, is_critical, multipliers)
  dbk_calc_weather_mults(user, target, base_dmg, calc_type, is_critical, multipliers)
    if @ai.trainer.medium_skill?
      case user.battler.effectiveWeather
      when :Sun, :HarshSun
        case calc_type
        when :FIRE18
          multipliers[:final_damage_multiplier] *= 1.5
        when :WATER18
          if function_code == "IncreasePowerInSunWeather"
            multipliers[:final_damage_multiplier] *= 1.5
          else
            multipliers[:final_damage_multiplier] /= 2
          end
        end
      when :Rain, :HeavyRain
        case calc_type
        when :FIRE18
          multipliers[:final_damage_multiplier] /= 2
        when :WATER18
          multipliers[:final_damage_multiplier] *= 1.5
        end
      when :Sandstorm
        if target.has_type?(:BEAST18) && specialMove?(calc_type) &&
           function_code != "UseTargetDefenseInsteadOfTargetSpDef"
          multipliers[:defense_multiplier] *= 1.5
        end
      when :Hail
        if PluginManager.installed?("Generation 9 Pack") && 
           Settings::HAIL_WEATHER_TYPE > 0 && target.pbHasType?(:ICE18) &&
           (physicalMove?(calc_type) || function_code == "UseTargetDefenseInsteadOfTargetSpDef")
          multipliers[:defense_multiplier] *= 1.5
        end
      end
    end
  end
  
  #-----------------------------------------------------------------------------
  # Calculates damage multipliers based on typing.
  #-----------------------------------------------------------------------------
  def calc_type_mults(user, target, base_dmg, calc_type, is_critical, multipliers)
    if calc_type && user.has_type?(calc_type)
      if user.has_active_ability?(:ADAPTABILITY)
        multipliers[:final_damage_multiplier] *= 2
      else
        multipliers[:final_damage_multiplier] *= 1.5
      end
	# TAoA Final Boss Ability - STAB regardless of nature
	elsif user.has_active_ability?([:PHANTASMDREAM, :PHANTASMDREAM_ALT1, :PHANTASMDREAM_ALT2])
	  multipliers[:final_damage_multiplier] *= 1.5
	elsif user.has_type?(:PHANTASM)
	  multipliers[:final_damage_multiplier] *= 1
    end
    # Type effectiveness
    typemod = target.effectiveness_of_type_against_battler(calc_type, user, @move)
    multipliers[:final_damage_multiplier] *= typemod
  end
end