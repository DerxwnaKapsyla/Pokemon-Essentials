#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Feel free to Add, Remove, or Change anything here at your leisure.
# Use the Settings script section to get an example of what is and isn't
# available to modify.
# - DerxwnaKapsyla
#==============================================================================#
module Settings
#  SHINY_POKEMON_CHANCE = $PokemonGlobal.sake ? 256 : 16 # If active, increase rate 16-fold.
                                                        # This should be a reasonable amount, right?
														
  #-----------------------------------------------------------------------------
  # Credits
  #-----------------------------------------------------------------------------
  def self.game_credits
    if pbGet(105) == 1
	  return [
        _INTL("---- Touhou Puppet Play ----"),
        _INTL("--- The Mansion of Mystery ---"),
        _INTL("Credits"),
		"",
        _INTL("--- Game Director ---"),
        "DerxwnaKapsyla",
        "",
        _INTL("--- Art Director ---"),
        "DerxwnaKapsyla",
        "",
        _INTL("--- World Director ---"),
        "DerxwnaKapsyla",
        "",
        _INTL("--- Lead Programmer ---"),
        "DerxwnaKapsyla",
        "",
        _INTL("--- Music Compositions ---"),
        "U2 Akiyama<s>a-TTTempo",
		"Uda-Shi<s>KecleonTencho",
		"Veloreon<s>Mr. Unknown",
		"Amane<s>brawlman9876",
		"danmaq<s>ZUN",
		"Ludwig van Beethoven",
		"",
		_INTL("--- Sound Effects & Cries ---"),
		"Go Ichinose<s>Morikazu Aoki",
		"a-TTTempo<s>Reimufate",
		"Uda-Shi<s>KecleonTencho",
		"",
		_INTL("--- Scenario Plot & Writing ---"),
		"DerxwnaKapsyla",
		"FionaKaenbyou",
		"",
		_INTL("--- Map Designers ---"),
		"DerxwnaKapsyla",
		"",
		_INTL("--- Dex Entry Text ---"),
		"Mille Marteaux",
		"DerxwnaKapsyla",
		"",
		_INTL("--- Environment & Tool Programmers ---"),
		"Alicia: Pokextractor Tools",
		"Maruno: Essentials Engine",
		"",
		_INTL("--- Puppet Designers ---"),
		"HemoglobinA1C<s>Stuffman",
		"Mille Marteaux<s>EXSariel",
		"DoesntKnowHowToPlay",
		"Masa<s>Reimufate",
		"DerxwnaKapsyla",
		"BluShell",
		"",
		_INTL("--- Touhou Project Designer ---"),
		"Team Shanghai Alice",
		"",
		_INTL("--- Beta Testers ---"),
		"Akiraita",
		"",
		_INTL("--- Artwork ---"),
		"HemoglobinA1C<s>Alicia",
		"BluShell<s>Stuffman",
		"Spyro<s>Irakuy",
		"Love_Albatross<s>SoulfulLex",
		"zero_breaker<s>Reimufate",
		"Uda-Shi<s>KecleonTencho",
		"AmethystRain",
		"Fantasy Puppet Theater",
		"",
		_INTL("--- Producer ---"),
		"ChaoticInfinity Development",
		"",
		_INTL("--- Special Thanks ---"),
		"- HemoglobinA1C & a-TTTempo -",
		"Creators of Touhou Puppet Play",
		"",
		"- FocasLens & Fantasy Puppet Theater -",
		"Developers of Gensou Ningyou Enbu and",
		"the Yume no Kakera Asset Collection Pack",
		"",
		"- Alicia -",
		"Developing the Pokextractor Tools",
		"",
		"- Mille Marteaux & EXSariel -",
		"Localization of Touhou Puppet Play 1.812",
		"Developer of Touhoumon Purple",
		"Developer of Shoddy Touhoumon",
		"",
		"- DoesntKnowHowToPlay -",
		"Developer of Touhoumon Unnamed",
		"",
		"- AmethystRain & Reborn Dev Team -",
		"Reborn Graphical Assets and Animations",
		"",
		"- Reimufate -",
		"Developer of Touhoumon Reimufate Version",
		"",
		"- FionaKaenbyou -",
		"Writing the dialogue for basicaly every trainer",
		"",
		"- Floofgear -",
		"Emotional support and motivation throughout the years",
		"",
		"- Eeveeexpo, Relic Castle, Game Dev Cafe -",
		"For putting up with my absurdity",
		"",
      ]
	elsif pbGet(105) == 2
	  return [
        _INTL("Touhou Puppet Play"),
        "The Festival of Curses",
        "",
		"Developed by: DerxwnaKapsyla",
        _INTL("Also involved were:"),
        "A. Lee Uss<s>Anne O'Nymus",
        "Ecksam Pell<s>Jane Doe",
        "Joe Dan<s>Nick Nayme",
        "Sue Donnim<s>",
        "",
        _INTL("Special thanks to:"),
        "Pizza"
      ]
	elsif pbGet(105) == 3
	  return [
        _INTL("Touhou Puppet Play"),
        "The Kingdom of Lunacy",
        "",
		"Developed by: DerxwnaKapsyla",
        _INTL("Also involved were:"),
        "A. Lee Uss<s>Anne O'Nymus",
        "Ecksam Pell<s>Jane Doe",
        "Joe Dan<s>Nick Nayme",
        "Sue Donnim<s>",
        "",
        _INTL("Special thanks to:"),
        "Pizza"
      ]
	else
	  return [
        _INTL("Touhou Puppet Play"),
        "The Adventures of Ayaka",
        "",
		"Developed by: DerxwnaKapsyla",
        _INTL("Also involved were:"),
        "A. Lee Uss<s>Anne O'Nymus",
        "Ecksam Pell<s>Jane Doe",
        "Joe Dan<s>Nick Nayme",
        "Sue Donnim<s>",
        "",
        _INTL("Special thanks to:"),
        "Pizza"
      ]	
	end
  end
  
  def self.closing_credits
	return [
      _INTL("Touhou Puppet Play"),
      "The Adventures of Ayaka",
      "",
	  "Developed by: DerxwnaKapsyla",
      _INTL("Also involved were:"),
      "A. Lee Uss<s>Anne O'Nymus",
      "Ecksam Pell<s>Jane Doe",
      "Joe Dan<s>Nick Nayme",
      "Sue Donnim<s>",
      "",
      _INTL("Special thanks to:"),
      "Pizza"
      ]	
  end
end