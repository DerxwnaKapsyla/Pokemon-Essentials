EventHandlers.add(:on_trainer_load, :clone,
  proc { |trainer|
   if trainer   # An NPCTrainer object containing party/items/lose text, etc.  
     if trainer.trainer_type==:DOPPELDEVICE #the clone trainer type
       partytoload=$player.party
       for i in 0...6
         if i<$player.party_count && !partytoload[i].egg?
           trainer.party[i]=partytoload[i].clone
           trainer.party[i].heal     #remove this comment to make a perfectly healed
         else                            #copy of the party
           trainer.party.pop()
        end
		trainer.name = $player.name
		trainer.trainer_type = $player.trainer_type
		#trainer.items = $bag
		$PokemonGlobal.nextBattleBack = "Inverse"
       end
     end
   end
  }
)