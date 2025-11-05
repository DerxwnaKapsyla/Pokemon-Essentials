#==============================================================================#
#                               Touhoumon Asteria                              #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Added in entries for the Type Checker to the Pokegear
#==============================================================================#
class PokemonPokegearScreen

  def pbStartScreen
    # Get all commands
    command_list = []
    commands = []
    MenuHandlers.each_available(:pokegear_menu) do |option, hash, name|
      command_list.push([hash["icon_name"] || "", name])
      commands.push(hash)
    end
    @scene.pbStartScene(command_list)
    # Main loop
    end_scene = false
    loop do
      choice = @scene.pbScene
      if choice < 0
        end_scene = true
        break
      end
      break if commands[choice]["effect"].call(@scene)
    end
    @scene.pbEndScene if end_scene
  end
end

MenuHandlers.add(:pokegear_menu, :checker, {
  "name"      => _INTL("Type Checker"),
  "icon_name" => "checker",
  "order"     => 20,
  "effect"    => proc { |menu|
    pbTypeMatchUI
    next false
  }
})


MenuHandlers.add(:pokegear_menu, :encounter, {
  "name"      => _INTL("Encounter Checker"),
  "icon_name" => "checker",
  "order"     => 30,
  "effect"    => proc { |menu|
    pbViewEncounters
    next false
  }
})


MenuHandlers.add(:pokegear_menu, :phone, {
  "name"      => _INTL("Phone"),
  "icon_name" => "phone",
  "order"     => 20,
  "condition" => proc { next $game_switches[1000] },
  "effect"    => proc { |menu|
    pbFadeOutIn do
      scene = PokemonPhone_Scene.new
      screen = PokemonPhoneScreen.new(scene)
      screen.pbStartScreen
    end
    next false
  }
})

MenuHandlers.add(:pokegear_menu, :jukebox, {
  "name"      => _INTL("Jukebox"),
  "icon_name" => "jukebox",
  "order"     => 30,
  "condition" => proc { next $game_switches[1000] },
  "effect"    => proc { |menu|
    pbFadeOutIn do
      scene = PokemonJukebox_Scene.new
      screen = PokemonJukeboxScreen.new(scene)
      screen.pbStartScreen
    end
    next false
  }
})
