def pbQuizShow
  pbSet(1,0)
  pbSet(2,0)
  questions = []
  pts = 0
  case pbGet(4)
  when 1
	questions = [
	  :Novice_01, :Novice_02, :Novice_03, :Novice_04, :Novice_05, 
      :Novice_06, :Novice_07, :Novice_08, :Novice_09, :Novice_10,
      :Novice_11, :Novice_12, :Novice_13, :Novice_14, :Novice_15]
  when 2
	questions = [
	  :Intermediate_01, :Intermediate_02, :Intermediate_03, :Intermediate_04, :Intermediate_05, 
      :Intermediate_06, :Intermediate_07, :Intermediate_08, :Intermediate_09, :Intermediate_10,
	  :Intermediate_11, :Intermediate_12, :Intermediate_13, :Intermediate_14, :Intermediate_15]
  when 3
    questions = [
	  :Expert_01, :Expert_02, :Expert_03, :Expert_04, :Expert_05, 
      :Expert_06, :Expert_07, :Expert_08, :Expert_09, :Expert_10,
      :Expert_11, :Expert_12, :Expert_13, :Expert_14, :Expert_15]
  end

  qarray = (questions).to_a.sample(5)

  qarray.each do |question|
    echoln("Start of loop")
	pbShowPicture(1,"Quiz/QuizKeine_Neutral.png",0,0,0,100,100,255,0)
    pbShowPicture(2,"Quiz/QuizAyaka_Neutral.png",0,0,0,100,100,255,0)
    echoln("Portraits displayed")
	anTriviaQuestion(question)
	echoln("Question Answered")
	if pbGet(2) >= pbGet(3)
	  echoln("Incorrect questions reached")
	  pbShowPicture(1,"Quiz/QuizKeine_Dejected.png",0,0,0,100,100,255,0)
	  pbMessage(_INTL("\\xn[Keine]\\bI'm afraid I cannot allow this to go on any longer, \\pn."))
	  pbMessage(_INTL("\\xn[Keine]\\bYou've answered too many questions incorrectly."))
	  pbMessage(_INTL("\\xn[Keine]\\bPlease come back after you've studied more!"))
	  $game_screen.pictures[1].erase
	  $game_screen.pictures[2].erase
	  break
	end
  end
  if pbGet(2) < pbGet(3)
    echoln("End of Quiz")
	pbShowPicture(1,"Quiz/QuizKeine_Happy.png",0,0,0,100,100,255,0)
	pbShowPicture(2,"Quiz/QuizAyaka_Happy.png",0,0,0,100,100,255,0)
    pbMessage(_INTL("\\xn[Keine]\\bCongratulations on passing, \\pn! I knew you had it in you!"))
    pbMessage(_INTL("\\xn[Keine]\\bFor clearing this quiz, I award you with these Festival Points."))
    pts = pbGet(1) * 2   # Correct questions, max of 10 points
    pts = pts * pbGet(4) # Selected difficulty. Novice - 1x, Interm. - 2x, Expert - 3x.
    $player.battle_points += pts
    pbMessage(_INTL("\\pn recieved {1} Festival Points!\\me[BP Fanfare]",pts))
	pbShowPicture(1,"Quiz/QuizKeine_Neutral.png",0,0,0,100,100,255,0)
    pbShowPicture(2,"Quiz/QuizAyaka_Neutral.png",0,0,0,100,100,255,0)
	pbMessage(_INTL("\\xn[Keine]\\bI'll be here if you decide you want to test your knowledge again!"))
	$game_screen.pictures[1].erase
	$game_screen.pictures[2].erase
  end
end
