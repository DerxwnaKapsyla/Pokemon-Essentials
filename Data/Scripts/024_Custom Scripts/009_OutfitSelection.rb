def outfitChoices
  # these will appear no matter what
  choices = ['Casual Wear 1', 'Casual Wear 2', 'Winter Wear 1', 'Winter Wear 2']
  
  # because it uses an array, 
  # you can add more choices if a certain condition is true
  
  if $game_switches[113] # The Classics Outfit Set
    choices.push('Red\'s outfit')
    choices.push('Blue\'s outfit')
  end
  
  if $game_switches[111] # Sealing Club Heroines Outfit Set
    choices.push('Renko Usami\'s outfit')
    choices.push('Maribel Hearn\'s outfit')
  end
  
  if $game_switches[112] # Hellcat Collector  
    choices.push('Rin Kaenbyou\'s outfit')
  end
  
  # then we need to convert this to something we can output
  # into a message.
  
  "Which outfit would you like to change into?\\ch[1,0,#{choices.join(',')}]"
end
