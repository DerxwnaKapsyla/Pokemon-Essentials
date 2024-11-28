#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Added the Touhoumon items to the Mining Minigame
#	* Made it so you can't find more than one of the new fossils at the same
#	  time.
#==============================================================================#
class MiningGameScene
  # ITEMS = []
  
  # Category arrays to hold similar items.
  # Item, probability, graphic x, graphic y, width, height, pattern
  GENERIC_ITEMS = [   
    [:GREENSPHERE1,  250,  0,  0, 2, 2, [1, 1, 1, 1]],
    [:REDSPHERE1,    250,  2,  0, 2, 2, [1, 1, 1, 1]],
    [:BLUESPHERE1,   250,  4,  0, 2, 2, [1, 1, 1, 1]],
    [:PRISMSPHERE1,  250,  6,  0, 2, 2, [1, 1, 1, 1]],
    [:PALESPHERE1,   250,  8,  0, 2, 2, [1, 1, 1, 1]],
    [:GREENSPHERE2,   50, 10,  0, 3, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1]],
    [:REDSPHERE2,     50, 13,  0, 3, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1]],
    [:BLUESPHERE2,    50, 16,  0, 3, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1]],
    [:PRISMSPHERE2,   50, 19,  0, 3, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1]],
    [:PALESPHERE2,    50, 22,  0, 3, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1]],
    [:REDSHARD,      100, 21, 22, 3, 3, [1, 1, 1, 1, 1, 0, 1, 1, 1]],
    [:GREENSHARD,    100, 25, 20, 4, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1]],
    [:YELLOWSHARD,   100, 25, 23, 4, 3, [1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1]],
    [:BLUESHARD,     100, 26, 26, 3, 3, [1, 1, 1, 1, 1, 1, 1, 1, 0]],
    [:REVIVE,        100,  0, 20, 3, 3, [0, 1, 0, 1, 1, 1, 0, 1, 0]],
    [:MAXREVIVE,      50,  0, 23, 3, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1]],
	[:HEARTSCALE,    200,  8, 24, 2, 2, [1, 0, 1, 1]]
  ]	
  FOSSILS = [
	[:DOMEFOSSIL,     20,  0,  3, 5, 4, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0]],
    [:HELIXFOSSIL,     5,  5,  3, 4, 4, [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0]],
    [:HELIXFOSSIL,     5,  9,  3, 4, 4, [1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1]],
    [:HELIXFOSSIL,     5, 13,  3, 4, 4, [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0]],
    [:HELIXFOSSIL,     5, 17,  3, 4, 4, [1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1]],
    [:OLDAMBER,       10, 21,  3, 4, 4, [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0]],
    [:OLDAMBER,       10, 25,  3, 4, 4, [1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1]],
    [:ROOTFOSSIL,      5,  0,  7, 5, 5, [1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0]],
    [:ROOTFOSSIL,      5,  5,  7, 5, 5, [0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0]],
    [:ROOTFOSSIL,      5, 10,  7, 5, 5, [0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1]],
    [:ROOTFOSSIL,      5, 15,  7, 5, 5, [0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0]],
    [:SKULLFOSSIL,    20, 20,  7, 4, 4, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0]],
    [:ARMORFOSSIL,    20, 24,  7, 5, 4, [0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0]],
    [:CLAWFOSSIL,      5,  0, 12, 4, 5, [0, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0]],
    [:CLAWFOSSIL,      5,  4, 12, 5, 4, [1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1]],
    [:CLAWFOSSIL,      5,  9, 12, 4, 5, [0, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 0, 0]],
    [:CLAWFOSSIL,      5, 13, 12, 5, 4, [1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1]],
    [:MAGIFOSSIL,     20,  9, 38, 3, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1]], 
    [:MIKOFOSSIL,     20, 12, 38, 3, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1]]
  ]    
  RELICS = [
	[:ODDKEYSTONE,    100, 10, 20,  4, 4, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]],
    [:RAREBONE,        50,  3, 17,  6, 3, [1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1]],
    [:RAREBONE,        50,  3, 20,  3, 6, [1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 1]],	
    [:STARPIECE,      100,  0, 17,  3, 3, [0, 1, 0, 1, 1, 1, 0, 1, 0]],
    [:RELICCOPPER,     50, 12, 41,  2, 2, [1, 1, 1, 1, 1, 1, 1, 1, 0]],
    [:RELICSILVER,     20, 14, 41,  2, 2, [1, 1, 1, 1, 1, 1, 1, 1, 0]],
    [:RELICGOLD,        5, 16, 41,  2, 2, [1, 1, 1, 1, 1, 1, 1, 1, 0]],
    [:NUGGET,          10, 11, 44,  3, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1]],
    [:BIGNUGGET,        8, 14, 44,  3, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1]],
	[:COMETSHARD,      15,  8, 44,  3, 3, [0, 1, 0, 1, 1, 1, 0, 1, 0]],
    [:REDUFO,          50,  0, 38,  3, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1]], 
    [:GREENUFO,       400,  3, 38,  3, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1]], 
    [:BLUEUFO,        100,  6, 38,  3, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1]]
  ]
  HOLD_ITEMS = [
    [:OVALSTONE,     150, 24, 17, 3, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1]],
    [:EVERSTONE,     150, 21, 20, 4, 2, [1, 1, 1, 1, 1, 1, 1, 1]],
    [:LIGHTCLAY,     100,  6, 20, 4, 4, [1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 0, 1]],
    [:HARDSTONE,     200,  6, 24, 2, 2, [1, 1, 1, 1]],
    [:IRONBALL,      100,  9, 17, 3, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1]],
    [:HEATROCK,       50, 12, 17, 4, 3, [1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1]],
    [:DAMPROCK,       50, 14, 20, 3, 3, [1, 1, 1, 1, 1, 1, 1, 0, 1]],
    [:SMOOTHROCK,     50, 17, 18, 4, 4, [0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0]],
    [:ICYROCK,        50, 17, 22, 4, 4, [0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1]]
  ] 
  EVOSTONES = [
    [:FIRESTONE,      20, 20, 11,  3, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1]],
    [:WATERSTONE,     20, 23, 11,  3, 3, [1, 1, 1, 1, 1, 1, 1, 1, 0]],
    [:THUNDERSTONE,   20, 26, 11,  3, 3, [0, 1, 1, 1, 1, 1, 1, 1, 0]],
    [:LEAFSTONE,      10, 18, 14,  3, 4, [0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0]],
    [:LEAFSTONE,      10, 21, 14,  4, 3, [0, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 0]],
    [:SUNSTONE,       20, 21, 17,  3, 3, [0, 1, 0, 1, 1, 1, 1, 1, 1]],
    [:DUSKSTONE,      20,  0, 41,  3, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1]],
    [:DAWNSTONE,      20,  3, 41,  3, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1]],
    [:SHINYSTONE,     20,  6, 41,  3, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1]],
    [:ICESTONE,       20,  9, 41,  3, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1]],
	[:DEFENSESHARD,   20,  0, 35,  2, 2, [1, 0, 1, 1]], 
    [:SWIFTSHARD,     20,  2, 35,  2, 2, [1, 0, 1, 1]], 
    [:SUPPORTSHARD,   20,  4, 35,  2, 2, [1, 0, 1, 1]], 
    [:TECHSHARD,      20,  6, 35,  2, 2, [1, 0, 1, 1]], 
    [:POWERSHARD,     20,  8, 35,  2, 2, [1, 0, 1, 1]], 
    [:SOLARSHARD,     20, 10, 35,  2, 2, [1, 0, 1, 1]], 
    [:CHROMESHARD,    20, 12, 35,  2, 2, [1, 0, 1, 1]]
  ]
  TYPE_PLATES = [
    [:INSECTPLATE,      10,  0, 26, 4, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]],
    [:DREADPLATE,       10,  4, 26, 4, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]],
    [:DRACOPLATE,       10,  8, 26, 4, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]],
    [:ZAPPLATE,         10, 12, 26, 4, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]],
    [:FISTPLATE,        10, 16, 26, 4, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]],
    [:FLAMEPLATE,       10, 20, 26, 4, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]],
    [:MEADOWPLATE,      10,  0, 29, 4, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]],
    [:EARTHPLATE,       10,  4, 29, 4, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]],
    [:ICICLEPLATE,      10,  8, 29, 4, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]],
    [:TOXICPLATE,       10, 12, 29, 4, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]],
    [:MINDPLATE,        10, 16, 29, 4, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]],
    [:STONEPLATE,       10, 20, 29, 4, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]],
    [:SKYPLATE,         10,  0, 32, 4, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]],
    [:SPOOKYPLATE,      10,  4, 32, 4, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]],
    [:IRONPLATE,        10,  8, 32, 4, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]],
    [:SPLASHPLATE,      10, 12, 32, 4, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]]
  ]
  TYPE_GEMS = [
    [:FIREGEM,     20,  0, 48, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:WATERGEM,    20,  3, 48, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:ELECTRICGEM, 20,  6, 48, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:GRASSGEM,    20,  9, 48, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:ICEGEM,      20, 12, 48, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:FIGHTINGGEM, 20, 15, 48, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:POISONGEM,   20, 18, 48, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:GROUNDGEM,   20, 21, 48, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:FLYINGGEM,   20,  0, 51, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:PSYCHICGEM,  20,  3, 51, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:BUGGEM,      20,  6, 51, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:ROCKGEM,     20,  9, 51, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:GHOSTGEM,    20, 12, 51, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:DRAGONGEM,   20, 15, 51, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:DARKGEM,     20, 18, 51, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:STEELGEM,    20, 21, 51, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:NORMALGEM,   20,  0, 54, 3, 2, [1, 1, 1, 1, 1, 1]]
  ]
  PUPPET_GEMS = [
    [:HEMATITE,     20,  0, 57, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:QUARTZ,       20,  3, 57, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:ONYX,         20,  6, 57, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:MALACHITE,    20,  9, 57, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:GOLD,         20, 12, 57, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:OBSIDIAN,     20, 15, 57, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:JADE,         20, 18, 57, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:AMETHYST,     20, 21, 57, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:AQUAMARINE,   20,  0, 60, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:DIAMOND,      20,  3, 60, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:LAPISLAZULI,  20,  6, 60, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:SUGILITE,     20,  9, 60, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:OPAL,         20, 12, 60, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:GARNET,       20,  0, 60, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:MORGANITE,    20, 15, 60, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:TOPAZ,        20, 18, 60, 3, 2, [1, 1, 1, 1, 1, 1]],
    [:MOONSTONEGEM, 20, 21, 63, 3, 2, [1, 1, 1, 1, 1, 1]]
  ]
  MOONSTONE = [
    [:MOONSTONE, 10, 25, 14, 4, 2, [0, 1, 1, 1, 1, 1, 1, 0]],
    [:MOONSTONE, 10, 27, 16, 2, 4, [1, 0, 1, 1, 1, 1, 0, 1]],
  ]
  
  def pbNoDuplicateItems(newitem)
    return true if newitem == :HEARTSCALE   # Allow multiple Heart Scales
    fossils =         [:DOMEFOSSIL, :HELIXFOSSIL, :OLDAMBER, :ROOTFOSSIL,
                       :SKULLFOSSIL, :ARMORFOSSIL, :CLAWFOSSIL, :MAGIFOSSIL, :MIKOFOSSIL]
    plates =          [:INSECTPLATE, :DREADPLATE, :DRACOPLATE, :ZAPPLATE, :FISTPLATE,
                       :FLAMEPLATE, :MEADOWPLATE, :EARTHPLATE, :ICICLEPLATE, :TOXICPLATE,
                       :MINDPLATE, :STONEPLATE, :SKYPLATE, :SPOOKYPLATE, :IRONPLATE, :SPLASHPLATE]
    poke_evostones =  [:LEAFSTONE, :FIRETONE, :WATERSTONE, :THUNDERSTONE,
                       :SUNSTONE, :DUSKSTONE, :DAWNSTONE, :SHINYSTONE, :ICESTONE]
    poke_gems =       [:FIREGEM, :WATERGEM, :ELECTRICGEM, :GRASSGEM, :ICEGEM,
                       :FIGHTINGGEM, :POISONGEM, :GROUNDGEM, :FLYINGGEM, :BUGGEM,
                       :ROCKGEM, :GHOSTGEM, :DRAGONGEM, :DARKGEM, :STEELGEM,
			           :NORMALGEM]
    puppet_evostones = [:DEFENSESHARD, :SWIFTSHARD, :TECHSHARD, :POWERSHARD,
                        :SUPPORTSHARD, :SOLARSHARD, :CHROMESHARD]
    puppet_gems =      [:HEMATITE, :QUARTZ, :ONYX, :MALACHITE, :GOLD,
                        :OBSIDIAN, :JADE, :AMETHYST, :AQUAMARINE, :DIAMOND,
				        :LAPISLAZULI, :SUGILITE, :OPAL, :GARNET, :MORGANITE,
				        :TOPAZ, :MOONSTONEGEM]
    @items.each do |i|
      preitem = @item_pool[i[0]][0]
      return false if preitem == newitem   # No duplicate items
      return false if fossils.include?(preitem) && fossils.include?(newitem)
      return false if plates.include?(preitem) && plates.include?(newitem)
      return false if poke_evostones.include?(preitem) && poke_evostones.include?(newitem)
      return false if poke_gems.include?(preitem) && poke_gems.include?(newitem)
      return false if puppet_evostones.include?(preitem) && puppet_evostones.include?(newitem)
      return false if puppet_gems.include?(preitem) && puppet_gems.include?(newitem)
    end
    return true
  end
  
  def pbCheckOverlaps(checkiron, provx, provy, provwidth, provheight, provpattern)
    @items.each do |i|
      prex = i[1]
      prey = i[2]
      prewidth = @item_pool[i[0]][4]
      preheight = @item_pool[i[0]][5]
      prepattern = @item_pool[i[0]][6]
      next if provx + provwidth <= prex || provx >= prex + prewidth ||
              provy + provheight <= prey || provy >= prey + preheight
      prepattern.length.times do |j|
        next if prepattern[j] == 0
        xco = prex + (j % prewidth)
        yco = prey + (j / prewidth).floor
        next if provx + provwidth <= xco || provx > xco ||
                provy + provheight <= yco || provy > yco
        return false if provpattern[xco - provx + ((yco - provy) * provwidth)] == 1
      end
    end
    if checkiron   # Check other irons as well
      @iron.each do |i|
        prex = i[1]
        prey = i[2]
        prewidth = IRON[i[0]][2]
        preheight = IRON[i[0]][3]
        prepattern = IRON[i[0]][4]
        next if provx + provwidth <= prex || provx >= prex + prewidth ||
                provy + provheight <= prey || provy >= prey + preheight
        prepattern.length.times do |j|
          next if prepattern[j] == 0
          xco = prex + (j % prewidth)
          yco = prey + (j / prewidth).floor
          next if provx + provwidth <= xco || provx > xco ||
                  provy + provheight <= yco || provy > yco
          return false if provpattern[xco - provx + ((yco - provy) * provwidth)] == 1
        end
      end
    end
    return true
  end
  
  def pbIsItemThere?(position)
    posx = position % BOARD_WIDTH
    posy = position / BOARD_WIDTH
    @items.each do |i|
      index = i[0]
      width = @item_pool[index][4]
      height = @item_pool[index][5]
      pattern = @item_pool[index][6]
      next if posx < i[1] || posx >= (i[1] + width)
      next if posy < i[2] || posy >= (i[2] + height)
      dx = posx - i[1]
      dy = posy - i[2]
      return true if pattern[dx + (dy * width)] > 0
    end
    return false
  end
  
  def pbCheckRevealed
    ret = []
    @items.length.times do |i|
      next if @items[i][3]
      revealed = true
      index = @items[i][0]
      width = @item_pool[index][4]
      height = @item_pool[index][5]
      pattern = @item_pool[index][6]
      height.times do |j|
        width.times do |k|
          layer = @sprites["tile#{@items[i][1] + k + ((@items[i][2] + j) * BOARD_WIDTH)}"].layer
          revealed = false if layer > 0 && pattern[k + (j * width)] > 0
          break if !revealed
        end
        break if !revealed
      end
      ret.push(i) if revealed
    end
    return ret
  end
  
  def pbFlashItems(revealed)
    return if revealed.length <= 0
    revealeditems = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
    revealeditems.z = 15
    revealeditems.color = Color.new(255, 255, 255, 0)
    flash_duration = 0.25
    2.times do |i|
      alpha_start = (i == 0) ? 0 : 255
      alpha_end = (i == 0) ? 255 : 0
      timer_start = System.uptime
      loop do
        revealed.each do |index|
          burieditem = @items[index]
          revealeditems.bitmap.blt(32 * burieditem[1], 64 + (32 * burieditem[2]),
                                   @itembitmap.bitmap,
                                   Rect.new(32 * @item_pool[burieditem[0]][2], 32 * @item_pool[burieditem[0]][3],
                                            32 * @item_pool[burieditem[0]][4], 32 * @item_pool[burieditem[0]][5]))
        end
        flash_alpha = lerp(alpha_start, alpha_end, flash_duration / 2, timer_start, System.uptime)
        revealeditems.color.alpha = flash_alpha
        update
        Graphics.update
        break if flash_alpha == alpha_end
      end
    end
    revealeditems.dispose
    revealed.each do |index|
      @items[index][3] = true
      item = @item_pool[@items[index][0]][0]
      @itemswon.push(item)
    end
  end
  
  def pbMergeIntoItemArray
    # This section is what will push the relevant items into the array based on the conditions defined
	@item_pool += GENERIC_ITEMS # These items will always appear - unless I come up with an area where they shouldn't.
	@item_pool += FOSSILS if $game_map.metadata&.has_flag?("M:Fossils")
    @item_pool += RELICS if $game_map.metadata&.has_flag?("M:Relics")
    @item_pool += HOLD_ITEMS if $game_map.metadata&.has_flag?("M:HoldItems")
	@item_pool += EVOSTONES if $game_map.metadata&.has_flag?("M:EvoStones")
	@item_pool += TYPE_PLATES if $game_map.metadata&.has_flag?("M:TypePlates")
	@item_pool += TYPE_GEMS if $game_map.metadata&.has_flag?("M:TypeGems")
	@item_pool += PUPPET_GEMS if $game_map.metadata&.has_flag?("M:PuppetGems")
	@item_pool += MOONSTONE if $game_map.metadata&.has_flag?("M:Moonstone")
  end
  
  def pbDistributeItems
    @item_pool = []
	# Set items to be buried (index in @item_pool, x coord, y coord)
    ptotal = 0
    pbMergeIntoItemArray
	@item_pool.each do |i|
      ptotal += i[1]
    end
    numitems = rand(2..4)
    tries = 0
    while numitems > 0
      rnd = rand(ptotal)
      added = false
      @item_pool.length.times do |i|
        rnd -= @item_pool[i][1]
        if rnd < 0
          if pbNoDuplicateItems(@item_pool[i][0])
            until added
              provx = rand(BOARD_WIDTH - @item_pool[i][4] + 1)
              provy = rand(BOARD_HEIGHT - @item_pool[i][5] + 1)
              if pbCheckOverlaps(false, provx, provy, @item_pool[i][4], @item_pool[i][5], @item_pool[i][6])
                @items.push([i, provx, provy])
                numitems -= 1
                added = true
              end
            end
          else
            break
          end
        end
        break if added
      end
      tries += 1
      break if tries >= 500
    end
    # Draw items on item layer
    layer = @sprites["itemlayer"].bitmap
    @items.each do |i|
      ox = @item_pool[i[0]][2]
      oy = @item_pool[i[0]][3]
      rectx = @item_pool[i[0]][4]
      recty = @item_pool[i[0]][5]
      layer.blt(32 * i[1], 64 + (32 * i[2]), @itembitmap.bitmap, Rect.new(32 * ox, 32 * oy, 32 * rectx, 32 * recty))
    end
  end
  
end