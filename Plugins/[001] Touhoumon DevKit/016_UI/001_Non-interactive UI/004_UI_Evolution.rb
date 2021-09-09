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
  def pbEvolution(cancancel=true)
    metaplayer1 = SpriteMetafilePlayer.new(@metafile1,@sprites["rsprite1"])
    metaplayer2 = SpriteMetafilePlayer.new(@metafile2,@sprites["rsprite2"])
    metaplayer1.play
    metaplayer2.play
    pbBGMStop
    @pokemon.play_cry
    pbMEPlay("Evolution start")
    pbMessageDisplay(@sprites["msgwindow"],
       _INTL("\\se[]What? {1} is evolving!\\^",@pokemon.name)) { pbUpdate }
    pbMessageWaitForInput(@sprites["msgwindow"],50,true) { pbUpdate }
    pbPlayDecisionSE
    oldstate  = pbSaveSpriteState(@sprites["rsprite1"])
    oldstate2 = pbSaveSpriteState(@sprites["rsprite2"])
    pbBGMPlay("U-002. Our Hisou Tensoku (Evolution).ogg")
    canceled = false
    begin
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
    end while metaplayer1.playing? && metaplayer2.playing?
    pbFlashInOut(canceled,oldstate,oldstate2)
    if canceled
      pbMessageDisplay(@sprites["msgwindow"],
         _INTL("Huh? {1} stopped evolving!",@pokemon.name)) { pbUpdate }
    else
      pbEvolutionSuccess
    end
  end
end