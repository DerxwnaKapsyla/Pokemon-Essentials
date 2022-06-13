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