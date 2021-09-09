#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Added Collector to the check for Fishing abilities, even though it's
#	  unofficial
#	* Removed explicit references to Pokemon
#==============================================================================#
def pbFishing(hasEncounter,rodType=1)
  speedup = ($Trainer.first_pokemon && [:STICKYHOLD, :SUCTIONCUPS, :COLLECTOR].include?($Trainer.first_pokemon.ability_id))
  biteChance = 20+(25*rodType)   # 45, 70, 95
  biteChance *= 1.5 if speedup   # 67.5, 100, 100
  hookChance = 100
  oldpattern = $game_player.fullPattern
  pbFishingBegin
  msgWindow = pbCreateMessageWindow
  ret = false
  loop do
    time = 5+rand(6)
    time = [time,5+rand(6)].min if speedup
    message = ""
    time.times { message += ".   " }
    if pbWaitMessage(msgWindow,time)
      pbFishingEnd
      $game_player.setDefaultCharName(nil,oldpattern)
      pbMessageDisplay(msgWindow,_INTL("Not even a nibble..."))
      break
    end
    if hasEncounter && rand(100)<biteChance
      $scene.spriteset.addUserAnimation(Settings::EXCLAMATION_ANIMATION_ID,$game_player.x,$game_player.y,true,3)
      frames = Graphics.frame_rate - rand(Graphics.frame_rate/2)   # 0.5-1 second
      if !pbWaitForInput(msgWindow,message+_INTL("\r\nOh! A bite!"),frames)
        pbFishingEnd
        $game_player.setDefaultCharName(nil,oldpattern)
        pbMessageDisplay(msgWindow,_INTL("They got away..."))
        break
      end
      if Settings::FISHING_AUTO_HOOK || rand(100) < hookChance
        pbFishingEnd
        pbMessageDisplay(msgWindow,_INTL("Landed something!")) if !Settings::FISHING_AUTO_HOOK
        $game_player.setDefaultCharName(nil,oldpattern)
        ret = true
        break
      end
#      biteChance += 15
#      hookChance += 15
    else
      pbFishingEnd
      $game_player.setDefaultCharName(nil,oldpattern)
      pbMessageDisplay(msgWindow,_INTL("They got away..."))
      break
    end
  end
  pbDisposeMessageWindow(msgWindow)
  return ret
end