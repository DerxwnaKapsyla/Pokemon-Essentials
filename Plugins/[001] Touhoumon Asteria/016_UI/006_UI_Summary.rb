#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Adjustments to get the Yin/Yang icons to display for Puppets in the
#	  Summary screen
#==============================================================================#
class PokemonSummary_Scene
  def drawPage(page)
    if @pokemon.egg?
      drawPageOneEgg
      return
    end
    @sprites["itemicon"].item = @pokemon.item_id
    overlay = @sprites["overlay"].bitmap
    overlay.clear
    base   = Color.new(248, 248, 248)
    shadow = Color.new(104, 104, 104)
    # Set background image
    @sprites["background"].setBitmap("Graphics/Pictures/Summary/bg_#{page}")
    imagepos = []
    # Show the Poké Ball containing the Pokémon
    ballimage = sprintf("Graphics/Pictures/Summary/icon_ball_%s", @pokemon.poke_ball)
    imagepos.push([ballimage, 14, 60])
    # Show status/fainted/Pokérus infected icon
    status = -1
    if @pokemon.fainted?
      status = GameData::Status.count
    elsif @pokemon.status != :NONE
      status = GameData::Status.get(@pokemon.status).icon_position
    elsif @pokemon.pokerusStage == 1
      status = GameData::Status.count + 1
    end
    if status >= 0
      imagepos.push(["Graphics/Pictures/statuses", 124, 100, 0, 16 * status, 44, 16])
    end
    # Show Pokérus cured icon
    if @pokemon.pokerusStage == 2
      imagepos.push([sprintf("Graphics/Pictures/Summary/icon_pokerus"), 176, 100])
    end
    # Show shininess star
    if @pokemon.shiny?
      imagepos.push([sprintf("Graphics/Pictures/shiny"), 2, 134])
    end
    # Draw all images
    pbDrawImagePositions(overlay, imagepos)
    # Write various bits of text
    pagename = [_INTL("INFO"),
                _INTL("TRAINER MEMO"),
                _INTL("SKILLS"),
                _INTL("MOVES"),
                _INTL("RIBBONS")][page - 1]
    textpos = [
      [pagename, 26, 22, 0, base, shadow],
      [@pokemon.name, 46, 68, 0, base, shadow],
      [@pokemon.level.to_s, 46, 98, 0, Color.new(64, 64, 64), Color.new(176, 176, 176)],
      [_INTL("Item"), 66, 324, 0, base, shadow]
    ]
    # Write the held item's name
    if @pokemon.hasItem?
      textpos.push([@pokemon.item.name, 16, 358, 0, Color.new(64, 64, 64), Color.new(176, 176, 176)])
    else
      textpos.push([_INTL("None"), 16, 358, 0, Color.new(192, 200, 208), Color.new(208, 216, 224)])
    end
    # Write the gender symbol
	pkmn_data = GameData::Species.get_species_form(@pokemon.species, @pokemon.form)
	if pkmn_data.has_flag?("Puppet")
      if @pokemon.male?
      	textpos.push([_INTL("¹"), 178, 68, 0, Color.new(24, 112, 216), Color.new(136, 168, 208)])
      elsif @pokemon.female?
      	textpos.push([_INTL("²"), 178, 68, 0, Color.new(248, 56, 32), Color.new(224, 152, 144)])
      end
    else
      if @pokemon.male?
      	textpos.push([_INTL("♂"), 178, 68, 0, Color.new(24, 112, 216), Color.new(136, 168, 208)])
      elsif @pokemon.female?
      	textpos.push([_INTL("♀"), 178, 68, 0, Color.new(248, 56, 32), Color.new(224, 152, 144)])
      end
    end
    # Draw all text
    pbDrawTextPositions(overlay, textpos)
    # Draw the Pokémon's markings
    drawMarkings(overlay, 84, 292)
    # Draw page-specific information
    case page
    when 1 then drawPageOne
    when 2 then drawPageTwo
    when 3 then drawPageThree
    when 4 then drawPageFour
    when 5 then drawPageFive
    end
  end
  
#==============================================================================#
# Changes in this section include the following:
#	* Removed explicit references to Pokemon
#==============================================================================#
  def drawPageOneEgg
    @sprites["itemicon"].item = @pokemon.item_id
    overlay = @sprites["overlay"].bitmap
    overlay.clear
    base   = Color.new(248, 248, 248)
    shadow = Color.new(104, 104, 104)
    # Set background image
    @sprites["background"].setBitmap("Graphics/Pictures/Summary/bg_egg")
    imagepos = []
    # Show the Poké Ball containing the Pokémon
    ballimage = sprintf("Graphics/Pictures/Summary/icon_ball_%s", @pokemon.poke_ball)
    imagepos.push([ballimage, 14, 60])
    # Draw all images
    pbDrawImagePositions(overlay, imagepos)
    # Write various bits of text
    textpos = [
      [_INTL("TRAINER MEMO"), 26, 22, 0, base, shadow],
      [@pokemon.name, 46, 68, 0, base, shadow],
      [_INTL("Item"), 66, 324, 0, base, shadow]
    ]
    # Write the held item's name
    if @pokemon.hasItem?
      textpos.push([@pokemon.item.name, 16, 358, 0, Color.new(64, 64, 64), Color.new(176, 176, 176)])
    else
      textpos.push([_INTL("None"), 16, 358, 0, Color.new(192, 200, 208), Color.new(208, 216, 224)])
    end
    # Draw all text
    pbDrawTextPositions(overlay, textpos)
    memo = ""
    # Write date received
    if @pokemon.timeReceived
      date  = @pokemon.timeReceived.day
      month = pbGetMonthName(@pokemon.timeReceived.mon)
      year  = @pokemon.timeReceived.year
      memo += _INTL("<c3=404040,B0B0B0>{1} {2}, {3}\n", date, month, year)
    end
    # Write map name egg was received on
    mapname = pbGetMapNameFromId(@pokemon.obtain_map)
    mapname = @pokemon.obtain_text if @pokemon.obtain_text && !@pokemon.obtain_text.empty?
    if mapname && mapname != ""
      memo += _INTL("<c3=404040,B0B0B0>A mysterious Egg received from <c3=F83820,E09890>{1}<c3=404040,B0B0B0>.\n", mapname)
    else
      memo += _INTL("<c3=404040,B0B0B0>A mysterious Egg.\n", mapname)
    end
    memo += "\n" # Empty line
    # Write Egg Watch blurb
    memo += _INTL("<c3=404040,B0B0B0>\"The Egg Watch\"\n")
    eggstate = _INTL("It looks like this Egg will take a long time to hatch.")
    eggstate = _INTL("What will hatch from this? It doesn't seem close to hatching.") if @pokemon.steps_to_hatch < 10_200
    eggstate = _INTL("It appears to move occasionally. It may be close to hatching.") if @pokemon.steps_to_hatch < 2550
    eggstate = _INTL("Sounds can be heard coming from inside! It will hatch soon!") if @pokemon.steps_to_hatch < 1275
    memo += sprintf("<c3=404040,B0B0B0>%s\n", eggstate)
    # Draw all text
    drawFormattedTextEx(overlay, 232, 86, 268, memo)
    # Draw the Pokémon's markings
    drawMarkings(overlay, 84, 292)
  end
end