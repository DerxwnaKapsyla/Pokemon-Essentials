# A file for a bunch of random one-off variables that are for Asteria

class PokemonTemp
  attr_accessor :enduredInKazami

  def enduredInKazami
    @enduredInKazami = false if !@enduredInKazami
    return @enduredInKazami
  end
end