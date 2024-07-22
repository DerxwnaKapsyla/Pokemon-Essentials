module APMSettings
  # By default these are set to the Pocket names, you can name them anything you want but you should respect the Pocket Order.
  # Unless you've modified this. Not all Categories are shown each time, for example, "Key Items" would probably never be shown (these are filtered out by the script by default).
  CategoryNames = PokemonBag.pocket_names.map { |pocket| pocket.to_s }

  CustomCategoryNames = {
    "Evolution Stones" => {
      :items => [:FIRESTONE, :THUNDERSTONE, :WATERSTONE, :LEAFSTONE, :MOONSTONE, :SUNSTONE, :DUSKSTONE, :DAWNSTONE, :SHINYSTONE, :ICESTONE, :POWERSHARD,:DEFENSESHARD,:TECHSHARD,:SWIFTSHARD,:SUPPORTSHARD,:SOLARSHARD,:CHROMESHARD],
      :order => 11
    },
    "Type Plates" => {
      :items => [:FLAMEPLATE, :SPLASHPLATE, :ZAPPLATE, :MEADOWPLATE, :ICICLEPLATE, :FISTPLATE, :TOXICPLATE, :EARTHPLATE, :SKYPLATE, :MINDPLATE, :INSECTPLATE, :STONEPLATE, :SPOOKYPLATE, :DRACOPLATE, :DREADPLATE, :IRONPLATE, :PIXIEPLATE],
      :order => 12
    },
    "Type Gems" => {
      :items => [:FIREGEM, :WATERGEM, :ELECTRICGEM, :GRASSGEM, :ICEGEM, :FIGHTINGGEM, :POISONGEM, :GROUNDGEM, :FLYINGGEM, :PSYCHICGEM, :BUGGEM, :ROCKGEM, :GHOSTGEM, :DRAGONGEM, :DARKGEM, :STEELGEM, :FAIRYGEM, :NORMALGEM],
      :order => 13
    },
	"Type Costumes" => {
      :items => [:BUNNYSUIT,:MAIDCOSTUME,:SWEATER,:CAMOUFLAGE,:BLAZER,:MISTRESS,:NINJA,:NURSE,:SWIMSUIT,:STEWARDESS,:THICKFUR,:KIMONO,:WITCH,:GOTHIC,:BRIDALGOWN,:PRIESTESS,:CHINADRESS],
      :order => 14
	},
	"Type Hairpins" => {
      :items => [:HEMATITEHAIRPIN,:QUARTZHAIRPIN,:ONYXHAIRPIN,:MALACHITEHAIRPIN,:GOLDHAIRPIN,:OBSIDIANHAIRPIN,:JADEHAIRPIN,:AMETHYSTHAIRPIN,:AQUAMARINEHAIRPIN,:DIAMONDHAIRPIN,:LAPISHAIRPIN,:SUGILITEHAIRPIN,:OPALHAIRPIN,:GARNETHAIRPIN,:MORGANITEHAIRPIN,:TOPAZHAIRPIN,:MOONSTONEHAIRPIN],
      :order => 15
	},
	"Skill Cards" => {
      :items => [:SC01,:SC02,:SC03,:SC04,:SC05,:SC06,:SC07,:SC08,:SC09,:SC10,:SC11,:SC12,:SC13,:SC14,:SC15,:SC16,:SC17,:SC18,:SC19,:SC20,:SC21,:SC22,:SC23,:SC24,:SC25,:SC26,:SC27,:SC28,:SC29,:SC30,:SC31,:SC32,:SC33,:SC34,:SC35,:SC36,:SC37,:SC38,:SC39,:SC40,:SC41,:SC42,:SC43,:SC44,:SC45,:SC46,:SC47,:SC48,:SC49,:SC50],
      :order => 16
	},
	"Battle Utility" => {
      :items => [:ANTIMETAL,:ANTIEARTH,:ANTIBEAST,:ANTINATURE,:ANTIHEART,:ANTIUMBRAL,:ANTIWIND,:ANTIMIASMA,:ANTIHYDRO,:ANTIAERO,:ANTICRYO,:ANTINETHER,:ANTIREASON,:ANTIPYRO,:ANTIILLUSION,:ANTIFAITH,:ANTIDREAM],
      :order => 17
	},
  }

  BadgesForItems = {
    1 => [],
    3 => [],
    5 => [],
    7 => [],
    8 => []
  }

  Discounts = {
    :COUPONA => {
      27 => [0, 3, 6, 8, -10],
      28 => [0, -2, -5]
    },
    26 => [0, 1, 4, 7, 11],
    :COUPONB => {
    29 => [10, 8, 6, 4, 2, 0, -2, -4, -6, -8, -10, -12]
    }
  }

  BonusItems = {
    # :POKEBALL => {
      # :amount => 10,
      # :item => :PREMIERBALL
    # },
    # :GREATBALL => {
      # :amount => 10,
      # :item => [
        # [:GREATBALL, 80],
        # [:PREMIERBALL, 20]
      # ]
    # },
    # :ULTRABALL => {
      # :amount => 5,
      # :item => {
        # :PREMIERBALL => {
          # :amount => 3
        # },
        # :MASTERBALL => {
          # :chance => 0.1
        # },
        # :ULTRABALL => {
          # :amount => 2,
          # :chance => 5
        # }
      # }
    # },
    # :POTION => {
      # :amount => 5,
      # :item => {
        # :ANTIDOTE => {
          # :amount => 2
        # },
        # :PARALYZEHEAL => {
          # :amount => 2,
          # :chance => 20
        # },
        # :ICEHEAL => {
          # :amount => 2,
          # :chance => 20
        # },
        # :BURNHEAL => {
          # :amount => 2
        # },
        # :FULLHEAL => {
          # :chance => 5
        # }
      # }
    # },
    # :FULLHEAL => {
      # :amount => 10,
      # :item => {
        # :FULLHEAL => {
          # :amount => 3
        # }
      # }
    # }
  }

  ProSeller = {
    # Text when talking to them. This is the default one.
    IntroText: ["Good Day, welcome how may I serve you?", "Hello, welcome, what can I mean for you?", "Hello, Welcome what can I get for you?"],
    # Text when choosing to buy item. (optional: If you make this empty( [] ), you'll go to the buy screen directly.)
    CategoryText: ["We listed our Items in Categories for you.","Exclusively for you, these are the Categories we have to offer."], # or CategoryText: [],
    # Text when choosing amount of item. {1} = item name.
    BuyItemAmount: ["So how many {1}?", "How many {1} would you like?"],
    # Text when choosing amount of item with discount. {1} = item name {2} = discount price {3} = original price.
    BuyItemAmountDiscount: ["There's a discount on {1}, they're ${2} instead of ${3}. How many would you like?"],
    # Text when choosing amount of item with overcharge. {1} = item name {2} = overcharge price {3} = original price.
    BuyItemAmountOvercharge: ["There's overcharge on {1}, you must pay ${2} instead of ${3}. So how many?"],
    # Text when buying 1 of an item. {1} = item vowel {2} = item name {3} = price.
    BuyItem: ["So you want {1} {2}?\nIt'll be ${3}. All right?", "So you would like to buy {1} {2}?\nThat's going to cost you ${3}!"],
    # Text when buying 2 or more of an item. {1} = amount {2} = item name (plural) {3} = price.
    BuyItemMult: ["So you want {1} {2}?\nThey'll be ${3}. All right?"],
    # Text when buying important item (that you can only buy 1 off). {1} = item name {2} = price.
    BuyItemImportant: ["So you want {1}?\nIt'll be ${2} . All right?"],
    # Text when wanted item is out of stock. {1} = item name (plural) {2} = time in days (tomorrow, in 2 days, in x days, in a week, next week etc.)
    BuyOutOfStock: ["We're really sorry, this item is currently out of stock. Come back {2}!", "We're sorry but we don't have any {1} left. Come back {2}!", "Come back {2} when we have more {1}."],
    # Text when bought item.
    BuyThanks: ["Here you are! Thank you!"],
    # Text when x or more of a kind of item is bought and is defined in BonusItems Setting. {1} = Bonus Item(s) name(s).
    BuyBonusMult: ["And have {1} on the house!"],
    # Text when you don't have enough money to buy x item(s).
    NotEnoughMoney: ["You don't have enough money."],
    # Text when you don't have enough room in your bag. (Only used if you have an item limit).
    NoRoomInBag: ["You have no room in your Bag."],
    # Text when selecting an item to sell. {1} = item name
    SellItemAmount: ["How many {1} would you like to sell?"],
    # Text when confirming amount of selected item to sell. {1} = price
    SellItem: ["I can pay ${1}.\nWould that be OK?"],
    # Text when unable to sell selected item. {1} = item name
    CantSellItem: ["Oh, no. I can't buy {1}."],
    # Text when returning to menu to choose either buying, selling or exit.
    MenuReturnText: ["Is there anything else I can do for you?", "What else could I mean for you today?"],
    # Text when exiting.
    OutroText: ["Do come again!", "Thank you, I hope to see you again.", "Thank you for your purchase, come again!"],
    OutroTextSaturday: ["Thank you for your purchase. \nEnjoy the rest of your Saturday."]
  }

  BerrySeller = {
    # Text when talking to them.
    IntroText: ["Welcome to the Berry Shop! Locally grown berries is all I sell. How can I help you today?"],
    # Text when choosing to buy item. (optional: If you make this empty( [] ), you'll go to the buy screen directly.)
    CategoryText: [], # or CategoryText: [],
    # Text when choosing amount of item. {1} = item name.
    BuyItemConfirm: ["So you want how many of {1}?"],
    # Text when buying 1 of an item. {1} = item vowel {2} = item name {3} = price.
    BuyItem: ["So you want {1} {2}?\nIt'll be ${3}. Sound good?", "So you would like to buy {1} {2}?\nThat's going to cost you ${3}!"],
    # Text when buying 2 or more of an item. {1} = amount {2} = item name (plural) {3} = price.
    BuyItemMult: ["So you want {1} {2}?\nThey'll be ${3}. All right?"],
    # Text when buying important item (that you can only buy 1 off). {1} = item name {2} = price.
    BuyItemImportant: ["So you want {1}?\nIt'll be ${2}. All right?"],
    # Text when wanted item is out of stock. {1} = item name (plural) {2} = time in days (tomorrow, in 2 days, in x days, in a week, next week etc.)
    BuyOutOfStock: ["Oh man, we're fresh out of those! You'll have to come back {2} and we'll have more {1} in stock!", "Looks like you bought out all of the {1} we had. Come back {2}!", "Come back {2} when we have more {1}."],
    # Text when bought item.
    BuyThanks: ["I hope you enjoy your delicious berries!"],
    # Text when x or more of a kind of item is bought and is defined in BonusItems Setting. {1} = Bonus Item(s) name(s).
    BuyBonusMult: ["And have {1} on the house!"],
    # Text when you don't have enough money to buy x item(s).
    NotEnoughMoney: ["You don't have enough money."],
    # Text when you don't have enough room in your bag. (Only used if you have an item limit).
    NoRoomInBag: ["You have no room in your Bag."],
    # Text when selecting an item to sell. {1} = item name
    SellItem: ["How many {1} would you like to sell?"],
    # Text when confirming amount of selected item to sell. {1} = price
    SellItemConfirm: ["I can pay ${1}.\nWould that be OK?"],
    # Text when unable to sell selected item. {1} = item name
    CantSellItem: ["Oh, no. I can't buy {1}."],
    # Text when returning to menu to choose either buying, selling or exit.
    MenuReturnText: ["Is there anything else I can do for you?", "What else could I get for you today?"],
    # Text when exiting.
    OutroText: ["Do come again!", "Thank you, I hope to see you again.", "Thank you for your purchase, come again!"],
  }
  
  AliceShop = {
    # Text when talking to them. This is the default one.
    IntroText: ["\\xn[Alice]May I interest you in one of our products? Please, don't be shy!"],
    # Text when choosing to buy item. (optional: If you make this empty( [] ), you'll go to the buy screen directly.)
    CategoryText: ["\\xn[Alice]We have full costumes and accessories, which would you like to browse?"], # or CategoryText: [],
    # Text when choosing amount of item. {1} = item name.
    BuyItemAmount: ["{1}? Sure, how many would you like?"],
    # Text when choosing amount of item with discount. {1} = item name {2} = discount price {3} = original price.
    BuyItemAmountDiscount: [],
    # Text when choosing amount of item with overcharge. {1} = item name {2} = overcharge price {3} = original price.
    BuyItemAmountOvercharge: [],
    # Text when buying 1 of an item. {1} = item vowel {2} = item name {3} = price.
    BuyItem: ["So you want {1} {2}?\nIt'll be ${3}. All right?"],
    # Text when buying 2 or more of an item. {1} = amount {2} = item name (plural) {3} = price.
    BuyItemMult: ["So you want {1} {2}?\nThey'll be ${3}. All right?"],
    # Text when buying important item (that you can only buy 1 off). {1} = item name {2} = price.
    BuyItemImportant: ["So you want {1}?\nIt'll be ${2} . All right?"],
    # Text when wanted item is out of stock. {1} = item name (plural) {2} = time in days (tomorrow, in 2 days, in x days, in a week, next week etc.)
    BuyOutOfStock: [],
    # Text when bought item.
    BuyThanks: ["Thank you for your business!"],
    # Text when x or more of a kind of item is bought and is defined in BonusItems Setting. {1} = Bonus Item(s) name(s).
    BuyBonusMult: [],
    # Text when you don't have enough money to buy x item(s).
    NotEnoughMoney: ["I'm not running a charity here! Please return when you have more money!"],
    # Text when you don't have enough room in your bag. (Only used if you have an item limit).
    NoRoomInBag: ["You should perhaps make some additional room in your bag before I give you these!"],
    # Text when selecting an item to sell. {1} = item name
    SellItemAmount: ["How many {1} would you like to sell?"],
    # Text when confirming amount of selected item to sell. {1} = price
    SellItem: ["I can pay ${1}.\nWould that be OK?"],
    # Text when unable to sell selected item. {1} = item name
    CantSellItem: ["Oh, no. I can't buy {1}."],
    # Text when returning to menu to choose either buying, selling or exit.
    MenuReturnText: ["\\xn[Alice]Is there anything else I can do for you?"],
    # Text when exiting.
    OutroText: ["\\xn[Alice]Thank you, please come again!"],
  }
  
  KirisameShop = {
    # Text when talking to them. This is the default one.
    IntroText: ["\\xn[Maya]Welcome to the Kirisame General Store, where our motto is \"We have everything we don't lack\"!\\nHow can I help you today?"],
    # Text when choosing to buy item. (optional: If you make this empty( [] ), you'll go to the buy screen directly.)
    CategoryText: ["\\xn[Maya]Currently we are stocking Skill Cards and Battle Utility items. Which one would you like to purchase?"], # or CategoryText: [],
    # Text when choosing amount of item. {1} = item name.
    BuyItemAmount: ["{1}? Sure, how many would you like?"],
    # Text when choosing amount of item with discount. {1} = item name {2} = discount price {3} = original price.
    BuyItemAmountDiscount: [],
    # Text when choosing amount of item with overcharge. {1} = item name {2} = overcharge price {3} = original price.
    BuyItemAmountOvercharge: [],
    # Text when buying 1 of an item. {1} = item vowel {2} = item name {3} = price.
    BuyItem: ["So you want {1} {2}?\nIt'll be ${3}. All right?"],
    # Text when buying 2 or more of an item. {1} = amount {2} = item name (plural) {3} = price.
    BuyItemMult: ["So you want {1} {2}?\nThey'll be ${3}. All right?"],
    # Text when buying important item (that you can only buy 1 off). {1} = item name {2} = price.
    BuyItemImportant: ["So you want {1}?\nIt'll be ${2} . All right?"],
    # Text when wanted item is out of stock. {1} = item name (plural) {2} = time in days (tomorrow, in 2 days, in x days, in a week, next week etc.)
    BuyOutOfStock: [],
    # Text when bought item.
    BuyThanks: ["Thank you for your business!"],
    # Text when x or more of a kind of item is bought and is defined in BonusItems Setting. {1} = Bonus Item(s) name(s).
    BuyBonusMult: [],
    # Text when you don't have enough money to buy x item(s).
    NotEnoughMoney: ["You don't have enough money for this item..."],
    # Text when you don't have enough room in your bag. (Only used if you have an item limit).
    NoRoomInBag: ["Your bag looks like its about to burst! You should make some space first."],
    # Text when selecting an item to sell. {1} = item name
    SellItemAmount: ["How many {1} would you like to sell?"],
    # Text when confirming amount of selected item to sell. {1} = price
    SellItem: ["I can pay ${1}.\nWould that be OK?"],
    # Text when unable to sell selected item. {1} = item name
    CantSellItem: ["Oh, no. I can't buy {1}."],
    # Text when returning to menu to choose either buying, selling or exit.
    MenuReturnText: ["\\xn[Maya]Is there anything else I can do for you?"],
    # Text when exiting.
    OutroText: ["\\xn[Maya]Thank you, please come again!"],
  }
  
  TavernShop = {
    # Text when talking to them. This is the default one.
    IntroText: ["Hey \\pn! Don't see you here often! What can I get for you today?"],
    # Text when choosing to buy item. (optional: If you make this empty( [] ), you'll go to the buy screen directly.)
    CategoryText: [], # or CategoryText: [],
    # Text when choosing amount of item. {1} = item name.
    BuyItemAmount: ["{1}? Sure, how many would you like?"],
    # Text when choosing amount of item with discount. {1} = item name {2} = discount price {3} = original price.
    BuyItemAmountDiscount: [],
    # Text when choosing amount of item with overcharge. {1} = item name {2} = overcharge price {3} = original price.
    BuyItemAmountOvercharge: [],
    # Text when buying 1 of an item. {1} = item vowel {2} = item name {3} = price.
    BuyItem: ["So you want {1} {2}?\nIt'll be ${3}. All right?"],
    # Text when buying 2 or more of an item. {1} = amount {2} = item name (plural) {3} = price.
    BuyItemMult: ["So you want {1} {2}?\nThey'll be ${3}. All right?"],
    # Text when buying important item (that you can only buy 1 off). {1} = item name {2} = price.
    BuyItemImportant: ["So you want {1}?\nIt'll be ${2} . All right?"],
    # Text when wanted item is out of stock. {1} = item name (plural) {2} = time in days (tomorrow, in 2 days, in x days, in a week, next week etc.)
    BuyOutOfStock: [],
    # Text when bought item.
    BuyThanks: ["Enjoy your drink!"],
    # Text when x or more of a kind of item is bought and is defined in BonusItems Setting. {1} = Bonus Item(s) name(s).
    BuyBonusMult: [],
    # Text when you don't have enough money to buy x item(s).
    NotEnoughMoney: ["C'mon \\pn, you know I can't just give you alcohol for free."],
    # Text when you don't have enough room in your bag. (Only used if you have an item limit).
    NoRoomInBag: ["Are you sure you have room to carry this?"],
    # Text when selecting an item to sell. {1} = item name
    SellItemAmount: ["How many {1} would you like to sell?"],
    # Text when confirming amount of selected item to sell. {1} = price
    SellItem: ["I can pay ${1}.\nWould that be OK?"],
    # Text when unable to sell selected item. {1} = item name
    CantSellItem: ["Oh, no. I can't buy {1}."],
    # Text when returning to menu to choose either buying, selling or exit.
    MenuReturnText: ["Did you need anything else?"],
    # Text when exiting.
    OutroText: ["Alright \\pn, don't be a stranger!"],
  }
  
  Musharna = {
    # Text when talking to them. This is the default one.
    IntroText: ["\\se[MUSHARNA]The Musharna makes a pleasant noise, like it's greeting you."],
    # Text when choosing to buy item. (optional: If you make this empty( [] ), you'll go to the buy screen directly.)
    CategoryText: [], # or CategoryText: [],
    # Text when choosing amount of item. {1} = item name.
    BuyItemAmount: ["The Musharna makes a questioning noise, almost like it's asking how many {1} you want."],
    # Text when choosing amount of item with discount. {1} = item name {2} = discount price {3} = original price.
    BuyItemAmountDiscount: [],
    # Text when choosing amount of item with overcharge. {1} = item name {2} = overcharge price {3} = original price.
    BuyItemAmountOvercharge: [],
    # Text when buying 1 of an item. {1} = item vowel {2} = item name {3} = price.
    BuyItem: ["The Musharna makes a confirming noise, almost like it's asking if you want {1} {2}, and that it'll be ${3}."],
    # Text when buying 2 or more of an item. {1} = amount {2} = item name (plural) {3} = price.
    BuyItemMult: ["The Musharna makes a confirming noise, almost like it's asking if you want {1} {2}, and that it'll be ${3}."],
    # Text when buying important item (that you can only buy 1 off). {1} = item name {2} = price.
    BuyItemImportant: ["The Musharna makes a confirming noise, almost like it's asking if you want {1}, and that it'll be ${2}."],
    # Text when wanted item is out of stock. {1} = item name (plural) {2} = time in days (tomorrow, in 2 days, in x days, in a week, next week etc.)
    BuyOutOfStock: [],
    # Text when bought item.
    BuyThanks: ["The Musharna makes a pleased noise and takes your money!"],
    # Text when x or more of a kind of item is bought and is defined in BonusItems Setting. {1} = Bonus Item(s) name(s).
    BuyBonusMult: [],
    # Text when you don't have enough money to buy x item(s).
    NotEnoughMoney: ["The Musharna makes a sad noise, as if informing you that you don't have enough money."],
    # Text when you don't have enough room in your bag. (Only used if you have an item limit).
    NoRoomInBag: ["The Musharna makes a sad noise, as if informing you that you don't have enough bag space."],
    # Text when selecting an item to sell. {1} = item name
    SellItemAmount: ["The Musharna makes a questioning noise, almost like it's asking how many {1} you want to sell?"],
    # Text when confirming amount of selected item to sell. {1} = price
    SellItem: ["The Musharna makes a confirming noise, almost like it's telling you that they pay ${1} for the items."],
    # Text when unable to sell selected item. {1} = item name
    CantSellItem: ["The Musharna makes a confused noise, as if to tell you that it can't buy the {1}."],
    # Text when returning to menu to choose either buying, selling or exit.
    MenuReturnText: ["The Musharna makes a questioning noise, almost like it's asking if you need anything else."],
    # Text when exiting.
    OutroText: ["\\se[MUSHARNA]The Musharna makes a pleasant noise, like it's telling you to have a good day!"],
  }
end

# If it would be easier to setup stores here then you only need to add an event script line saying pbStore1 or whatever you called the method.
# Since you're more limited in space in the event, it could be easier to manage your stores here (or you can make .rb files for each store)

# the arguments are as following pbPokemonMart(["refresh type", [:ITEM, min, max], :ITEM], "SellerClass", true, false)
# "refresh type" = this can either be "random", "daily", "2daily" or "weekly" or if you don't want limited stock just don't include this at all.
# [:ITEM, min, max] = an array containing the item and a min and max amount
# (the min and max values will be used to generate a random amount between these number which will decide the limited amount of stock for this item)
# :ITEM = just the item and no item limit is given (this item won't run out of stock)
# "SellerClass" like the examples above ProSeller or BerrySeller these are classes, this is required if you want to use custom speeches for your saleman.
# true = item categories are enabled (items will be devided in categories which might look more orginized).
# false = can't sell is disabled or just don't put this at all (true is enabled)
def pbStore1
  pbPokemonMart(
  ["random",
    :POTION,
    [:SUPERPOTION],
    [:HYPERPOTION, 15, 10],
    :MAXPOTION,
    :FULLRESTORE,
    :REVIVE,
    :ANTIDOTE,
    :PARALYZEHEAL,
    :BURNHEAL,
    :ICEHEAL,
    :AWAKENING,
    :FULLHEAL,
    :POKEBALL,
    :GREATBALL,
    :ULTRABALL,
    :REPEL,
    :SUPERREPEL,
    :MAXREPEL,
    :GRASSMAIL,
    :FLAMEMAIL,
    :BUBBLEMAIL,
    :SPACEMAIL,
    :FIRESTONE,
    :THUNDERSTONE,
    :WATERSTONE,
    :LEAFSTONE,
    :MOONSTONE,
    :SUNSTONE,
    :DUSKSTONE,
    :DAWNSTONE,
    :SHINYSTONE,
    :ICESTONE,
    :FLAMEPLATE,
    :SPLASHPLATE,
    :ZAPPLATE,
    :MEADOWPLATE,
    :ICICLEPLATE,
    :FISTPLATE,
    :TOXICPLATE,
    :EARTHPLATE,
    :SKYPLATE,
    :MINDPLATE,
    :INSECTPLATE,
    :STONEPLATE,
    :SPOOKYPLATE,
    :DRACOPLATE,
    :DREADPLATE,
    :IRONPLATE,
    :PIXIEPLATE,
    :FIREGEM,
    :WATERGEM,
    :ELECTRICGEM,
    :GRASSGEM,
    :ICEGEM,
    :FIGHTINGGEM,
    :POISONGEM,
    :GROUNDGEM,
    :FLYINGGEM,
    :PSYCHICGEM,
    :BUGGEM,
    :ROCKGEM,
    :GHOSTGEM,
    :DRAGONGEM,
    :DARKGEM,
    :STEELGEM,
    :FAIRYGEM,
    :NORMALGEM
  ], "ProSeller", true)
end

def pbStore2
  pbPokemonMart(
  ["random",
    :ORANBERRY,
    :CHESTOBERRY,
    :PECHABERRY
  ], "BerrySeller", true)
end

def pbSomeMart
  pbPokemonMart(["daily",
    [:POKEBALL, 10, 20], :GREATBALL, :ULTRABALL,
    :POTION, [:SUPERPOTION, 8, 12], [:HYPERPOTION, 5, 8], [:MAXPOTION, 2, 5],
    :FULLRESTORE, [:REVIVE, 1, 4],
    [:ANTIDOTE, 5], :PARALYZEHEAL, :AWAKENING, :BURNHEAL, :ICEHEAL,
    :FULLHEAL,
    :REPEL, :SUPERREPEL, :MAXREPEL,
    :ESCAPEROPE
  ], "ProSeller", true, 26)
end

def pbAliceStore
  pbPokemonMart([
    :BUNNYSUIT,:MAIDCOSTUME,:SWEATER,
	:CAMOUFLAGE,:BLAZER,:MISTRESS,
	:NINJA,:NURSE,:SWIMSUIT,
    :STEWARDESS,:THICKFUR,:KIMONO,
	:WITCH,:GOTHIC,:BRIDALGOWN,
	:PRIESTESS,:CHINADRESS,
    :HEMATITEHAIRPIN,:QUARTZHAIRPIN,
	:ONYXHAIRPIN,:MALACHITEHAIRPIN,
	:GOLDHAIRPIN,:OBSIDIANHAIRPIN,
	:JADEHAIRPIN,:AMETHYSTHAIRPIN,
	:AQUAMARINEHAIRPIN,:DIAMONDHAIRPIN,
	:LAPISHAIRPIN,:SUGILITEHAIRPIN,
	:OPALHAIRPIN,:GARNETHAIRPIN,
    :MORGANITEHAIRPIN,:TOPAZHAIRPIN,
	:MOONSTONEHAIRPIN
  ], "AliceShop", true)
end

def pbKirisameStore
  pbPokemonMart([
    :SC01,:SC02,:SC03,:SC04,:SC05,:SC06,:SC07,:SC08,:SC09,:SC10,
    :SC11,:SC12,:SC13,:SC14,:SC15,:SC16,:SC17,:SC18,:SC19,:SC20,
    :SC21,:SC22,:SC23,:SC24,:SC25,:SC26,:SC27,:SC28,:SC29,:SC30,
    :SC31,:SC32,:SC33,:SC34,:SC35,:SC36,:SC37,:SC38,:SC39,:SC40,
    :SC41,:SC42,:SC43,:SC44,:SC45,:SC46,:SC47,:SC48,:SC49,:SC50,
	:ANTIMETAL,:ANTIEARTH,:ANTIBEAST,:ANTINATURE,
	:ANTIHEART,:ANTIUMBRAL,:ANTIWIND,:ANTIMIASMA,
    :ANTIHYDRO,:ANTIAERO,:ANTICRYO,:ANTINETHER,
	:ANTIREASON,:ANTIPYRO,:ANTIILLUSION,:ANTIFAITH,
    :ANTIDREAM
  ], "KirisameShop", true)
end

def pbTavernShop
    if pbGet(121) < 20
	  pbPokemonMart([
      :BEER,
	  :SAKE,
	  :ONIKILLERSAKE
    ], "TavernShop", true)
	elsif pbGet(121) >= 20
	  pbPokemonMart([
      :BEER,
	  :SAKE,
	  :ONIKILLERSAKE,
	  :GOLDENRICESAKE
    ], "TavernShop", true)
	else $game_switches[107]
	  pbPokemonMart([
      :BEER,
	  :SAKE,
	  :ONIKILLERSAKE,
	  :GOLDENRICESAKE#,
	  #:GOLDPEACHSAKE
    ], "TavernShop", true)
	end
end

def pbRestStop
    if !$game_switches[99]
	  pbPokemonMart([
      :PUPPETORB,:GREATORB,:ULTRAORB,
      :POTION,:SUPERPOTION,:HYPERPOTION,
      :REVIVE,:FULLHEAL,
      :REPEL,:SUPERREPEL,
      :POWERSHARD,:DEFENSESHARD,:TECHSHARD,
      :SWIFTSHARD,:SUPPORTSHARD,:SOLARSHARD,
      :CHROMESHARD
    ], true)
	else
	  pbPokemonMart([
      :PUPPETORB,:GREATORB,:ULTRAORB,
      :POTION,:SUPERPOTION,:HYPERPOTION,
      :REVIVE,:MAXREVIVE,
      :FULLHEAL,:FULLRESTORE,
      :ETHER,:MAXETHER,:ELIXIR,:MAXELIXIR,
      :REPEL,:SUPERREPEL,:MAXREPEL,
      :PPUP,:RARECANDY,
      :POWERSHARD,:DEFENSESHARD,:TECHSHARD,
      :SWIFTSHARD,:SUPPORTSHARD,:SOLARSHARD,
      :CHROMESHARD
    ], true)
	end
end

def pbMusharnaShop
	  pbPokemonMart([
      :PUPPETORB,:GREATORB,:ULTRAORB,:MOONBALL,
      :POTION,:SUPERPOTION,:HYPERPOTION,
      :REVIVE,:MAXREVIVE,
      :FULLHEAL,:FULLRESTORE,
      :ETHER,:MAXETHER,:ELIXIR,:MAXELIXIR,
      :REPEL,:SUPERREPEL,:MAXREPEL,
      :PPUP,:RARECANDY,
      :POWERSHARD,:DEFENSESHARD,:TECHSHARD,
      :SWIFTSHARD,:SUPPORTSHARD,:SOLARSHARD,
      :CHROMESHARD
    ], "Musharna", true)
end