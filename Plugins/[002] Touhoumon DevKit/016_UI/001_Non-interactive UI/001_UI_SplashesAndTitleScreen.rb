#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Modified the graphics used in the Title and Splash Screen
#==============================================================================#
class IntroEventScene < EventScene
  # Splash screen images that appear for a few seconds and then disappear.
  SPLASH_IMAGES         = ['intro1','intro2','intro3']
  # The main title screen background image.
  TITLE_BG_IMAGE        = 'splash'
  TITLE_START_IMAGE     = 'start'
  TITLE_START_IMAGE_X   = 0
  TITLE_START_IMAGE_Y   = 322
  SECONDS_PER_SPLASH    = 2
  TICKS_PER_ENTER_FLASH = 40   # 20 ticks per second
  FADE_TICKS            = 8    # 20 ticks per second
end