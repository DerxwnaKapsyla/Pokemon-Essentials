#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Addition of the Focus Ribbon, which works like the Focus Sash
#==============================================================================#
class PokeBattle_Move
  def pbReduceDamage(user,target)
    damage = target.damageState.calcDamage
    # Substitute takes the damage
    if target.damageState.substitute
      damage = target.effects[PBEffects::Substitute] if damage>target.effects[PBEffects::Substitute]
      target.damageState.hpLost       = damage
      target.damageState.totalHPLost += damage
      return
    end
    # Disguise takes the damage
    return if target.damageState.disguise
    # Target takes the damage
    if damage>=target.hp
      damage = target.hp
      # Survive a lethal hit with 1 HP effects
      if nonLethal?(user,target)
        damage -= 1
      elsif target.effects[PBEffects::Endure]
        target.damageState.endured = true
        damage -= 1
      elsif damage==target.totalhp
        if target.hasActiveAbility?(:STURDY) && !@battle.moldBreaker
          target.damageState.sturdy = true
          damage -= 1
        elsif target.hasActiveItem?(:FOCUSSASH) && target.hp==target.totalhp
          target.damageState.focusSash = true
          damage -= 1
        elsif target.hasActiveItem?(:FOCUSBAND) && @battle.pbRandom(100)<10
          target.damageState.focusBand = true
          damage -= 1
        elsif target.hasActiveItem?(:FOCUSRIBBON) && @battle.pbRandom(100)<10
          target.damageState.focusBand = true
          damage -= 1
        end
      end
    end
    damage = 0 if damage<0
    target.damageState.hpLost       = damage
    target.damageState.totalHPLost += damage
  end
end