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