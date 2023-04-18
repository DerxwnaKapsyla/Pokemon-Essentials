#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Addition of Severe Hail
#	* Addition of Cruel Sandstorm
#==============================================================================#
GameData::BattleWeather.register({
  :id        => :SevereHail,
  :name      => _INTL("Severe Hail"),
  :animation => "SevereHail"
})

GameData::BattleWeather.register({
  :id        => :CruelSandstorm,
  :name      => _INTL("Cruel Sandstorm"),
  :animation => "CruelSandstorm"
})