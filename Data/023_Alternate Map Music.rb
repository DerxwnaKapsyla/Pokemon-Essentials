#-----------------------------------
# Code Backbone done by Leilou
# Tweaks done by DerxwnaKapsyla
#
# Used for when a 


class Game_Map
  alias autoplayAsCue_old autoplay


  def autoplay
	newbgm = nil
	  if $game_map && $game_switches[114]	# If the switch for Alternate Map Music is on,
	    case $game_variables[119]			# check this variable, and depending on the number returned...
		  when 0 							# Team Rocket Invasion theme
			POWER_PLANT_MAPS = [79,239]
			if $game_map.map_id == POWER_PLANT_MAPS
				bgmname = "W-021. Team Rocket Attacks.ogg" 
			end 
		  #when 1; bgmname = "Team Rocket HQ"						# Team Rocket Headquarters theme
	    end
	  end
      if PBDayNight.isNight? && FileTest.audio_exist?("Audio/BGM/"+ newbgm + "_n")
        pbCueBGM(newbgm+"_n",1.0,@map.bgm.volume,@map.bgm.pitch)
      else
        pbCueBGM(newbgm,1.0)
      end
      if @map.autoplay_bgs
        pbBGSPlay(@map.bgs)
      end
    else
      autoplayAsCue_old
    end
  end    
end