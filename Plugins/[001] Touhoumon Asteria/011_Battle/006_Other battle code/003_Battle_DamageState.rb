#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Added the Sturdy Vine to the Damage State checks
#	* Added the Sturdy Vine to the Reset Per Hit checks
#==============================================================================#
class Battle::DamageState
  attr_accessor :sturdyVine       # Sturdy Vine used
  
  alias asteria_resetPerHit resetPerHit
  def resetPerHit
	asteria_resetPerHit
	@sturdyVine          = false
  end
end