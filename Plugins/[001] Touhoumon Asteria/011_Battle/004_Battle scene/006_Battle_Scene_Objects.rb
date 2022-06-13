#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Adjustments to get the Yin/Yang glyphs to display for Puppets in the 
#	  Battle interface
#==============================================================================#
class Battle::Scene::PokemonDataBox < SpriteWrapper

  def refresh
    self.bitmap.clear
    return if !@battler.pokemon
    textPos = []
    imagePos = []
    # Draw background panel
    self.bitmap.blt(0, 0, @databoxBitmap.bitmap, Rect.new(0, 0, @databoxBitmap.width, @databoxBitmap.height))
    # Draw Pokémon's name
    nameWidth = self.bitmap.text_size(@battler.name).width
    nameOffset = 0
    nameOffset = nameWidth - 116 if nameWidth > 116
    textPos.push([@battler.name, @spriteBaseX + 8 - nameOffset, 12, false, NAME_BASE_COLOR, NAME_SHADOW_COLOR])
    # Draw Pokémon's gender symbol
	pkmn_data = GameData::Species.get_species_form(@battler.species, @battler.form)
	if pkmn_data.has_flag?("Puppet")
      case @battler.displayGender
      when 0   # Male
      	textPos.push([_INTL("¹"), @spriteBaseX + 126, 12, false, MALE_BASE_COLOR, MALE_SHADOW_COLOR])
      when 1   # Female
      	textPos.push([_INTL("²"), @spriteBaseX + 126, 12, false, FEMALE_BASE_COLOR, FEMALE_SHADOW_COLOR])
      end
    pbDrawTextPositions(self.bitmap, textPos)
	else
      case @battler.displayGender
      when 0   # Male
      	textPos.push([_INTL("♂"), @spriteBaseX + 126, 12, false, MALE_BASE_COLOR, MALE_SHADOW_COLOR])
      when 1   # Female
      	textPos.push([_INTL("♀"), @spriteBaseX + 126, 12, false, FEMALE_BASE_COLOR, FEMALE_SHADOW_COLOR])
      end
    pbDrawTextPositions(self.bitmap, textPos)
	end
    # Draw Pokémon's level
    imagePos.push(["Graphics/Pictures/Battle/overlay_lv", @spriteBaseX + 140, 16])
    pbDrawNumber(@battler.level, self.bitmap, @spriteBaseX + 162, 16)
    # Draw shiny icon
    if @battler.shiny?
      shinyX = (@battler.opposes?(0)) ? 206 : -6   # Foe's/player's
      imagePos.push(["Graphics/Pictures/shiny", @spriteBaseX + shinyX, 36])
    end
    # Draw Mega Evolution/Primal Reversion icon
    if @battler.mega?
      imagePos.push(["Graphics/Pictures/Battle/icon_mega", @spriteBaseX + 8, 34])
    elsif @battler.primal?
      primalX = (@battler.opposes?) ? 208 : -28   # Foe's/player's
      if @battler.isSpecies?(:KYOGRE)
        imagePos.push(["Graphics/Pictures/Battle/icon_primal_Kyogre", @spriteBaseX + primalX, 4])
      elsif @battler.isSpecies?(:GROUDON)
        imagePos.push(["Graphics/Pictures/Battle/icon_primal_Groudon", @spriteBaseX + primalX, 4])
      end
    end
    # Draw owned icon (foe Pokémon only)
    if @battler.owned? && @battler.opposes?(0)
      imagePos.push(["Graphics/Pictures/Battle/icon_own", @spriteBaseX + 8, 36])
    end
    # Draw status icon
    if @battler.status != :NONE
      if @battler.status == :POISON && @battler.statusCount > 0   # Badly poisoned
        s = GameData::Status.count - 1
      else
        s = GameData::Status.get(@battler.status).icon_position
      end
      if s >= 0
        imagePos.push(["Graphics/Pictures/Battle/icon_statuses", @spriteBaseX + 24, 36,
                       0, s * STATUS_ICON_HEIGHT, -1, STATUS_ICON_HEIGHT])
      end
    end
    pbDrawImagePositions(self.bitmap, imagePos)
    refreshHP
    refreshExp
  end
end