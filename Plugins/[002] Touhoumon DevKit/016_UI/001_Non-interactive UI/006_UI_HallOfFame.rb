#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Changed the Hall of Fame entry music
#	* Adjusted the script to get the Yin/Yang icons to display for the HoF
#	* Made it so an applause SE plays like in official games
#==============================================================================#
class HallOfFame_Scene
  HALL_OF_FAME_BGM = "U-010. Broken Moon" # Derx: Hall of Fame music changed
  
  def createTrainerBattler
    @sprites["trainer"] = IconSprite.new(@viewport)
    @sprites["trainer"].setBitmap("Graphics/Trainers/AYAKA_2")
    if SINGLE_ROW_OF_POKEMON
      @sprites["trainer"].x = Graphics.width / 2
      @sprites["trainer"].y = 208
    else
      @sprites["trainer"].x = Graphics.width - 96
      @sprites["trainer"].y = 160
    end
    @movements.push([Graphics.width / 2, @sprites["trainer"].x, @sprites["trainer"].y, @sprites["trainer"].y])
    @sprites["trainer"].z = 9
    @sprites["trainer"].ox = @sprites["trainer"].bitmap.width / 2
    @sprites["trainer"].oy = @sprites["trainer"].bitmap.height / 2
    if REMOVE_BARS_WHEN_SHOWING_TRAINER
      @sprites["overlay"].bitmap.clear
      @sprites["hallbars"].visible = false
    end
    if ANIMATION && !SINGLE_ROW_OF_POKEMON   # Trainer Animation
      @sprites["trainer"].x = @movements.last[0]
    else
      timer_start = System.uptime
      loop do
        Graphics.update
        Input.update
        pbUpdate
        break if System.uptime - timer_start >= ENTRY_WAIT_TIME
      end
    end
  end
  
  def writeTrainerData
    if $PokemonGlobal.hallOfFameLastNumber == 1
      totalsec = $stats.time_to_enter_hall_of_fame.to_i
    else
      totalsec = $stats.play_time.to_i
    end
    hour = totalsec / 60 / 60
    min = totalsec / 60 % 60
    pubid = sprintf("%05d", $player.public_ID)
    lefttext = _INTL("Name<r>{1}", $player.name) + "<br>"
    lefttext += _INTL("ID No.<r>{1}", pubid) + "<br>"
    if hour > 0
      lefttext += _INTL("Time<r>{1}h {2}m", hour, min) + "<br>"
    else
      lefttext += _INTL("Time<r>{1}m", min) + "<br>"
    end
#    lefttext += _INTL("Pokédex<r>{1}/{2}",
#                      $player.pokedex.owned_count, $player.pokedex.seen_count) + "<br>"
    @sprites["messagebox"] = Window_AdvancedTextPokemon.new(lefttext)
    @sprites["messagebox"].viewport = @viewport
    @sprites["messagebox"].width = 192 if @sprites["messagebox"].width < 192
    @sprites["msgwindow"] = pbCreateMessageWindow(@viewport)
    pbMessageDisplay(@sprites["msgwindow"],
                     _INTL("Conqueror of the Tower!\nCongratulations!") + "\\^")
  end
  
  def writePokemonData(pokemon, hallNumber = -1)
    overlay = @sprites["overlay"].bitmap
    overlay.clear
    pokename = pokemon.name
    speciesname = pokemon.speciesName
    pkmn_data = GameData::Species.get_species_form(pokemon.species, pokemon.form)
    if pkmn_data.has_flag?("Puppet")
      if pokemon.male?
      	speciesname += "¹"
      elsif pokemon.female?
     	speciesname += "²"
      end
    else
      if pokemon.male?
      	speciesname += "♂"
      elsif pokemon.female?
     	speciesname += "♀"
      end
    end
    pokename += "/" + speciesname
    pokename = _INTL("Egg") + "/" + _INTL("Egg") if pokemon.egg?
    idno = (pokemon.owner.name.empty? || pokemon.egg?) ? "?????" : sprintf("%05d", pokemon.owner.public_id)
    dexnumber = _INTL("No. ???")
    if !pokemon.egg?
      number = @nationalDexList.index(pokemon.species) || 0
      dexnumber = _ISPRINTF("No. {1:03d}", number)
    end
    textPositions = [
      [dexnumber, 32, Graphics.height - 74, :left, TEXT_BASE_COLOR, TEXT_SHADOW_COLOR],
      [pokename, Graphics.width - 192, Graphics.height - 74, :center, TEXT_BASE_COLOR, TEXT_SHADOW_COLOR],
      [_INTL("Lv. {1}", pokemon.egg? ? "?" : pokemon.level),
       64, Graphics.height - 42, :left, TEXT_BASE_COLOR, TEXT_SHADOW_COLOR],
      [_INTL("ID No. {1}", pokemon.egg? ? "?????" : idno),
       Graphics.width - 192, Graphics.height - 42, :center, TEXT_BASE_COLOR, TEXT_SHADOW_COLOR]
    ]
    if hallNumber > -1
      textPositions.push([_INTL("Hall of Fame No."), (Graphics.width / 2) - 104, 6, :left, TEXT_BASE_COLOR, TEXT_SHADOW_COLOR])
      textPositions.push([hallNumber.to_s, (Graphics.width / 2) + 104, 6, :right, TEXT_BASE_COLOR, TEXT_SHADOW_COLOR])
    end
    pbDrawTextPositions(overlay, textPositions)
  end

  def writeWelcome
    overlay = @sprites["overlay"].bitmap
    overlay.clear
    pbDrawTextPositions(overlay, [[_INTL("Welcome to the Hall of Fame!"),
                                   Graphics.width / 2, Graphics.height - 68, :center, TEXT_BASE_COLOR, TEXT_SHADOW_COLOR]])
	pbSEPlay("Applause") # Derx: Official applause sound effect
  end
end