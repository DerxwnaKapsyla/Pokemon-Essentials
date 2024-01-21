#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Additions to the Overworld Weather to make it so it plays an audio file
#	  depending on the weather effect.
#==============================================================================#
class Game_Screen
  alias overworld_weather_sfx weather
	
  def weather(type, power, duration)
    overworld_weather_sfx(type, power, duration)
    case @weather_type
      when :Rain        then pbBGSPlay("Rain")
      when :Storm 		then pbBGSPlay("Storm")
      when :Snow        then pbBGSPlay("Snow")
      when :Blizzard    then pbBGSPlay("Blizzard")
      when :Sandstorm   then pbBGSPlay("Sandstorm")
      when :HeavyRain   then pbBGSPlay("HeavyStorm")
      when :Sun         then pbBGSPlay("Sunny")
      when :Fog         then pbBGSPlay("Fog")
      else                   pbBGSFade(duration)
	end
  end
end


