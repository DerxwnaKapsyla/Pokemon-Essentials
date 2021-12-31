#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Additions of the various Touhoumon items
#	* Changes to vanilla Pokemon items to accomidate new Touhoumon mechanics
#	* Changed it so that Rock Incense had its own entry so it could buff
#	  Earth types and wouldn't be copied by Hard Stone/Stone Plate
#	* Changed it so that Rose Incense had its own entry so it could buff
#	  Nature types and wouldn't be copied by Miracle Seed/Meadow Plate
#	* Changed it so that Sea Incense had its own entry so it could buff
#	  Touhoumon Water types and wouldn't be copied by Mystic Water/Splash Plate
#	* Changed it so that Odd Incense had its own entry so it could buff
#	  Reason types and wouldn't be copied by Twisted Spoon/Mind Plate
#	* Added the Scepter Spheres, which are used by Sariel Omega as Type-Changing
#	  items akin to Arceus' Plates.
#	* Added in the Puppet Gemstones and Hairpins (T1 and T2 Gemstones)
#	* Added in the Pokemon Ribbons (T2 Gemstones)
#	* Added in the Puppet Type Resisting Charms
#	* Added in the Pokemon Type Resisting Pendants
#==============================================================================#

BattleHandlers::DamageCalcUserItem.copy(:CHOICEBAND,:BLOOMERS,:POWERRIBBON)

BattleHandlers::DamageCalcUserItem.add(:KUSANAGI,
  proc { |item,user,target,move,mults,baseDmg,type|
    if user.isSpecies?(:RINNOSUKE) && move.specialMove?
      mults[:attack_multiplier] *= 2
    end
  }
)

BattleHandlers::DamageCalcUserItem.copy(:HARDSTONE,:STONEPLATE)

BattleHandlers::DamageCalcUserItem.add(:ROCKINCENSE,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if (type == :ROCK || type == :EARTH)
  }
)

BattleHandlers::DamageCalcUserItem.add(:ICEBALL,
  proc { |item,user,target,move,mults,baseDmg,type|
    if user.isSpecies?(:CCIRNO)
      mults[:attack_multiplier] *= 2
    end
  }
)

BattleHandlers::DamageCalcUserItem.copy(:MIRACLESEED,:MEADOWPLATE)

BattleHandlers::DamageCalcUserItem.add(:ROSEINCENSE,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if (type == :GRASS || type == :NATURE18)
  }
)

BattleHandlers::DamageCalcUserItem.copy(:MYSTICWATER,:SPLASHPLATE,:WAVEINCENSE)

BattleHandlers::DamageCalcUserItem.add(:SEAINCENSE,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if (type == :WATER || type == :WATER18)
  }
)

BattleHandlers::DamageCalcUserItem.add(:DARKRIBBON,
  proc { |item,user,target,move,mults,baseDmg,type|
    if (user.isSpecies?(:CHINA) || user.isSpecies?(:HINA)) && move.physicalMove?
      mults[:attack_multiplier] *= 2
    end
  }
)

BattleHandlers::DamageCalcUserItem.copy(:TWISTEDSPOON,:MINDPLATE)

BattleHandlers::DamageCalcUserItem.add(:ODDINCENSE,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if (type == :PSYCHIC || type == :REASON18)
  }
)

# ----------------------------
BattleHandlers::DamageCalcUserItem.add(:BUNNYSUIT,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :BEAST18
  }
)

BattleHandlers::DamageCalcUserItem.add(:MAIDCOSTUME,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :STEEL18
  }


)

BattleHandlers::DamageCalcUserItem.add(:SWEATER,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :EARTH18
  }
)

BattleHandlers::DamageCalcUserItem.add(:CAMOUFLAGE,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :NATURE18
  }
)

BattleHandlers::DamageCalcUserItem.add(:BLAZER,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :HEART18
  }
)

BattleHandlers::DamageCalcUserItem.add(:MISTRESS,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :DARK18
  }
)

BattleHandlers::DamageCalcUserItem.add(:NINJA,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :WIND18
  }
)

BattleHandlers::DamageCalcUserItem.add(:NURSE,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :MIASMA18
  }
)

BattleHandlers::DamageCalcUserItem.add(:SWIMSUIT,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :WATER18
  }
)

BattleHandlers::DamageCalcUserItem.add(:STEWARDESS,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :FLYING18
  }
)

BattleHandlers::DamageCalcUserItem.add(:THICKFUR,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :ICE18
  }
)

BattleHandlers::DamageCalcUserItem.add(:KIMONO,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :GHOST18
  }
)

BattleHandlers::DamageCalcUserItem.add(:WITCH18,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :REASON18
  }
)

BattleHandlers::DamageCalcUserItem.add(:GOTHIC,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :FIRE18
  }
)

BattleHandlers::DamageCalcUserItem.add(:BRIDALGOWN,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :ILLUSION18
  }
)

BattleHandlers::DamageCalcUserItem.add(:PRIESTESS,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :FAITH18
  }
)

BattleHandlers::DamageCalcUserItem.add(:CHINADRESS,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :DREAM18
  }
)

#------------------------

BattleHandlers::DamageCalcTargetItem.add(:YATAMIRROR,
  proc { |item,user,target,move,mults,baseDmg,type|
    if target.isSpecies?(:RINNOSUKE) && move.specialMove?
      mults[:defense_multiplier] *= 2
    end
  }
)

BattleHandlers::CriticalCalcUserItem.add(:NYUUDOUFIST,
  proc { |item,user,target,c|
    next c+2 if (user.isSpecies?(:CICHIRIN) ||
				 user.isSpecies?(:ICHIRIN))
  }
)

# --- Pokemon T2 Gemstones - Ribbons
BattleHandlers::DamageCalcUserItem.add(:FIRERIBBON,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:FIRE,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:WATERRIBBON,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:WATER,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:DARKRIBBON,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:DARK,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:DRAGONRIBBON,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:DRAGON,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:ELECTRICRIBBON,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:ELECTRIC,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:FIGHTINGRIBBON,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:FIGHTING,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:FLYINGRIBBON,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:FLYING,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:GHOSTRIBBON,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:GHOST,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:GRASSRIBBON,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:GRASS,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:GROUNDRIBBON,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:GROUND,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:ICERIBBON,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:ICE,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:NORMALRIBBON,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:NORMAL,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:POISONRIBBON,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:POISON,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:PSYCHICRIBBON,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:PSYCHIC,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:ROCKRIBBON,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:ROCK,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:STEELRIBBON,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:STEEL,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)
# ----------------------------------

# --- Puppet T1 Gemstones
BattleHandlers::DamageCalcUserItem.add(:HEMATITE,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:STEEL18,move,mults,type)
  }
)

BattleHandlers::DamageCalcUserItem.add(:QUARTZ,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:EARTH18,move,mults,type)
  }
)

BattleHandlers::DamageCalcUserItem.add(:ONYX,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:BEAST18,move,mults,type)
  }
)

BattleHandlers::DamageCalcUserItem.add(:MALACHITE,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:NATURE18,move,mults,type)
  }
)

BattleHandlers::DamageCalcUserItem.add(:GOLD,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:HEART18,move,mults,type)
  }
)

BattleHandlers::DamageCalcUserItem.add(:OBSIDIAN,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:DARK18,move,mults,type)
  }
)

BattleHandlers::DamageCalcUserItem.add(:JADE,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:WIND18,move,mults,type)
  }
)

BattleHandlers::DamageCalcUserItem.add(:AMETHYST,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:MIASMA18,move,mults,type)
  }
)

BattleHandlers::DamageCalcUserItem.add(:DIAMOND,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:FLYING18,move,mults,type)
  }
)

BattleHandlers::DamageCalcUserItem.add(:LAPISLAZULI,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:ICE18,move,mults,type)
  }
)

BattleHandlers::DamageCalcUserItem.add(:SUGILITE,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:GHOST18,move,mults,type)
  }
)

BattleHandlers::DamageCalcUserItem.add(:OPAL,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:REASON18,move,mults,type)
  }
)

BattleHandlers::DamageCalcUserItem.add(:GARNET,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:FIRE18,move,mults,type)
  }
)

BattleHandlers::DamageCalcUserItem.add(:MORGANITE,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:ILLUSION18,move,mults,type)
  }
)

BattleHandlers::DamageCalcUserItem.add(:TOPAZ,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:FAITH18,move,mults,type)
  }
)

BattleHandlers::DamageCalcUserItem.add(:MOONSTONE,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:DREAM18,move,mults,type)
  }
)
# -----------------------

# --- Puppet T2 Gemstones: Hairpins
BattleHandlers::DamageCalcUserItem.add(:HEMATITEHAIRPIN,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:STEEL18,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:QUARTZHAIRPIN,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:EARTH18,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:ONYXHAIRPIN,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:BEAST18,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:MALACHITEHAIRPIN,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:NATURE18,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:GOLDHAIRPIN,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:HEART18,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:OBSIDIANHAIRPIN,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:DARK18,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:JADEHAIRPIN,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:WIND18,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:AMETHYSTHAIRPIN,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:MIASMA18,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:DIAMONDHAIRPIN,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:FLYING18,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:LAPISHAIRPIN,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:ICE18,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:SUGILITEHAIRPIN,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:GHOST18,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:OPALHAIRPIN,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:REASON18,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:GARNETHAIRPIN,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:FIRE18,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:MORGANITEHAIRPIN,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:ILLUSION18,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:TOPAZHAIRPIN,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:FAITH18,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcUserItem.add(:MOONSTONEHAIRPIN,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleGem(user,:DREAM18,move,mults,type)
	$PokemonTemp.inertItem = true
  }
)
# ---------------------------------

# --- Puppet Scepter Spheres
BattleHandlers::DamageCalcUserItem.add(:DAMASCUSSPHERE,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :STEEL18
  }
)

BattleHandlers::DamageCalcUserItem.add(:TERRASPHERE,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :EARTH18
  }
)

BattleHandlers::DamageCalcUserItem.add(:FERALSPHERE,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :BEAST18
  }
)

BattleHandlers::DamageCalcUserItem.add(:GROWTHSPHERE,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :NATURE18
  }
)

BattleHandlers::DamageCalcUserItem.add(:TRUSTSPHERE,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :HEART18
  }
)

BattleHandlers::DamageCalcUserItem.add(:SINSPHERE,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :DARK18
  }
)

BattleHandlers::DamageCalcUserItem.add(:GUSTSPHERE,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :WIND18
  }
)

BattleHandlers::DamageCalcUserItem.add(:CORROSIONSPHERE,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :MIASMA18
  }
)

BattleHandlers::DamageCalcUserItem.add(:FLOODSPHERE,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :HYDRO18
  }
)

BattleHandlers::DamageCalcUserItem.add(:FLIGHTSPHERE,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :FLYING18
  }
)

BattleHandlers::DamageCalcUserItem.add(:FROSTSPHERE,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :ICE18
  }
)

BattleHandlers::DamageCalcUserItem.add(:SOULSPHERE,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :GHOST18
  }
)

BattleHandlers::DamageCalcUserItem.add(:KNOWLEDGESPHERE,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :REASON18
  }
)

BattleHandlers::DamageCalcUserItem.add(:VIRTUESPHERE,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :FAITH18
  }
)

BattleHandlers::DamageCalcUserItem.add(:PHANTASMSPHERE,
  proc { |item,user,target,move,mults,baseDmg,type|
    mults[:base_damage_multiplier] *= 1.2 if type == :DREAM18
  }
)
# --------------------------

# --- Pokemon T2 Damage Resist Berries: Pendants

BattleHandlers::DamageCalcTargetItem.add(:BABIRIPENDANT,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:STEEL,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:CHARTIPENDANT,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:ROCK,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:CHILANPENDANT,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:NORMAL,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:CHOPLEPENDANT,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:FIGHTING,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:COBAPENDANT,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:FLYING,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:COLBURPENDANT,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:DARK,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:HABANPENDANT,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:DRAGON,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:KASIBPENDANT,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:GHOST,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:KEBIAPENDANT,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:POISON,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:OCCAPENDANT,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:FIRE,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:PASSHOPENDANT,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:WATER,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:PAYAPAPENDANT,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:PSYCHIC,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:RINDOPENDANT,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:GRASS,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:SHUCAPENDANT,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:GROUND,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:TANGAPENDANT,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:BUG,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:WACANPENDANT,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:ELECTRIC,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:YACHEPENDANT,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:ICE,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)
# ----------------------------------------------

# --- Puppet T2 Damage Resist Berries: Charms
BattleHandlers::DamageCalcTargetItem.add(:ANTIMETAL,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:STEEL18,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:ANTIEARTH,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:EARTH18,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:ANTIBEAST,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:BEAST18,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:ANTINATURE,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:NATURE18,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:ANTIHEART,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:HEART18,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:ANTIUMBRAL,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:DARK18,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:ANTIWIND,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:WIND18,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:ANTIMIASMA,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:MIASMA18,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:ANTIHYDRO,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:WATER18,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:ANTIAERO,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:FLYING18,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:ANTICRYO,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:ICE18,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:ANTINETHER,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:GHOST18,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:ANTIREASON,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:REASON18,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:ANTIPYRO,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:FIRE18,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:ANTIILLUSION,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:ILLUSION18,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:ANTIFAITH,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:FAITH18,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

BattleHandlers::DamageCalcTargetItem.add(:ANTIDREAM,
  proc { |item,user,target,move,mults,baseDmg,type|
    pbBattleTypeWeakingBerry(:DREAM18,type,target,mults)
	$PokemonTemp.inertItem = true
  }
)

# ------------------------------------------