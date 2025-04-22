#-------------------------------------------------------------------------------
# I want to keep all of Prismriver Manor's specific scripts in one file so it is
# easier to find them. A detailed list of effects will be provided below.
#-------------------------------------------------------------------------------
# In the Challenge Mode for Prismriver Manor, there will be several effects
# that can occur within the mansion on different floors. There will be two
# types of effects. 
#
# The first one is Floor Effects, which will occur for every battle on that 
# floor. Things like blidness (lowers accuracy in every battle by 1), Phantom
# Weather (Rain, Sun, Hail, Sand), stuff like that.
#
# The second type is Random Effects, which occur during battle, but are only
# relevant for that battle specifically (except for in the case of Status
# conditions). These can range from the adjustment of stats, completely
# changing the ability of a battler, the application of effects such as
# Ingrain and Aurora Veil, the aforementioned status conditions, and more.
#
# Every floor will determine its Floor Effect upon the first time visiting
# it, and it will always be different every run. 
#-------------------------------------------------------------------------------
# Per Floor Effects:
#-------------------------------------------------------------------------------
# Phantom Weather:
# * Will apply the effects of weather to all battles on that floor.
# * Weathers that can be applied: Rain. Sun. Sand. Hail.
#
# Blindness:
# * Makes it so all Puppets have -1 Accuracy.
#
# Phantom Terrain:
# * Will apply Field Effects to all battles on that floor.
# * Terrains and Fields that can be applied: Trick Room. Inverse Battle. Grassy Terrain. Electric Terrain.
#   Misty Terrain. Psychic Terrain. 
# 
# Phantom Lockdown:
# * Makes it so the Player's active battler cannot switch out or flee.
#-------------------------------------------------------------------------------
# Per Battle Effects:
#-------------------------------------------------------------------------------
# Spectral Status:
# * Will apply a random status condition to one or both sides.
# * Statuses that can be applied: Poison. Paralysis. Burn. Sleep. Freeze.
#
# Spectral Stats:
# * Will raise or lower a random stat to one or both sides.
# * Stats that can be adjusted: Attack. Defense. Speed. Special Attack. Special Defense. Accuracy.
# * Stats will be adjusted by the following values: +1. +2. -1. -2.
#
# Spectral Abilities:
# * Will "add" a second ability to one or both sides. (Might not be actual ability.)
# * Spectral Abilities will be based off of existing abilities but renamed from vanilla counterparts.
# * Abilitires that can be added: Spectre's Guard (Wonder Guard). Spectral Image (Sturdy). 
#   Spectral Touch (Rough Skin). Spectre's Strike (Parental Bond). Trickster Specter (Contrary). 
#   Spectre's Charm (Cute Charm).
#-------------------------------------------------------------------------------

#MidbattleHandlers.add(:midbattle_global, :battle_effects,
  # proc { |battle, idxBattler, idxTarget, trigger|
    # scene   = battle.scene
	# player  = battle.battlers[0]
	# foe     = battle.battlers[1]
    # case trigger
	# when "RoundStartCommand_1_foe"
	#-------------------------------------
	# Run a Random Number Generation here to determine effect.
	#-------------------------------------
	# battle.pbDisplayPaused(_INTL("The field has become haunted by spirits!"))
	# pbSet(1) = rand(3)
	#-------------------------------------
	# Battle Effect 1: Spectral Status
	#-------------------------------------

#)


#MidbattleHandlers.add(:midbattle_global, :floor1_effects,


#)