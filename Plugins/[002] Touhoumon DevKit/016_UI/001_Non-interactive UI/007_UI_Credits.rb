#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Added in the relevant credits
#	* Changed the music that plays for the credits
#==============================================================================#
class Scene_Credits
  # Backgrounds to show in credits. Found in Graphics/Titles/ folder
  BACKGROUNDS_LIST       = ["credits1", "credits2", "credits3", "credits4", "credits5"]
  BGM                    = "W-012. Hourai Illusion ~ Far East.ogg"
  SCROLL_SPEED           = 40   # Pixels per second
  SECONDS_PER_BACKGROUND = 11
  TEXT_OUTLINE_COLOR     = Color.new(0, 0, 128, 255)
  TEXT_BASE_COLOR        = Color.new(255, 255, 255, 255)
  TEXT_SHADOW_COLOR      = Color.new(0, 0, 0, 100)

  # This next piece of code is the credits.
  # Start Editing
  CREDIT = <<_END_

--- Touhoumon Development Kit ---
Credits



--- Game Director ---
DerxwnaKapsyla



--- Art Director ---
DerxwnaKapsyla



--- World Director ---
DerxwnaKapsyla



--- Lead Programmer ---
DerxwnaKapsyla



--- Music Composition ---
Mr. Unknown<s>a-TTTempo
Uda-Shi<s>KecleonTencho
brawlman9876<s>Jesslejohn
Magnius<s>DerxwnaKapsyla
Junichi Masuda<s>Go Ichinose
Hitomo Sato<s>Mark DiAngelo
Paradarx<s>Masayoshi Soken
ZUN



--- Sound Effects & Cries ---
Go Ichinose
Morikazu Aoki
a-TTTempo
Uda-Shi
KecleonTencho
Reimufate



--- Game Designers ---
DerxwnaKapsyla



--- Scenario Plot ---
DerxwnaKapsyla



--- Scenario ---
DerxwnaKapsyla




--- Map Designers ---
DerxwnaKapsyla



--- Pokedex Text ---
Mille Materaux
DerxwnaKapsyla



--- Environment and Tool Programmers ---
Maralis: Pokextractor Tools
Maruno: Pokemon Essentials



--- Touhoumon Designers ---
HemoglobinA1C
Stuffman
Mille Marteaux
EXSariel
DoesntKnowHowToPlay
Masa
Reimufate
DerxwnaKapsyla
BulShell


--- Original Designs for the Touhoumon ---
Team Shanghai Alice



--- Beta Testers ---
:wacko:



--- Artwork ---
HemoglobinA1C<s>Maralis
BluShell<s>Stuffman
Spyro<s>Irakuy
Love_Albatross<s>SoulfulLex
zero_breaker<s>Reimufate
Uda-shi<s>KecleonTensho




--- Programmer ---
DerxwnaKapsyla

--- Custom Scripts ---
{INSERTS_PLUGIN_CREDITS_DO_NOT_REMOVE}
SoulfulLex: Various misc improvements

--- Producers ---
ChaoticInfinity Development
Overseer Household



--- Executive Director and Producer ---
DerxwnaKapsyla



--- Special Thanks ---
HemoglobinA1C: Developing Touhou Puppet Play
Maralis: Developing the Pokéxtractor Tools
Mille Marteaux: Localization of Touhoumon 1.812 and Developer of Touhoumon Purple
EX Sariel: Localization of Touhoumon 1.812
DoesntKnowHowToPlay: Developer of Touhoumon Unnamed
AmethystRain & Reborn Dev Team: Permission to use graphical assets
Reimufate: Developer of Touhoumon Reimufate Version
FocasLens & Fantasy Puppet Theater: GNE-YnK- Asset Collection Pack
The Dirty Cog Crew: Emotional support and motivation throughout the years



--- Special Thanks ---
Flameguru: Initial development of Pokémon Essentials
Poccil (Peter O.): Developing Pokémon Essentials
Maruno: Picking up Pokémon Essentials
The "Pokémon Essentials" Development Team

With contributions from:
AvatarMonkeyKirby<s>Marin
Boushy<s>MiDas Mike
Brother1440<s>Near Fantastica
FL.<s>PinkMan
Genzai Kawakami<s>Popper
Golisopod User<s>Rataime
help-14<s>Savordez
IceGod64<s>SoundSpawn
Jacob O. Wobbrock<s>the__end
KitsuneKouta<s>Venom12
Lisa Anthony<s>Wachunga
Luka S.J.<s>
and everyone else who helped out



--- Special Thanks ---
Enterbrain: Developers and Producers of "RPG Maker XP"
GameFreak: Developers of "Pokémon"
ZUN: Head Developer of "Touhou Project"



And YOU...





"mkxp-z" by:
Roza
Based on "mkxp" by Ancurio et al.

"RPG Maker XP" by:
Enterbrain

Pokémon is owned by:
The Pokémon Company
Nintendo
Affiliated with Game Freak

This is a non-profit fan-made game.
No copyright infringements intended.
Please support the official games!

Touhoumon Development Kit
2011-2022<s>DerxwnaKapsyla
2012-2021<s>ChaoticInfinity Development
2020-2022<s>Overseer Household
Based on Pokémon Essentials


Pokémon Essentials
2007-2010<s>Peter O.
2011-2022<s>Maruno
Based on work by Flameguru



This is a non-profit fan-made game.
No copyright infringements intended.
Please support the official games!

_END_
# Stop Editing
end