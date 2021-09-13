#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Adjustments to get the Yin/Yang icons to display for Puppets in the 
#	  Battle interface
#==============================================================================#
class PokemonDataBox < SpriteWrapper

  def refresh
    self.bitmap.clear
    return if !@battler.pokemon
    textPos = []
    imagePos = []
    # Draw background panel
    self.bitmap.blt(0,0,@databoxBitmap.bitmap,Rect.new(0,0,@databoxBitmap.width,@databoxBitmap.height))
    # Draw Pokémon's name
    nameWidth = self.bitmap.text_size(@battler.name).width
    nameOffset = 0
    nameOffset = nameWidth-116 if nameWidth>116
    textPos.push([@battler.name,@spriteBaseX+8-nameOffset,0,false,NAME_BASE_COLOR,NAME_SHADOW_COLOR])
    # Draw Pokémon's gender symbol
	pkmn_data = GameData::Species.get_species_form(@battler.species, @battler.form)
	if pkmn_data.generation <20
	  case @battler.displayGender
	  when 0   # Male
		textPos.push([_INTL("♂"),@spriteBaseX+126,0,false,MALE_BASE_COLOR,MALE_SHADOW_COLOR])
	  when 1   # Female
		textPos.push([_INTL("♀"),@spriteBaseX+126,0,false,FEMALE_BASE_COLOR,FEMALE_SHADOW_COLOR])
	  end
	else
	  case @battler.displayGender
	  when 0   # Yin
		imagepos=[([sprintf("Graphics/icons/yin"),@spriteBaseX+120,10,0,0,-1,-1])]
		pbDrawImagePositions(self.bitmap,imagepos)
	  when 1   # Yang
		imagepos=[([sprintf("Graphics/icons/yang"),@spriteBaseX+120,10,0,0,-1,-1])]
		pbDrawImagePositions(self.bitmap,imagepos)
	  end
	end
    pbDrawTextPositions(self.bitmap,textPos)
    # Draw Pokémon's level
    imagePos.push(["Graphics/Pictures/Battle/overlay_lv",@spriteBaseX+140,16])
    pbDrawNumber(@battler.level,self.bitmap,@spriteBaseX+162,16)
    # Draw shiny icon
    if @battler.shiny?
      shinyX = (@battler.opposes?(0)) ? 206 : -6   # Foe's/player's
      imagePos.push(["Graphics/Pictures/shiny",@spriteBaseX+shinyX,36])
    end
    # Draw Mega Evolution/Primal Reversion icon
    if @battler.mega?
      imagePos.push(["Graphics/Pictures/Battle/icon_mega",@spriteBaseX+8,34])
    elsif @battler.primal?
      primalX = (@battler.opposes?) ? 208 : -28   # Foe's/player's
      if @battler.isSpecies?(:KYOGRE)
        imagePos.push(["Graphics/Pictures/Battle/icon_primal_Kyogre",@spriteBaseX+primalX,4])
      elsif @battler.isSpecies?(:GROUDON)
        imagePos.push(["Graphics/Pictures/Battle/icon_primal_Groudon",@spriteBaseX+primalX,4])
      end
    end
    # Draw owned icon (foe Pokémon only)
    if @battler.owned? && @battler.opposes?(0)
      imagePos.push(["Graphics/Pictures/Battle/icon_own",@spriteBaseX+8,36])
    end
    # Draw status icon
    if @battler.status != :NONE
      s = GameData::Status.get(@battler.status).id_number
      if s == :POISON && @battler.statusCount > 0   # Badly poisoned
        s = GameData::Status::DATA.keys.length / 2
      end
      imagePos.push(["Graphics/Pictures/Battle/icon_statuses",@spriteBaseX+24,36,
         0,(s-1)*STATUS_ICON_HEIGHT,-1,STATUS_ICON_HEIGHT])
    end
    pbDrawImagePositions(self.bitmap,imagePos)
    refreshHP
    refreshExp
  end
end