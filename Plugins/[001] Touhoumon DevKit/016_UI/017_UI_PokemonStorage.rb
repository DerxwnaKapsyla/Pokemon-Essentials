#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Removed explicit references to Pokemon if possible, otherwise specified
#	  both Pokemon and Puppets.
#==============================================================================#
class PokemonStorageScene
  def pbMark(selected,heldpoke)
    @sprites["markingbg"].visible      = true
    @sprites["markingoverlay"].visible = true
    msg = _INTL("Mark your Pokémon and Puppets.")
    msgwindow = Window_UnformattedTextPokemon.newWithSize("",180,0,Graphics.width-180,32)
    msgwindow.viewport       = @viewport
    msgwindow.visible        = true
    msgwindow.letterbyletter = false
    msgwindow.text           = msg
    msgwindow.resizeHeightToFit(msg,Graphics.width-180)
    pbBottomRight(msgwindow)
    base   = Color.new(248,248,248)
    shadow = Color.new(80,80,80)
    pokemon = heldpoke
    if heldpoke
      pokemon = heldpoke
    elsif selected[0]==-1
      pokemon = @storage.party[selected[1]]
    else
      pokemon = @storage.boxes[selected[0]][selected[1]]
    end
    markings = pokemon.markings
    index = 0
    redraw = true
    markrect = Rect.new(0,0,16,16)
    loop do
      # Redraw the markings and text
      if redraw
        @sprites["markingoverlay"].bitmap.clear
        for i in 0...6
          markrect.x = i*16
          markrect.y = (markings&(1<<i)!=0) ? 16 : 0
          @sprites["markingoverlay"].bitmap.blt(336+58*(i%3),106+50*(i/3),@markingbitmap.bitmap,markrect)
        end
        textpos = [
           [_INTL("OK"),402,208,2,base,shadow,1],
           [_INTL("Cancel"),402,272,2,base,shadow,1]
        ]
        pbDrawTextPositions(@sprites["markingoverlay"].bitmap,textpos)
        pbMarkingSetArrow(@sprites["arrow"],index)
        redraw = false
      end
      Graphics.update
      Input.update
      key = -1
      key = Input::DOWN if Input.repeat?(Input::DOWN)
      key = Input::RIGHT if Input.repeat?(Input::RIGHT)
      key = Input::LEFT if Input.repeat?(Input::LEFT)
      key = Input::UP if Input.repeat?(Input::UP)
      if key>=0
        oldindex = index
        index = pbMarkingChangeSelection(key,index)
        pbPlayCursorSE if index!=oldindex
        pbMarkingSetArrow(@sprites["arrow"],index)
      end
      self.update
      if Input.trigger?(Input::BACK)
        pbPlayCancelSE
        break
      elsif Input.trigger?(Input::USE)
        pbPlayDecisionSE
        if index==6   # OK
          pokemon.markings = markings
          break
        elsif index==7   # Cancel
          break
        else
          mask = (1<<index)
          if (markings&mask)==0
            markings |= mask
          else
            markings &= ~mask
          end
          redraw = true
        end
      end
    end
    @sprites["markingbg"].visible      = false
    @sprites["markingoverlay"].visible = false
    msgwindow.dispose
  end
  
#==============================================================================#
# Changes in this section include the following:
#	* Added in the Yin/Yang icons to the Storage System display.
#==============================================================================#
  def pbUpdateOverlay(selection,party=nil)
    overlay = @sprites["overlay"].bitmap
    overlay.clear
    buttonbase = Color.new(248,248,248)
    buttonshadow = Color.new(80,80,80)
    pbDrawTextPositions(overlay,[
       [_INTL("Party: {1}",(@storage.party.length rescue 0)),270,326,2,buttonbase,buttonshadow,1],
       [_INTL("Exit"),446,326,2,buttonbase,buttonshadow,1],
    ])
    pokemon = nil
    if @screen.pbHeldPokemon
      pokemon = @screen.pbHeldPokemon
    elsif selection>=0
      pokemon = (party) ? party[selection] : @storage[@storage.currentBox,selection]
    end
    if !pokemon
      @sprites["pokemon"].visible = false
      return
    end
    @sprites["pokemon"].visible = true
    base   = Color.new(88,88,80)
    shadow = Color.new(168,184,184)
    nonbase   = Color.new(208,208,208)
    nonshadow = Color.new(224,224,224)
    pokename = pokemon.name
    textstrings = [
       [pokename,10,2,false,base,shadow]
    ]
    if !pokemon.egg?
      imagepos = []
      pkmn_data = GameData::Species.get_species_form(pokemon.species, pokemon.form)
	  if pkmn_data.generation <20
		if pokemon.male?
          textstrings.push([_INTL("♂"),148,2,false,Color.new(24,112,216),Color.new(136,168,208)])
		elsif pokemon.female?
          textstrings.push([_INTL("♀"),148,2,false,Color.new(248,56,32),Color.new(224,152,144)])
		end
	  else
		if pokemon.male?
		  imagepos.push(["Graphics/icons/yin",148,13,0,0,-1,-1])
		elsif pokemon.female?
		  imagepos.push(["Graphics/icons/yang",148,13,0,0,-1,-1])
		end	  
	  end
      imagepos.push(["Graphics/Pictures/Storage/overlay_lv",6,246])
      textstrings.push([pokemon.level.to_s,28,228,false,base,shadow])
      if pokemon.ability
        textstrings.push([pokemon.ability.name,86,300,2,base,shadow])
      else
        textstrings.push([_INTL("No ability"),86,300,2,nonbase,nonshadow])
      end
      if pokemon.item
        textstrings.push([pokemon.item.name,86,336,2,base,shadow])
      else
        textstrings.push([_INTL("No item"),86,336,2,nonbase,nonshadow])
      end
      if pokemon.shiny?
        imagepos.push(["Graphics/Pictures/shiny",156,198])
      end
      typebitmap = AnimatedBitmap.new(_INTL("Graphics/Pictures/types"))
      type1_number = GameData::Type.get(pokemon.type1).id_number
      type2_number = GameData::Type.get(pokemon.type2).id_number
      type1rect = Rect.new(0, type1_number * 28, 64, 28)
      type2rect = Rect.new(0, type2_number * 28, 64, 28)
      if pokemon.type1==pokemon.type2
        overlay.blt(52,272,typebitmap.bitmap,type1rect)
      else
        overlay.blt(18,272,typebitmap.bitmap,type1rect)
        overlay.blt(88,272,typebitmap.bitmap,type2rect)
      end
      drawMarkings(overlay,70,240,128,20,pokemon.markings)
      pbDrawImagePositions(overlay,imagepos)
    end
    pbDrawTextPositions(overlay,textstrings)
    @sprites["pokemon"].setPokemonBitmap(pokemon)
  end
end

#==============================================================================#
# Changes in this section include the following:
#	* Removed explicit references to Pokemon
#==============================================================================#
class PokemonStorageScreen
  def pbStartScreen(command)
    @heldpkmn = nil
    if command==0   # Organise
      @scene.pbStartBox(self,command)
      loop do
        selected = @scene.pbSelectBox(@storage.party)
        if selected==nil
          if pbHeldPokemon
            pbDisplay(_INTL("You're holding something!"))
            next
          end
          next if pbConfirm(_INTL("Continue Box operations?"))
          break
        elsif selected[0]==-3   # Close box
          if pbHeldPokemon
            pbDisplay(_INTL("You're holding something!"))
            next
          end
          if pbConfirm(_INTL("Exit from the Box?"))
            pbSEPlay("PC close")
            break
          end
          next
        elsif selected[0]==-4   # Box name
          pbBoxCommands
        else
          pokemon = @storage[selected[0],selected[1]]
          heldpoke = pbHeldPokemon
          next if !pokemon && !heldpoke
          if @scene.quickswap
            if @heldpkmn
              (pokemon) ? pbSwap(selected) : pbPlace(selected)
            else
              pbHold(selected)
            end
          else
            commands = []
            cmdMove     = -1
            cmdSummary  = -1
            cmdWithdraw = -1
            cmdItem     = -1
            cmdMark     = -1
            cmdRelease  = -1
            cmdDebug    = -1
            cmdCancel   = -1
            if heldpoke
              helptext = _INTL("{1} is selected.",heldpoke.name)
              commands[cmdMove=commands.length]   = (pokemon) ? _INTL("Shift") : _INTL("Place")
            elsif pokemon
              helptext = _INTL("{1} is selected.",pokemon.name)
              commands[cmdMove=commands.length]   = _INTL("Move")
            end
            commands[cmdSummary=commands.length]  = _INTL("Summary")
            commands[cmdWithdraw=commands.length] = (selected[0]==-1) ? _INTL("Store") : _INTL("Withdraw")
            commands[cmdItem=commands.length]     = _INTL("Item")
            commands[cmdMark=commands.length]     = _INTL("Mark")
            commands[cmdRelease=commands.length]  = _INTL("Release")
            commands[cmdDebug=commands.length]    = _INTL("Debug") if $DEBUG
            commands[cmdCancel=commands.length]   = _INTL("Cancel")
            command=pbShowCommands(helptext,commands)
            if cmdMove>=0 && command==cmdMove   # Move/Shift/Place
              if @heldpkmn
                (pokemon) ? pbSwap(selected) : pbPlace(selected)
              else
                pbHold(selected)
              end
            elsif cmdSummary>=0 && command==cmdSummary   # Summary
              pbSummary(selected,@heldpkmn)
            elsif cmdWithdraw>=0 && command==cmdWithdraw   # Store/Withdraw
              (selected[0]==-1) ? pbStore(selected,@heldpkmn) : pbWithdraw(selected,@heldpkmn)
            elsif cmdItem>=0 && command==cmdItem   # Item
              pbItem(selected,@heldpkmn)
            elsif cmdMark>=0 && command==cmdMark   # Mark
              pbMark(selected,@heldpkmn)
            elsif cmdRelease>=0 && command==cmdRelease   # Release
              pbRelease(selected,@heldpkmn)
            elsif cmdDebug>=0 && command==cmdDebug   # Debug
              pbPokemonDebug((@heldpkmn) ? @heldpkmn : pokemon,selected,heldpoke)
            end
          end
        end
      end
      @scene.pbCloseBox
    elsif command==1   # Withdraw
      @scene.pbStartBox(self,command)
      loop do
        selected = @scene.pbSelectBox(@storage.party)
        if selected==nil
          next if pbConfirm(_INTL("Continue Box operations?"))
          break
        else
          case selected[0]
          when -2   # Party Pokémon
            pbDisplay(_INTL("Which one will you take?"))
            next
          when -3   # Close box
            if pbConfirm(_INTL("Exit from the Box?"))
              pbSEPlay("PC close")
              break
            end
            next
          when -4   # Box name
            pbBoxCommands
            next
          end
          pokemon = @storage[selected[0],selected[1]]
          next if !pokemon
          command = pbShowCommands(_INTL("{1} is selected.",pokemon.name),[
             _INTL("Withdraw"),
             _INTL("Summary"),
             _INTL("Mark"),
             _INTL("Release"),
             _INTL("Cancel")
          ])
          case command
          when 0 then pbWithdraw(selected, nil)
          when 1 then pbSummary(selected, nil)
          when 2 then pbMark(selected, nil)
          when 3 then pbRelease(selected, nil)
          end
        end
      end
      @scene.pbCloseBox
    elsif command==2   # Deposit
      @scene.pbStartBox(self,command)
      loop do
        selected = @scene.pbSelectParty(@storage.party)
        if selected==-3   # Close box
          if pbConfirm(_INTL("Exit from the Box?"))
            pbSEPlay("PC close")
            break
          end
          next
        elsif selected<0
          next if pbConfirm(_INTL("Continue Box operations?"))
          break
        else
          pokemon = @storage[-1,selected]
          next if !pokemon
          command = pbShowCommands(_INTL("{1} is selected.",pokemon.name),[
             _INTL("Store"),
             _INTL("Summary"),
             _INTL("Mark"),
             _INTL("Release"),
             _INTL("Cancel")
          ])
          case command
          when 0 then pbStore([-1, selected], nil)
          when 1 then pbSummary([-1, selected], nil)
          when 2 then pbMark([-1, selected], nil)
          when 3 then pbRelease([-1, selected], nil)
          end
        end
      end
      @scene.pbCloseBox
    elsif command==3
      @scene.pbStartBox(self,command)
      @scene.pbCloseBox
    end
  end
  
  def pbStore(selected,heldpoke)
    box = selected[0]
    index = selected[1]
    if box!=-1
      raise _INTL("Can't deposit from box...")
    end
    if pbAbleCount<=1 && pbAble?(@storage[box,index]) && !heldpoke
      pbPlayBuzzerSE
      pbDisplay(_INTL("That's your last party member!"))
    elsif heldpoke && heldpoke.mail
      pbDisplay(_INTL("Please remove the Mail."))
    elsif !heldpoke && @storage[box,index].mail
      pbDisplay(_INTL("Please remove the Mail."))
    else
      loop do
        destbox = @scene.pbChooseBox(_INTL("Deposit in which Box?"))
        if destbox>=0
          firstfree = @storage.pbFirstFreePos(destbox)
          if firstfree<0
            pbDisplay(_INTL("The Box is full."))
            next
          end
          if heldpoke || selected[0]==-1
            p = (heldpoke) ? heldpoke : @storage[-1,index]
            p.time_form_set = nil
            p.form          = 0 if p.isSpecies?(:SHAYMIN)
            p.heal
          end
          @scene.pbStore(selected,heldpoke,destbox,firstfree)
          if heldpoke
            @storage.pbMoveCaughtToBox(heldpoke,destbox)
            @heldpkmn = nil
          else
            @storage.pbMove(destbox,-1,-1,index)
          end
        end
        break
      end
      @scene.pbRefresh
    end
  end

  def pbHold(selected)
    box = selected[0]
    index = selected[1]
    if box==-1 && pbAble?(@storage[box,index]) && pbAbleCount<=1
      pbPlayBuzzerSE
      pbDisplay(_INTL("That's your last party member!"))
      return
    end
    @scene.pbHold(selected)
    @heldpkmn = @storage[box,index]
    @storage.pbDelete(box,index)
    @scene.pbRefresh
  end
  
  def pbRelease(selected,heldpoke)
    box = selected[0]
    index = selected[1]
    pokemon = (heldpoke) ? heldpoke : @storage[box,index]
    return if !pokemon
    if pokemon.egg?
      pbDisplay(_INTL("You can't release an Egg."))
      return false
    elsif pokemon.mail
      pbDisplay(_INTL("Please remove the mail."))
      return false
    end
    if box==-1 && pbAbleCount<=1 && pbAble?(pokemon) && !heldpoke
      pbPlayBuzzerSE
      pbDisplay(_INTL("That's your last party member!"))
      return
    end
    command = pbShowCommands(_INTL("Release this party member?"),[_INTL("No"),_INTL("Yes")])
    if command==1
      pkmnname = pokemon.name
      @scene.pbRelease(selected,heldpoke)
      if heldpoke
        @heldpkmn = nil
      else
        @storage.pbDelete(box,index)
      end
      @scene.pbRefresh
      pbDisplay(_INTL("{1} was released.",pkmnname))
      pbDisplay(_INTL("Bye-bye, {1}!",pkmnname))
      @scene.pbRefresh
    end
    return
  end
end