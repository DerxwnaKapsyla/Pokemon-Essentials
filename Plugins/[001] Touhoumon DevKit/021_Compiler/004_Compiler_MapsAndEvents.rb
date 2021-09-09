#==============================================================================#
#                             Touhoumon Essentials                             #
#                                  Version 3.x                                 #
#             https://github.com/DerxwnaKapsyla/pokemon-essentials             #
#==============================================================================#
# Changes in this section include the following:
#	* Changed pbTrainerIntro to TrainerIntro2 as a result of how the Trainer
#	  intro system works now.
#==============================================================================#
module Compiler
  def convert_to_trainer_event(event,trainerChecker)
    return nil if !event || event.pages.length==0
    list = event.pages[0].list
    return nil if list.length<2
    commands = []
    isFirstCommand = false
    # Find all the trainer comments in the event
    for i in 0...list.length
      next if list[i].code!=108   # Comment (first line)
      command = list[i].parameters[0]
      for j in (i+1)...list.length
        break if list[j].code!=408   # Comment (continuation line)
        command += "\r\n"+list[j].parameters[0]
      end
      if command[/^(Battle\:|Type\:|Name\:|BattleID\:|DoubleBattle\:|Backdrop\:|EndSpeech\:|Outcome\:|Continue\:|EndBattle\:|EndIfSwitch\:|VanishIfSwitch\:|RegSpeech\:)/i]
        commands.push(command)
        isFirstCommand = true if i==0
      end
    end
    return nil if commands.length==0
    # Found trainer comments; create a new Event object to replace this event
    ret = RPG::Event.new(event.x,event.y)
    ret.name = event.name
    ret.id   = event.id
    firstpage = Marshal::load(Marshal.dump(event.pages[0]))   # Copy event's first page
    firstpage.trigger = 2   # On event touch
    firstpage.list    = []   # Clear page's commands
    # Rename the event if there's nothing above the trainer comments
    if isFirstCommand
      if !event.name[/trainer/i]
        ret.name = "Trainer(3)"
      elsif event.name[/^\s*trainer\s*\((\d+)\)\s*$/i]
        ret.name = "Trainer(#{$1})"
      end
    end
    # Compile the trainer comments
    rewriteComments = false   # You can change this
    battles        = []
    trtype         = nil
    trname         = nil
    battleid       = 0
    doublebattle   = false
    backdrop       = nil
    endspeeches    = []
    outcome        = 0
    continue       = false
    endbattles     = []
    endifswitch    = []
    vanishifswitch = []
    regspeech      = nil
    for command in commands
      if command[/^Battle\:\s*([\s\S]+)$/i]
        battles.push($~[1])
        push_comment(firstpage.list,command) if rewriteComments
      elsif command[/^Type\:\s*([\s\S]+)$/i]
        trtype = $~[1].gsub(/^\s+/,"").gsub(/\s+$/,"")
        push_comment(firstpage.list,command) if rewriteComments
      elsif command[/^Name\:\s*([\s\S]+)$/i]
        trname = $~[1].gsub(/^\s+/,"").gsub(/\s+$/,"")
        push_comment(firstpage.list,command) if rewriteComments
      elsif command[/^BattleID\:\s*(\d+)$/i]
        battleid = $~[1].to_i
        push_comment(firstpage.list,command) if rewriteComments
      elsif command[/^DoubleBattle\:\s*([\s\S]+)$/i]
        value = $~[1].gsub(/^\s+/,"").gsub(/\s+$/,"")
        doublebattle = true if value.upcase=="TRUE" || value.upcase=="YES"
        push_comment(firstpage.list,command) if rewriteComments
      elsif command[/^Backdrop\:\s*([\s\S]+)$/i]
        backdrop = $~[1].gsub(/^\s+/,"").gsub(/\s+$/,"")
        push_comment(firstpage.list,command) if rewriteComments
      elsif command[/^EndSpeech\:\s*([\s\S]+)$/i]
        endspeeches.push($~[1].gsub(/^\s+/,"").gsub(/\s+$/,""))
        push_comment(firstpage.list,command) if rewriteComments
      elsif command[/^Outcome\:\s*(\d+)$/i]
        outcome = $~[1].to_i
        push_comment(firstpage.list,command) if rewriteComments
      elsif command[/^Continue\:\s*([\s\S]+)$/i]
        value = $~[1].gsub(/^\s+/,"").gsub(/\s+$/,"")
        continue = true if value.upcase=="TRUE" || value.upcase=="YES"
        push_comment(firstpage.list,command) if rewriteComments
      elsif command[/^EndBattle\:\s*([\s\S]+)$/i]
        endbattles.push($~[1].gsub(/^\s+/,"").gsub(/\s+$/,""))
        push_comment(firstpage.list,command) if rewriteComments
      elsif command[/^EndIfSwitch\:\s*([\s\S]+)$/i]
        endifswitch.push(($~[1].gsub(/^\s+/,"").gsub(/\s+$/,"")).to_i)
        push_comment(firstpage.list,command) if rewriteComments
      elsif command[/^VanishIfSwitch\:\s*([\s\S]+)$/i]
        vanishifswitch.push(($~[1].gsub(/^\s+/,"").gsub(/\s+$/,"")).to_i)
        push_comment(firstpage.list,command) if rewriteComments
      elsif command[/^RegSpeech\:\s*([\s\S]+)$/i]
        regspeech = $~[1].gsub(/^\s+/,"").gsub(/\s+$/,"")
        push_comment(firstpage.list,command) if rewriteComments
      end
    end
    return nil if battles.length<=0
    # Run trainer check now, except in editor
    trainerChecker.pbTrainerBattleCheck(trtype,trname,battleid)
    # Set the event's charset to one depending on the trainer type if the event
    # doesn't have a charset
    if firstpage.graphic.character_name=="" && GameData::TrainerType.exists?(trtype)
      trainerid = GameData::TrainerType.get(trtype).id
      filename = GameData::TrainerType.charset_filename_brief(trainerid)
      if FileTest.image_exist?("Graphics/Characters/"+filename)
        firstpage.graphic.character_name = sprintf(filename)
      end
    end
    # Create strings that will be used repeatedly
    safetrcombo = sprintf(":%s,\"%s\"",trtype,safequote(trname))   # :YOUNGSTER,"Joey"
    introplay   = sprintf("TrainerIntro2(:%s)",trtype)
    # Write first page
    push_script(firstpage.list,introplay)   # pbTrainerIntro
    push_script(firstpage.list,"pbNoticePlayer(get_character(0))")
    push_text(firstpage.list,battles[0])
    if battles.length>1   # Has rematches
      push_script(firstpage.list,sprintf("pbTrainerCheck(%s,%d,%d)",safetrcombo,battles.length,battleid))
    end
    push_script(firstpage.list,"setBattleRule(\"double\")") if doublebattle
    push_script(firstpage.list,sprintf("setBattleRule(\"backdrop\",\"%s\")",safequote(backdrop))) if backdrop
    push_script(firstpage.list,sprintf("setBattleRule(\"outcomeVar\",%d)",outcome)) if outcome>1
    push_script(firstpage.list,"setBattleRule(\"canLose\")") if continue
    espeech = (endspeeches[0]) ? sprintf("_I(\"%s\")",safequote2(endspeeches[0])) : "nil"
    if battleid>0
      battleString = sprintf("pbTrainerBattle(%s,%s,nil,%d)",safetrcombo,espeech,battleid)
    elsif endspeeches[0]
      battleString = sprintf("pbTrainerBattle(%s,%s)",safetrcombo,espeech)
    else
      battleString = sprintf("pbTrainerBattle(%s)",safetrcombo)
    end
    push_branch(firstpage.list,battleString)
    if battles.length>1   # Has rematches
      push_script(firstpage.list,
         sprintf("pbPhoneRegisterBattle(_I(\"%s\"),get_character(0),%s,%d)",
         regspeech,safetrcombo,battles.length),1)
    end
    push_self_switch(firstpage.list,"A",true,1)
    push_branch_end(firstpage.list,1)
    push_script(firstpage.list,"pbTrainerEnd",0)
    push_end(firstpage.list)
    # Copy first page to last page and make changes to its properties
    lastpage = Marshal::load(Marshal.dump(firstpage))
    lastpage.trigger   = 0   # On action
    lastpage.list      = []   # Clear page's commands
    lastpage.condition = firstpage.condition.clone
    lastpage.condition.self_switch_valid = true
    lastpage.condition.self_switch_ch    = "A"
    # Copy last page to rematch page
    rematchpage = Marshal::load(Marshal.dump(lastpage))
    rematchpage.list      = lastpage.list.clone   # Copy the last page's commands
    rematchpage.condition = lastpage.condition.clone
    rematchpage.condition.self_switch_valid = true
    rematchpage.condition.self_switch_ch    = "B"
    # Write rematch and last pages
    for i in 1...battles.length
      # Run trainer check now, except in editor
      trainerChecker.pbTrainerBattleCheck(trtype,trname,battleid+i)
      if i==battles.length-1
        push_branch(rematchpage.list,sprintf("pbPhoneBattleCount(%s)>=%d",safetrcombo,i))
        push_branch(lastpage.list,sprintf("pbPhoneBattleCount(%s)>%d",safetrcombo,i))
      else
        push_branch(rematchpage.list,sprintf("pbPhoneBattleCount(%s)==%d",safetrcombo,i))
        push_branch(lastpage.list,sprintf("pbPhoneBattleCount(%s)==%d",safetrcombo,i))
      end
      # Rematch page
      push_script(rematchpage.list,introplay,1)   # pbTrainerIntro
      push_text(rematchpage.list,battles[i],1)
      push_script(rematchpage.list,"setBattleRule(\"double\")",1) if doublebattle
      push_script(rematchpage.list,sprintf("setBattleRule(\"backdrop\",%s)",safequote(backdrop)),1) if backdrop
      push_script(rematchpage.list,sprintf("setBattleRule(\"outcomeVar\",%d)",outcome),1) if outcome>1
      push_script(rematchpage.list,"setBattleRule(\"canLose\")",1) if continue
      espeech = nil
      if endspeeches.length>0
        espeech = (endspeeches[i]) ? endspeeches[i] : endspeeches[endspeeches.length-1]
      end
      espeech = (espeech) ? sprintf("_I(\"%s\")",safequote2(espeech)) : "nil"
      battleString = sprintf("pbTrainerBattle(%s,%s,nil,%d)",safetrcombo,espeech,battleid+i)
      push_branch(rematchpage.list,battleString,1)
      push_script(rematchpage.list,sprintf("pbPhoneIncrement(%s,%d)",safetrcombo,battles.length),2)
      push_self_switch(rematchpage.list,"A",true,2)
      push_self_switch(rematchpage.list,"B",false,2)
      push_script(rematchpage.list,"pbTrainerEnd",2)
      push_branch_end(rematchpage.list,2)
      push_exit(rematchpage.list,1)   # Exit Event Processing
      push_branch_end(rematchpage.list,1)
      # Last page
      if endbattles.length>0
        ebattle = (endbattles[i]) ? endbattles[i] : endbattles[endbattles.length-1]
        push_text(lastpage.list,ebattle,1)
      end
      push_script(lastpage.list,
         sprintf("pbPhoneRegisterBattle(_I(\"%s\"),get_character(0),%s,%d)",
         regspeech,safetrcombo,battles.length),1)
      push_exit(lastpage.list,1)   # Exit Event Processing
      push_branch_end(lastpage.list,1)
    end
    # Finish writing rematch page
    push_end(rematchpage.list)
    # Finish writing last page
    ebattle = (endbattles[0]) ? endbattles[0] : "..."
    push_text(lastpage.list,ebattle)
    if battles.length>1
      push_script(lastpage.list,
         sprintf("pbPhoneRegisterBattle(_I(\"%s\"),get_character(0),%s,%d)",
         regspeech,safetrcombo,battles.length))
    end
    push_end(lastpage.list)
    # Add pages to the new event
    if battles.length==1   # Only one battle
      ret.pages = [firstpage,lastpage]
    else   # Has rematches
      ret.pages = [firstpage,rematchpage,lastpage]
    end
    # Copy last page to endIfSwitch page
    for endswitch in endifswitch
      endIfSwitchPage = Marshal::load(Marshal.dump(lastpage))
      endIfSwitchPage.condition = lastpage.condition.clone
      if endIfSwitchPage.condition.switch1_valid   # Add another page condition
        endIfSwitchPage.condition.switch2_valid = true
        endIfSwitchPage.condition.switch2_id    = endswitch
      else
        endIfSwitchPage.condition.switch1_valid = true
        endIfSwitchPage.condition.switch1_id    = endswitch
      end
      endIfSwitchPage.condition.self_switch_valid = false
      endIfSwitchPage.list = []   # Clear page's commands
      ebattle = (endbattles[0]) ? endbattles[0] : "..."
      push_text(endIfSwitchPage.list,ebattle)
      push_end(endIfSwitchPage.list)
      ret.pages.push(endIfSwitchPage)
    end
    # Copy last page to vanishIfSwitch page
    for vanishswitch in vanishifswitch
      vanishIfSwitchPage = Marshal::load(Marshal.dump(lastpage))
      vanishIfSwitchPage.graphic.character_name = ""   # No charset
      vanishIfSwitchPage.condition = lastpage.condition.clone
      if vanishIfSwitchPage.condition.switch1_valid   # Add another page condition
        vanishIfSwitchPage.condition.switch2_valid = true
        vanishIfSwitchPage.condition.switch2_id    = vanishswitch
      else
        vanishIfSwitchPage.condition.switch1_valid = true
        vanishIfSwitchPage.condition.switch1_id    = vanishswitch
      end
      vanishIfSwitchPage.condition.self_switch_valid = false
      vanishIfSwitchPage.list = []   # Clear page's commands
      push_end(vanishIfSwitchPage.list)
      ret.pages.push(vanishIfSwitchPage)
    end
    return ret
  end
end