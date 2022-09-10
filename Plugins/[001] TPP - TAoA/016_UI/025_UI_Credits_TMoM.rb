#==============================================================================
# * Scene_Credits_TMoM
#------------------------------------------------------------------------------
# Scrolls the credits you make below. Original Author unknown.
#
## Edited by MiDas Mike so it doesn't play over the Title, but runs by calling
# the following:
#    $scene = Scene_Credits.new
#
## New Edit 3/6/2007 11:14 PM by AvatarMonkeyKirby.
# Ok, what I've done is changed the part of the script that was supposed to make
# the credits automatically end so that way they actually end! Yes, they will
# actually end when the credits are finished! So, that will make the people you
# should give credit to now is: Unknown, MiDas Mike, and AvatarMonkeyKirby.
#                                             -sincerly yours,
#                                               Your Beloved
# Oh yea, and I also added a line of code that fades out the BGM so it fades
# sooner and smoother.
#
## New Edit 24/1/2012 by Maruno.
# Added the ability to split a line into two halves with <s>, with each half
# aligned towards the centre. Please also credit me if used.
#
## New Edit 22/2/2012 by Maruno.
# Credits now scroll properly when played with a zoom factor of 0.5. Music can
# now be defined. Credits can't be skipped during their first play.
#
## New Edit 25/3/2020 by Maruno.
# Scroll speed is now independent of frame rate. Now supports non-integer values
# for SCROLL_SPEED.
#
## New Edit 21/8/2020 by Marin.
# Now automatically inserts the credits from the plugins that have been
# registered through the PluginManager module.
#==============================================================================
class Scene_Credits_TMoM
  # Backgrounds to show in credits. Found in Graphics/Titles/ folder
  BACKGROUNDS_LIST       = ["mansion"]
  BGM                    = "W-014. Eternal Full Moon.ogg"
  SCROLL_SPEED           = 40   # Pixels per second
  SECONDS_PER_BACKGROUND = 7
  TEXT_OUTLINE_COLOR     = Color.new(0, 0, 128, 255)
  TEXT_BASE_COLOR        = Color.new(255, 255, 255, 255)
  TEXT_SHADOW_COLOR      = Color.new(0, 0, 0, 100)

  # This next piece of code is the credits.
  # Start Editing
  CREDIT = <<_END_

---- Touhou Puppet Play ----
--- The Mansion of Mystery ---
Credits



--- Game Director ---
DerxwnaKapsyla



--- Art Director ---
DerxwnaKapsyla



--- World Director ---
DerxwnaKapsyla



--- Lead Programmer ---
DerxwnaKapsyla



--- Music Composition ---
Mr. Unknown<s>a-TTTempo
Uda-Shi<s>KecleonTencho
brawlman9876<s>Jesslejohn
Magnius<s>DerxwnaKapsyla
Junichi Masuda<s>Go Ichinose
Hitomo Sato<s>Mark DiAngelo
Paradarx<s>Masayoshi Soken
brawlman9876<s>danmaq
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



--- Scenario Writing ---
DerxwnaKapsyla
FionaKaenbyou




--- Map Designers ---
DerxwnaKapsyla



--- Pokedex Text ---
Mille Materaux
DerxwnaKapsyla



--- Environment and Tool Programmers ---
Alicia: Pokextractor Tools
Maruno: Pokemon Essentials



--- Touhoumon Designers ---
HemoglobinA1C
Stuffman
Mille Marteaux
EXSariel
DoesntKnowHowToPlay
Masa
Reimufate
DerxwnaKapsyla
BulShell


--- Touhou Project Designer ---
Team Shanghai Alice



--- Beta Testers ---
Akiraita



--- Artwork ---
HemoglobinA1C<s>Alicia
BluShell<s>Stuffman
Spyro<s>Irakuy
Love_Albatross<s>SoulfulLex
zero_breaker<s>Reimufate
Uda-shi<s>KecleonTensho
AmethystRain



--- Programmer ---
DerxwnaKapsyla



--- Custom Scripts ---
{INSERTS_PLUGIN_CREDITS_DO_NOT_REMOVE}
SoulfulLex: Various misc improvements

--- Producers ---
ChaoticInfinity Development
Overseer Household



--- Executive Director and Producer ---
DerxwnaKapsyla



--- Special Thanks ---
- HemoglobinA1C - 
Developing Touhou Puppet Play

- Alicia - 
Developing the Pokéxtractor Tools

- Mille Marteaux - 
Localization of Touhoumon 1.812
Developer of Touhoumon Purple

- EX Sariel -
Localization of Touhoumon 1.812

- DoesntKnowHowToPlay -
Developer of Touhoumon Unnamed

- AmethystRain & Reborn Dev Team -
Pokemon Reborn Graphical Assets and Animations

- Reimufate -
Developer of Touhoumon Reimufate Version

- FocasLens & Fantasy Puppet Theater -
Gensou Ningyou Enbu - Yume no Kakera -
Asset Collection Pack

- FionaKaenbyou -
Writing the dialogue for basically every trainer

- Floofgear -
Emotional support and motivation throughout the years

- Relic Castle -
For putting up with my absurdity



--- Special Thanks ---
Flameguru: Initial development of Pokémon Essentials
Poccil (Peter O.): Developing Pokémon Essentials
Maruno: Picking up Pokémon Essentials
The "Pokémon Essentials" Development Team

With contributions from:
AvatarMonkeyKirby<s>Marin
Boushy<s>MiDas Mike
Brother1440<s>Near Fantastica
FL.<s>PinkMan
Genzai Kawakami<s>Popper
Golisopod User<s>Rataime
help-14<s>Savordez
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





"mkxp-z" by:
Roza
Based on "mkxp" by Ancurio et al.

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
2011-2022<s>DerxwnaKapsyla
2012-2021<s>ChaoticInfinity Development
2020-2022<s>Overseer Household
Based on Pokémon Essentials


Pokémon Essentials
2007-2010<s>Peter O.
2011-2022<s>Maruno
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
