module PBEggGroups
  Undiscovered = 0    # NoEggs, None, NA
  Monster      = 1
  Water1       = 2
  Bug          = 3
  Flying       = 4
  Field        = 5    # Ground
  Fairy        = 6
  Grass        = 7    # Plant
  Humanlike    = 8    # Humanoid, Humanshape, Human
  Water3       = 9
  Mineral      = 10
  Amorphous    = 11   # Indeterminate
  Water2       = 12
  Ditto        = 13
  Dragon       = 14
# ------ Derx: Touhoumon Egg Groups
  MonsterP     = 15
  Water4P      = 16
  BugP         = 17
  FlyingP      = 18
  FieldP       = 19
  FairyP       = 20
  PlantP       = 21
  HumanshapeP  = 22
  Water6P      = 23
  MineralP     = 24
  ChaosP       = 25
  Water5P      = 26
  DragonP      = 27
# ------ Derx: End of Touhoumon Egg Groups

  def self.maxValue; 27; end # Derx: Changed from 14
  def self.getCount; 28; end # Derx: Changed from 15

  def self.getName(id)
    id = getID(PBEggGroups,id)
    names = [
      _INTL("Undiscovered"),
      _INTL("Monster"),
      _INTL("Water 1"),
      _INTL("Bug"),
      _INTL("Flying"),
      _INTL("Field"),
      _INTL("Fairy"),
      _INTL("Grass"),
      _INTL("Human-like"),
      _INTL("Water 3"),
      _INTL("Mineral"),
      _INTL("Amorphous"),
      _INTL("Water 2"),
      _INTL("Ditto"),
      _INTL("Dragon"),
# ------ Derx: Internal names for the Touhoumon Egg Groups
       _INTL("Monster*"),
       _INTL("Water 4*"),
       _INTL("Bug*"),
       _INTL("Flying*"),
       _INTL("Field*"),
       _INTL("Fairy*"),
       _INTL("Plant*"),
       _INTL("Humanshape*"),
       _INTL("Water 6*"),
       _INTL("Mineral*"),
       _INTL("Chaos*"),
       _INTL("Water 5*"),
       _INTL("Dragon*")
# ------ Derx: End of Internal Names for the Touhoumon Egg Groups
    ]
    return names[id]
  end
end
