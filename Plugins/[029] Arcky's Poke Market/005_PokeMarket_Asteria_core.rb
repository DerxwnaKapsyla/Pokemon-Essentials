module APMSettings

  BonusItems = {
    :POKEBALL => {
      :amount => 10,
      :item => {
	    :PREMIERBALL => {
		  :amount => 1
		},
		:CHERISHBALL => {
		  :chance => 5,
		  :amount => 1
		}
	  }
    },
    :GREATBALL => {
      :amount => 10,
      :item => {
	    :PREMIERBALL => {
		  :amount => 5
		},
		:CHERISHBALL => {
		  :chance => 5,
		  :amount => 5
		}
	  }
    },
    :ULTRABALL => {
      :amount => 10,
      :item => {
	    :PREMIERBALL => {
		  :amount => 10
		},
		:CHERISHBALL => {
		  :chance => 5,
		  :amount => 10
		},
		:GREATBALL => {
		  :chance => 80,
		  :amount => 5
		}
	  }
    }
  }
  
  # GameCorner ={
    # IntroText: ["Good Day, welcome how may I serve you?"],
    # MenuTextBuy: ["I want to buy!"],
    # MenuTextSell: ["Give me your money!"],
    # MenuTextBill: ["I'm paying my debt"],
    # MenuTextQuit: ["Bye bye!"],
    # CategoryText: [],
    # BuyItemAmount: ["So how many {1}?", "How many {1} would you like?"],
    # BuyItemAmountDiscount: ["There's a discount on {1}, they're {2} instead of {3}. How many would you like?"],
    # BuyItemAmountOvercharge: ["There's overcharge on {1}, you must pay {2} instead of {3}. So how many?"],
    # BuyItem: ["So you want {1} {2}?\nIt'll be {3}. All right?", "So you would like to buy {1} {2}?\nThat's going to cost you {3}!"],
    # BuyItemMult: ["So you want {1} {2}?\nThey'll be {3}. All right?"],
    # BuyItemImportant: ["So you want {1}?\nIt'll be {2} . All right?"],
    # BuyOutOfStock: ["We're really sorry, this item is currently out of stock. Come back {2}!", "We're sorry but we don't have any {1} left. Come back {2}!", "Come back {2} when we have more {1}."],
    # BuyThanks: ["Here you are! Thank you!"],
    # BuyBonusMult: ["And have {1} on the house!"],
    # NotEnoughMoney: ["You don't have enough money."],
    # NoRoomInBag: ["You have no room in your Bag."],
    # SellItemAmount: ["How many {1} would you like to sell?"],
    # SellItem: ["I can pay {1}.\nWould that be OK?"],
    # CantSellItem: ["Oh, no. I can't buy {1}."],
    # MenuReturnText: ["Is there anything else I can do for you?", "What else could I mean for you today?"],
    # BillCheckOut: ["Your basket contains {1} which comes to a total of {2}, please."],
    # PurchaseCount: ["Congratulations, you've earned 1 loyalty point!"],
    # PurchaseCountMult: ["Wow, amazing! You got {1} loyalty points!"],
    # EverythingOutOfStock: ["Well you bought everything I have in my stock. You can buy again {1}."],
    # OutroText: ["Do come again!", "Thank you, I hope to see you again.", "Thank you for your purchase, come again!"],
  # }
end

