#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Adding in the Yin/Yang glyphs to the party menu
#==============================================================================#
class PokemonPartyPanel < SpriteWrapper
  def refresh
    return if disposed?
    return if @refreshing
    @refreshing = true
    if @panelbgsprite && !@panelbgsprite.disposed?
      if self.selected
        if self.preselected
          @panelbgsprite.changeBitmap("swapsel2")
        elsif @switching
          @panelbgsprite.changeBitmap("swapsel")
        elsif @pokemon.fainted?
          @panelbgsprite.changeBitmap("faintedsel")
        else
          @panelbgsprite.changeBitmap("ablesel")
        end
      else
        if self.preselected
          @panelbgsprite.changeBitmap("swap")
        elsif @pokemon.fainted?
          @panelbgsprite.changeBitmap("fainted")
        else
          @panelbgsprite.changeBitmap("able")
        end
      end
      @panelbgsprite.x     = self.x
      @panelbgsprite.y     = self.y
      @panelbgsprite.color = self.color
    end
    if @hpbgsprite && !@hpbgsprite.disposed?
      @hpbgsprite.visible = (!@pokemon.egg? && !(@text && @text.length > 0))
      if @hpbgsprite.visible
        if self.preselected || (self.selected && @switching)
          @hpbgsprite.changeBitmap("swap")
        elsif @pokemon.fainted?
          @hpbgsprite.changeBitmap("fainted")
        else
          @hpbgsprite.changeBitmap("able")
        end
        @hpbgsprite.x     = self.x + 96
        @hpbgsprite.y     = self.y + 50
        @hpbgsprite.color = self.color
      end
    end
    if @ballsprite && !@ballsprite.disposed?
      @ballsprite.changeBitmap((self.selected) ? "sel" : "desel")
      @ballsprite.x     = self.x + 10
      @ballsprite.y     = self.y
      @ballsprite.color = self.color
    end
    if @pkmnsprite && !@pkmnsprite.disposed?
      @pkmnsprite.x        = self.x + 60
      @pkmnsprite.y        = self.y + 40
      @pkmnsprite.color    = self.color
      @pkmnsprite.selected = self.selected
    end
    if @helditemsprite&.visible && !@helditemsprite.disposed?
      @helditemsprite.x     = self.x + 62
      @helditemsprite.y     = self.y + 48
      @helditemsprite.color = self.color
    end
    if @overlaysprite && !@overlaysprite.disposed?
      @overlaysprite.x     = self.x
      @overlaysprite.y     = self.y
      @overlaysprite.color = self.color
    end
    if @refreshBitmap
      @refreshBitmap = false
      @overlaysprite.bitmap&.clear
      basecolor   = Color.new(248, 248, 248)
      shadowcolor = Color.new(40, 40, 40)
      pbSetSystemFont(@overlaysprite.bitmap)
      textpos = []
      # Draw Pokémon name
      textpos.push([@pokemon.name, 96, 22, 0, basecolor, shadowcolor])
      if !@pokemon.egg?
        if !@text || @text.length == 0
          # Draw HP numbers
          textpos.push([sprintf("% 3d /% 3d", @pokemon.hp, @pokemon.totalhp), 224, 66, 1, basecolor, shadowcolor])
          # Draw HP bar
          if @pokemon.hp > 0
            w = @pokemon.hp * 96 / @pokemon.totalhp.to_f
            w = 1 if w < 1
            w = ((w / 2).round) * 2
            hpzone = 0
            hpzone = 1 if @pokemon.hp <= (@pokemon.totalhp / 2).floor
            hpzone = 2 if @pokemon.hp <= (@pokemon.totalhp / 4).floor
            hprect = Rect.new(0, hpzone * 8, w, 8)
            @overlaysprite.bitmap.blt(128, 52, @hpbar.bitmap, hprect)
          end
          # Draw status
          status = -1
          if @pokemon.fainted?
            status = GameData::Status.count
          elsif @pokemon.status != :NONE
            status = GameData::Status.get(@pokemon.status).icon_position
          elsif @pokemon.pokerusStage == 1
            status = GameData::Status.count + 1
          end
          if status >= 0
            statusrect = Rect.new(0, 16 * status, 44, 16)
            @overlaysprite.bitmap.blt(78, 68, @statuses.bitmap, statusrect)
          end
        end
        # Draw gender symbol
		pkmn_data = GameData::Species.get_species_form(pokemon.species, pokemon.form)
		if pkmn_data.has_flag?("Puppet")
          if @pokemon.male?
          	textpos.push([_INTL("¹"), 224, 22, 0, Color.new(0, 112, 248), Color.new(120, 184, 232)])
          elsif @pokemon.female?
          	textpos.push([_INTL("²"), 224, 22, 0, Color.new(232, 32, 16), Color.new(248, 168, 184)])
          end
        else
          if @pokemon.male?
          	textpos.push([_INTL("♂"), 224, 22, 0, Color.new(0, 112, 248), Color.new(120, 184, 232)])
          elsif @pokemon.female?
          	textpos.push([_INTL("♀"), 224, 22, 0, Color.new(232, 32, 16), Color.new(248, 168, 184)])
          end
        end
        # Draw shiny icon
        if @pokemon.shiny?
          pbDrawImagePositions(@overlaysprite.bitmap,
                               [["Graphics/Pictures/shiny", 80, 48, 0, 0, 16, 16]])
        end
      end
      pbDrawTextPositions(@overlaysprite.bitmap, textpos)
      # Draw level text
      if !@pokemon.egg?
        pbDrawImagePositions(@overlaysprite.bitmap,
                             [["Graphics/Pictures/Party/overlay_lv", 20, 70, 0, 0, 22, 14]])
        pbSetSmallFont(@overlaysprite.bitmap)
        pbDrawTextPositions(@overlaysprite.bitmap,
                            [[@pokemon.level.to_s, 42, 68, 0, basecolor, shadowcolor]])
      end
      # Draw annotation text
      if @text && @text.length > 0
        pbSetSystemFont(@overlaysprite.bitmap)
        pbDrawTextPositions(@overlaysprite.bitmap,
                            [[@text, 96, 62, 0, basecolor, shadowcolor]])
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
    @scene.pbStartScene(@party, _INTL("Who should hold this?"))
    pkmnid = @scene.pbChoosePokemon
    ret = false
    if pkmnid >= 0
      ret = pbGiveItemToPokemon(item, @party[pkmnid], self, pkmnid)
    end
    pbRefreshSingle(pkmnid)
    @scene.pbEndScene
    return ret
  end

  def pbPokemonGiveMailScreen(mailIndex)
    @scene.pbStartScene(@party, _INTL("Who should hold this?"))
    pkmnid = @scene.pbChoosePokemon
    if pkmnid >= 0
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
    Settings::MAX_PARTY_SIZE.times do |i|
      if i < positions.length
        ordinals.push(positions[i])
      else
        ordinals.push("#{i + 1}th")
      end
    end
    return nil if !ruleset.hasValidTeam?(@party)
    ret = nil
    addedEntry = false
    @party.length.times do |i|
      statuses[i] = (ruleset.isPokemonValid?(@party[i])) ? 1 : 2
      annot[i] = ordinals[statuses[i]]
    end
    @scene.pbStartScene(@party, _INTL("Choose party member and confirm."), annot, true)
    loop do
      realorder = []
      @party.length.times do |i|
        @party.length.times do |j|
          if statuses[j] == i + 3
            realorder.push(j)
            break
          end
        end
      end
      realorder.length.times do |i|
        statuses[realorder[i]] = i + 3
      end
      @party.length.times do |i|
        annot[i] = ordinals[statuses[i]]
      end
      @scene.pbAnnotate(annot)
      if realorder.length == ruleset.number && addedEntry
        @scene.pbSelect(Settings::MAX_PARTY_SIZE)
      end
      @scene.pbSetHelpText(_INTL("Choose party member and confirm."))
      pkmnid = @scene.pbChoosePokemon
      addedEntry = false
      if pkmnid == Settings::MAX_PARTY_SIZE   # Confirm was chosen
        ret = []
        realorder.each do |i|
          ret.push(@party[i])
        end
        error = []
        break if ruleset.isValid?(ret, error)
        pbDisplay(error[0])
        ret = nil
      end
      break if pkmnid < 0   # Cancelled
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
      command = @scene.pbShowCommands(_INTL("Do what with {1}?", pkmn.name), commands) if pkmn
      if cmdEntry >= 0 && command == cmdEntry
        if realorder.length >= ruleset.number && ruleset.number > 0
          pbDisplay(_INTL("No more than {1} combatant may enter.", ruleset.number))
        else
          statuses[pkmnid] = realorder.length + 3
          addedEntry = true
          pbRefreshSingle(pkmnid)
        end
      elsif cmdNoEntry >= 0 && command == cmdNoEntry
        statuses[pkmnid] = 1
        pbRefreshSingle(pkmnid)
      elsif cmdSummary >= 0 && command == cmdSummary
        @scene.pbSummary(pkmnid) {
          @scene.pbSetHelpText((@party.length > 1) ? _INTL("Choose a party member.") : _INTL("Choose party member or cancel."))
        }
      end
    end
    @scene.pbEndScene
    return ret
  end

  def pbChooseAblePokemon(ableProc, allowIneligible = false)
    annot = []
    eligibility = []
    @party.each do |pkmn|
      elig = ableProc.call(pkmn)
      eligibility.push(elig)
      annot.push((elig) ? _INTL("ABLE") : _INTL("NOT ABLE"))
    end
    ret = -1
    @scene.pbStartScene(
      @party,
      (@party.length > 1) ? _INTL("Choose a party member.") : _INTL("Choose party member or cancel."),
      annot
    )
    loop do
      @scene.pbSetHelpText(
        (@party.length > 1) ? _INTL("Choose a party member.") : _INTL("Choose party memberor cancel.")
      )
      pkmnid = @scene.pbChoosePokemon
      break if pkmnid < 0
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

  def pbChooseTradablePokemon(ableProc, allowIneligible = false)
    annot = []
    eligibility = []
    @party.each do |pkmn|
      elig = ableProc.call(pkmn)
      elig = false if pkmn.egg? || pkmn.shadowPokemon? || pkmn.cannot_trade
      eligibility.push(elig)
      annot.push((elig) ? _INTL("ABLE") : _INTL("NOT ABLE"))
    end
    ret = -1
    @scene.pbStartScene(
      @party,
      (@party.length > 1) ? _INTL("Choose a party member.") : _INTL("Choose party member or cancel."),
      annot
    )
    loop do
      @scene.pbSetHelpText(
        (@party.length > 1) ? _INTL("Choose a party member.") : _INTL("Choose party member or cancel.")
      )
      pkmnid = @scene.pbChoosePokemon
      break if pkmnid < 0
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
    can_access_storage = false
    if ($player.has_box_link || $bag.has?(:POKEMONBOXLINK)) &&
       !$game_switches[Settings::DISABLE_BOX_LINK_SWITCH] &&
       !$game_map.metadata&.has_flag?("DisableBoxLink")
      can_access_storage = true
    end
    @scene.pbStartScene(@party,
                        (@party.length > 1) ? _INTL("Choose a party member.") : _INTL("Choose party member or cancel."),
                        nil, false, can_access_storage)
    # Main loop
    loop do
      # Choose a Pokémon or cancel or press Action to quick switch
      @scene.pbSetHelpText((@party.length > 1) ? _INTL("Choose a party member.") : _INTL("Choose party member or cancel."))
      party_idx = @scene.pbChoosePokemon(false, -1, 1)
      break if (party_idx.is_a?(Numeric) && party_idx < 0) || (party_idx.is_a?(Array) && party_idx[1] < 0)
      # Quick switch
      if party_idx.is_a?(Array) && party_idx[0] == 1   # Switch
        @scene.pbSetHelpText(_INTL("Move to where?"))
        old_party_idx = party_idx[1]
        party_idx = @scene.pbChoosePokemon(true, -1, 2)
        pbSwitch(old_party_idx, party_idx) if party_idx >= 0 && party_idx != old_party_idx
        next
      end
      # Chose a Pokémon
      pkmn = @party[party_idx]
      # Get all commands
      command_list = []
      commands = []
      MenuHandlers.each_available(:party_menu, self, @party, party_idx) do |option, hash, name|
        command_list.push(name)
        commands.push(hash)
      end
      command_list.push(_INTL("Cancel"))
      # Add field move commands
      if !pkmn.egg?
        insert_index = ($DEBUG) ? 2 : 1
        pkmn.moves.each_with_index do |move, i|
          next if !HiddenMoveHandlers.hasHandler(move.id) &&
                  ![:MILKDRINK, :SOFTBOILED].include?(move.id)
          command_list.insert(insert_index, [move.name, 1])
          commands.insert(insert_index, i)
          insert_index += 1
        end
      end
      # Choose a menu option
      choice = @scene.pbShowCommands(_INTL("Do what with {1}?", pkmn.name), command_list)
      next if choice < 0 || choice >= commands.length
      # Effect of chosen menu option
      case commands[choice]
      when Hash   # Option defined via a MenuHandler below
        commands[choice]["effect"].call(self, @party, party_idx)
      when Integer   # Hidden move's index
        move = pkmn.moves[commands[choice]]
        if [:MILKDRINK, :SOFTBOILED].include?(move.id)
          amt = [(pkmn.totalhp / 5).floor, 1].max
          if pkmn.hp <= amt
            pbDisplay(_INTL("Not enough HP..."))
            next
          end
          @scene.pbSetHelpText(_INTL("Use on which party member?"))
          old_party_idx = party_idx
          loop do
            @scene.pbPreSelect(old_party_idx)
            party_idx = @scene.pbChoosePokemon(true, party_idx)
            break if party_idx < 0
            newpkmn = @party[party_idx]
            movename = move.name
            if party_idx == old_party_idx
              pbDisplay(_INTL("{1} can't use {2} on itself!", pkmn.name, movename))
            elsif newpkmn.egg?
              pbDisplay(_INTL("{1} can't be used on an Egg!", movename))
            elsif newpkmn.fainted? || newpkmn.hp == newpkmn.totalhp
              pbDisplay(_INTL("{1} can't be used on that party member.", movename))
            else
              pkmn.hp -= amt
              hpgain = pbItemRestoreHP(newpkmn, amt)
              @scene.pbDisplay(_INTL("{1}'s HP was restored by {2} points.", newpkmn.name, hpgain))
              pbRefresh
            end
            break if pkmn.hp <= amt
          end
          @scene.pbSelect(old_party_idx)
          pbRefresh
        elsif pbCanUseHiddenMove?(pkmn, move.id)
          if pbConfirmUseHiddenMove(pkmn, move.id)
            @scene.pbEndScene
            if move.id == :FLY
              scene = PokemonRegionMap_Scene.new(-1, false)
              screen = PokemonRegionMapScreen.new(scene)
              ret = screen.pbStartFlyScreen
              if ret
                $game_temp.fly_destination = ret
                return [pkmn, move.id]
              end
              @scene.pbStartScene(
                @party, (@party.length > 1) ? _INTL("Choose a party member.") : _INTL("Choose party member or cancel.")
              )
              next
            end
            return [pkmn, move.id]
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
MenuHandlers.add(:party_menu, :summary, {
  "name"      => _INTL("Summary"),
  "order"     => 10,
  "effect"    => proc { |screen, party, party_idx|
    screen.scene.pbSummary(party_idx) {
      screen.scene.pbSetHelpText((party.length > 1) ? _INTL("Choose a party member.") : _INTL("Choose party member or cancel."))
    }
  }
})

MenuHandlers.add(:party_menu, :mail, {
  "name"      => _INTL("Mail"),
  "order"     => 40,
  "condition" => proc { |screen, party, party_idx| next !party[party_idx].egg? && party[party_idx].mail },
  "effect"    => proc { |screen, party, party_idx|
    pkmn = party[party_idx]
    command = screen.scene.pbShowCommands(_INTL("Do what with the mail?"),
                                          [_INTL("Read"), _INTL("Take"), _INTL("Cancel")])
    case command
    when 0   # Read
      pbFadeOutIn {
        pbDisplayMail(pkmn.mail, pkmn)
        screen.scene.pbSetHelpText((party.length > 1) ? _INTL("Choose a party member.") : _INTL("Choose party member or cancel."))
      }
    when 1   # Take
      if pbTakeItemFromPokemon(pkmn, screen)
        screen.pbRefreshSingle(party_idx)
      end
    end
  }
})

MenuHandlers.add(:party_menu_item, :use, {
  "name"      => _INTL("Use"),
  "order"     => 10,
  "effect"    => proc { |screen, party, party_idx|
    pkmn = party[party_idx]
    item = screen.scene.pbUseItem($bag, pkmn) {
      screen.scene.pbSetHelpText((party.length > 1) ? _INTL("Choose a party member.") : _INTL("Choose party member or cancel."))
    }
    next if !item
    pbUseItemOnPokemon(item, pkmn, screen)
    screen.pbRefreshSingle(party_idx)
  }
})

MenuHandlers.add(:party_menu_item, :give, {
  "name"      => _INTL("Give"),
  "order"     => 20,
  "effect"    => proc { |screen, party, party_idx|
    pkmn = party[party_idx]
    item = screen.scene.pbChooseItem($bag) {
      screen.scene.pbSetHelpText((party.length > 1) ? _INTL("Choose a party member.") : _INTL("Choose party member or cancel."))
    }
    next if !item || !pbGiveItemToPokemon(item, pkmn, screen, party_idx)
    screen.pbRefreshSingle(party_idx)
  }
})

#==============================================================================#
# Changes in this section include the following:
#	* Removing explicit references to Pokemon
#==============================================================================#
def pbChoosePokemon(variableNumber, nameVarNumber, ableProc = nil, allowIneligible = false)
  chosen = 0
  pbFadeOutIn {
    scene = PokemonParty_Scene.new
    screen = PokemonPartyScreen.new(scene, $player.party)
    if ableProc
      chosen = screen.pbChooseAblePokemon(ableProc, allowIneligible)
    else
      screen.pbStartScene(_INTL("Choose a party member."), false)
      chosen = screen.pbChoosePokemon
      screen.pbEndScene
    end
  }
  pbSet(variableNumber, chosen)
  if chosen >= 0
    pbSet(nameVarNumber, $player.party[chosen].name)
  else
    pbSet(nameVarNumber, "")
  end
end

def pbChooseTradablePokemon(variableNumber, nameVarNumber, ableProc = nil, allowIneligible = false)
  chosen = 0
  pbFadeOutIn {
    scene = PokemonParty_Scene.new
    screen = PokemonPartyScreen.new(scene, $player.party)
    if ableProc
      chosen = screen.pbChooseTradablePokemon(ableProc, allowIneligible)
    else
      screen.pbStartScene(_INTL("Choose a party member."), false)
      chosen = screen.pbChoosePokemon
      screen.pbEndScene
    end
  }
  pbSet(variableNumber, chosen)
  if chosen >= 0
    pbSet(nameVarNumber, $player.party[chosen].name)
  else
    pbSet(nameVarNumber, "")
  end
end