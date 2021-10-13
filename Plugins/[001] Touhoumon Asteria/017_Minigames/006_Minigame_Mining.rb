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
  ITEMS = [   # Item, probability, graphic x, graphic y, width, height, pattern
     [:GREENSPHERE1,250, 0,0, 2,2,[1,1,1,1]],
     [:REDSPHERE1,250, 2,0, 2,2,[1,1,1,1]],
     [:BLUESPHERE1,250, 4,0, 2,2,[1,1,1,1]],
     [:PRISMSPHERE1,250, 6,0, 2,2,[1,1,1,1]],
     [:PALESPHERE1,250, 8,0, 2,2,[1,1,1,1]],
     [:GREENSPHERE2,50, 10,0, 3,3,[1,1,1,1,1,1,1,1,1]],
     [:REDSPHERE2,50, 13,0, 3,3,[1,1,1,1,1,1,1,1,1]],
     [:BLUESPHERE2,50, 16,0, 3,3,[1,1,1,1,1,1,1,1,1]],
     [:PRISMSPHERE2,50, 19,0, 3,3,[1,1,1,1,1,1,1,1,1]],
     [:PALESPHERE2,50, 22,0, 3,3,[1,1,1,1,1,1,1,1,1]],
     [:DOMEFOSSIL,20, 0,3, 5,4,[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,0]],
     [:HELIXFOSSIL,5, 5,3, 4,4,[0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0]],
     [:HELIXFOSSIL,5, 9,3, 4,4,[1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1]],
     [:HELIXFOSSIL,5, 13,3, 4,4,[0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0]],
     [:HELIXFOSSIL,5, 17,3, 4,4,[1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1]],
     [:OLDAMBER,10, 21,3, 4,4,[0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0]],
     [:OLDAMBER,10, 25,3, 4,4,[1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1]],
     [:ROOTFOSSIL,5, 0,7, 5,5,[1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,0,0,0,1,1,0,0,1,1,0]],
     [:ROOTFOSSIL,5, 5,7, 5,5,[0,0,1,1,1,0,0,1,1,1,1,0,0,1,1,1,1,1,1,1,0,1,1,1,0]],
     [:ROOTFOSSIL,5, 10,7, 5,5,[0,1,1,0,0,1,1,0,0,0,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1]],
     [:ROOTFOSSIL,5, 15,7, 5,5,[0,1,1,1,0,1,1,1,1,1,1,1,0,0,1,1,1,1,0,0,1,1,1,0,0]],
     [:SKULLFOSSIL,20, 20,7, 4,4,[1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,0]],
     [:ARMORFOSSIL,20, 24,7, 5,4,[0,1,1,1,0,0,1,1,1,0,1,1,1,1,1,0,1,1,1,0]],
     [:CLAWFOSSIL,5, 0,12, 4,5,[0,0,1,1,0,1,1,1,0,1,1,1,1,1,1,0,1,1,0,0]],
     [:CLAWFOSSIL,5, 4,12, 5,4,[1,1,0,0,0,1,1,1,1,0,0,1,1,1,1,0,0,1,1,1]],
     [:CLAWFOSSIL,5, 9,12, 4,5,[0,0,1,1,0,1,1,1,1,1,1,0,1,1,1,0,1,1,0,0]],
     [:CLAWFOSSIL,5, 13,12, 5,4,[1,1,1,0,0,1,1,1,1,0,0,1,1,1,1,0,0,0,1,1]],
     [:FIRESTONE,20, 20,11, 3,3,[1,1,1,1,1,1,1,1,1]],
     [:WATERSTONE,20, 23,11, 3,3,[1,1,1,1,1,1,1,1,0]],
     [:THUNDERSTONE,20, 26,11, 3,3,[0,1,1,1,1,1,1,1,0]],
     [:LEAFSTONE,10, 18,14, 3,4,[0,1,0,1,1,1,1,1,1,0,1,0]],
     [:LEAFSTONE,10, 21,14, 4,3,[0,1,1,0,1,1,1,1,0,1,1,0]],
     [:MOONSTONE,10, 25,14, 4,2,[0,1,1,1,1,1,1,0]],
     [:MOONSTONE,10, 27,16, 2,4,[1,0,1,1,1,1,0,1]],
     [:SUNSTONE,20, 21,17, 3,3,[0,1,0,1,1,1,1,1,1]],
     [:OVALSTONE,150, 24,17, 3,3,[1,1,1,1,1,1,1,1,1]],
     [:EVERSTONE,150, 21,20, 4,2,[1,1,1,1,1,1,1,1]],
     [:STARPIECE,100, 0,17, 3,3,[0,1,0,1,1,1,0,1,0]],
     [:REVIVE,100, 0,20, 3,3,[0,1,0,1,1,1,0,1,0]],
     [:MAXREVIVE,50, 0,23, 3,3,[1,1,1,1,1,1,1,1,1]],
     [:RAREBONE,50, 3,17, 6,3,[1,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,1]],
     [:RAREBONE,50, 3,20, 3,6,[1,1,1,0,1,0,0,1,0,0,1,0,0,1,0,1,1,1]],
     [:LIGHTCLAY,100, 6,20, 4,4,[1,0,1,0,1,1,1,0,1,1,1,1,0,1,0,1]],
     [:HARDSTONE,200, 6,24, 2,2,[1,1,1,1]],
     [:HEARTSCALE,200, 8,24, 2,2,[1,0,1,1]],
     [:IRONBALL,100, 9,17, 3,3,[1,1,1,1,1,1,1,1,1]],
     [:ODDKEYSTONE,20, 10,20, 4,4,[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]],
     [:HEATROCK,50, 12,17, 4,3,[1,0,1,0,1,1,1,1,1,1,1,1]],
     [:DAMPROCK,50, 14,20, 3,3,[1,1,1,1,1,1,1,0,1]],
     [:SMOOTHROCK,50, 17,18, 4,4,[0,0,1,0,1,1,1,0,0,1,1,1,0,1,0,0]],
     [:ICYROCK,50, 17,22, 4,4,[0,1,1,0,1,1,1,1,1,1,1,1,1,0,0,1]],
     [:REDSHARD,100, 21,22, 3,3,[1,1,1,1,1,0,1,1,1]],
     [:GREENSHARD,100, 25,20, 4,3,[1,1,1,1,1,1,1,1,1,1,0,1]],
     [:YELLOWSHARD,100, 25,23, 4,3,[1,0,1,0,1,1,1,0,1,1,1,1]],
     [:BLUESHARD,100, 26,26, 3,3,[1,1,1,1,1,1,1,1,0]],
     [:INSECTPLATE,10, 0,26, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
     [:DREADPLATE,10, 4,26, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
     [:DRACOPLATE,10, 8,26, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
     [:ZAPPLATE,10, 12,26, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
     [:FISTPLATE,10, 16,26, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
     [:FLAMEPLATE,10, 20,26, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
     [:MEADOWPLATE,10, 0,29, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
     [:EARTHPLATE,10, 4,29, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
     [:ICICLEPLATE,10, 8,29, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
     [:TOXICPLATE,10, 12,29, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
     [:MINDPLATE,10, 16,29, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
     [:STONEPLATE,10, 20,29, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
     [:SKYPLATE,10, 0,32, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
     [:SPOOKYPLATE,10, 4,32, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
     [:IRONPLATE,10, 8,32, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
     [:SPLASHPLATE,10, 12,32, 4,3,[1,1,1,1,1,1,1,1,1,1,1,1]],
     [:DEFENSESHARD,20, 0,35, 2,2,[1,0,1,1]],
     [:SWIFTSHARD,20, 2,35, 2,2,[1,0,1,1]],
     [:SUPPORTSHARD,20, 4,35, 2,2,[1,0,1,1]],
     [:TECHSHARD,20, 6,35, 2,2,[1,0,1,1]],
     [:POWERSHARD,20, 8,35, 2,2,[1,0,1,1]],
     [:SOLARSHARD,20, 10,35, 2,2,[1,0,1,1]],
     [:CHROMESHARD,20, 12,35, 2,2,[1,0,1,1]],
     [:REDUFO,50, 0,38, 3,3,[1,1,1,1,1,1,1,1,1]],
     [:GREENUFO,400, 3,38, 3,3,[1,1,1,1,1,1,1,1,1]],
     [:BLUEUFO,100, 6,38, 3,3,[1,1,1,1,1,1,1,1,1]],
     [:MAGIFOSSIL,20, 9,38, 3,3,[1,1,1,1,1,1,1,1,1]],
     [:MIKOFOSSIL,20, 12,38, 3,3,[1,1,1,1,1,1,1,1,1]]     
  ]
  
  def pbNoDuplicateItems(newitem)
    return true if newitem==:HEARTSCALE   # Allow multiple Heart Scales
    fossils=[:DOMEFOSSIL,:HELIXFOSSIL,:OLDAMBER,:ROOTFOSSIL,
             :SKULLFOSSIL,:ARMORFOSSIL,:CLAWFOSSIL,
			 :MAGIFOSSIL,:MIKOFOSSIL]
    plates=[:INSECTPLATE,:DREADPLATE,:DRACOPLATE,:ZAPPLATE,:FISTPLATE,
            :FLAMEPLATE,:MEADOWPLATE,:EARTHPLATE,:ICICLEPLATE,:TOXICPLATE,
            :MINDPLATE,:STONEPLATE,:SKYPLATE,:SPOOKYPLATE,:IRONPLATE,:SPLASHPLATE]
    for i in @items
      preitem=ITEMS[i[0]][0]
      return false if preitem==newitem   # No duplicate items
      return false if fossils.include?(preitem) && fossils.include?(newitem)
      return false if plates.include?(preitem) && plates.include?(newitem)
    end
    return true
  end
end