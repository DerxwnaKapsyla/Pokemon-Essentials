class PokemonLoadPanel < Sprite
  def refresh
    return if @refreshing
    return if disposed?
    @refreshing = true
    if !self.bitmap || self.bitmap.disposed?
      self.bitmap = BitmapWrapper.new(@bgbitmap.width, 222)
      pbSetSystemFont(self.bitmap)
    end
    if @refreshBitmap
      @refreshBitmap = false
      self.bitmap&.clear
      if @isContinue
        self.bitmap.blt(0, 0, @bgbitmap.bitmap, Rect.new(0, (@selected) ? 222 : 0, @bgbitmap.width, 222))
      else
        self.bitmap.blt(0, 0, @bgbitmap.bitmap, Rect.new(0, 444 + ((@selected) ? 46 : 0), @bgbitmap.width, 46))
      end
      textpos = []
      if @isContinue
        textpos.push([@title, 32, 16, 0, TEXTCOLOR, TEXTSHADOWCOLOR])
        textpos.push([_INTL("Losses:"), 32, 150, 0, TEXTCOLOR, TEXTSHADOWCOLOR])
        textpos.push([$stats.trainer_battles_lost.to_s, 206, 150, 1, TEXTCOLOR, TEXTSHADOWCOLOR])
        textpos.push([_INTL("Scenario:"), 32, 182, 0, TEXTCOLOR, TEXTSHADOWCOLOR])
        textpos.push([trainer.scenario_name, 152, 182, 0, TEXTCOLOR, TEXTSHADOWCOLOR])
        textpos.push([_INTL("Time:"), 32, 118, 0, TEXTCOLOR, TEXTSHADOWCOLOR])
        hour = @totalsec / 60 / 60
        min  = @totalsec / 60 % 60
        if hour > 0
          textpos.push([_INTL("{1}h {2}m", hour, min), 206, 118, 1, TEXTCOLOR, TEXTSHADOWCOLOR])
        else
          textpos.push([_INTL("{1}m", min), 206, 118, 1, TEXTCOLOR, TEXTSHADOWCOLOR])
        end
        if @trainer.male?
          textpos.push([@trainer.name, 112, 70, 0, MALETEXTCOLOR, MALETEXTSHADOWCOLOR])
        elsif @trainer.female?
          textpos.push([@trainer.name, 112, 70, 0, FEMALETEXTCOLOR, FEMALETEXTSHADOWCOLOR])
        else
          textpos.push([@trainer.name, 112, 70, 0, TEXTCOLOR, TEXTSHADOWCOLOR])
        end
        mapname = pbGetMapNameFromId(@mapid)
        mapname.gsub!(/\\PN/, @trainer.name)
        textpos.push([mapname, 386, 16, 1, TEXTCOLOR, TEXTSHADOWCOLOR])
      else
        textpos.push([@title, 32, 14, 0, TEXTCOLOR, TEXTSHADOWCOLOR])
      end
      pbDrawTextPositions(self.bitmap, textpos)
    end
    @refreshing = false
  end
end

class PokemonLoad_Scene
  def pbSetParty(trainer)
    return if !trainer || !trainer.party
    meta = GameData::PlayerMetadata.get(trainer.character_ID)
    if meta
      filename = pbGetPlayerCharset(meta.walk_charset, trainer, true)
      @sprites["player"] = TrainerWalkingCharSprite.new(filename, @viewport)
      charwidth  = @sprites["player"].bitmap.width
      charheight = @sprites["player"].bitmap.height
      @sprites["player"].x        = 112 - (charwidth / 8)
      @sprites["player"].y        = 112 - (charheight / 8)
      @sprites["player"].src_rect = Rect.new(0, 0, charwidth / 4, charheight / 4)
    end
    trainer.party.each_with_index do |pkmn, i|
      @sprites["party#{i}"] = PokemonIconSprite.new(pkmn, @viewport)
      @sprites["party#{i}"].setOffset(PictureOrigin::CENTER)
      @sprites["party#{i}"].x = 296 + (66 * (i % 3))
      @sprites["party#{i}"].y = 112 + (50 * (i / 3))
      @sprites["party#{i}"].z = 99999
    end
  end
end