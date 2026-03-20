#-------------------------------------------------------------------------------
# Main Module
#-------------------------------------------------------------------------------
module ScreenShake
  module_function

  VALID_STYLES = [:NORMAL, :DAMPING, :ELASTIC]

  @strength_x = 0.0
  @strength_y = 0.0
  @speed_x = 0.0
  @speed_y = 0.0
  @duration = 0.0
  @style = :NORMAL
  @pattern = :PINGPONG

  @current_shake_x = 0.0
  @current_shake_y = 0.0
  @start_time_x = nil
  @start_time_y = nil

  @stopping_x = false
  @stopping_y = false

  @is_random = false
  @random_start_x = 0.0
  @random_start_y = 0.0
  @random_target_x = 0.0
  @random_target_y = 0.0
  @last_random_time = nil

  @transition_from_x = 0.0
  @transition_from_y = 0.0
  @transition_start_time = nil
  @transition_duration = 0.15

  def active?
    !@start_time_x.nil? || !@start_time_y.nil? || @current_shake_x != 0.0 || @current_shake_y != 0.0
  end

  def validate_style(style)
    return if VALID_STYLES.include?(style)
    raise "Unknown ScreenShake style: #{style}"
  end

  def get_strength(val)
    return val if val.is_a?(Numeric)
    raise "Unknown ScreenShake strength symbol: #{val}" unless STRENGTH_LEVELS.key?(val)
    return STRENGTH_LEVELS[val]
  end

  def get_speed(val)
    return val if val.is_a?(Numeric)
    raise "Unknown ScreenShake speed symbol: #{val}" unless SPEED_LEVELS.key?(val)
    return SPEED_LEVELS[val]
  end

  def init_transition
    if active?
      @transition_from_x = @current_shake_x
      @transition_from_y = @current_shake_y
      @transition_start_time = System.uptime
    else
      @transition_start_time = nil
    end
  end

  def start_basic(str_x, str_y, spd_x, spd_y, duration = 0.0, style = :NORMAL, pattern = :PINGPONG)
    validate_style(style)
    init_transition
    @is_random = false
    @strength_x = get_strength(str_x).to_f * Game_Map::TILE_WIDTH
    @strength_y = get_strength(str_y).to_f * Game_Map::TILE_HEIGHT
    @speed_x = get_speed(spd_x).to_f
    @speed_y = get_speed(spd_y).to_f
    @duration = duration.to_f
    @style = style
    @pattern = pattern
    @stopping_x = false
    @stopping_y = false
    @start_time_x = System.uptime if @strength_x.abs > 0 && @speed_x > 0
    @start_time_y = System.uptime if @strength_y.abs > 0 && @speed_y > 0
  end

  def start_horizontal(strength, speed, duration = 0.0, style = :NORMAL)
    start_basic(strength, 0.0, speed, 0.0, duration, style)
  end

  def start_vertical(strength, speed, duration = 0.0, style = :NORMAL)
    start_basic(0.0, strength, 0.0, speed, duration, style)
  end

  def start_diagonal(strength, speed, direction = :TOP_LEFT, duration = 0.0, style = :NORMAL)
    if [:BOTTOM_LEFT, :TOP_RIGHT].include?(direction)
      start_basic(-strength, strength, speed, speed, duration, style)
    elsif [:TOP_LEFT, :BOTTOM_RIGHT].include?(direction)
      start_basic(strength, strength, speed, speed, duration, style)
    else
      raise "Unknown ScreenShake diagonal direction: #{direction}"
    end
  end

  def start_circular(strength, speed, duration = 0.0, style = :NORMAL)
    start_basic(strength, strength, speed, speed, duration, style, :CIRCULAR)
  end

  def start_figure8(strength, speed, duration = 0.0, style = :NORMAL)
    start_basic(strength, strength, speed, speed, duration, style, :FIGURE8)
  end

  def start_noise(str_x, str_y, spd_x, spd_y, duration = 0.0, style = :NORMAL)
    start_basic(str_x, str_y, spd_x, spd_y, duration, style, :NOISE)
  end

  def start_heartbeat(strength, speed, duration = 0.0, style = :NORMAL)
    start_basic(strength, strength, speed, speed, duration, style, :HEARTBEAT)
  end

  def start_random(str_x, str_y, speed, duration = 0.0, style = :NORMAL)
    validate_style(style)
    init_transition
    @is_random = true
    @strength_x = get_strength(str_x).to_f * Game_Map::TILE_WIDTH
    @strength_y = get_strength(str_y).to_f * Game_Map::TILE_HEIGHT
    @speed_x = get_speed(speed).to_f
    @speed_y = get_speed(speed).to_f
    @duration = duration.to_f
    @style = style
    @stopping_x = false
    @stopping_y = false
    @start_time_x = System.uptime if @strength_x.abs > 0 && @speed_x > 0
    @start_time_y = System.uptime if @strength_y.abs > 0 && @speed_y > 0
    @last_random_time = System.uptime
    @random_target_x = 0.0
    @random_target_y = 0.0
    generate_random_targets
  end

  def generate_random_targets
    @random_start_x = @random_target_x
    @random_start_y = @random_target_y
    @random_target_x = ((rand * 2.0) - 1.0) * @strength_x
    @random_target_y = ((rand * 2.0) - 1.0) * @strength_y
    @last_random_time = System.uptime
  end

  def stop
    @stopping_x = true if @strength_x.abs > 0
    @stopping_y = true if @strength_y.abs > 0
    return unless @is_random && (@stopping_x || @stopping_y)
    interval = (@speed_x > 0) ? @speed_x : 0.05
    elapsed = System.uptime - @last_random_time
    progress = (interval > 0) ? (elapsed / interval).clamp(0.0, 1.0) : 1.0
    @random_start_x += ((@random_target_x - @random_start_x) * progress)
    @random_start_y += ((@random_target_y - @random_start_y) * progress)
    @random_target_x = 0.0
    @random_target_y = 0.0
    @last_random_time = System.uptime
  end

  def stop_random
    @current_shake_x = 0.0
    @current_shake_y = 0.0
    @start_time_x = nil
    @start_time_y = nil
    @stopping_x = false
    @stopping_y = false
    @is_random = false
  end

  def stop_x
    @current_shake_x = 0.0
    @strength_x = 0.0
    @speed_x = 0.0
    @start_time_x = nil
    @stopping_x = false
  end

  def stop_y
    @current_shake_y = 0.0
    @strength_y = 0.0
    @speed_y = 0.0
    @start_time_y = nil
    @stopping_y = false
  end

  def get_pingpong(start_time, speed, strength)
    elapsed = System.uptime - start_time
    phase = ((elapsed / speed) * 2.0) % 4.0
    abs_str = strength.abs
    sign = (strength < 0) ? -1.0 : 1.0
    if phase < 1.0
      val = phase * abs_str
    elsif phase < 3.0
      val = abs_str - ((phase - 1.0) * abs_str)
    else
      val = -abs_str + ((phase - 3.0) * abs_str)
    end
    return val * sign
  end

  def get_noise(start_time, speed, strength, offset)
    elapsed = System.uptime - start_time
    t = (elapsed / speed) * Math::PI * 2.0
    t += offset
    val = Math.sin(t) + (0.5 * Math.sin(t * 1.732)) + (0.25 * Math.sin(t * 2.846)) + (0.125 * Math.sin(t * 4.123))
    return strength * (val / 1.875)
  end

  def get_heartbeat(start_time, speed, strength)
    elapsed = System.uptime - start_time
    t = (elapsed % speed) / speed.to_f
    val = 0.0
    if t < 0.15
      val = Math.sin((t / 0.15) * Math::PI * 2.0)
    elsif t >= 0.25 && t < 0.40
      val = Math.sin(((t - 0.25) / 0.15) * Math::PI * 2.0)
    end
    return strength * val
  end

  def get_base_x(start_time, speed, strength)
    return 0.0 if !start_time || speed <= 0 || strength == 0.0
    elapsed = System.uptime - start_time
    case @pattern
    when :CIRCULAR, :FIGURE8
      strength * Math.sin((elapsed / speed) * Math::PI * 2.0)
    when :NOISE
      get_noise(start_time, speed, strength, 0.0)
    when :HEARTBEAT
      get_heartbeat(start_time, speed, strength)
    else
      if @style == :ELASTIC
        abs_str = strength.abs
        sign = (strength < 0) ? -1.0 : 1.0
        abs_str * Math.cos((elapsed / speed) * Math::PI * 2.0) * sign
      else
        get_pingpong(start_time, speed, strength)
      end
    end
  end

  def get_base_y(start_time, speed, strength)
    return 0.0 if !start_time || speed <= 0 || strength == 0.0
    elapsed = System.uptime - start_time
    case @pattern
    when :CIRCULAR
      strength * Math.cos((elapsed / speed) * Math::PI * 2.0)
    when :FIGURE8
      strength * Math.sin((elapsed / speed) * Math::PI * 4.0)
    when :NOISE
      get_noise(start_time, speed, strength, 100.0)
    when :HEARTBEAT
      get_heartbeat(start_time, speed, strength)
    else
      if @style == :ELASTIC
        abs_str = strength.abs
        sign = (strength < 0) ? -1.0 : 1.0
        abs_str * Math.cos((elapsed / speed) * Math::PI * 2.0) * sign
      else
        get_pingpong(start_time, speed, strength)
      end
    end
  end

  def get_multiplier(start_time)
    return 1.0 if @duration <= 0.0 || !start_time
    elapsed = System.uptime - start_time
    return 0.0 if elapsed >= @duration
    return 1.0 unless @style == :DAMPING || @style == :ELASTIC
    mul = 1.0 - (elapsed / @duration)
    return [mul, 0.0].max
  end

  def apply_transition_x(target)
    return target unless @transition_start_time
    elapsed = System.uptime - @transition_start_time
    return target if elapsed >= @transition_duration
    t = elapsed / @transition_duration
    return @transition_from_x + ((target - @transition_from_x) * t)
  end

  def apply_transition_y(target)
    return target unless @transition_start_time
    elapsed = System.uptime - @transition_start_time
    return target if elapsed >= @transition_duration
    t = elapsed / @transition_duration
    return @transition_from_y + ((target - @transition_from_y) * t)
  end

  def update_random
    return unless @start_time_x || @start_time_y
    mul = get_multiplier(@start_time_x || @start_time_y)
    if mul <= 0.0
      stop_random
      return
    end
    elapsed = System.uptime - @last_random_time
    interval = (@speed_x > 0) ? @speed_x : 0.05
    if elapsed >= interval
      if @stopping_x || @stopping_y
        stop_random
        return
      else
        generate_random_targets
        elapsed = 0.0
      end
    end
    return unless @is_random || @stopping_x || @stopping_y
    progress = (interval > 0) ? elapsed / interval : 1.0
    base_x = @random_start_x + ((@random_target_x - @random_start_x) * progress)
    base_y = @random_start_y + ((@random_target_y - @random_start_y) * progress)
    @current_shake_x = apply_transition_x(base_x * mul)
    @current_shake_y = apply_transition_y(base_y * mul)
  end

  def shake_in_range?(current, new_val)
    return current == 0.0 || (current > 0 && new_val <= 0) || (current < 0 && new_val >= 0)
  end

  def update_x
    if @start_time_x && @strength_x.abs > 0 && @speed_x > 0
      mul = get_multiplier(@start_time_x)
      base_shake = get_base_x(@start_time_x, @speed_x, @strength_x)
      new_shake = base_shake * mul
      if mul <= 0.0 || (@stopping_x && shake_in_range?(@current_shake_x, new_shake))
        stop_x
      else
        @current_shake_x = apply_transition_x(new_shake)
      end
    else
      stop_x
    end
  end

  def update_y
    if @start_time_y && @strength_y.abs > 0 && @speed_y > 0
      mul = get_multiplier(@start_time_y)
      base_shake = get_base_y(@start_time_y, @speed_y, @strength_y)
      new_shake = base_shake * mul
      if mul <= 0.0 || (@stopping_y && shake_in_range?(@current_shake_y, new_shake))
        stop_y
      else
        @current_shake_y = apply_transition_y(new_shake)
      end
    else
      stop_y
    end
  end

  def apply_deltas(prev_shake_x, prev_shake_y)
    return unless $game_map && (prev_shake_x != @current_shake_x || prev_shake_y != @current_shake_y)
    delta_x = @current_shake_x - prev_shake_x
    delta_y = @current_shake_y - prev_shake_y
    $game_map.display_x += delta_x
    $game_map.display_y += delta_y
  end

  def update
    prev_shake_x = @current_shake_x
    prev_shake_y = @current_shake_y
    if @is_random
      update_random
    else
      update_x
      update_y
    end
    if @transition_start_time && (System.uptime - @transition_start_time) >= @transition_duration
      @transition_start_time = nil
    end
    apply_deltas(prev_shake_x, prev_shake_y)
  end
end

#-------------------------------------------------------------------------------
# Game_Player overrides
#-------------------------------------------------------------------------------
class Game_Player
  unless method_defined?(:__screenshake__update_screen_position)
    alias __screenshake__update_screen_position update_screen_position
  end

  def update_screen_position(last_real_x, last_real_y)
    if ScreenShake.active?
      return if map.scrolling? || !(@moved_last_frame || @moved_this_frame)
      map.display_x += @real_x - last_real_x if @real_x != last_real_x
      map.display_y += @real_y - last_real_y if @real_y != last_real_y
    else
      __screenshake__update_screen_position(last_real_x, last_real_y)
    end
  end
end

#-------------------------------------------------------------------------------
# Game_Map overrides
#-------------------------------------------------------------------------------
class Game_Map
  alias __screenshake__update update unless method_defined?(:__screenshake__update)
  alias __screenshake__start_scroll start_scroll unless method_defined?(:__screenshake__start_scroll)
  alias __screenshake__scroll_up scroll_up unless method_defined?(:__screenshake__scroll_up)
  alias __screenshake__scroll_down scroll_down unless method_defined?(:__screenshake__scroll_down)
  alias __screenshake__scroll_left scroll_left unless method_defined?(:__screenshake__scroll_left)
  alias __screenshake__scroll_right scroll_right unless method_defined?(:__screenshake__scroll_right)

  def update
    __screenshake__update
    ScreenShake.update
  end

  def start_scroll(direction, distance, speed)
    __screenshake__start_scroll(direction, distance, speed)
  end

  def scroll_down(distance)
    (ScreenShake.active?) ? @display_y += distance : __screenshake__scroll_down(distance)
  end

  def scroll_left(distance)
    (ScreenShake.active?) ? @display_x -= distance : __screenshake__scroll_left(distance)
  end

  def scroll_right(distance)
    (ScreenShake.active?) ? @display_x += distance : __screenshake__scroll_right(distance)
  end

  def scroll_up(distance)
    (ScreenShake.active?) ? @display_y -= distance : __screenshake__scroll_up(distance)
  end
end

#-------------------------------------------------------------------------------
# Interpreter warning
#-------------------------------------------------------------------------------
class Interpreter
  alias __screenshake__command_225 command_225 unless method_defined?(:__screenshake__command_225)
  def command_225
    Console.echo_warn("Using Base RMXP Screen Shake command. Use the ScreenShake module instead.")
    __screenshake__command_225
  end
end
