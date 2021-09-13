#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Added a BGM to play for the trading UI
#==============================================================================#
class PokemonTrade_Scene
  def pbTrade
    pbBGMStop
	pbBGMPlay("U-004. Shanghai Alice of Meiji 17 (Trading).ogg")
    @pokemon.play_cry
    speciesname1=GameData::Species.get(@pokemon.species).name
    speciesname2=GameData::Species.get(@pokemon2.species).name
    pbMessageDisplay(@sprites["msgwindow"],
       _ISPRINTF("{1:s}\r\nID: {2:05d}   OT: {3:s}\\wtnp[0]",
       @pokemon.name,@pokemon.owner.public_id,@pokemon.owner.name)) { pbUpdate }
    pbMessageWaitForInput(@sprites["msgwindow"],50,true) { pbUpdate }
    pbPlayDecisionSE
    pbScene1
    pbMessageDisplay(@sprites["msgwindow"],
       _INTL("For {1}'s {2},\r\n{3} sends {4}.\1",@trader1,speciesname1,@trader2,speciesname2)) { pbUpdate }
    pbMessageDisplay(@sprites["msgwindow"],
       _INTL("{1} bids farewell to {2}.",@trader2,speciesname2)) { pbUpdate }
    pbScene2
    pbMessageDisplay(@sprites["msgwindow"],
       _ISPRINTF("{1:s}\r\nID: {2:05d}   OT: {3:s}\1",
       @pokemon2.name,@pokemon2.owner.public_id,@pokemon2.owner.name)) { pbUpdate }
    pbMessageDisplay(@sprites["msgwindow"],
       _INTL("Take good care of {1}.",speciesname2)) { pbUpdate }
  end
end