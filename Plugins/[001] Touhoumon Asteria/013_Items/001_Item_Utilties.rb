#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Removed explicit references to Pokemon
#==============================================================================#
def pbUseItem(bag,item,bagscene=nil)
  itm = GameData::Item.get(item)
  useType = itm.field_use
  if itm.is_machine?    # TM or TR or HM
    if $Trainer.pokemon_count == 0
      pbMessage(_INTL("Your party is empty."))
      return 0
    end
    machine = itm.move
    return 0 if !machine
    movename = GameData::Move.get(machine).name
    pbMessage(_INTL("\\se[PC access]You booted up {1}.\1",itm.name))
    if !pbConfirmMessage(_INTL("Do you want to teach {1} to a party member?",movename))
      return 0
    elsif pbMoveTutorChoose(machine,nil,true,itm.is_TR?)
      bag.pbDeleteItem(item) if itm.is_TR?
      return 1
    end
    return 0
  elsif useType==1 || useType==5   # Item is usable on a Pokémon
    if $Trainer.pokemon_count == 0
      pbMessage(_INTL("Your party is empty."))
      return 0
    end
    ret = false
    annot = nil
    if itm.is_evolution_stone?
      annot = []
      for pkmn in $Trainer.party
        elig = pkmn.check_evolution_on_use_item(item)
        annot.push((elig) ? _INTL("ABLE") : _INTL("NOT ABLE"))
      end
    end
    pbFadeOutIn {
      scene = PokemonParty_Scene.new
      screen = PokemonPartyScreen.new(scene,$Trainer.party)
      screen.pbStartScene(_INTL("Use on which party member?"),false,annot)
      loop do
        scene.pbSetHelpText(_INTL("Use on which party member?"))
        chosen = screen.pbChoosePokemon
        if chosen<0
          ret = false
          break
        end
        pkmn = $Trainer.party[chosen]
        if pbCheckUseOnPokemon(item,pkmn,screen)
          ret = ItemHandlers.triggerUseOnPokemon(item,pkmn,screen)
          if ret && useType==1   # Usable on Pokémon, consumed
            bag.pbDeleteItem(item)
            if !bag.pbHasItem?(item)
              pbMessage(_INTL("You used your last {1}.",itm.name)) { screen.pbUpdate }
              break
            end
          end
        end
      end
      screen.pbEndScene
      bagscene.pbRefresh if bagscene
    }
    return (ret) ? 1 : 0
  elsif useType==2   # Item is usable from Bag
    intret = ItemHandlers.triggerUseFromBag(item)
    case intret
    when 0 then return 0
    when 1 then return 1   # Item used
    when 2 then return 2   # Item used, end screen
    when 3                 # Item used, consume item
      bag.pbDeleteItem(item)
      return 1
    when 4                 # Item used, end screen and consume item
      bag.pbDeleteItem(item)
      return 2
    end
    pbMessage(_INTL("Can't use that here."))
    return 0
  end
  pbMessage(_INTL("Can't use that here."))
  return 0
end

def pbGiveItemToPokemon(item,pkmn,scene,pkmnid=0)
  newitemname = GameData::Item.get(item).name
  if pkmn.egg?
    scene.pbDisplay(_INTL("Eggs can't hold items."))
    return false
  elsif pkmn.mail
    scene.pbDisplay(_INTL("{1}'s mail must be removed before giving it an item.",pkmn.name))
    return false if !pbTakeItemFromPokemon(pkmn,scene)
  end
  if pkmn.hasItem?
    olditemname = pkmn.item.name
    if pkmn.hasItem?(:LEFTOVERS)
      scene.pbDisplay(_INTL("{1} is already holding some {2}.\1",pkmn.name,olditemname))
    elsif newitemname.starts_with_vowel?
      scene.pbDisplay(_INTL("{1} is already holding an {2}.\1",pkmn.name,olditemname))
    else
      scene.pbDisplay(_INTL("{1} is already holding a {2}.\1",pkmn.name,olditemname))
    end
    if scene.pbConfirm(_INTL("Would you like to switch the two items?"))
      $PokemonBag.pbDeleteItem(item)
      if !$PokemonBag.pbStoreItem(pkmn.item)
        if !$PokemonBag.pbStoreItem(item)
          raise _INTL("Could't re-store deleted item in Bag somehow")
        end
        scene.pbDisplay(_INTL("The Bag is full. The item could not be removed."))
      else
        if GameData::Item.get(item).is_mail?
          if pbWriteMail(item,pkmn,pkmnid,scene)
            pkmn.item = item
            scene.pbDisplay(_INTL("Took the {1} from {2} and gave it the {3}.",olditemname,pkmn.name,newitemname))
            return true
          else
            if !$PokemonBag.pbStoreItem(item)
              raise _INTL("Couldn't re-store deleted item in Bag somehow")
            end
          end
        else
          pkmn.item = item
          scene.pbDisplay(_INTL("Took the {1} from {2} and gave it the {3}.",olditemname,pkmn.name,newitemname))
          return true
        end
      end
    end
  else
    if !GameData::Item.get(item).is_mail? || pbWriteMail(item,pkmn,pkmnid,scene)
      $PokemonBag.pbDeleteItem(item)
      pkmn.item = item
      scene.pbDisplay(_INTL("{1} is now holding the {2}.",pkmn.name,newitemname))
      return true
    end
  end
  return false
end

def pbTakeItemFromPokemon(pkmn,scene)
  ret = false
  if !pkmn.hasItem?
    scene.pbDisplay(_INTL("{1} isn't holding anything.",pkmn.name))
  elsif !$PokemonBag.pbCanStore?(pkmn.item)
    scene.pbDisplay(_INTL("The Bag is full. The item could not be removed."))
  elsif pkmn.mail
    if scene.pbConfirm(_INTL("Save the removed mail in your PC?"))
      if !pbMoveToMailbox(pkmn)
        scene.pbDisplay(_INTL("Your PC's Mailbox is full."))
      else
        scene.pbDisplay(_INTL("The mail was saved in your PC."))
        pkmn.item = nil
        ret = true
      end
    elsif scene.pbConfirm(_INTL("If the mail is removed, its message will be lost. OK?"))
      $PokemonBag.pbStoreItem(pkmn.item)
      scene.pbDisplay(_INTL("Received the {1} from {2}.",pkmn.item.name,pkmn.name))
      pkmn.item = nil
      pkmn.mail = nil
      ret = true
    end
  else
    $PokemonBag.pbStoreItem(pkmn.item)
    scene.pbDisplay(_INTL("Received the {1} from {2}.",pkmn.item.name,pkmn.name))
    pkmn.item = nil
    ret = true
  end
  return ret
end