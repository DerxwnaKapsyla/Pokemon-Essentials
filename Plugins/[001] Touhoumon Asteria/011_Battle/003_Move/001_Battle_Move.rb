class Battle::Move

  def waveMove?;         return @flags.any? { |f| f[/^Wave$/i] };               end
  
end