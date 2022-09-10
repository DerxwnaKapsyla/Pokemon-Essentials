#==============================================================================
# * Scene_Credits_TFoC
#==============================================================================
class Scene_Credits_TFoC
  # Backgrounds to show in credits. Found in Graphics/Titles/ folder
  BACKGROUNDS_LIST       = ["Gensokyo","Human Village","BGFestival","BGMistyLake","BGYoukaiWoods1","BGYoukaiWoods2","BGPlains","BGSuzuran","BGGarden","BGMugenkan"]
  BGM                    = "U-001. Sakura, Sakura ~ Japanize Dream.ogg"
  SCROLL_SPEED           = 40   # Pixels per second
  SECONDS_PER_BACKGROUND = 12
  TEXT_OUTLINE_COLOR     = Color.new(0, 0, 128, 255)
  TEXT_BASE_COLOR        = Color.new(255, 255, 255, 255)
  TEXT_SHADOW_COLOR      = Color.new(0, 0, 0, 100)

  # This next piece of code is the credits.
  # Start Editing
  CREDIT = <<_END_

--- Touhou Puppet Play ---
--- The Festival of Curses ---
Credits



--- Game Director ---
DerxwnaKapsyla



--- Art Director ---
Jelo
DerxwnaKapsyla



--- World Director ---
DerxwnaKapsyla



--- Lead Programmer ---
DerxwnaKapsyla



--- Music Composition ---
a-TTTempo<s>U2 Akiyama
Uda-Shi<s>KecleonTencho
Paradarx<s>Vlizzurd
ZUN



--- Sound Effects & Cries ---
Go Ichinose
Morikazu Aoki
a-TTTempo
Uda-Shi
KecleonTencho
Reimufate



--- Game Designers ---
DerxwnaKapsyla



--- Scenario Plot ---
DerxwnaKapsyla



--- Scenario ---
DerxwnaKapsyla




--- Map Designers ---
DerxwnaKapsyla



--- Environment and Tool Programmers ---
Maralis: Pokextractor Tools
Maruno: Pokemon Essentials



--- Touhoumon Designers ---
HemoglobinA1C<s>Reimufate
Stuffman<s>Masa
Agastya<s>EXSariel
DoesntKnowHowToPlay
DerxwnaKapsyla



--- Original Designs for the Touhoumon ---
Team Shanghai Alice



--- Beta Testers ---
Karl Grogslurper



--- Artwork ---
HemoglobinA1C<s>Maralis
Kasael<s>Stuffman
Spyro<s>Irakuy
Love_Albatross<s>SoulfulLex
zero_breaker<s>Reimufate
Uda-shi<s>KecleonTensho
Jelo<s>DerxwnaKapsyla
FocasLens<s>Poltergeist
Amethyst and the Pokemon Reborn Team
Relic Castle Game Jam Staff
Team Shanghai Alice<s>Twilight Frontier



--- Programmer ---
DerxwnaKapsyla

--- Custom Scripts ---
{INSERTS_PLUGIN_CREDITS_DO_NOT_REMOVE}
FL: Trainer Intro Music script, HMs as Items script
derFischae: HMs as Items script
Bulbasarlv15: HMs as Items script
Nuru Yuri: FModEx Script
Marin: Toggleable turbo script
Vendily: Ambient Pokemon cries
Marty152: Sideways Stairs script
AmethystRain: Skip Text script
Boonzeet: Efficent water puddles script
SoulfulLex: Various misc improvements
Mr. Gela: Name Windows
Rot8er_ConeX: Doppelganger Trainer
Mej71 & game_guy: Unlimited Self-Switch Variants port
DerxwnaKapsyla: Game Corner Shop


--- Producers ---
ChaoticInfinity Development
Overseer Household



--- Executive Director and Producer ---
DerxwnaKapsyla



--- Special Thanks ---
HemoglobinA1C: Developing Touhou Puppet Play
Maralis: Developing the Pokéxtractor Tools
Kasael: Spriting Overworlds and Battle Sprites
Agastya: Localization of Touhoumon 1.812 and Developer of Touhoumon Purple
EX Sariel: Localization of Touhoumon 1.812
DoesntKnowHowToPlay: Developer of Touhoumon Unnamed
AmethystRain & Reborn Dev Team: Permission to use graphical assets
Reimufate: Developer of Touhoumon Reimufate Version
FocasLens & Fantasy Puppet Theater: GNE-YnK- Asset Collection Pack
The Dirty Cog Crew: Emotional support and motivation throughout the years



--- Special Thanks ---
Flameguru: Initial development of Pokémon Essentials
Poccil (Peter O.): Developing Pokémon Essentials
Maruno: Picking up Pokémon Essentials
The Relic Castle Game Jam Staff
The "Pokémon Essentials" Development Team

With contributions from:
AvatarMonkeyKirby<s>Marin
Boushy<s>MiDas Mike
Brother1440<s>Near Fantastica
FL.<s>PinkMan
Genzai Kawakami<s>Popper
help-14<s>Rataime
IceGod64<s>SoundSpawn
Jacob O. Wobbrock<s>the__end
KitsuneKouta<s>Venom12
Lisa Anthony<s>Wachunga
Luka S.J.<s>
and everyone else who helped out



--- Special Thanks ---
Enterbrain: Developers and Producers of "RPG Maker XP"
GameFreak: Developers of "Pokémon"
FocasLens: Developers of "Gensou Ningyou Enbu" and "Yume no Kakera"
ZUN: Head Developer of "Touhou Project"



And YOU...





"RPG Maker XP" by:
Enterbrain

Pokémon is owned by:
The Pokémon Company
Nintendo
Affiliated with Game Freak

This is a non-profit fan-made game.
No copyright infringements intended.
Please support the official games!

Touhoumon Development Kit
2011-2021<s>DerxwnaKapsyla
2012-2021<s>ChaoticInfinity Development
2020-2021<s>Overseer Household
Based on Pokémon Essentials

Touhou Puppet Play
The Festival of Curses
2011-2021<s>DerxwnaKapsyla
2012-2021<s>ChaoticInfinity Development
2020-2021<s>Overseer Household

Pokémon Essentials
2007-2010<s>Peter O.
2011-2017<s>Maruno
Based on work by Flameguru

_END_
# Stop Editing

  def main
    #-------------------------------
    # Animated Background Setup
    #-------------------------------
    @counter = 0.0   # Counts time elapsed since the background image changed
    @bg_index = 0
    @bitmap_height = Graphics.height   # For a single credits text bitmap
    @trim = Graphics.height / 10
    # Number of game frames per background frame
    @realOY = -(Graphics.height - @trim)
    #-------------------------------
    # Credits text Setup
    #-------------------------------
    plugin_credits = ""
    PluginManager.plugins.each do |plugin|
      pcred = PluginManager.credits(plugin)
      plugin_credits << "\"#{plugin}\" v.#{PluginManager.version(plugin)} by:\n"
      if pcred.size >= 5
        plugin_credits << (pcred[0] + "\n")
        i = 1
        until i >= pcred.size
          plugin_credits << (pcred[i] + "<s>" + (pcred[i + 1] || "") + "\n")
          i += 2
        end
      else
        pcred.each { |name| plugin_credits << (name + "\n") }
      end
      plugin_credits << "\n"
    end
    CREDIT.gsub!(/\{INSERTS_PLUGIN_CREDITS_DO_NOT_REMOVE\}/, plugin_credits)
    credit_lines = CREDIT.split(/\n/)
    #-------------------------------
    # Make background and text sprites
    #-------------------------------
    viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    viewport.z = 99999
    text_viewport = Viewport.new(0, @trim, Graphics.width, Graphics.height - (@trim * 2))
    text_viewport.z = 99999
    @background_sprite = IconSprite.new(0, 0)
    @background_sprite.setBitmap("Graphics/Titles/" + BACKGROUNDS_LIST[0])
    @credit_sprites = []
    @total_height = credit_lines.size * 32
    lines_per_bitmap = @bitmap_height / 32
    num_bitmaps = (credit_lines.size.to_f / lines_per_bitmap).ceil
    num_bitmaps.times do |i|
      credit_bitmap = Bitmap.new(Graphics.width, @bitmap_height + 16)
      pbSetSystemFont(credit_bitmap)
      lines_per_bitmap.times do |j|
        line = credit_lines[(i * lines_per_bitmap) + j]
        next if !line
        line = line.split("<s>")
        xpos = 0
        align = 1   # Centre align
        linewidth = Graphics.width
        line.length.times do |k|
          if line.length > 1
            xpos = (k == 0) ? 0 : 20 + (Graphics.width / 2)
            align = (k == 0) ? 2 : 0   # Right align : left align
            linewidth = (Graphics.width / 2) - 20
          end
          credit_bitmap.font.color = TEXT_SHADOW_COLOR
          credit_bitmap.draw_text(xpos, (j * 32) + 12, linewidth, 32, line[k], align)
          credit_bitmap.font.color = TEXT_OUTLINE_COLOR
          credit_bitmap.draw_text(xpos + 2, (j * 32) + 2, linewidth, 32, line[k], align)
          credit_bitmap.draw_text(xpos,     (j * 32) + 2, linewidth, 32, line[k], align)
          credit_bitmap.draw_text(xpos - 2, (j * 32) + 2, linewidth, 32, line[k], align)
          credit_bitmap.draw_text(xpos + 2, (j * 32) + 4, linewidth, 32, line[k], align)
          credit_bitmap.draw_text(xpos - 2, (j * 32) + 4, linewidth, 32, line[k], align)
          credit_bitmap.draw_text(xpos + 2, (j * 32) + 6, linewidth, 32, line[k], align)
          credit_bitmap.draw_text(xpos,     (j * 32) + 6, linewidth, 32, line[k], align)
          credit_bitmap.draw_text(xpos - 2, (j * 32) + 6, linewidth, 32, line[k], align)
          credit_bitmap.font.color = TEXT_BASE_COLOR
          credit_bitmap.draw_text(xpos, (j * 32) + 4, linewidth, 32, line[k], align)
        end
      end
      credit_sprite = Sprite.new(text_viewport)
      credit_sprite.bitmap = credit_bitmap
      credit_sprite.z      = 9998
      credit_sprite.oy     = @realOY - (@bitmap_height * i)
      @credit_sprites[i] = credit_sprite
    end
    #-------------------------------
    # Setup
    #-------------------------------
    # Stops all audio but background music
    previousBGM = $game_system.getPlayingBGM
    pbMEStop
    pbBGSStop
    pbSEStop
    pbBGMFade(2.0)
    pbBGMPlay(BGM)
    Graphics.transition
    loop do
      Graphics.update
      Input.update
      update
      break if $scene != self
    end
    pbBGMFade(2.0)
    $game_temp.background_bitmap = Graphics.snap_to_bitmap
    Graphics.freeze
    viewport.color = Color.new(0, 0, 0, 255)   # Ensure screen is black
    Graphics.transition(8, "fadetoblack")
    $game_temp.background_bitmap.dispose
    @background_sprite.dispose
    @credit_sprites.each { |s| s&.dispose }
    text_viewport.dispose
    viewport.dispose
    $PokemonGlobal.creditsPlayed = true
    pbBGMPlay(previousBGM)
  end

  # Check if the credits should be cancelled
  def cancel?
    if Input.trigger?(Input::USE) && $PokemonGlobal.creditsPlayed
      $scene = Scene_Map.new
      pbBGMFade(1.0)
      return true
    end
    return false
  end

  # Checks if credits bitmap has reached its ending point
  def last?
    if @realOY > @total_height + @trim
      $scene = ($game_map) ? Scene_Map.new : nil
      pbBGMFade(2.0)
      return true
    end
    return false
  end

  def update
    delta = Graphics.delta_s
    @counter += delta
    # Go to next slide
    if @counter >= SECONDS_PER_BACKGROUND
      @counter -= SECONDS_PER_BACKGROUND
      @bg_index += 1
      @bg_index = 0 if @bg_index >= BACKGROUNDS_LIST.length
      @background_sprite.setBitmap("Graphics/Titles/" + BACKGROUNDS_LIST[@bg_index])
    end
    return if cancel?
    return if last?
    @realOY += SCROLL_SPEED * delta
    @credit_sprites.each_with_index { |s, i| s.oy = @realOY - (@bitmap_height * i) }
  end
end
