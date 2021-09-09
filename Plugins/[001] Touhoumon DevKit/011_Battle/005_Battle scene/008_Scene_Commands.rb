#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Removed explicit references to Pokemon
#==============================================================================#
class PokeBattle_Scene
  def pbCommandMenu(idxBattler,firstAction)
    shadowTrainer = (GameData::Type.exists?(:SHADOW) && @battle.trainerBattle?)
    cmds = [
       _INTL("What will\n{1} do?",@battle.battlers[idxBattler].name),
       _INTL("Fight"),
       _INTL("Bag"),
       _INTL("Party"),
       (shadowTrainer) ? _INTL("Call") : (firstAction) ? _INTL("Run") : _INTL("Cancel")
    ]
    ret = pbCommandMenuEx(idxBattler,cmds,(shadowTrainer) ? 2 : (firstAction) ? 0 : 1)
    ret = 4 if ret==3 && shadowTrainer   # Convert "Run" to "Call"
    ret = -1 if ret==3 && !firstAction   # Convert "Run" to "Cancel"
    return ret
  end
  
  def pbPartyScreen(idxBattler,canCancel=false)
    # Fade out and hide all sprites
    visibleSprites = pbFadeOutAndHide(@sprites)
    # Get player's party
    partyPos = @battle.pbPartyOrder(idxBattler)
    partyStart, _partyEnd = @battle.pbTeamIndexRangeFromBattlerIndex(idxBattler)
    modParty = @battle.pbPlayerDisplayParty(idxBattler)
    # Start party screen
    scene = PokemonParty_Scene.new
    switchScreen = PokemonPartyScreen.new(scene,modParty)
    switchScreen.pbStartScene(_INTL("Choose a party member."),@battle.pbNumPositions(0,0))
    # Loop while in party screen
    loop do
      # Select a Pokémon
      scene.pbSetHelpText(_INTL("Choose a party member."))
      idxParty = switchScreen.pbChoosePokemon
      if idxParty<0
        next if !canCancel
        break
      end
      # Choose a command for the selected Pokémon
      cmdSwitch  = -1
      cmdSummary = -1
      commands = []
      commands[cmdSwitch  = commands.length] = _INTL("Switch In") if modParty[idxParty].able?
      commands[cmdSummary = commands.length] = _INTL("Summary")
      commands[commands.length]              = _INTL("Cancel")
      command = scene.pbShowCommands(_INTL("Do what with {1}?",modParty[idxParty].name),commands)
      if cmdSwitch>=0 && command==cmdSwitch        # Switch In
        idxPartyRet = -1
        partyPos.each_with_index do |pos,i|
          next if pos!=idxParty+partyStart
          idxPartyRet = i
          break
        end
        break if yield idxPartyRet, switchScreen
      elsif cmdSummary>=0 && command==cmdSummary   # Summary
        scene.pbSummary(idxParty,true)
      end
    end
    # Close party screen
    switchScreen.pbEndScene
    # Fade back into battle screen
    pbFadeInAndShow(@sprites,visibleSprites)
  end
  
  def pbItemMenu(idxBattler,_firstAction)
    # Fade out and hide all sprites
    visibleSprites = pbFadeOutAndHide(@sprites)
    # Set Bag starting positions
    oldLastPocket = $PokemonBag.lastpocket
    oldChoices    = $PokemonBag.getAllChoices
    $PokemonBag.lastpocket = @bagLastPocket if @bagLastPocket!=nil
    $PokemonBag.setAllChoices(@bagChoices) if @bagChoices!=nil
    # Start Bag screen
    itemScene = PokemonBag_Scene.new
    itemScene.pbStartScene($PokemonBag,true,Proc.new { |item|
      useType = GameData::Item.get(item).battle_use
      next useType && useType>0
      },false)
    # Loop while in Bag screen
    wasTargeting = false
    loop do
      # Select an item
      item = itemScene.pbChooseItem
      break if !item
      # Choose a command for the selected item
      item = GameData::Item.get(item)
      itemName = item.name
      useType = item.battle_use
      cmdUse = -1
      commands = []
      commands[cmdUse = commands.length] = _INTL("Use") if useType && useType!=0
      commands[commands.length]          = _INTL("Cancel")
      command = itemScene.pbShowCommands(_INTL("{1} is selected.",itemName),commands)
      next unless cmdUse>=0 && command==cmdUse   # Use
      # Use types:
      # 0 = not usable in battle
      # 1 = use on Pokémon (lots of items), consumed
      # 2 = use on Pokémon's move (Ethers), consumed
      # 3 = use on battler (X items, Persim Berry), consumed
      # 4 = use on opposing battler (Poké Balls), consumed
      # 5 = use no target (Poké Doll, Guard Spec., Launcher items), consumed
      # 6 = use on Pokémon (Blue Flute), not consumed
      # 7 = use on Pokémon's move, not consumed
      # 8 = use on battler (Red/Yellow Flutes), not consumed
      # 9 = use on opposing battler, not consumed
      # 10 = use no target (Poké Flute), not consumed
      case useType
      when 1, 2, 3, 6, 7, 8   # Use on Pokémon/Pokémon's move/battler
        # Auto-choose the Pokémon/battler whose action is being decided if they
        # are the only available Pokémon/battler to use the item on
        case useType
        when 1, 6   # Use on Pokémon
          if @battle.pbTeamLengthFromBattlerIndex(idxBattler)==1
            break if yield item.id, useType, @battle.battlers[idxBattler].pokemonIndex, -1, itemScene
          end
        when 3, 8   # Use on battler
          if @battle.pbPlayerBattlerCount==1
            break if yield item.id, useType, @battle.battlers[idxBattler].pokemonIndex, -1, itemScene
          end
        end
        # Fade out and hide Bag screen
        itemScene.pbFadeOutScene
        # Get player's party
        party    = @battle.pbParty(idxBattler)
        partyPos = @battle.pbPartyOrder(idxBattler)
        partyStart, _partyEnd = @battle.pbTeamIndexRangeFromBattlerIndex(idxBattler)
        modParty = @battle.pbPlayerDisplayParty(idxBattler)
        # Start party screen
        pkmnScene = PokemonParty_Scene.new
        pkmnScreen = PokemonPartyScreen.new(pkmnScene,modParty)
        pkmnScreen.pbStartScene(_INTL("Use on which party member?"),@battle.pbNumPositions(0,0))
        idxParty = -1
        # Loop while in party screen
        loop do
          # Select a Pokémon
          pkmnScene.pbSetHelpText(_INTL("Use on which party member?"))
          idxParty = pkmnScreen.pbChoosePokemon
          break if idxParty<0
          idxPartyRet = -1
          partyPos.each_with_index do |pos,i|
            next if pos!=idxParty+partyStart
            idxPartyRet = i
            break
          end
          next if idxPartyRet<0
          pkmn = party[idxPartyRet]
          next if !pkmn || pkmn.egg?
          idxMove = -1
          if useType==2 || useType==7   # Use on Pokémon's move
            idxMove = pkmnScreen.pbChooseMove(pkmn,_INTL("Restore which move?"))
            next if idxMove<0
          end
          break if yield item.id, useType, idxPartyRet, idxMove, pkmnScene
        end
        pkmnScene.pbEndScene
        break if idxParty>=0
        # Cancelled choosing a Pokémon; show the Bag screen again
        itemScene.pbFadeInScene
      when 4, 9   # Use on opposing battler (Poké Balls)
        idxTarget = -1
        if @battle.pbOpposingBattlerCount(idxBattler)==1
          @battle.eachOtherSideBattler(idxBattler) { |b| idxTarget = b.index }
          break if yield item.id, useType, idxTarget, -1, itemScene
        else
          wasTargeting = true
          # Fade out and hide Bag screen
          itemScene.pbFadeOutScene
          # Fade in and show the battle screen, choosing a target
          tempVisibleSprites = visibleSprites.clone
          tempVisibleSprites["commandWindow"] = false
          tempVisibleSprites["targetWindow"]  = true
          idxTarget = pbChooseTarget(idxBattler,GameData::Target.get(:Foe),tempVisibleSprites)
          if idxTarget>=0
            break if yield item.id, useType, idxTarget, -1, self
          end
          # Target invalid/cancelled choosing a target; show the Bag screen again
          wasTargeting = false
          pbFadeOutAndHide(@sprites)
          itemScene.pbFadeInScene
        end
      when 5, 10   # Use with no target
        break if yield item.id, useType, idxBattler, -1, itemScene
      end
    end
    @bagLastPocket = $PokemonBag.lastpocket
    @bagChoices    = $PokemonBag.getAllChoices
    $PokemonBag.lastpocket = oldLastPocket
    $PokemonBag.setAllChoices(oldChoices)
    # Close Bag screen
    itemScene.pbEndScene
    # Fade back into battle screen (if not already showing it)
    pbFadeInAndShow(@sprites,visibleSprites) if !wasTargeting
  end
end