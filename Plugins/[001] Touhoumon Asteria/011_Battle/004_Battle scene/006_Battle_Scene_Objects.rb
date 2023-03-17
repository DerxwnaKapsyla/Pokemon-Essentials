#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Adjustments to get the Yin/Yang glyphs to display for Puppets in the 
#	  Battle interface
#	* Adjustments to hide the AI Level when a certain switch is on
#==============================================================================#
class Battle::Scene::PokemonDataBox < Sprite
  
  def draw_level
    return if $game_switches[103] && @battler.opposes?(0)
	# "Lv" graphic
    pbDrawImagePositions(self.bitmap,
      [["Graphics/Pictures/Battle/overlay_lv", @spriteBaseX + 140, 16]]
    )
    # Level number
    pbDrawNumber(@battler.level, self.bitmap, @spriteBaseX + 162, 16)
  end
  
  def draw_gender
    gender = @battler.displayGender
    return if ![0, 1].include?(gender)
	pkmn_data = GameData::Species.get_species_form(@battler.species, @battler.form)
	if pkmn_data.has_flag?("Puppet")
	  gender_text  = (gender == 0) ? _INTL("¹") : _INTL("²")
	else
	  gender_text  = (gender == 0) ? _INTL("♂") : _INTL("♀")
	end
    base_color   = (gender == 0) ? MALE_BASE_COLOR : FEMALE_BASE_COLOR
    shadow_color = (gender == 0) ? MALE_SHADOW_COLOR : FEMALE_SHADOW_COLOR
	if pkmn_data.has_flag?("Puppet")
	  pbDrawTextPositions(self.bitmap, [[gender_text, @spriteBaseX + 122, 12, false, base_color, shadow_color]])
	else
	  pbDrawTextPositions(self.bitmap, [[gender_text, @spriteBaseX + 126, 12, false, base_color, shadow_color]])
	end
  end
  
end