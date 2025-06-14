#===============================================================================
# Pokémon party panel
#===============================================================================
class PokemonPartyPanel < Sprite
  TEXT_BASE_COLOR        = Color.new(248, 248, 248)
  TEXT_SHADOW_COLOR      = Color.new(40, 40, 40)
  DARKTEXT_BASE_COLOR    = Color.new(80, 80, 88)
  DARKTEXT_SHADOW_COLOR  = Color.new(160, 160, 168)
  HP_BAR_WIDTH           = 96
  STATUS_ICON_WIDTH      = 44
  STATUS_ICON_HEIGHT     = 16

  def initialize(pokemon, index, viewport = nil, evoreqs = nil)
    super(viewport)
    @pokemon = pokemon
    @evoreqs = evoreqs
    refresh_evoreqs
    @active = (index == 0)   # true = rounded panel, false = rectangular panel
    @refreshing = true
    self.x = Graphics.width / 8 + 2
    self.y = 0 + (53 * index)
    @panelbgsprite = ChangelingSprite.new(0, 0, viewport)
    @panelbgsprite.z = self.z
      @panelbgsprite.addBitmap("able", "Graphics/UI/Party/panel")
      @panelbgsprite.addBitmap("ablesel", "Graphics/UI/Party/panel_sel")
      @panelbgsprite.addBitmap("fainted", "Graphics/UI/Party/panel_faint")
      @panelbgsprite.addBitmap("faintedsel", "Graphics/UI/Party/panel_faint_sel")
      @panelbgsprite.addBitmap("swap", "Graphics/UI/Party/panel_swap")
      @panelbgsprite.addBitmap("swapsel", "Graphics/UI/Party/panel_swap_sel")
      @panelbgsprite.addBitmap("swapsel2", "Graphics/UI/Party/panel_swap_sel2")
    @hpbgsprite = ChangelingSprite.new(0, 0, viewport)
    @hpbgsprite.z = self.z + 1
    @hpbgsprite.addBitmap("able", _INTL("Graphics/UI/Party/overlay_hp_back"))
    @hpbgsprite.addBitmap("fainted", _INTL("Graphics/UI/Party/overlay_hp_back_faint"))
    @hpbgsprite.addBitmap("swap", _INTL("Graphics/UI/Party/overlay_hp_back_swap"))
    @ballsprite = ChangelingSprite.new(0, 0, viewport)
    @ballsprite.z = self.z + 1
    @ballsprite.addBitmap("desel", "Graphics/UI/Party/icon_ball")
    @ballsprite.addBitmap("sel", "Graphics/UI/Party/icon_ball_sel")
    @ballsprite.addBitmap("desel_canevo", "Graphics/UI/LAEVO/evo_icon_ball")
    @ballsprite.addBitmap("sel_canevo", "Graphics/UI/LAEVO/evo_icon_ball_sel")
    @pkmnsprite = PokemonIconSprite.new(pokemon, viewport)
    @pkmnsprite.setOffset(PictureOrigin::CENTER)
    @pkmnsprite.active = @active
    @pkmnsprite.z      = self.z + 2
    @helditemsprite = HeldItemIconSprite.new(0, 0, @pokemon, viewport)
    @helditemsprite.z = self.z + 3
    @overlaysprite = BitmapSprite.new(Graphics.width, Graphics.height, viewport)
    @overlaysprite.z = self.z + 4
    pbSetSystemFont(@overlaysprite.bitmap)
    @hpbar    = AnimatedBitmap.new("Graphics/UI/Party/overlay_hp")
    @statuses = AnimatedBitmap.new(_INTL("Graphics/UI/statuses"))
    @selected      = false
    @preselected   = false
    @switching     = false
    @text          = nil
    @refreshBitmap = true
    @refreshing    = false
    refresh
  end
  
  def refresh_panel_graphic
    return if !@panelbgsprite || @panelbgsprite.disposed?
    if self.selected
      if self.preselected
        @panelbgsprite.changeBitmap("swapsel2")
      elsif @switching
        @panelbgsprite.changeBitmap("swapsel")
      elsif @pokemon.fainted?
        @panelbgsprite.changeBitmap("faintedsel")
      else
        @panelbgsprite.changeBitmap("ablesel")
      end
    else
      if self.preselected
        @panelbgsprite.changeBitmap("swap")
      elsif @pokemon.fainted?
        @panelbgsprite.changeBitmap("fainted")
      else
        @panelbgsprite.changeBitmap("able")
      end
    end
    @panelbgsprite.x     = self.x
    @panelbgsprite.y     = self.y
    @panelbgsprite.color = self.color
  end

  def refresh_hp_bar_graphic
    return if !@hpbgsprite || @hpbgsprite.disposed?
    @hpbgsprite.visible = (!@pokemon.egg? && !(@text && @text.length > 0))
    return if !@hpbgsprite.visible
    if self.preselected || (self.selected && @switching)
      @hpbgsprite.changeBitmap("swap")
    elsif @pokemon.fainted?
      @hpbgsprite.changeBitmap("fainted")
    else
      @hpbgsprite.changeBitmap("able")
    end
    @hpbgsprite.x     = self.x + 234
    @hpbgsprite.y     = self.y + 12
    @hpbgsprite.color = self.color
  end

  def refresh_ball_graphic
    return if !@ballsprite || @ballsprite.disposed?
    @ballsprite.changeBitmap((self.selected) ? "sel" : "desel")
    @ballsprite.x     = self.x + 8
    @ballsprite.y     = self.y - 1
    @ballsprite.color = self.color
  end

  def refresh_pokemon_icon
    return if !@pkmnsprite || @pkmnsprite.disposed?
    @pkmnsprite.x        = self.x + 30
    @pkmnsprite.y        = self.y + 26
    @pkmnsprite.color    = self.color
    @pkmnsprite.selected = self.selected
  end

  def refresh_held_item_icon
    return if !@helditemsprite || @helditemsprite.disposed? || !@helditemsprite.visible
    @helditemsprite.x     = self.x + 32
    @helditemsprite.y     = self.y + 34
    @helditemsprite.color = self.color
  end
  
  def draw_name
    pbDrawTextPositions(@overlaysprite.bitmap,
                        [[@pokemon.name, 54, 7, :left, TEXT_BASE_COLOR, TEXT_SHADOW_COLOR]])
  end

  def draw_level
    return if @pokemon.egg?
    # "Lv" graphic
    pbDrawImagePositions(@overlaysprite.bitmap,
                         [[_INTL("Graphics/UI/Party/overlay_lv_dark"), 54, 34, 0, 0, 22, 14]])
    # Level number
    pbSetSmallFont(@overlaysprite.bitmap)
    pbDrawTextPositions(@overlaysprite.bitmap,
                        [[@pokemon.level.to_s, 76, 32, :left, DARKTEXT_BASE_COLOR, DARKTEXT_SHADOW_COLOR]])
    pbSetSystemFont(@overlaysprite.bitmap)
  end

  def draw_gender
    return if @pokemon.egg? || @pokemon.genderless?
	pkmn_data = GameData::Species.get_species_form(pokemon.species, pokemon.form)
	if pkmn_data.has_flag?("Puppet")
      gender_text  = (@pokemon.male?) ? _INTL("¹") : _INTL("²")
	else
	  gender_text  = (@pokemon.male?) ? _INTL("♂") : _INTL("♀")
	end
    base_color   = (@pokemon.male?) ? Color.new(0, 112, 248) : Color.new(232, 32, 16)
    shadow_color = (@pokemon.male?) ? Color.new(120, 184, 232) : Color.new(248, 168, 184)
    pbDrawTextPositions(@overlaysprite.bitmap,
                        [[gender_text, 178, 8, :left, base_color, shadow_color]])
  end
  
  def draw_hp
    return if @pokemon.egg? || (@text && @text.length > 0)
    # HP numbers
    hp_text = sprintf("% 3d /% 3d", @pokemon.hp, @pokemon.totalhp)
	x_offset = 16
	pbSetSmallFont(@overlaysprite.bitmap)
    pbDrawTextPositions(@overlaysprite.bitmap,
                        [[hp_text, 343 + x_offset, 32, :right, DARKTEXT_BASE_COLOR, DARKTEXT_SHADOW_COLOR]])
    pbSetSystemFont(@overlaysprite.bitmap)
	# HP bar
    if @pokemon.able?
      w = @pokemon.hp * HP_BAR_WIDTH / @pokemon.totalhp.to_f
      w = 1 if w < 1
      w = ((w / 2).round) * 2   # Round to the nearest 2 pixels
      hpzone = 0
      hpzone = 1 if @pokemon.hp <= (@pokemon.totalhp / 2).floor
      hpzone = 2 if @pokemon.hp <= (@pokemon.totalhp / 4).floor
      hprect = Rect.new(0, hpzone * 8, w, 8)
      @overlaysprite.bitmap.blt(266, 14, @hpbar.bitmap, hprect)
    end
  end
  
  def draw_status
    return if @pokemon.egg? || (@text && @text.length > 0)
    status = -1
    if @pokemon.fainted?
      status = GameData::Status.count - 1
    elsif @pokemon.status != :NONE
      status = GameData::Status.get(@pokemon.status).icon_position
    elsif @pokemon.pokerusStage == 1
      status = GameData::Status.count
    end
    return if status < 0
    statusrect = Rect.new(0, STATUS_ICON_HEIGHT * status, STATUS_ICON_WIDTH, STATUS_ICON_HEIGHT)
    @overlaysprite.bitmap.blt(226, 32, @statuses.bitmap, statusrect)
  end

  def draw_shiny_icon
    return if @pokemon.egg? || !@pokemon.shiny?
    pbDrawImagePositions(@overlaysprite.bitmap,
                         [["Graphics/UI/shiny", 108, 32, 0, 0, 16, 16]])
  end
  
  def draw_annotation
    return if !@text || @text.length == 0
    pbDrawTextPositions(@overlaysprite.bitmap,
                        [[@text, 220, 7, :left, TEXT_BASE_COLOR, TEXT_SHADOW_COLOR]])
  end
  
  def refresh
    return if disposed?
    return if @refreshing
    @refreshing = true
    refresh_panel_graphic
    refresh_hp_bar_graphic
    refresh_ball_graphic
    refresh_pokemon_icon
    refresh_held_item_icon
    if @overlaysprite && !@overlaysprite.disposed?
      @overlaysprite.x     = self.x
      @overlaysprite.y     = self.y
      @overlaysprite.color = self.color
    end
    refresh_overlay_information
    @refreshBitmap = false
    @refreshing = false
  end
end

class PokemonParty_Scene

  def pbSwitchBegin(oldid, newid)
    pbSEPlay("GUI party switch")
    oldsprite = @sprites["pokemon#{oldid}"]
    newsprite = @sprites["pokemon#{newid}"]
    old_start_x = oldsprite.x
    new_start_x = newsprite.x
    old_mult = -2
    new_mult = -2
    timer_start = System.uptime
    loop do
      oldsprite.x = lerp(old_start_x, old_start_x + (old_mult * Graphics.width / 2), 0.4, timer_start, System.uptime)
      newsprite.x = lerp(new_start_x, new_start_x + (new_mult * Graphics.width / 2), 0.4, timer_start, System.uptime)
      Graphics.update
      Input.update
      self.update
      break if oldsprite.x == old_start_x + (old_mult * Graphics.width / 2)
    end
  end

  def pbSwitchEnd(oldid, newid)
    pbSEPlay("GUI party switch")
    oldsprite = @sprites["pokemon#{oldid}"]
    newsprite = @sprites["pokemon#{newid}"]
    oldsprite.pokemon = @party[oldid]
    newsprite.pokemon = @party[newid]
    old_start_x = oldsprite.x
    new_start_x = newsprite.x
    old_mult = -2
    new_mult = -2
    timer_start = System.uptime
    loop do
      oldsprite.x = lerp(old_start_x, old_start_x - (old_mult * Graphics.width / 2), 0.4, timer_start, System.uptime)
      newsprite.x = lerp(new_start_x, new_start_x - (new_mult * Graphics.width / 2), 0.4, timer_start, System.uptime)
      Graphics.update
      Input.update
      self.update
      break if oldsprite.x == old_start_x - (old_mult * Graphics.width / 2)
    end
    Settings::MAX_PARTY_SIZE.times do |i|
      @sprites["pokemon#{i}"].preselected = false
      @sprites["pokemon#{i}"].switching   = false
    end
    pbRefresh
  end

  def pbChangeSelection(key, currentsel)
    numsprites = Settings::MAX_PARTY_SIZE + ((@multiselect) ? 2 : 1)
    case key
    when Input::UP
      if currentsel >= Settings::MAX_PARTY_SIZE
        currentsel -= 1
        while currentsel > 0 && currentsel < Settings::MAX_PARTY_SIZE && !@party[currentsel]
          currentsel -= 1
        end
        currentsel = numsprites - 1 if currentsel < Settings::MAX_PARTY_SIZE && currentsel >= @party.length
      else
        loop do
          currentsel -= 1
          break unless currentsel > 0 && !@party[currentsel]
        end
      end
      if currentsel >= @party.length && currentsel < Settings::MAX_PARTY_SIZE
        currentsel = @party.length - 1
      end
      currentsel = numsprites - 1 if currentsel < 0
    when Input::DOWN
      if currentsel >= Settings::MAX_PARTY_SIZE - 1
        currentsel += 1
      else
        currentsel += 1
        currentsel = Settings::MAX_PARTY_SIZE if currentsel < Settings::MAX_PARTY_SIZE && !@party[currentsel]
      end
      if currentsel >= @party.length && currentsel < Settings::MAX_PARTY_SIZE
        currentsel = Settings::MAX_PARTY_SIZE
      elsif currentsel >= numsprites
        currentsel = (@party.length == 0) ? Settings::MAX_PARTY_SIZE : 0
      end
    end
    return currentsel
  end
end

class PokemonPartyBlankPanel < Sprite
  attr_accessor :text

  def initialize(_pokemon, index, viewport = nil)
    super(viewport)
    self.x = Graphics.width / 8 + 2
    self.y = 0 + (53 * index)
    @panelbgsprite = AnimatedBitmap.new("Graphics/UI/Party/panel_blank")
    self.bitmap = @panelbgsprite.bitmap
    @text = nil
  end
end
