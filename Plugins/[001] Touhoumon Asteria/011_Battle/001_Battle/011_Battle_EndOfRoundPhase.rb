class Battle

  def pbEOREndWeather(priority)
    # NOTE: Primordial weather doesn't need to be checked here, because if it
    #       could wear off here, it will have worn off already.
    # Count down weather duration
    @field.weatherDuration -= 1 if @field.weatherDuration > 0
    # Weather wears off
    if @field.weatherDuration == 0
      case @field.weather
      when :Sun       then pbDisplay(_INTL("The sunlight faded."))
      when :Rain      then pbDisplay(_INTL("The rain stopped."))
      when :Sandstorm then pbDisplay(_INTL("The sandstorm subsided."))
      when :Hail      then pbDisplay(_INTL("The hail stopped."))
      when :ShadowSky then pbDisplay(_INTL("The shadow sky faded."))
      end
      @field.weather = :None
      # Check for form changes caused by the weather changing
      allBattlers.each { |battler| battler.pbCheckFormOnWeatherChange }
      # Start up the default weather
      pbStartWeather(nil, @field.defaultWeather) if @field.defaultWeather != :None
      return if @field.weather == :None
    end
    # Weather continues
    weather_data = GameData::BattleWeather.try_get(@field.weather)
    pbCommonAnimation(weather_data.animation) if weather_data
    case @field.weather
    when :Sun         		then pbDisplay(_INTL("The sunlight is strong."))
    when :Rain       		then pbDisplay(_INTL("Rain continues to fall."))
    when :Sandstorm  		then pbDisplay(_INTL("The sandstorm is raging."))
    when :Hail       		then pbDisplay(_INTL("The hail is crashing down."))
    when :HarshSun   		then pbDisplay(_INTL("The sunlight is extremely harsh."))
    when :HeavyRain   		then pbDisplay(_INTL("It is raining heavily."))
    when :StrongWinds 		then pbDisplay(_INTL("The wind is strong."))
    when :ShadowSky   		then pbDisplay(_INTL("The shadow sky continues."))
	when :CruelSandstorm	then pbDisplay(_INTL("The cruel sandstorm is raging."))
	when :SevereHail		then pbDisplay(_INTL("The severe hail is crashing down."))
    end
    # Effects due to weather
    priority.each do |battler|
      # Weather-related abilities
      if battler.abilityActive?
        Battle::AbilityEffects.triggerEndOfRoundWeather(battler.ability, battler.effectiveWeather, battler, self)
        battler.pbFaint if battler.fainted?
      end
      # Weather damage
      pbEORWeatherDamage(battler)
    end
  end
  
  def pbEORWeatherDamage(battler)
    return if battler.fainted?
    amt = -1
    case battler.effectiveWeather
    when :Sandstorm
      return if !battler.takesSandstormDamage?
      pbDisplay(_INTL("{1} is buffeted by the sandstorm!", battler.pbThis))
      amt = battler.totalhp / 16
    when :Hail
      return if !battler.takesHailDamage?
      pbDisplay(_INTL("{1} is buffeted by the hail!", battler.pbThis))
      amt = battler.totalhp / 16
    when :ShadowSky
      return if !battler.takesShadowSkyDamage?
      pbDisplay(_INTL("{1} is hurt by the shadow sky!", battler.pbThis))
      amt = battler.totalhp / 16
    when :CruelSandstorm
      return if !battler.takesSandstormDamage?
      pbDisplay(_INTL("{1} is buffeted by the sandstorm!", battler.pbThis))
      amt = battler.totalhp / 8
    when :SevereHail
      return if !battler.takesHailDamage?
      pbDisplay(_INTL("{1} is buffeted by the hail!", battler.pbThis))
      amt = battler.totalhp / 8
    return if amt < 0
	end
    @scene.pbDamageAnimation(battler)
    battler.pbReduceHP(amt, false)
    battler.pbItemHPHealCheck
    battler.pbFaint if battler.fainted?
  end
end