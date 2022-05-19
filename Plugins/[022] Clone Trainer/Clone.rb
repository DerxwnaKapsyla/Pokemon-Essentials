Events.onTrainerPartyLoad += proc { |_sender, trainer|
  if trainer   # An NPCTrainer object containing party/items/lose text, etc.
    #if $game_switches[63]
    if trainer[0].trainer_type==:SABRINA_Alt # The trainer class to use for the Doppelganger
      partytoload=$Trainer.party
      for i in 0...6
        if i<$Trainer.party_count && !partytoload[i].egg?
          trainer[0].party[i]=partytoload[i].clone
          trainer[0].party[i].heal     # comment this line to make an exact copy of your party
		  #you can customize the clone's party here.
        else                            
          trainer[0].party.pop()
        end
      end
    end
  end
}