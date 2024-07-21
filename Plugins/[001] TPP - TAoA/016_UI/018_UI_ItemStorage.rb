#===============================================================================
#
#===============================================================================
class ItemStorage_Scene
  ITEMLISTBASECOLOR   = Color.new(88, 88, 80)
  ITEMLISTSHADOWCOLOR = Color.new(168, 184, 184)
  ITEMTEXTBASECOLOR   = Color.new(248, 248, 248)
  ITEMTEXTSHADOWCOLOR = Color.new(0, 0, 0)
  TITLEBASECOLOR      = Color.new(248, 248, 248)
  TITLESHADOWCOLOR    = Color.new(0, 0, 0)
  ITEMSVISIBLE        = 7

  def pbStartScene(bag, party)
    @viewport   = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport.z = 99999
    @bag = bag
    @sprites = {}
    @sprites["background"] = IconSprite.new(0, 0, @viewport)
    @sprites["background"].setBitmap("Graphics/UI/itemstorage_bg")
    @sprites["icon"] = ItemIconSprite.new(50, 334, nil, @viewport)
    # Item list
    @sprites["itemwindow"] = Window_PokemonItemStorage.new(@bag, 98, 14, 334, 32 + (ITEMSVISIBLE * 32))
    @sprites["itemwindow"].viewport    = @viewport
    @sprites["itemwindow"].index       = 0
    @sprites["itemwindow"].baseColor   = ITEMLISTBASECOLOR
    @sprites["itemwindow"].shadowColor = ITEMLISTSHADOWCOLOR
    @sprites["itemwindow"].refresh
    # Title
    @sprites["pocketwindow"] = BitmapSprite.new(88, 64, @viewport)
    @sprites["pocketwindow"].x = 14
    @sprites["pocketwindow"].y = 16
    pbSetNarrowFont(@sprites["pocketwindow"].bitmap)
    # Item description
    @sprites["itemtextwindow"] = Window_UnformattedTextPokemon.newWithSize("", 84, 272, Graphics.width - 84, 128, @viewport)
    @sprites["itemtextwindow"].baseColor   = ITEMTEXTBASECOLOR
    @sprites["itemtextwindow"].shadowColor = ITEMTEXTSHADOWCOLOR
    @sprites["itemtextwindow"].windowskin  = nil
    @sprites["helpwindow"] = Window_UnformattedTextPokemon.new("")
    @sprites["helpwindow"].visible  = false
    @sprites["helpwindow"].viewport = @viewport
    # Letter-by-letter message window
    @sprites["msgwindow"] = Window_AdvancedTextPokemon.new("")
    @sprites["msgwindow"].visible  = false
    @sprites["msgwindow"].viewport = @viewport
    pbBottomLeftLines(@sprites["helpwindow"], 1)
    pbDeactivateWindows(@sprites)
    pbRefresh
    pbFadeInAndShow(@sprites)
  end

end
