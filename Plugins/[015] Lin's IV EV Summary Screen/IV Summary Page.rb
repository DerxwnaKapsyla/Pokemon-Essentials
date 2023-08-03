#===============================================================================
# Adds/edits various Summary utilities.
#===============================================================================
class PokemonSummary_Scene
  def drawPageIV
    overlay = @sprites["overlay"].bitmap
    base   = Color.new(248, 248, 248)
    shadow = Color.new(104, 104, 104)
    # Determine which stats are boosted and lowered by the Pokémon's nature
    statshadows = {}
    GameData::Stat.each_main { |s| statshadows[s.id] = shadow }
    # Write various bits of text
    textpos = [
      [_INTL("HP"), 248, 94, :left, base, statshadows[:HP]],
      [sprintf("%d", @pokemon.iv[:HP]), 456, 94, :right, Color.new(64, 64, 64), Color.new(176, 176, 176)],
      [_INTL("Attack"), 248, 126, :left, base, statshadows[:ATTACK]],
      [sprintf("%d", @pokemon.iv[:ATTACK]), 456, 126, :right, Color.new(64, 64, 64), Color.new(176, 176, 176)],
      [_INTL("Defense"), 248, 158, :left, base, statshadows[:DEFENSE]],
      [sprintf("%d", @pokemon.iv[:DEFENSE]), 456, 158, :right, Color.new(64, 64, 64), Color.new(176, 176, 176)],
      [_INTL("Sp. Atk"), 248, 190, :left, base, statshadows[:SPECIAL_ATTACK]],
      [sprintf("%d", @pokemon.iv[:SPECIAL_ATTACK]), 456, 190, :right, Color.new(64, 64, 64), Color.new(176, 176, 176)],
      [_INTL("Sp. Def"), 248, 222, :left, base, statshadows[:SPECIAL_DEFENSE]],
      [sprintf("%d", @pokemon.iv[:SPECIAL_DEFENSE]), 456, 222, :right, Color.new(64, 64, 64), Color.new(176, 176, 176)],
      [_INTL("Speed"), 248, 254, :left, base, statshadows[:SPEED]],
      [sprintf("%d", @pokemon.iv[:SPEED]), 456, 254, :right, Color.new(64, 64, 64), Color.new(176, 176, 176)]
    ]
    # Draw all text
    pbDrawTextPositions(overlay, textpos)
  end
end