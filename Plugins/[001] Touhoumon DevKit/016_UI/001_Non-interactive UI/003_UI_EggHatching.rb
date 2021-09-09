#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Added Fire Veil to the abilities that influence egg hatching
#==============================================================================#
Events.onStepTaken += proc { |_sender,_e|
  for egg in $Trainer.party
    next if egg.steps_to_hatch <= 0
    egg.steps_to_hatch -= 1
    for i in $Trainer.pokemon_party
      next if !i.hasAbility?(:FLAMEBODY) && !i.hasAbility?(:MAGMAARMOR) && !i.hasAbility?(:FIREVEIL) 
      egg.steps_to_hatch -= 1
      break
    end
    if egg.steps_to_hatch <= 0
      egg.steps_to_hatch = 0
      pbHatch(egg)
    end
  end
}