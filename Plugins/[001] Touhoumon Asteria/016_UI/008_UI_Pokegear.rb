#==============================================================================#
#                               Touhoumon Asteria                              #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Added in entries for the Quest Log to the Pokegear
#	* Added in entries for the Type Checker to the Pokegear
#==============================================================================#
class PokemonPokegearScreen

  def pbStartScreen
    commands = []
    cmdMap     = -1
    cmdPhone   = -1
    cmdJukebox = -1
	cmdQuests  = -1
    commands[cmdMap = commands.length]     = ["map",_INTL("Map")]
    if $PokemonGlobal.phoneNumbers && $PokemonGlobal.phoneNumbers.length>0
      commands[cmdPhone = commands.length] = ["phone",_INTL("Phone")]
    end
    commands[cmdJukebox = commands.length] = ["jukebox",_INTL("Jukebox")]
	commands[cmdQuests = commands.length] = ["quests",_INTL("Quests")]
	commands[cmdTypeCheck = commands.length] = ["checker",_INTL("Type Checker")]
    @scene.pbStartScene(commands)
    loop do
      cmd = @scene.pbScene
      if cmd<0
        break
      elsif cmdMap>=0 && cmd==cmdMap
        pbShowMap(-1,false)
      elsif cmdPhone>=0 && cmd==cmdPhone
        pbFadeOutIn {
          PokemonPhoneScene.new.start
        }
      elsif cmdJukebox>=0 && cmd==cmdJukebox
        pbFadeOutIn {
          scene = PokemonJukebox_Scene.new
          screen = PokemonJukeboxScreen.new(scene)
          screen.pbStartScreen
        }
		elsif cmdQuests>=0 && cmd==cmdQuests
		  pbFadeOutIn {
			pbViewQuests
		}
		elsif cmdTypeCheck>=0 && cmd==cmdTypeCheck
		  pbFadeOutIn {
			pbTypeMatchUI
		}
      end
    end
    @scene.pbEndScene
  end
end