# This code is partially derived from Vendily's Wild Drop Items plugin.
# The way my modifications work is that it derives an item from a global drop table with four different tiers.
# It then pushes the chosen tier into the items array, and then it samples the array to select an item at random.
# it then drops that item at the end of battle

class Battle::Battler
  # This batch of code comes from Vendily's Wild Drop Items
  alias wild_drop_pbFaint pbFaint
  def pbFaint(showMessage = true)
    old_fainted = @fainted
    wild_drop_pbFaint(showMessage)
    return unless showMessage
    return unless @battle.wildBattle? && opposes?
    return unless @fainted && old_fainted != @fainted
    return unless @pokemon && @battle.internalBattle
    # This is where my changes start
	# Only proceed if the player-relevant flag is set
	return unless $player.enable_item_drops
	lowvalue  = [:TINYMUSHROOM, :PEARL, :STARDUST, :RELICCOPPER]
	midvalue  = [:RAREBONE, :BIGPEARL, :BIGMUSHROOM, :SLOWPOKETAIL]
	highvalue = [:NUGGET, :RELICSILVER, :STARPIECE, :BALMMUSHROOM]
	maxvalue  = [:PEARLSTRING, :COMETSHARD, :BIGNUGGET, :RELICGOLD]
	items     = []
	rand_tier = rand(100)
	echoln "Random Number: #{rand_tier}"
    case rand_tier
	when  0...55  then items = lowvalue
	when 55...80  then items = midvalue
	when 80...95  then items = highvalue
	when 95...100 then items = maxvalue
	end
	echoln "Chosen Items: #{items}"
    item = items.sample
	echoln "Final Chosen Items: #{item}"
    # if we have an item and successfully added it
    old_quantity_items = $bag.quantity(item)
    $bag.add(item, 1)
    added_items = $bag.quantity(item) - old_quantity_items
    if added_items>0
      item_data = GameData::Item.get(item)
      itemname = (added_items > 1) ? item_data.portion_name_plural : item_data.portion_name
      pocket = item_data.pocket
      # change the false to true if your battle window skin is dark
      colour_tag = getSkinColor(nil, 1, false)
      @battle.pbDisplay(_INTL("{1} dropped {2}{3} x{4}</c3>!",pbThis,colour_tag,itemname,added_items))
      @battle.pbDisplay(_INTL("You put the {1} in\nyour Bag's <icon=bagPocket{2}>{3}{4}</c3> pocket.",
                    itemname, pocket, colour_tag, PokemonBag.pocket_names[pocket - 1]))
    end
  end
end