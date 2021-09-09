#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Tweaks to existing move effects to account for Touhoumon mechanics
#==============================================================================#

#===============================================================================
# Uses the last move that was used. (Copycat)
#
# Addition: Added Recollection to Copycat's blacklist
#===============================================================================
class PokeBattle_Move_0AF < PokeBattle_Move

  def initialize(battle,move)
    super
    @moveBlacklist = [
       # Struggle, Chatter, Belch
       "002",   # Struggle
       "014",   # Chatter
       "158",   # Belch                               # Not listed on Bulbapedia
       # Moves that affect the moveset
       "05C",   # Mimic
       "05D",   # Sketch
       "069",   # Transform
	   "504",	# Recollection
       # Counter moves
       "071",   # Counter
       "072",   # Mirror Coat
       "073",   # Metal Burst                         # Not listed on Bulbapedia
       # Helping Hand, Feint (always blacklisted together, don't know why)
       "09C",   # Helping Hand
       "0AD",   # Feint
       # Protection moves
       "0AA",   # Detect, Protect
       "0AB",   # Quick Guard                         # Not listed on Bulbapedia
       "0AC",   # Wide Guard                          # Not listed on Bulbapedia
       "0E8",   # Endure
       "149",   # Mat Block
       "14A",   # Crafty Shield                       # Not listed on Bulbapedia
       "14B",   # King's Shield
       "14C",   # Spiky Shield
       "168",   # Baneful Bunker
       # Moves that call other moves
       "0AE",   # Mirror Move
       "0AF",   # Copycat (this move)
       "0B0",   # Me First
       "0B3",   # Nature Power                        # Not listed on Bulbapedia
       "0B4",   # Sleep Talk
       "0B5",   # Assist
       "0B6",   # Metronome
       # Move-redirecting and stealing moves
       "0B1",   # Magic Coat                          # Not listed on Bulbapedia
       "0B2",   # Snatch
       "117",   # Follow Me, Rage Powder
       "16A",   # Spotlight
       # Set up effects that trigger upon KO
       "0E6",   # Grudge                              # Not listed on Bulbapedia
       "0E7",   # Destiny Bond
       # Held item-moving moves
       "0F1",   # Covet, Thief
       "0F2",   # Switcheroo, Trick
       "0F3",   # Bestow
       # Moves that start focussing at the start of the round
       "115",   # Focus Punch
       "171",   # Shell Trap
       "172",   # Beak Blast
       # Event moves that do nothing
       "133",   # Hold Hands
       "134"    # Celebrate
    ]
    if Settings::MECHANICS_GENERATION >= 6
      @moveBlacklist += [
         # Target-switching moves
         "0EB",   # Roar, Whirlwind
         "0EC"    # Circle Throw, Dragon Tail
      ]
    end
  end
end

#===============================================================================
# Uses a random move known by any non-user Pokémon in the user's party. (Assist)
#
# Addition: Added Recollection to Assist's blacklist
#===============================================================================
class PokeBattle_Move_0B5 < PokeBattle_Move

  def initialize(battle,move)
    super
    @moveBlacklist = [
       # Struggle, Chatter, Belch
       "002",   # Struggle
       "014",   # Chatter
       "158",   # Belch
       # Moves that affect the moveset
       "05C",   # Mimic
       "05D",   # Sketch
       "069",   # Transform
	   "504",	# Recollection
       # Counter moves
       "071",   # Counter
       "072",   # Mirror Coat
       "073",   # Metal Burst                         # Not listed on Bulbapedia
       # Helping Hand, Feint (always blacklisted together, don't know why)
       "09C",   # Helping Hand
       "0AD",   # Feint
       # Protection moves
       "0AA",   # Detect, Protect
       "0AB",   # Quick Guard                         # Not listed on Bulbapedia
       "0AC",   # Wide Guard                          # Not listed on Bulbapedia
       "0E8",   # Endure
       "149",   # Mat Block
       "14A",   # Crafty Shield                       # Not listed on Bulbapedia
       "14B",   # King's Shield
       "14C",   # Spiky Shield
       "168",   # Baneful Bunker
       # Moves that call other moves
       "0AE",   # Mirror Move
       "0AF",   # Copycat
       "0B0",   # Me First
#       "0B3",   # Nature Power                                      # See below
       "0B4",   # Sleep Talk
       "0B5",   # Assist
       "0B6",   # Metronome
       # Move-redirecting and stealing moves
       "0B1",   # Magic Coat                          # Not listed on Bulbapedia
       "0B2",   # Snatch
       "117",   # Follow Me, Rage Powder
       "16A",   # Spotlight
       # Set up effects that trigger upon KO
       "0E6",   # Grudge                              # Not listed on Bulbapedia
       "0E7",   # Destiny Bond
       # Target-switching moves
#       "0EB",   # Roar, Whirlwind                                    # See below
       "0EC",   # Circle Throw, Dragon Tail
       # Held item-moving moves
       "0F1",   # Covet, Thief
       "0F2",   # Switcheroo, Trick
       "0F3",   # Bestow
       # Moves that start focussing at the start of the round
       "115",   # Focus Punch
       "171",   # Shell Trap
       "172",   # Beak Blast
       # Event moves that do nothing
       "133",   # Hold Hands
       "134"    # Celebrate
    ]
    if Settings::MECHANICS_GENERATION >= 6
      @moveBlacklist += [
         # Moves that call other moves
         "0B3",   # Nature Power
         # Two-turn attacks
         "0C3",   # Razor Wind                        # Not listed on Bulbapedia
         "0C4",   # Solar Beam, Solar Blade           # Not listed on Bulbapedia
         "0C5",   # Freeze Shock                      # Not listed on Bulbapedia
         "0C6",   # Ice Burn                          # Not listed on Bulbapedia
         "0C7",   # Sky Attack                        # Not listed on Bulbapedia
         "0C8",   # Skull Bash                        # Not listed on Bulbapedia
         "0C9",   # Fly
         "0CA",   # Dig
         "0CB",   # Dive
         "0CC",   # Bounce
         "0CD",   # Shadow Force
         "0CE",   # Sky Drop
         "12E",   # Shadow Half
         "14D",   # Phantom Force
         "14E",   # Geomancy                          # Not listed on Bulbapedia
         # Target-switching moves
         "0EB"    # Roar, Whirlwind
      ]
    end
  end
end

#===============================================================================
# Uses a random move that exists. (Metronome)
#
# Addition: Added Recollection to Metronome's blacklist
#===============================================================================
class PokeBattle_Move_0B6 < PokeBattle_Move

  def initialize(battle,move)
    super
    @moveBlacklist = [
       "011",   # Snore
       "11D",   # After You
       "11E",   # Quash
       "16C",   # Instruct
       # Struggle, Chatter, Belch
       "002",   # Struggle
       "014",   # Chatter
       "158",   # Belch
       # Moves that affect the moveset
       "05C",   # Mimic
       "05D",   # Sketch
       "069",   # Transform
	   "504",	# Recollection
       # Counter moves
       "071",   # Counter
       "072",   # Mirror Coat
       "073",   # Metal Burst                         # Not listed on Bulbapedia
       # Helping Hand, Feint (always blacklisted together, don't know why)
       "09C",   # Helping Hand
       "0AD",   # Feint
       # Protection moves
       "0AA",   # Detect, Protect
       "0AB",   # Quick Guard
       "0AC",   # Wide Guard
       "0E8",   # Endure
       "149",   # Mat Block
       "14A",   # Crafty Shield
       "14B",   # King's Shield
       "14C",   # Spiky Shield
       "168",   # Baneful Bunker
       # Moves that call other moves
       "0AE",   # Mirror Move
       "0AF",   # Copycat
       "0B0",   # Me First
       "0B3",   # Nature Power
       "0B4",   # Sleep Talk
       "0B5",   # Assist
       "0B6",   # Metronome
       # Move-redirecting and stealing moves
       "0B1",   # Magic Coat                          # Not listed on Bulbapedia
       "0B2",   # Snatch
       "117",   # Follow Me, Rage Powder
       "16A",   # Spotlight
       # Set up effects that trigger upon KO
       "0E6",   # Grudge                              # Not listed on Bulbapedia
       "0E7",   # Destiny Bond
       # Held item-moving moves
       "0F1",   # Covet, Thief
       "0F2",   # Switcheroo, Trick
       "0F3",   # Bestow
       # Moves that start focussing at the start of the round
       "115",   # Focus Punch
       "171",   # Shell Trap
       "172",   # Beak Blast
       # Event moves that do nothing
       "133",   # Hold Hands
       "134"    # Celebrate
    ]
    @moveBlacklistSignatures = [
       :SNARL,
       # Signature moves
       :DIAMONDSTORM,     # Diancie (Gen 6)
       :FLEURCANNON,      # Magearna (Gen 7)
       :FREEZESHOCK,      # Black Kyurem (Gen 5)
       :HYPERSPACEFURY,   # Hoopa Unbound (Gen 6)
       :HYPERSPACEHOLE,   # Hoopa Confined (Gen 6)
       :ICEBURN,          # White Kyurem (Gen 5)
       :LIGHTOFRUIN,      # Eternal Flower Floette (Gen 6)
       :MINDBLOWN,        # Blacephalon (Gen 7)
       :PHOTONGEYSER,     # Necrozma (Gen 7)
       :PLASMAFISTS,      # Zeraora (Gen 7)
       :RELICSONG,        # Meloetta (Gen 5)
       :SECRETSWORD,      # Keldeo (Gen 5)
       :SPECTRALTHIEF,    # Marshadow (Gen 7)
       :STEAMERUPTION,    # Volcanion (Gen 6)
       :TECHNOBLAST,      # Genesect (Gen 5)
       :THOUSANDARROWS,   # Zygarde (Gen 6)
       :THOUSANDWAVES,    # Zygarde (Gen 6)
       :VCREATE           # Victini (Gen 5)
    ]
  end
end

#===============================================================================
# For 4 rounds, the target must use the same move each round. (Encore)
#
# Addition: Added Recollection to Encore's blacklist
#===============================================================================
class PokeBattle_Move_0BC < PokeBattle_Move
  
  def initialize(battle,move)
    super
    @moveBlacklist = [
       "0BC",   # Encore
       # Struggle
       "002",   # Struggle
       # Moves that affect the moveset
       "05C",   # Mimic
       "05D",   # Sketch
       "069",   # Transform
	   "504",	# Recollection
       # Moves that call other moves (see also below)
       "0AE"    # Mirror Move
    ]
    if Settings::MECHANICS_GENERATION >= 7
      @moveBlacklist += [
         # Moves that call other moves
#         "0AE",   # Mirror Move                                     # See above
         "0AF",   # Copycat
         "0B0",   # Me First
         "0B3",   # Nature Power
         "0B4",   # Sleep Talk
         "0B5",   # Assist
         "0B6"    # Metronome
      ]
    end
  end
end

#===============================================================================
# All current battlers will perish after 3 more rounds. (Perish Song)
#
# Change: Removed explicit references to Pokemon as an individual species
#===============================================================================
class PokeBattle_Move_0E5 < PokeBattle_Move
  def pbShowAnimation(id,user,targets,hitNum=0,showAnimation=true)
    super
    @battle.pbDisplay(_INTL("Everyone on the field that heard the song will faint in three turns!"))
  end
end

#===============================================================================
# In wild battles, makes target flee. Fails if target is a higher level than the
# user.
# In trainer battles, target switches out.
# For status moves. (Roar, Whirlwind)
#
# Addition: Added in a check for Gatekeeper, which is a clone of Suction Cups
#===============================================================================
class PokeBattle_Move_0EB < PokeBattle_Move

  def pbFailsAgainstTarget?(user,target)
    if target.hasActiveAbility?(:SUCTIONCUPS) && !@battle.moldBreaker
      @battle.pbShowAbilitySplash(target)
      if PokeBattle_SceneConstants::USE_ABILITY_SPLASH
        @battle.pbDisplay(_INTL("{1} anchors itself!",target.pbThis))
      else
        @battle.pbDisplay(_INTL("{1} anchors itself with {2}!",target.pbThis,target.abilityName))
      end
      @battle.pbHideAbilitySplash(target)
      return true
	elsif target.hasActiveAbility?(:GATEKEEPER) && !@battle.moldBreaker
      @battle.pbShowAbilitySplash(target)
      if PokeBattle_SceneConstants::USE_ABILITY_SPLASH
        @battle.pbDisplay(_INTL("{1} stood resolute!",target.pbThis))
      else
        @battle.pbDisplay(_INTL("{1} stod resolute like a {2}!",target.pbThis,target.abilityName))
      end
      @battle.pbHideAbilitySplash(target)
      return true
    end
    if target.effects[PBEffects::Ingrain]
      @battle.pbDisplay(_INTL("{1} anchored itself with its roots!",target.pbThis))
      return true
    end
    if !@battle.canRun
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    if @battle.wildBattle? && target.level>user.level
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    if @battle.trainerBattle?
      canSwitch = false
      @battle.eachInTeamFromBattlerIndex(target.index) do |_pkmn,i|
        next if !@battle.pbCanSwitchLax?(target.index,i)
        canSwitch = true
        break
      end
      if !canSwitch
        @battle.pbDisplay(_INTL("But it failed!"))
        return true
      end
    end
    return false
  end
end

#===============================================================================
# In wild battles, makes target flee. Fails if target is a higher level than the
# user.
# In trainer battles, target switches out.
# For damaging moves. (Circle Throw, Dragon Tail)
#
# Addition: Added in a check for Gateekeper
#===============================================================================
class PokeBattle_Move_0EC < PokeBattle_Move

  def pbSwitchOutTargetsEffect(user,targets,numHits,switchedBattlers)
    return if @battle.wildBattle?
    return if user.fainted? || numHits==0
    roarSwitched = []
    targets.each do |b|
      next if b.fainted? || b.damageState.unaffected || b.damageState.substitute
      next if switchedBattlers.include?(b.index)
      next if b.effects[PBEffects::Ingrain]
      next if (b.hasActiveAbility?(:SUCTIONCUPS) ||
			   b.hasActiveAbility?(:GATEKEEPER)) && !@battle.moldBreaker
      newPkmn = @battle.pbGetReplacementPokemonIndex(b.index,true)   # Random
      next if newPkmn<0
      @battle.pbRecallAndReplace(b.index, newPkmn, true)
      @battle.pbDisplay(_INTL("{1} was dragged out!",b.pbThis))
      @battle.pbClearChoice(b.index)   # Replacement Pokémon does nothing this round
      switchedBattlers.push(b.index)
      roarSwitched.push(b.index)
    end
    if roarSwitched.length>0
      @battle.moldBreaker = false if roarSwitched.include?(user.index)
      @battle.pbPriority(true).each do |b|
        b.pbEffectsOnSwitchIn(true) if roarSwitched.include?(b.index)
      end
    end
  end
end

#===============================================================================
# Target drops its item. It regains the item at the end of the battle. (Knock Off)
# If target has a losable item, damage is multiplied by 1.5.
#
# Addition: Made it so those w/ Collector as an ability can't lose items
#===============================================================================
class PokeBattle_Move_0F0 < PokeBattle_Move

  def pbEffectAfterAllHits(user,target)
    return if @battle.wildBattle? && user.opposes?   # Wild Pokémon can't knock off
    return if user.fainted?
    return if target.damageState.unaffected || target.damageState.substitute
    return if !target.item || target.unlosableItem?(target.item)
    return if target.hasActiveAbility?(:STICKYHOLD) && !@battle.moldBreaker
    return if target.hasActiveAbility?(:COLLECTOR) && !@battle.moldBreaker
    itemName = target.itemName
    target.pbRemoveItem(false)
    @battle.pbDisplay(_INTL("{1} dropped its {2}!",target.pbThis,itemName))
  end
end

#===============================================================================
# User steals the target's item, if the user has none itself. (Covet, Thief)
# Items stolen from wild Pokémon are kept after the battle.
#
# Addition: Made it so those w/ Collector as an ability can't lose items
#===============================================================================
class PokeBattle_Move_0F1 < PokeBattle_Move
  def pbEffectAfterAllHits(user,target)
    return if @battle.wildBattle? && user.opposes?   # Wild Pokémon can't thieve
    return if user.fainted?
    return if target.damageState.unaffected || target.damageState.substitute
    return if !target.item || user.item
    return if target.unlosableItem?(target.item)
    return if user.unlosableItem?(target.item)
    return if target.hasActiveAbility?(:STICKYHOLD) && !@battle.moldBreaker
	return if target.hasActiveAbility?(:COLLECTOR) && !@battle.moldBreaker
    itemName = target.itemName
    user.item = target.item
    # Permanently steal the item from wild Pokémon
    if @battle.wildBattle? && target.opposes? && !user.initialItem &&
       target.item == target.initialItem
      user.setInitialItem(target.item)
      target.pbRemoveItem
    else
      target.pbRemoveItem(false)
    end
    @battle.pbDisplay(_INTL("{1} stole {2}'s {3}!",user.pbThis,target.pbThis(true),itemName))
    user.pbHeldItemTriggerCheck
  end
end

#===============================================================================
# User and target swap items. They remain swapped after wild battles.
# (Switcheroo, Trick)
#
# Addition: Made it so those w/ Collector as an ability can't lose items
#===============================================================================
class PokeBattle_Move_0F2 < PokeBattle_Move
  def pbFailsAgainstTarget?(user,target)
    if !user.item && !target.item
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    if target.unlosableItem?(target.item) ||
       target.unlosableItem?(user.item) ||
       user.unlosableItem?(user.item) ||
       user.unlosableItem?(target.item)
      @battle.pbDisplay(_INTL("But it failed!"))
      return true
    end
    if (target.hasActiveAbility?(:STICKYHOLD) ||
		target.hasActiveAbility?(:COLLECTOR)) && !@battle.moldBreaker
      @battle.pbShowAbilitySplash(target)
      if PokeBattle_SceneConstants::USE_ABILITY_SPLASH
        @battle.pbDisplay(_INTL("But it failed to affect {1}!",target.pbThis(true)))
      else
        @battle.pbDisplay(_INTL("But it failed to affect {1} because of its {2}!",
           target.pbThis(true),target.abilityName))
      end
      @battle.pbHideAbilitySplash(target)
      return true
    end
    return false
  end
end

#===============================================================================
# User consumes target's berry and gains its effect. (Bug Bite, Pluck)
#
# Addition: Made it so those w/ Collector as an ability can't lose items
#===============================================================================
class PokeBattle_Move_0F4 < PokeBattle_Move
  def pbEffectAfterAllHits(user,target)
    return if user.fainted? || target.fainted?
    return if target.damageState.unaffected || target.damageState.substitute
    return if !target.item || !target.item.is_berry?
    return if target.hasActiveAbility?(:STICKYHOLD) && !@battle.moldBreaker
	return if target.hasActiveAbility?(:COLLECTOR) && !@battle.moldBreaker
    item = target.item
    itemName = target.itemName
    target.pbRemoveItem
    @battle.pbDisplay(_INTL("{1} stole and ate its target's {2}!",user.pbThis,itemName))
    user.pbHeldItemTriggerCheck(item,false)
  end
end

#===============================================================================
# User flings its item at the target. Power/effect depend on the item. (Fling)
#
# Addition: Added several new Touhoumon items to the Fling powers array
# Addition: Added a check fro Advent to prevent Fling's secondary effects
# Addition: Added the Ice Ball for fling effects, which freezes a target
#===============================================================================
class PokeBattle_Move_0F7 < PokeBattle_Move
  def initialize(battle,move)
    super
    # 80 => all Mega Stones
    # 10 => all Berries
    @flingPowers = {
      130 => [:IRONBALL
             ],
      100 => [:HARDSTONE,:RAREBONE,
              # Fossils
              :ARMORFOSSIL,:CLAWFOSSIL,:COVERFOSSIL,:DOMEFOSSIL,:HELIXFOSSIL,
              :JAWFOSSIL,:OLDAMBER,:PLUMEFOSSIL,:ROOTFOSSIL,:SAILFOSSIL,
              :SKULLFOSSIL,
			  # ------ Derx: Touhoumon Items with Value 100
			  :MIKOFOSSIL,:MAGIFOSSIL
             ],
       90 => [:DEEPSEATOOTH,:GRIPCLAW,:THICKCLUB,
              # Plates
              :DRACOPLATE,:DREADPLATE,:EARTHPLATE,:FISTPLATE,:FLAMEPLATE,
              :ICICLEPLATE,:INSECTPLATE,:IRONPLATE,:MEADOWPLATE,:MINDPLATE,
              :PIXIEPLATE,:SKYPLATE,:SPLASHPLATE,:SPOOKYPLATE,:STONEPLATE,
              :TOXICPLATE,:ZAPPLATE,
			  # ------ Derx: Touhoumon Items with Value 90
			  :DARKRIBBON,:KUSANAGI
             ],
       80 => [:ASSAULTVEST,:DAWNSTONE,:DUSKSTONE,:ELECTIRIZER,:MAGMARIZER,
              :ODDKEYSTONE,:OVALSTONE,:PROTECTOR,:QUICKCLAW,:RAZORCLAW,:SACHET,
              :SAFETYGOGGLES,:SHINYSTONE,:STICKYBARB,:WEAKNESSPOLICY,
              :WHIPPEDDREAM,
			  # ------ Derx: Touhoumon Items with Value 80
			  :CHROMESHARD
             ],
       70 => [:DRAGONFANG,:POISONBARB,
              # EV-training items (Macho Brace is 60)
              :POWERANKLET,:POWERBAND,:POWERBELT,:POWERBRACER,:POWERLENS,
              :POWERWEIGHT,
              # Drives
              :BURNDRIVE,:CHILLDRIVE,:DOUSEDRIVE,:SHOCKDRIVE
             ],
       60 => [:ADAMANTORB,:DAMPROCK,:GRISEOUSORB,:HEATROCK,:LUSTROUSORB,
              :MACHOBRACE,:ROCKYHELMET,:STICK,:TERRAINEXTENDER
             ],
       50 => [:DUBIOUSDISC,:SHARPBEAK,
              # Memories
              :BUGMEMORY,:DARKMEMORY,:DRAGONMEMORY,:ELECTRICMEMORY,:FAIRYMEMORY,
              :FIGHTINGMEMORY,:FIREMEMORY,:FLYINGMEMORY,:GHOSTMEMORY,
              :GRASSMEMORY,:GROUNDMEMORY,:ICEMEMORY,:POISONMEMORY,
              :PSYCHICMEMORY,:ROCKMEMORY,:STEELMEMORY,:WATERMEMORY
             ],
       40 => [:EVIOLITE,:ICYROCK,:LUCKYPUNCH,
			  # ------ Derx: Touhoumon Items with Value 40
			  :NYUUDOUFIST
             ],
       30 => [:ABSORBBULB,:ADRENALINEORB,:AMULETCOIN,:BINDINGBAND,:BLACKBELT,
              :BLACKGLASSES,:BLACKSLUDGE,:BOTTLECAP,:CELLBATTERY,:CHARCOAL,
              :CLEANSETAG,:DEEPSEASCALE,:DRAGONSCALE,:EJECTBUTTON,:ESCAPEROPE,
              :EXPSHARE,:FLAMEORB,:FLOATSTONE,:FLUFFYTAIL,:GOLDBOTTLECAP,
              :HEARTSCALE,:HONEY,:KINGSROCK,:LIFEORB,:LIGHTBALL,:LIGHTCLAY,
              :LUCKYEGG,:LUMINOUSMOSS,:MAGNET,:METALCOAT,:METRONOME,
              :MIRACLESEED,:MYSTICWATER,:NEVERMELTICE,:PASSORB,:POKEDOLL,
              :POKETOY,:PRISMSCALE,:PROTECTIVEPADS,:RAZORFANG,:SACREDASH,
              :SCOPELENS,:SHELLBELL,:SHOALSALT,:SHOALSHELL,:SMOKEBALL,:SNOWBALL,
              :SOULDEW,:SPELLTAG,:TOXICORB,:TWISTEDSPOON,:UPGRADE,
              # Healing items
              :ANTIDOTE,:AWAKENING,:BERRYJUICE,:BIGMALASADA,:BLUEFLUTE,
              :BURNHEAL,:CASTELIACONE,:ELIXIR,:ENERGYPOWDER,:ENERGYROOT,:ETHER,
              :FRESHWATER,:FULLHEAL,:FULLRESTORE,:HEALPOWDER,:HYPERPOTION,
              :ICEHEAL,:LAVACOOKIE,:LEMONADE,:LUMIOSEGALETTE,:MAXELIXIR,
              :MAXETHER,:MAXPOTION,:MAXREVIVE,:MOOMOOMILK,:OLDGATEAU,
              :PARALYZEHEAL,:PARLYZHEAL,:PEWTERCRUNCHIES,:POTION,:RAGECANDYBAR,
              :REDFLUTE,:REVIVALHERB,:REVIVE,:SHALOURSABLE,:SODAPOP,
              :SUPERPOTION,:SWEETHEART,:YELLOWFLUTE,
              # Battle items
              :XACCURACY,:XACCURACY2,:XACCURACY3,:XACCURACY6,
              :XATTACK,:XATTACK2,:XATTACK3,:XATTACK6,
              :XDEFEND,:XDEFEND2,:XDEFEND3,:XDEFEND6,
              :XDEFENSE,:XDEFENSE2,:XDEFENSE3,:XDEFENSE6,
              :XSPATK,:XSPATK2,:XSPATK3,:XSPATK6,
              :XSPECIAL,:XSPECIAL2,:XSPECIAL3,:XSPECIAL6,
              :XSPDEF,:XSPDEF2,:XSPDEF3,:XSPDEF6,
              :XSPEED,:XSPEED2,:XSPEED3,:XSPEED6,
              :DIREHIT,:DIREHIT2,:DIREHIT3,
              :ABILITYURGE,:GUARDSPEC,:ITEMDROP,:ITEMURGE,:RESETURGE,
              # Vitamins
              :CALCIUM,:CARBOS,:HPUP,:IRON,:PPUP,:PPMAX,:PROTEIN,:ZINC,
              :RARECANDY,
              # Most evolution stones (see also 80)
              :EVERSTONE,:FIRESTONE,:ICESTONE,:LEAFSTONE,:MOONSTONE,:SUNSTONE,
              :THUNDERSTONE,:WATERSTONE,
              # Repels
              :MAXREPEL,:REPEL,:SUPERREPEL,
              # Mulches
              :AMAZEMULCH,:BOOSTMULCH,:DAMPMULCH,:GOOEYMULCH,:GROWTHMULCH,
              :RICHMULCH,:STABLEMULCH,:SURPRISEMULCH,
              # Shards
              :BLUESHARD,:GREENSHARD,:REDSHARD,:YELLOWSHARD,
              # Valuables
              :BALMMUSHROOM,:BIGMUSHROOM,:BIGNUGGET,:BIGPEARL,:COMETSHARD,
              :NUGGET,:PEARL,:PEARLSTRING,:RELICBAND,:RELICCOPPER,:RELICCROWN,
              :RELICGOLD,:RELICSILVER,:RELICSTATUE,:RELICVASE,:STARDUST,
              :STARPIECE,:STRANGESOUVENIR,:TINYMUSHROOM,
			  # ------ Derx: Touhoumon items with Value 30
			  :MIRROROFYATA,:ICEBALL,:SOLARSHARD,:POWERSHARD,:DEFENSESHARD,
			  :SWIFTSHARD,:TECHSHARD,:SUPPORTSHARD,:GREENUNFO,:REDUFO,
			  :BLUEUFO,:MAIDCOSTUME,:SWEATER,:BUNNYSUIT,:CAMOUFLAGE,
			  :BLAZER,:MISTRESS,:NINJA,:NURSE,:SWIMSUIT,:STEWARDESS,
			  :THICKFUR,:KIMONO,:WITCH,:GOTHIC,:BRIDALGOWN,:PRIESTESS,
			  :CHINADRESS
             ],
       20 => [# Wings
              :CLEVERWING,:GENIUSWING,:HEALTHWING,:MUSCLEWING,:PRETTYWING,
              :RESISTWING,:SWIFTWING
             ],
       10 => [:AIRBALLOON,:BIGROOT,:BRIGHTPOWDER,:CHOICEBAND,:CHOICESCARF,
              :CHOICESPECS,:DESTINYKNOT,:DISCOUNTCOUPON,:EXPERTBELT,:FOCUSBAND,
              :FOCUSSASH,:LAGGINGTAIL,:LEFTOVERS,:MENTALHERB,:METALPOWDER,
              :MUSCLEBAND,:POWERHERB,:QUICKPOWDER,:REAPERCLOTH,:REDCARD,
              :RINGTARGET,:SHEDSHELL,:SILKSCARF,:SILVERPOWDER,:SMOOTHROCK,
              :SOFTSAND,:SOOTHEBELL,:WHITEHERB,:WIDELENS,:WISEGLASSES,:ZOOMLENS,
              # Terrain seeds
              :ELECTRICSEED,:GRASSYSEED,:MISTYSEED,:PSYCHICSEED,
              # Nectar
              :PINKNECTAR,:PURPLENECTAR,:REDNECTAR,:YELLOWNECTAR,
              # Incenses
              :FULLINCENSE,:LAXINCENSE,:LUCKINCENSE,:ODDINCENSE,:PUREINCENSE,
              :ROCKINCENSE,:ROSEINCENSE,:SEAINCENSE,:WAVEINCENSE,
              # Scarves
              :BLUESCARF,:GREENSCARF,:PINKSCARF,:REDSCARF,:YELLOWSCARF,
			  # ------ Derx: Touhoumon Items with Value 10
			  :BLOOMERS,:POWERRIBBON,:FOCUSRIBBON
             ]
    }
  end
  
  def pbEffectAgainstTarget(user,target)
    return if target.damageState.substitute
    return if target.hasActiveAbility?(:SHIELDDUST) && !@battle.moldBreaker
	return if target.hasActiveAbility?(:ADVENT) && !@battle.moldBreaker
    case user.item_id
    when :POISONBARB
      target.pbPoison(user) if target.pbCanPoison?(user,false,self)
    when :TOXICORB
      target.pbPoison(user,nil,true) if target.pbCanPoison?(user,false,self)
    when :FLAMEORB
      target.pbBurn(user) if target.pbCanBurn?(user,false,self)
    when :LIGHTBALL
      target.pbParalyze(user) if target.pbCanParalyze?(user,false,self)
	when :ICEBALL
	  target.pbFreeze(user) if target.pbCanFreeze?(user,false,self)
    when :KINGSROCK, :RAZORFANG
      target.pbFlinch(user)
    else
      target.pbHeldItemTriggerCheck(user.item,true)
    end
  end
end

#===============================================================================
# For 5 rounds, all held items cannot be used in any way and have no effect.
# Held items can still change hands, but can't be thrown. (Magic Room)
#
# Change: Removed explicit references to Pokemon as an individual species
#===============================================================================
class PokeBattle_Move_0F9 < PokeBattle_Move
  def pbEffectGeneral(user)
    if @battle.field.effects[PBEffects::MagicRoom]>0
      @battle.field.effects[PBEffects::MagicRoom] = 0
      @battle.pbDisplay(_INTL("The area returned to normal!"))
    else
      @battle.field.effects[PBEffects::MagicRoom] = 5
      @battle.pbDisplay(_INTL("It created a bizarre area in which held items lose their effects!"))
    end
  end
end