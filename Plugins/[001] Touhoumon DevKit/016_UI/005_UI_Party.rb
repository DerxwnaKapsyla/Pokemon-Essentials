#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Adding in the Yin/Yang icons to the party menu
#==============================================================================#
class PokemonPartyPanel < SpriteWrapper
  def refresh
    return if disposed?
    return if @refreshing
    @refreshing = true
    if @panelbgsprite && !@panelbgsprite.disposed?
      if self.selected
        if self.preselected;     @panelbgsprite.changeBitmap("swapsel2")
        elsif @switching;        @panelbgsprite.changeBitmap("swapsel")
        elsif @pokemon.fainted?; @panelbgsprite.changeBitmap("faintedsel")
        else;                    @panelbgsprite.changeBitmap("ablesel")
        end
      else
        if self.preselected;     @panelbgsprite.changeBitmap("swap")
        elsif @pokemon.fainted?; @panelbgsprite.changeBitmap("fainted")
        else;                    @panelbgsprite.changeBitmap("able")
        end
      end
      @panelbgsprite.x     = self.x
      @panelbgsprite.y     = self.y
      @panelbgsprite.color = self.color
    end
    if @hpbgsprite && !@hpbgsprite.disposed?
      @hpbgsprite.visible = (!@pokemon.egg? && !(@text && @text.length>0))
      if @hpbgsprite.visible
        if self.preselected || (self.selected && @switching); @hpbgsprite.changeBitmap("swap")
        elsif @pokemon.fainted?;                              @hpbgsprite.changeBitmap("fainted")
        else;                                                 @hpbgsprite.changeBitmap("able")
        end
        @hpbgsprite.x     = self.x+96
        @hpbgsprite.y     = self.y+50
        @hpbgsprite.color = self.color
      end
    end
    if @ballsprite && !@ballsprite.disposed?
      @ballsprite.changeBitmap((self.selected) ? "sel" : "desel")
      @ballsprite.x     = self.x+10
      @ballsprite.y     = self.y
      @ballsprite.color = self.color
    end
    if @pkmnsprite && !@pkmnsprite.disposed?
      @pkmnsprite.x        = self.x+60
      @pkmnsprite.y        = self.y+40
      @pkmnsprite.color    = self.color
      @pkmnsprite.selected = self.selected
    end
    if @helditemsprite && !@helditemsprite.disposed?
      if @helditemsprite.visible
        @helditemsprite.x     = self.x+62
        @helditemsprite.y     = self.y+48
        @helditemsprite.color = self.color
      end
    end
    if @overlaysprite && !@overlaysprite.disposed?
      @overlaysprite.x     = self.x
      @overlaysprite.y     = self.y
      @overlaysprite.color = self.color
    end
    if @refreshBitmap
      @refreshBitmap = false
      @overlaysprite.bitmap.clear if @overlaysprite.bitmap
      basecolor   = Color.new(248,248,248)
      shadowcolor = Color.new(40,40,40)
      pbSetSystemFont(@overlaysprite.bitmap)
      textpos = []
      # Draw Pokémon name
      textpos.push([@pokemon.name,96,10,0,basecolor,shadowcolor])
      if !@pokemon.egg?
        if !@text || @text.length==0
          # Draw HP numbers
          textpos.push([sprintf("% 3d /% 3d",@pokemon.hp,@pokemon.totalhp),224,54,1,basecolor,shadowcolor])
          # Draw HP bar
          if @pokemon.hp>0
            w = @pokemon.hp*96*1.0/@pokemon.totalhp
            w = 1 if w<1
            w = ((w/2).round)*2
            hpzone = 0
            hpzone = 1 if @pokemon.hp<=(@pokemon.totalhp/2).floor
            hpzone = 2 if @pokemon.hp<=(@pokemon.totalhp/4).floor
            hprect = Rect.new(0,hpzone*8,w,8)
            @overlaysprite.bitmap.blt(128,52,@hpbar.bitmap,hprect)
          end
          # Draw status
          status = 0
          if @pokemon.fainted?
            status = GameData::Status::DATA.keys.length / 2
          elsif @pokemon.status != :NONE
            status = GameData::Status.get(@pokemon.status).id_number
          elsif @pokemon.pokerusStage == 1
            status = GameData::Status::DATA.keys.length / 2 + 1
          end
          status -= 1
          if status >= 0
            statusrect = Rect.new(0,16*status,44,16)
            @overlaysprite.bitmap.blt(78,68,@statuses.bitmap,statusrect)
          end
        end
        # Draw gender symbol
		pkmn_data = GameData::Species.get_species_form(pokemon.species, pokemon.form)
		if pkmn_data.generation <20
		  if @pokemon.male?
			textpos.push([_INTL("♂"),224,10,0,Color.new(0,112,248),Color.new(120,184,232)])
          elsif @pokemon.female?
			textpos.push([_INTL("♀"),224,10,0,Color.new(232,32,16),Color.new(248,168,184)])
		  end
		else
		  if @pokemon.male?
			  pbDrawImagePositions(@overlaysprite.bitmap,[
				[sprintf("Graphics/icons/yin"),220,21,0,0,-1,-1]
			  ])
          elsif @pokemon.female?
			  pbDrawImagePositions(@overlaysprite.bitmap,[
				[sprintf("Graphics/icons/yang"),220,21,0,0,-1,-1]
			  ])	
		  end
		end
        # Draw shiny icon
        if @pokemon.shiny?
          pbDrawImagePositions(@overlaysprite.bitmap,[[
             "Graphics/Pictures/shiny",80,48,0,0,16,16]])
        end
      end
      pbDrawTextPositions(@overlaysprite.bitmap,textpos)
      # Draw level text
      if !@pokemon.egg?
        pbDrawImagePositions(@overlaysprite.bitmap,[[
           "Graphics/Pictures/Party/overlay_lv",20,70,0,0,22,14]])
        pbSetSmallFont(@overlaysprite.bitmap)
        pbDrawTextPositions(@overlaysprite.bitmap,[
           [@pokemon.level.to_s,42,57,0,basecolor,shadowcolor]
        ])
      end
      # Draw annotation text
      if @text && @text.length>0
        pbSetSystemFont(@overlaysprite.bitmap)
        pbDrawTextPositions(@overlaysprite.bitmap,[
           [@text,96,52,0,basecolor,shadowcolor]
        ])
      end
    end
    @refreshing = false
  end
end

#==============================================================================#
# Changes in this section include the following:
#	* Removing explicit references to Pokemon
#==============================================================================#
class PokemonPartyScreen
  def pbPokemonGiveScreen(item)
    @scene.pbStartScene(@party,_INTL("Who should hold this?"))
    pkmnid = @scene.pbChoosePokemon
    ret = false
    if pkmnid>=0
      ret = pbGiveItemToPokemon(item,@party[pkmnid],self,pkmnid)
    end
    pbRefreshSingle(pkmnid)
    @scene.pbEndScene
    return ret
  end

  def pbPokemonGiveMailScreen(mailIndex)
    @scene.pbStartScene(@party,_INTL("Who should hold this?"))
    pkmnid = @scene.pbChoosePokemon
    if pkmnid>=0
      pkmn = @party[pkmnid]
      if pkmn.hasItem? || pkmn.mail
        pbDisplay(_INTL("They are already holding an item. It can't hold mail."))
      elsif pkmn.egg?
        pbDisplay(_INTL("Eggs can't hold mail."))
      else
        pbDisplay(_INTL("Mail was transferred from the Mailbox."))
        pkmn.mail = $PokemonGlobal.mailbox[mailIndex]
        pkmn.item = pkmn.mail.item
        $PokemonGlobal.mailbox.delete_at(mailIndex)
        pbRefreshSingle(pkmnid)
      end
    end
    @scene.pbEndScene
  end
  
  def pbPokemonMultipleEntryScreenEx(ruleset)
    annot = []
    statuses = []
    ordinals = [_INTL("INELIGIBLE"), _INTL("NOT ENTERED"), _INTL("BANNED")]
    positions = [_INTL("FIRST"), _INTL("SECOND"), _INTL("THIRD"), _INTL("FOURTH"),
                 _INTL("FIFTH"), _INTL("SIXTH"), _INTL("SEVENTH"), _INTL("EIGHTH"),
                 _INTL("NINTH"), _INTL("TENTH"), _INTL("ELEVENTH"), _INTL("TWELFTH")]
    for i in 0...Settings::MAX_PARTY_SIZE
      if i < positions.length
        ordinals.push(positions[i])
      else
        ordinals.push("#{i + 1}th")
      end
    end
    return nil if !ruleset.hasValidTeam?(@party)
    ret = nil
    addedEntry = false
    for i in 0...@party.length
      statuses[i] = (ruleset.isPokemonValid?(@party[i])) ? 1 : 2
    end
    for i in 0...@party.length
      annot[i] = ordinals[statuses[i]]
    end
    @scene.pbStartScene(@party,_INTL("Choose party member and confirm."),annot,true)
    loop do
      realorder = []
      for i in 0...@party.length
        for j in 0...@party.length
          if statuses[j]==i+3
            realorder.push(j)
            break
          end
        end
      end
      for i in 0...realorder.length
        statuses[realorder[i]] = i+3
      end
      for i in 0...@party.length
        annot[i] = ordinals[statuses[i]]
      end
      @scene.pbAnnotate(annot)
      if realorder.length==ruleset.number && addedEntry
        @scene.pbSelect(Settings::MAX_PARTY_SIZE)
      end
      @scene.pbSetHelpText(_INTL("Choose party member and confirm."))
      pkmnid = @scene.pbChoosePokemon
      addedEntry = false
      if pkmnid == Settings::MAX_PARTY_SIZE   # Confirm was chosen
        ret = []
        for i in realorder; ret.push(@party[i]); end
        error = []
        break if ruleset.isValid?(ret,error)
        pbDisplay(error[0])
        ret = nil
      end
      break if pkmnid<0   # Cancelled
      cmdEntry   = -1
      cmdNoEntry = -1
      cmdSummary = -1
      commands = []
      if (statuses[pkmnid] || 0) == 1
        commands[cmdEntry = commands.length]   = _INTL("Entry")
      elsif (statuses[pkmnid] || 0) > 2
        commands[cmdNoEntry = commands.length] = _INTL("No Entry")
      end
      pkmn = @party[pkmnid]
      commands[cmdSummary = commands.length]   = _INTL("Summary")
      commands[commands.length]                = _INTL("Cancel")
      command = @scene.pbShowCommands(_INTL("Do what with {1}?",pkmn.name),commands) if pkmn
      if cmdEntry>=0 && command==cmdEntry
        if realorder.length>=ruleset.number && ruleset.number>0
          pbDisplay(_INTL("No more than {1} combatant may enter.",ruleset.number))
        else
          statuses[pkmnid] = realorder.length+3
          addedEntry = true
          pbRefreshSingle(pkmnid)
        end
      elsif cmdNoEntry>=0 && command==cmdNoEntry
        statuses[pkmnid] = 1
        pbRefreshSingle(pkmnid)
      elsif cmdSummary>=0 && command==cmdSummary
        @scene.pbSummary(pkmnid) {
          @scene.pbSetHelpText((@party.length>1) ? _INTL("Choose a party member.") : _INTL("Choose party member or cancel."))
        }
      end
    end
    @scene.pbEndScene
    return ret
  end

  def pbChooseAblePokemon(ableProc,allowIneligible=false)
    annot = []
    eligibility = []
    for pkmn in @party
      elig = ableProc.call(pkmn)
      eligibility.push(elig)
      annot.push((elig) ? _INTL("ABLE") : _INTL("NOT ABLE"))
    end
    ret = -1
    @scene.pbStartScene(@party,
       (@party.length>1) ? _INTL("Choose a party member.") : _INTL("Choose party member or cancel."),annot)
    loop do
      @scene.pbSetHelpText(
         (@party.length>1) ? _INTL("Choose a party member.") : _INTL("Choose party member or cancel."))
      pkmnid = @scene.pbChoosePokemon
      break if pkmnid<0
      if !eligibility[pkmnid] && !allowIneligible
        pbDisplay(_INTL("This party member can't be chosen."))
      else
        ret = pkmnid
        break
      end
    end
    @scene.pbEndScene
    return ret
  end

  def pbChooseTradablePokemon(ableProc,allowIneligible=false)
    annot = []
    eligibility = []
    for pkmn in @party
      elig = ableProc.call(pkmn)
      elig = false if pkmn.egg? || pkmn.shadowPokemon?
      eligibility.push(elig)
      annot.push((elig) ? _INTL("ABLE") : _INTL("NOT ABLE"))
    end
    ret = -1
    @scene.pbStartScene(@party,
       (@party.length>1) ? _INTL("Choose a party member.") : _INTL("Choose party member or cancel."),annot)
    loop do
      @scene.pbSetHelpText(
         (@party.length>1) ? _INTL("Choose a party member.") : _INTL("Choose party member or cancel."))
      pkmnid = @scene.pbChoosePokemon
      break if pkmnid<0
      if !eligibility[pkmnid] && !allowIneligible
        pbDisplay(_INTL("This party member can't be chosen."))
      else
        ret = pkmnid
        break
      end
    end
    @scene.pbEndScene
    return ret
  end

  def pbPokemonScreen
    @scene.pbStartScene(@party,
       (@party.length>1) ? _INTL("Choose a party member.") : _INTL("Choose party member or cancel."),nil)
    loop do
      @scene.pbSetHelpText((@party.length>1) ? _INTL("Choose a party member.") : _INTL("Choose party member or cancel."))
      pkmnid = @scene.pbChoosePokemon(false,-1,1)
      break if (pkmnid.is_a?(Numeric) && pkmnid<0) || (pkmnid.is_a?(Array) && pkmnid[1]<0)
      if pkmnid.is_a?(Array) && pkmnid[0]==1   # Switch
        @scene.pbSetHelpText(_INTL("Move to where?"))
        oldpkmnid = pkmnid[1]
        pkmnid = @scene.pbChoosePokemon(true,-1,2)
        if pkmnid>=0 && pkmnid!=oldpkmnid
          pbSwitch(oldpkmnid,pkmnid)
        end
        next
      end
      pkmn = @party[pkmnid]
      commands   = []
      cmdSummary = -1
      cmdDebug   = -1
      cmdMoves   = [-1] * pkmn.numMoves
      cmdSwitch  = -1
      cmdMail    = -1
      cmdItem    = -1
      # Build the commands
      commands[cmdSummary = commands.length]      = _INTL("Summary")
      commands[cmdDebug = commands.length]        = _INTL("Debug") if $DEBUG
      if !pkmn.egg?
        # Check for hidden moves and add any that were found
        pkmn.moves.each_with_index do |m, i|
          if [:MILKDRINK, :SOFTBOILED].include?(m.id) ||
             HiddenMoveHandlers.hasHandler(m.id)
            commands[cmdMoves[i] = commands.length] = [m.name, 1]
          end
        end
      end
      commands[cmdSwitch = commands.length]       = _INTL("Switch") if @party.length>1
      if !pkmn.egg?
        if pkmn.mail
          commands[cmdMail = commands.length]     = _INTL("Mail")
        else
          commands[cmdItem = commands.length]     = _INTL("Item")
        end
      end
      commands[commands.length]                   = _INTL("Cancel")
      command = @scene.pbShowCommands(_INTL("Do what with {1}?",pkmn.name),commands)
      havecommand = false
      cmdMoves.each_with_index do |cmd, i|
        next if cmd < 0 || cmd != command
        havecommand = true
        if [:MILKDRINK, :SOFTBOILED].include?(pkmn.moves[i].id)
          amt = [(pkmn.totalhp/5).floor,1].max
          if pkmn.hp<=amt
            pbDisplay(_INTL("Not enough HP..."))
            break
          end
          @scene.pbSetHelpText(_INTL("Use on which party member?"))
          oldpkmnid = pkmnid
          loop do
            @scene.pbPreSelect(oldpkmnid)
            pkmnid = @scene.pbChoosePokemon(true,pkmnid)
            break if pkmnid<0
            newpkmn = @party[pkmnid]
            movename = pkmn.moves[i].name
            if pkmnid==oldpkmnid
              pbDisplay(_INTL("{1} can't use {2} on itself!",pkmn.name,movename))
            elsif newpkmn.egg?
              pbDisplay(_INTL("{1} can't be used on an Egg!",movename))
            elsif newpkmn.hp==0 || newpkmn.hp==newpkmn.totalhp
              pbDisplay(_INTL("{1} can't be used on that party member.",movename))
            else
              pkmn.hp -= amt
              hpgain = pbItemRestoreHP(newpkmn,amt)
              @scene.pbDisplay(_INTL("{1}'s HP was restored by {2} points.",newpkmn.name,hpgain))
              pbRefresh
            end
            break if pkmn.hp<=amt
          end
          @scene.pbSelect(oldpkmnid)
          pbRefresh
          break
        elsif pbCanUseHiddenMove?(pkmn,pkmn.moves[i].id)
          if pbConfirmUseHiddenMove(pkmn,pkmn.moves[i].id)
            @scene.pbEndScene
            if pkmn.moves[i].id == :FLY
              scene = PokemonRegionMap_Scene.new(-1,false)
              screen = PokemonRegionMapScreen.new(scene)
              ret = screen.pbStartFlyScreen
              if ret
                $PokemonTemp.flydata=ret
                return [pkmn,pkmn.moves[i].id]
              end
              @scene.pbStartScene(@party,
                 (@party.length>1) ? _INTL("Choose a party member.") : _INTL("Choose party member or cancel."))
              break
            end
            return [pkmn,pkmn.moves[i].id]
          end
        end
      end
      next if havecommand
      if cmdSummary>=0 && command==cmdSummary
        @scene.pbSummary(pkmnid) {
          @scene.pbSetHelpText((@party.length>1) ? _INTL("Choose a party member.") : _INTL("Choose party member or cancel."))
        }
      elsif cmdDebug>=0 && command==cmdDebug
        pbPokemonDebug(pkmn,pkmnid)
      elsif cmdSwitch>=0 && command==cmdSwitch
        @scene.pbSetHelpText(_INTL("Move to where?"))
        oldpkmnid = pkmnid
        pkmnid = @scene.pbChoosePokemon(true)
        if pkmnid>=0 && pkmnid!=oldpkmnid
          pbSwitch(oldpkmnid,pkmnid)
        end
      elsif cmdMail>=0 && command==cmdMail
        command = @scene.pbShowCommands(_INTL("Do what with the mail?"),
           [_INTL("Read"),_INTL("Take"),_INTL("Cancel")])
        case command
        when 0   # Read
          pbFadeOutIn {
            pbDisplayMail(pkmn.mail,pkmn)
            @scene.pbSetHelpText((@party.length>1) ? _INTL("Choose a party member.") : _INTL("Choose party member or cancel."))
          }
        when 1   # Take
          if pbTakeItemFromPokemon(pkmn,self)
            pbRefreshSingle(pkmnid)
          end
        end
      elsif cmdItem>=0 && command==cmdItem
        itemcommands = []
        cmdUseItem   = -1
        cmdGiveItem  = -1
        cmdTakeItem  = -1
        cmdMoveItem  = -1
        # Build the commands
        itemcommands[cmdUseItem=itemcommands.length]  = _INTL("Use")
        itemcommands[cmdGiveItem=itemcommands.length] = _INTL("Give")
        itemcommands[cmdTakeItem=itemcommands.length] = _INTL("Take") if pkmn.hasItem?
        itemcommands[cmdMoveItem=itemcommands.length] = _INTL("Move") if pkmn.hasItem? &&
                                                                         !GameData::Item.get(pkmn.item).is_mail?
        itemcommands[itemcommands.length]             = _INTL("Cancel")
        command = @scene.pbShowCommands(_INTL("Do what with an item?"),itemcommands)
        if cmdUseItem>=0 && command==cmdUseItem   # Use
          item = @scene.pbUseItem($PokemonBag,pkmn) {
            @scene.pbSetHelpText((@party.length>1) ? _INTL("Choose a party member.") : _INTL("Choose party member or cancel."))
          }
          if item
            pbUseItemOnPokemon(item,pkmn,self)
            pbRefreshSingle(pkmnid)
          end
        elsif cmdGiveItem>=0 && command==cmdGiveItem   # Give
          item = @scene.pbChooseItem($PokemonBag) {
            @scene.pbSetHelpText((@party.length>1) ? _INTL("Choose a party member.") : _INTL("Choose party member or cancel."))
          }
          if item
            if pbGiveItemToPokemon(item,pkmn,self,pkmnid)
              pbRefreshSingle(pkmnid)
            end
          end
        elsif cmdTakeItem>=0 && command==cmdTakeItem   # Take
          if pbTakeItemFromPokemon(pkmn,self)
            pbRefreshSingle(pkmnid)
          end
        elsif cmdMoveItem>=0 && command==cmdMoveItem   # Move
          item = pkmn.item
          itemname = item.name
          @scene.pbSetHelpText(_INTL("Move {1} to where?",itemname))
          oldpkmnid = pkmnid
          loop do
            @scene.pbPreSelect(oldpkmnid)
            pkmnid = @scene.pbChoosePokemon(true,pkmnid)
            break if pkmnid<0
            newpkmn = @party[pkmnid]
            break if pkmnid==oldpkmnid
            if newpkmn.egg?
              pbDisplay(_INTL("Eggs can't hold items."))
            elsif !newpkmn.hasItem?
              newpkmn.item = item
              pkmn.item = nil
              @scene.pbClearSwitching
              pbRefresh
              pbDisplay(_INTL("{1} was given the {2} to hold.",newpkmn.name,itemname))
              break
            elsif GameData::Item.get(newpkmn.item).is_mail?
              pbDisplay(_INTL("{1}'s mail must be removed before giving it an item.",newpkmn.name))
            else
              newitem = newpkmn.item
              newitemname = newitem.name
              if newitem == :LEFTOVERS
                pbDisplay(_INTL("{1} is already holding some {2}.\1",newpkmn.name,newitemname))
              elsif newitemname.starts_with_vowel?
                pbDisplay(_INTL("{1} is already holding an {2}.\1",newpkmn.name,newitemname))
              else
                pbDisplay(_INTL("{1} is already holding a {2}.\1",newpkmn.name,newitemname))
              end
              if pbConfirm(_INTL("Would you like to switch the two items?"))
                newpkmn.item = item
                pkmn.item = newitem
                @scene.pbClearSwitching
                pbRefresh
                pbDisplay(_INTL("{1} was given the {2} to hold.",newpkmn.name,itemname))
                pbDisplay(_INTL("{1} was given the {2} to hold.",pkmn.name,newitemname))
                break
              end
            end
          end
        end
      end
    end
    @scene.pbEndScene
    return nil
  end
end

#==============================================================================#
# Changes in this section include the following:
#	* Removing explicit references to Pokemon
#==============================================================================#
def pbChoosePokemon(variableNumber,nameVarNumber,ableProc=nil,allowIneligible=false)
  chosen = 0
  pbFadeOutIn {
    scene = PokemonParty_Scene.new
    screen = PokemonPartyScreen.new(scene,$Trainer.party)
    if ableProc
      chosen=screen.pbChooseAblePokemon(ableProc,allowIneligible)
    else
      screen.pbStartScene(_INTL("Choose a party member."),false)
      chosen = screen.pbChoosePokemon
      screen.pbEndScene
    end
  }
  pbSet(variableNumber,chosen)
  if chosen>=0
    pbSet(nameVarNumber,$Trainer.party[chosen].name)
  else
    pbSet(nameVarNumber,"")
  end
end

def pbChooseTradablePokemon(variableNumber,nameVarNumber,ableProc=nil,allowIneligible=false)
  chosen = 0
  pbFadeOutIn {
    scene = PokemonParty_Scene.new
    screen = PokemonPartyScreen.new(scene,$Trainer.party)
    if ableProc
      chosen=screen.pbChooseTradablePokemon(ableProc,allowIneligible)
    else
      screen.pbStartScene(_INTL("Choose a party member."),false)
      chosen = screen.pbChoosePokemon
      screen.pbEndScene
    end
  }
  pbSet(variableNumber,chosen)
  if chosen>=0
    pbSet(nameVarNumber,$Trainer.party[chosen].name)
  else
    pbSet(nameVarNumber,"")
  end
end