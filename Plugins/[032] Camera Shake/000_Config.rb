#-------------------------------------------------------------------------------
# Config Options
#-------------------------------------------------------------------------------
module ScreenShake
  # Mappings for shake strengths in tiles.
  # For example, 1.0 = exactly 1 map tile distance
  STRENGTH_LEVELS = {
    :VERY_LIGHT => 0.1,
    :LIGHT      => 0.25,
    :MEDIUM     => 0.5,
    :HEAVY      => 1.0,
    :VERY_HEAVY => 2.0
  }

  # Mappings for shake speeds in seconds.
  # Represents the time of one complete -max to +max oscillation
  # For example, 0.05 = 20 shakes per second
  SPEED_LEVELS = {
    :VERY_FAST => 0.05,
    :FAST      => 0.1,
    :NORMAL    => 0.25,
    :SLOW      => 0.5,
    :VERY_SLOW => 1.0
  }
end
