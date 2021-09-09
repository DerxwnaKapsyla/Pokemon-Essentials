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
  ENTRYMUSIC = "U-005. Broken Moon (Hall of Fame Mix).ogg" # Derx: Hall of Fame music changed
  
  def writePokemonData(pokemon,hallNumber=-1)
    overlay=@sprites["overlay"].bitmap
    overlay.clear
    pokename=pokemon.name
    speciesname=pokemon.speciesName
    pkmn_data = GameData::Species.get_species_form(pokemon.species, pokemon.form)
	if pkmn_data.generation <20
	  if pokemon.male?
		speciesname+="♂"
      elsif pokemon.female?
		speciesname+="♀"
      end
	else
	  if pokemon.male?
		speciesname
      elsif pokemon.female?
		speciesname
      end
	end
    pokename+="/"+speciesname
    pokename=_INTL("Egg")+"/"+_INTL("Egg") if pokemon.egg?
    idno=(pokemon.owner.name.empty? || pokemon.egg?) ? "?????" : sprintf("%05d",pokemon.owner.public_id)
    dexnumber = _INTL("No. ???")
    if !pokemon.egg?
      species_data = GameData::Species.get(pokemon.species)
      dexnumber = _ISPRINTF("No. {1:03d}",species_data.id_number)
    end
    textPositions=[
       [dexnumber,32,Graphics.height-86,0,BASECOLOR,SHADOWCOLOR],
       [pokename,Graphics.width-192,Graphics.height-86,2,BASECOLOR,SHADOWCOLOR],
       [_INTL("Lv. {1}",pokemon.egg? ? "?" : pokemon.level),
           64,Graphics.height-54,0,BASECOLOR,SHADOWCOLOR],
       [_INTL("IDNo.{1}",pokemon.egg? ? "?????" : idno),
           Graphics.width-192,Graphics.height-54,2,BASECOLOR,SHADOWCOLOR]
    ]
    if (hallNumber>-1)
      textPositions.push([_INTL("Hall of Fame No."),Graphics.width/2-104,-6,0,BASECOLOR,SHADOWCOLOR])
      textPositions.push([hallNumber.to_s,Graphics.width/2+104,-6,1,BASECOLOR,SHADOWCOLOR])
    end
    pbDrawTextPositions(overlay,textPositions)
	iconoffset=overlay.text_size(pokename).width/2 + Graphics.width-192
	if pkmn_data.generation == 20 && pokemon.isMale?
	  pbDrawImagePositions(overlay,[
		["Graphics/Icons/yin",iconoffset,Graphics.height-80,0,0,-1,-1]
	  ])
	elsif pkmn_data.generation == 20 && pokemon.isFemale?
		pbDrawImagePositions(overlay,[
		  ["Graphics/Icons/yang",iconoffset,Graphics.height-80,0,0,-1,-1]
		])
	end
  end
  
  def writeWelcome
    overlay=@sprites["overlay"].bitmap
    overlay.clear
    pbDrawTextPositions(overlay,[[_INTL("Welcome to the Hall of Fame!"),
       Graphics.width/2,Graphics.height-80,2,BASECOLOR,SHADOWCOLOR]])
	pbSEPlay("Applause") # Derx: Official applause sound effect
  end
end