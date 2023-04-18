#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Adds in Special Battle handlers for when Wish is used.
#==============================================================================#
class Battle
  def pbThisEx(idxBattler, idxParty)
    party = pbParty(idxBattler)
    if opposes?(idxBattler)
	  if $game_switches[Settings::SPECIAL_BATTLE_SWITCH]
		case $game_variables[Settings::SPECIAL_BATTLE_VARIABLE]
		  when 1	then sbName = "The territorial"
		  when 2	then sbName = "The aggressive"
		  when 3	then sbName = "Celadon Gym's"
		  when 4	then sbName = "A trainer's"
		  else			 sbName = "The wild"
		end
		return _INTL("{2} {1}",party[idxParty].name,sbName)
	  else
		return _INTL("The opposing {1}",party[idxParty].name) if trainerBattle?
		return _INTL("The wild {1}",party[idxParty].name)
	  end
    end
    return _INTL("The ally {1}",party[idxParty].name) if !pbOwnedByPlayer?(idxBattler)
    return party[idxParty].name
  end
  
#==============================================================================#
# Changes in this section include the following:
#	* Adds in checks for Hisouten and Unconcious to return the effective weather
#	  state.
#==============================================================================#  
  def pbWeather
    return :None if allBattlers.any? { |b| b.hasActiveAbility?([:CLOUDNINE, :AIRLOCK, :HISOUTEN, :UNCONCIOUS]) }
    return @field.weather
  end
  
#==============================================================================#
# Changes in this section include the following:
#	* Removing explicit references to Pokemon as an individual species.
#	* Added in Severe Hail and Cruel Sandstorm
#==============================================================================#  
  def pbStartWeather(user, newWeather, fixedDuration = false, showAnim = true)
    return if @field.weather == newWeather
    @field.weather = newWeather
    duration = (fixedDuration) ? 5 : -1
    if duration > 0 && user && user.itemActive?
      duration = Battle::ItemEffects.triggerWeatherExtender(user.item, @field.weather,
                                                            duration, user, self)
    end
    @field.weatherDuration = duration
    weather_data = GameData::BattleWeather.try_get(@field.weather)
    pbCommonAnimation(weather_data.animation) if showAnim && weather_data
    pbHideAbilitySplash(user) if user
    case @field.weather
    when :Sun         		then pbDisplay(_INTL("The sunlight turned harsh!"))
    when :Rain        		then pbDisplay(_INTL("It started to rain!"))
    when :Sandstorm   		then pbDisplay(_INTL("A sandstorm brewed!"))
    when :Hail        		then pbDisplay(_INTL("It started to hail!"))
    when :HarshSun    		then pbDisplay(_INTL("The sunlight turned extremely harsh!"))
    when :HeavyRain   		then pbDisplay(_INTL("A heavy rain began to fall!"))
	when :StrongWinds 		then pbDisplay(_INTL("Mysterious strong winds are protecting Flying-types!"))
    when :ShadowSky   		then pbDisplay(_INTL("A shadow sky appeared!"))
	when :SevereHail		then pbDisplay(_INTL("It started to hail severely!"))
	when :CruelSandstorm	then pbDisplay(_INTL("A cruel sandstorm brewed!"))
    end
    # Check for end of primordial weather, and weather-triggered form changes
    allBattlers.each { |b| b.pbCheckFormOnWeatherChange }
    pbEndPrimordialWeather
  end

#==============================================================================#
# Changes in this section include the following:
#	* Addition of Severe Hail and Cruel Sandstorm
#==============================================================================#  
  alias asteria_pbEndPrimordialWeather pbEndPrimordialWeather
  def pbEndPrimordialWeather
	asteria_pbEndPrimordialWeather
	case @field.weather
	when :SevereHail
      if !pbCheckGlobalAbility(:FROZENWORLD)
        @field.weather = :None
        pbDisplay("The severe hail stopped!")
      end
	when :CruelSandstorm
      if !pbCheckGlobalAbility(:ARIDWASTES)
        @field.weather = :None
        pbDisplay("The severe hail stopped!")
      end
	end
  end

  def pbStartWeatherAbility(new_weather, battler, ignore_primal = false)
	return if !ignore_primal && [:HarshSun, :HeavyRain, :StrongWinds, 
								 :SevereHail, :CruelSandstorm].include?(@field.weather)
    return if @field.weather == new_weather
    pbShowAbilitySplash(battler)
    if !Scene::USE_ABILITY_SPLASH
      pbDisplay(_INTL("{1}'s {2} activated!", battler.pbThis, battler.abilityName))
    end
    fixed_duration = false
    fixed_duration = true if Settings::FIXED_DURATION_WEATHER_FROM_ABILITY &&
                             ![:HarshSun, :HeavyRain, :StrongWinds,
							   :SevereHail, :CruelSandstorm].include?(new_weather)
    pbStartWeather(battler, new_weather, fixed_duration)
    # NOTE: The ability splash is hidden again in def pbStartWeather.
  end
end