class TrainerBattle
  def self.dx_start(foes, rules = {}, midbattle = {})
    #$game_temp.dx_rules     = rules
    #$game_temp.dx_midbattle = midbattle
    foe_size = 0
    foes.each { |f| foe_size += 1 if f.is_a?(Array) || f.is_a?(Symbol) || f.is_a?(NPCTrainer)}
    outcome = TrainerBattle.start(*foes)
    return outcome
  end
end

class WildBattle
  def self.dx_start(foes, rules = {}, pokemon = {}, midbattle = {})
    #$game_temp.dx_rules     = nil
    #$game_temp.dx_pokemon   = nil
    #$game_temp.dx_midbattle = nil
    pkmn = []
    species = level = nil
    foes.each do |foe|
      case foe
      when Pokemon then pkmn.push(foe)
      when Symbol  then species = foe
      when Integer then level = foe
      end
      if species && level
        next if !GameData::Species.exists?(species)
        next if !(1..Settings::MAXIMUM_LEVEL).include?(level)
        pkmn.push(Pokemon.new(species, level))
        species = level = nil
      end
    end
    outcome = WildBattle.start(*pkmn, can_override: false)
    return outcome
  end
end