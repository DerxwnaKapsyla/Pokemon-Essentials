class Battle
  def pbStartBattleSendOut(sendOuts)	
        if $game_switches[Settings::SPECIAL_BATTLE_SWITCH]
          case $game_variables[Settings::SPECIAL_BATTLE_VARIABLE]
                when 1        then sbName = "The territorial"
                when 2        then sbName = "The aggressive"
                when 3        then sbName = "Kortalan Gym's"
                when 4        then sbName = "A trainer's"
                else               sbName = "Oh! A wild"
          end
        else
          sbName = "Oh! A wild"
        end 
    # "Want to battle" messages
    if wildBattle?
      foeParty = pbParty(1)
      case foeParty.length
      when 1
        pbDisplayPaused(_INTL("{2} {1} appeared!", foeParty[0].name, sbName))
      when 2
        pbDisplayPaused(_INTL("{3} {1} and {2} appeared!", foeParty[0].name,
                              foeParty[1].name, sbName))
      when 3
        pbDisplayPaused(_INTL("{4} {1}, {2} and {3} appeared!", foeParty[0].name,
                              foeParty[1].name, foeParty[2].name, sbName))
      end
	  #if $game_switches[Settings::SHINY_WILD_POKEMON_SWITCH] # Used for the "Make Any Pokemon Shiny" passcode
	  #  $game_switches[Settings::SHINY_WILD_POKEMON_SWITCH] = false
	  #end
    else   # Trainer battle
      case @opponent.length
      when 1
        pbDisplayPaused(_INTL("You are challenged by {1}!", @opponent[0].full_name))
      when 2
        pbDisplayPaused(_INTL("You are challenged by {1} and {2}!", @opponent[0].full_name,
                              @opponent[1].full_name))
      when 3
        pbDisplayPaused(_INTL("You are challenged by {1}, {2} and {3}!",
                              @opponent[0].full_name, @opponent[1].full_name, @opponent[2].full_name))
      end
    end
    # Send out Pokémon (opposing trainers first)
    [1, 0].each do |side|
      next if side == 1 && wildBattle?
      msg = ""
      toSendOut = []
      trainers = (side == 0) ? @player : @opponent
      # Opposing trainers and partner trainers's messages about sending out Pokémon
      trainers.each_with_index do |t, i|
        next if side == 0 && i == 0   # The player's message is shown last
        msg += "\r\n" if msg.length > 0
        sent = sendOuts[side][i]
        case sent.length
        when 1
          msg += _INTL("{1} sent out {2}!", t.full_name, @battlers[sent[0]].name)
        when 2
          msg += _INTL("{1} sent out {2} and {3}!", t.full_name,
                       @battlers[sent[0]].name, @battlers[sent[1]].name)
        when 3
          msg += _INTL("{1} sent out {2}, {3} and {4}!", t.full_name,
                       @battlers[sent[0]].name, @battlers[sent[1]].name, @battlers[sent[2]].name)
        end
        toSendOut.concat(sent)
      end
      # The player's message about sending out Pokémon
      if side == 0
        msg += "\r\n" if msg.length > 0
        sent = sendOuts[side][0]
        case sent.length
        when 1
          msg += _INTL("Go! {1}!", @battlers[sent[0]].name)
        when 2
          msg += _INTL("Go! {1} and {2}!", @battlers[sent[0]].name, @battlers[sent[1]].name)
        when 3
          msg += _INTL("Go! {1}, {2} and {3}!", @battlers[sent[0]].name,
                       @battlers[sent[1]].name, @battlers[sent[2]].name)
        end
        toSendOut.concat(sent)
      end
      pbDisplayBrief(msg) if msg.length > 0
      # The actual sending out of Pokémon
      animSendOuts = []
      toSendOut.each do |idxBattler|
        animSendOuts.push([idxBattler, @battlers[idxBattler].pokemon])
      end
      pbSendOut(animSendOuts, true)
    end
  end
end