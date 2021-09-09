#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Adds a sound effect for when a berry is picked
#==============================================================================#
def pbBerryPlant
  interp=pbMapInterpreter
  thisEvent=interp.get_character(0)
  berryData=interp.getVariable
  if !berryData
    if Settings::NEW_BERRY_PLANTS
      berryData=[0,nil,0,0,0,0,0,0]
    else
      berryData=[0,nil,false,0,0,0]
    end
  end
  # Stop the event turning towards the player
  case berryData[0]
  when 1 then thisEvent.turn_down  # X planted
  when 2 then thisEvent.turn_down  # X sprouted
  when 3 then thisEvent.turn_left  # X taller
  when 4 then thisEvent.turn_right  # X flowering
  when 5 then thisEvent.turn_up  # X berries
  end
  watering = [:SPRAYDUCK, :SQUIRTBOTTLE, :WAILMERPAIL, :SPRINKLOTAD]
  berry=berryData[1]
  case berryData[0]
  when 0  # empty
    if Settings::NEW_BERRY_PLANTS
      # Gen 4 planting mechanics
      if !berryData[7] || berryData[7]==0 # No mulch used yet
        cmd=pbMessage(_INTL("It's soft, earthy soil."),[
                            _INTL("Fertilize"),
                            _INTL("Plant Berry"),
                            _INTL("Exit")],-1)
        if cmd==0 # Fertilize
          ret=0
          pbFadeOutIn {
            scene = PokemonBag_Scene.new
            screen = PokemonBagScreen.new(scene,$PokemonBag)
            ret = screen.pbChooseItemScreen(Proc.new { |item| GameData::Item.get(item).is_mulch? })
          }
          if ret
            if GameData::Item.get(ret).is_mulch?
              berryData[7]=ret
              pbMessage(_INTL("The {1} was scattered on the soil.\1",GameData::Item.get(ret).name))
              if pbConfirmMessage(_INTL("Want to plant a Berry?"))
                pbFadeOutIn {
                  scene = PokemonBag_Scene.new
                  screen = PokemonBagScreen.new(scene,$PokemonBag)
                  berry = screen.pbChooseItemScreen(Proc.new { |item| GameData::Item.get(item).is_berry? })
                }
                if berry
                  timenow=pbGetTimeNow
                  berryData[0]=1             # growth stage (1-5)
                  berryData[1]=berry         # item ID of planted berry
                  berryData[2]=0             # seconds alive
                  berryData[3]=timenow.to_i  # time of last checkup (now)
                  berryData[4]=100           # dampness value
                  berryData[5]=0             # number of replants
                  berryData[6]=0             # yield penalty
                  $PokemonBag.pbDeleteItem(berry,1)
                  pbMessage(_INTL("The {1} was planted in the soft, earthy soil.",
                     GameData::Item.get(berry).name))
                end
              end
              interp.setVariable(berryData)
            else
              pbMessage(_INTL("That won't fertilize the soil!"))
            end
            return
          end
        elsif cmd==1 # Plant Berry
          pbFadeOutIn {
            scene = PokemonBag_Scene.new
            screen = PokemonBagScreen.new(scene,$PokemonBag)
            berry = screen.pbChooseItemScreen(Proc.new { |item|  GameData::Item.get(item).is_berry? })
          }
          if berry
            timenow=pbGetTimeNow
            berryData[0]=1             # growth stage (1-5)
            berryData[1]=berry         # item ID of planted berry
            berryData[2]=0             # seconds alive
            berryData[3]=timenow.to_i  # time of last checkup (now)
            berryData[4]=100           # dampness value
            berryData[5]=0             # number of replants
            berryData[6]=0             # yield penalty
            $PokemonBag.pbDeleteItem(berry,1)
            pbMessage(_INTL("The {1} was planted in the soft, earthy soil.",
               GameData::Item.get(berry).name))
            interp.setVariable(berryData)
          end
          return
        end
      else
        pbMessage(_INTL("{1} has been laid down.\1",GameData::Item.get(berryData[7]).name))
        if pbConfirmMessage(_INTL("Want to plant a Berry?"))
          pbFadeOutIn {
            scene = PokemonBag_Scene.new
            screen = PokemonBagScreen.new(scene,$PokemonBag)
            berry = screen.pbChooseItemScreen(Proc.new { |item|  GameData::Item.get(item).is_berry? })
          }
          if berry
            timenow=pbGetTimeNow
            berryData[0]=1             # growth stage (1-5)
            berryData[1]=berry         # item ID of planted berry
            berryData[2]=0             # seconds alive
            berryData[3]=timenow.to_i  # time of last checkup (now)
            berryData[4]=100           # dampness value
            berryData[5]=0             # number of replants
            berryData[6]=0             # yield penalty
            $PokemonBag.pbDeleteItem(berry,1)
            pbMessage(_INTL("The {1} was planted in the soft, earthy soil.",
               GameData::Item.get(berry).name))
            interp.setVariable(berryData)
          end
          return
        end
      end
    else
      # Gen 3 planting mechanics
      if pbConfirmMessage(_INTL("It's soft, loamy soil.\nPlant a berry?"))
        pbFadeOutIn {
          scene = PokemonBag_Scene.new
          screen = PokemonBagScreen.new(scene,$PokemonBag)
          berry = screen.pbChooseItemScreen(Proc.new { |item| GameData::Item.get(item).is_berry? })
        }
        if berry
          timenow=pbGetTimeNow
          berryData[0]=1             # growth stage (1-5)
          berryData[1]=berry         # item ID of planted berry
          berryData[2]=false         # watered in this stage?
          berryData[3]=timenow.to_i  # time planted
          berryData[4]=0             # total waterings
          berryData[5]=0             # number of replants
          berryData[6]=nil; berryData[7]=nil; berryData.compact! # for compatibility
          $PokemonBag.pbDeleteItem(berry,1)
          pbMessage(_INTL("{1} planted a {2} in the soft loamy soil.",
             $Trainer.name,GameData::Item.get(berry).name))
          interp.setVariable(berryData)
        end
        return
      end
    end
  when 1 # X planted
    pbMessage(_INTL("A {1} was planted here.",GameData::Item.get(berry).name))
  when 2  # X sprouted
    pbMessage(_INTL("The {1} has sprouted.",GameData::Item.get(berry).name))
  when 3  # X taller
    pbMessage(_INTL("The {1} plant is growing bigger.",GameData::Item.get(berry).name))
  when 4  # X flowering
    if Settings::NEW_BERRY_PLANTS
      pbMessage(_INTL("This {1} plant is in bloom!",GameData::Item.get(berry).name))
    else
      case berryData[4]
      when 4
        pbMessage(_INTL("This {1} plant is in fabulous bloom!",GameData::Item.get(berry).name))
      when 3
        pbMessage(_INTL("This {1} plant is blooming very beautifully!",GameData::Item.get(berry).name))
      when 2
        pbMessage(_INTL("This {1} plant is blooming prettily!",GameData::Item.get(berry).name))
      when 1
        pbMessage(_INTL("This {1} plant is blooming cutely!",GameData::Item.get(berry).name))
      else
        pbMessage(_INTL("This {1} plant is in bloom!",GameData::Item.get(berry).name))
      end
    end
  when 5  # X berries
    berryvalues = GameData::BerryPlant.get(berryData[1])
    # Get berry yield (berrycount)
    berrycount=1
    if berryData.length > 6
      # Gen 4 berry yield calculation
      berrycount = [berryvalues.maximum_yield - berryData[6], berryvalues.minimum_yield].max
    else
      # Gen 3 berry yield calculation
      if berryData[4] > 0
        berrycount = (berryvalues.maximum_yield - berryvalues.minimum_yield) * (berryData[4] - 1)
        berrycount += rand(1 + berryvalues.maximum_yield - berryvalues.minimum_yield)
        berrycount = (berrycount / 4) + berryvalues.minimum_yield
      else
        berrycount = berryvalues.minimum_yield
      end
    end
    item = GameData::Item.get(berry)
    itemname = (berrycount>1) ? item.name_plural : item.name
    pocket = item.pocket
    if berrycount>1
      message=_INTL("There are {1} \\c[1]{2}\\c[0]!\nWant to pick them?",berrycount,itemname)
    else
      message=_INTL("There is 1 \\c[1]{1}\\c[0]!\nWant to pick it?",itemname)
    end
    if pbConfirmMessage(message)
      if !$PokemonBag.pbCanStore?(berry,berrycount)
        pbMessage(_INTL("Too bad...\nThe Bag is full..."))
        return
      end
      $PokemonBag.pbStoreItem(berry,berrycount)
      if berrycount>1
        pbSEPlay("Berry Pluck")
		pbMessage(_INTL("You picked the {1} \\c[1]{2}\\c[0].\\wtnp[30]",berrycount,itemname))
      else
        pbSEPlay("Berry Pluck")
		pbMessage(_INTL("You picked the \\c[1]{1}\\c[0].\\wtnp[30]",itemname))
      end
      pbMessage(_INTL("{1} put the \\c[1]{2}\\c[0] in the <icon=bagPocket{3}>\\c[1]{4}\\c[0] Pocket.\1",
         $Trainer.name,itemname,pocket,PokemonBag.pocketNames()[pocket]))
      if Settings::NEW_BERRY_PLANTS
        pbMessage(_INTL("The soil returned to its soft and earthy state."))
        berryData=[0,nil,0,0,0,0,0,0]
      else
        pbMessage(_INTL("The soil returned to its soft and loamy state."))
        berryData=[0,nil,false,0,0,0]
      end
      interp.setVariable(berryData)
    end
  end
  case berryData[0]
  when 1, 2, 3, 4
    for i in watering
      next if !GameData::Item.exists?(i) || !$PokemonBag.pbHasItem?(i)
      if pbConfirmMessage(_INTL("Want to sprinkle some water with the {1}?",GameData::Item.get(i).name))
        if berryData.length>6
          # Gen 4 berry watering mechanics
          berryData[4]=100
        else
          # Gen 3 berry watering mechanics
          if berryData[2]==false
            berryData[4]+=1
            berryData[2]=true
          end
        end
        interp.setVariable(berryData)
        pbMessage(_INTL("{1} watered the plant.\\wtnp[40]",$Trainer.name))
        if Settings::NEW_BERRY_PLANTS
          pbMessage(_INTL("There! All happy!"))
        else
          pbMessage(_INTL("The plant seemed to be delighted."))
        end
      end
      break
    end
  end
end

def pbPickBerry(berry, qty = 1)
  interp=pbMapInterpreter
  thisEvent=interp.get_character(0)
  berryData=interp.getVariable
  berry=GameData::Item.get(berry)
  itemname=(qty>1) ? berry.name_plural : berry.name
  if qty>1
    message=_INTL("There are {1} \\c[1]{2}\\c[0]!\nWant to pick them?",qty,itemname)
  else
    message=_INTL("There is 1 \\c[1]{1}\\c[0]!\nWant to pick it?",itemname)
  end
  if pbConfirmMessage(message)
    if !$PokemonBag.pbCanStore?(berry,qty)
      pbMessage(_INTL("Too bad...\nThe Bag is full..."))
      return
    end
    $PokemonBag.pbStoreItem(berry,qty)
    if qty>1
      pbSEPlay("Berry Pluck")
	  pbMessage(_INTL("You picked the {1} \\c[1]{2}\\c[0].\\wtnp[30]",qty,itemname))
    else
      pbSEPlay("Berry Pluck")
	  pbMessage(_INTL("You picked the \\c[1]{1}\\c[0].\\wtnp[30]",itemname))
    end
    pocket = berry.pocket
    pbMessage(_INTL("{1} put the \\c[1]{2}\\c[0] in the <icon=bagPocket{3}>\\c[1]{4}\\c[0] Pocket.\1",
       $Trainer.name,itemname,pocket,PokemonBag.pocketNames()[pocket]))
    if Settings::NEW_BERRY_PLANTS
      pbMessage(_INTL("The soil returned to its soft and earthy state."))
      berryData=[0,nil,0,0,0,0,0,0]
    else
      pbMessage(_INTL("The soil returned to its soft and loamy state."))
      berryData=[0,nil,false,0,0,0]
    end
    interp.setVariable(berryData)
    pbSetSelfSwitch(thisEvent.id,"A",true)
  end
end