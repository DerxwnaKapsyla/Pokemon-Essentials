#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Made the scene more accurate by adding audio before evolution
#	* Changed the theme used for the evolution scene
#==============================================================================#
class PokemonEvolutionScene
  def pbEvolution(cancancel = true)
    metaplayer1 = SpriteMetafilePlayer.new(@metafile1, @sprites["rsprite1"])
    metaplayer2 = SpriteMetafilePlayer.new(@metafile2, @sprites["rsprite2"])
    metaplayer1.play
    metaplayer2.play
    pbBGMStop
    pbMEPlay("Evolution start")
    pbMessageDisplay(@sprites["msgwindow"], "\\se[]" + _INTL("What?") + "\\1") { pbUpdate }
    pbPlayDecisionSE
    @pokemon.play_cry
    @sprites["msgwindow"].text = _INTL("{1} is evolving!", @pokemon.name)
    timer = 0.0
    loop do
      Graphics.update
      Input.update
      pbUpdate
      timer += Graphics.delta_s
      break if timer >= 1.0
    end
    oldstate  = pbSaveSpriteState(@sprites["rsprite1"])
    oldstate2 = pbSaveSpriteState(@sprites["rsprite2"])
    
    pbBGMPlay("U-002. Our Hisou Tensoku (Evolution).ogg")
    canceled = false
    loop do
      pbUpdateNarrowScreen
      metaplayer1.update
      metaplayer2.update
      Graphics.update
      Input.update
      pbUpdate(true)
      if Input.trigger?(Input::BACK) && cancancel
        pbBGMStop
        pbPlayCancelSE
        canceled = true
        break
      end
      break unless metaplayer1.playing? && metaplayer2.playing?
    end
    pbFlashInOut(canceled, oldstate, oldstate2)
    if canceled
      $stats.evolutions_cancelled += 1
      pbMessageDisplay(@sprites["msgwindow"],
                       _INTL("Huh? {1} stopped evolving!", @pokemon.name)) { pbUpdate }
    else
      pbEvolutionSuccess
    end
  end
end