#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Text changes to remove explicit references to Pokemon
#==============================================================================#
class PokeBattle_Battler
  def pbInitDummyPokemon(pkmn,idxParty)
    raise _INTL("An egg can't be an active battler.") if pkmn.egg?
    @name         = pkmn.name
    @species      = pkmn.species
    @form         = pkmn.form
    @level        = pkmn.level
    @hp           = pkmn.hp
    @totalhp      = pkmn.totalhp
    @type1        = pkmn.type1
    @type2        = pkmn.type2
    # ability and item intentionally not copied across here
    @gender       = pkmn.gender
    @attack       = pkmn.attack
    @defense      = pkmn.defense
    @spatk        = pkmn.spatk
    @spdef        = pkmn.spdef
    @speed        = pkmn.speed
    @status       = pkmn.status
    @statusCount  = pkmn.statusCount
    @pokemon      = pkmn
    @pokemonIndex = idxParty
    @participants = []
    # moves intentionally not copied across here
    @iv           = {}
    GameData::Stat.each_main { |s| @iv[s.id] = pkmn.iv[s.id] }
    @dummy        = true
  end
  
  def pbInitPokemon(pkmn,idxParty)
    raise _INTL("An egg can't be an active battler.") if pkmn.egg?
    @name         = pkmn.name
    @species      = pkmn.species
    @form         = pkmn.form
    @level        = pkmn.level
    @hp           = pkmn.hp
    @totalhp      = pkmn.totalhp
    @type1        = pkmn.type1
    @type2        = pkmn.type2
    @ability_id   = pkmn.ability_id
    @item_id      = pkmn.item_id
    @gender       = pkmn.gender
    @attack       = pkmn.attack
    @defense      = pkmn.defense
    @spatk        = pkmn.spatk
    @spdef        = pkmn.spdef
    @speed        = pkmn.speed
    @status       = pkmn.status
    @statusCount  = pkmn.statusCount
    @pokemon      = pkmn
    @pokemonIndex = idxParty
    @participants = []   # Participants earn Exp. if this battler is defeated
    @moves        = []
    pkmn.moves.each_with_index do |m,i|
      @moves[i] = PokeBattle_Move.from_pokemon_move(@battle,m)
    end
    @iv           = {}
    GameData::Stat.each_main { |s| @iv[s.id] = pkmn.iv[s.id] }
  end
end