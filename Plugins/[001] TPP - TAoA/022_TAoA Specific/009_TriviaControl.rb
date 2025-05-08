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

  qarray = (questions).to_a.sample(7)

  qarray.each do |question|
    echoln("Start of loop")
	pbSet(5,question)
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
    pbMessage(_INTL("\\pn recieved {1} Festival Points!\\me[BP Fanfare]\\wtnp[10]",pts))
	pbShowPicture(1,"Quiz/QuizKeine_Neutral.png",0,0,0,100,100,255,0)
    pbShowPicture(2,"Quiz/QuizAyaka_Neutral.png",0,0,0,100,100,255,0)
	pbMessage(_INTL("\\xn[Keine]\\bI'll be here if you decide you want to test your knowledge again!"))
	$game_screen.pictures[1].erase
	$game_screen.pictures[2].erase
  end
end


def pbExplainAnswerIncorrect
  case pbGet(5)
  when :Novice_02
    pbMessage(_INTL("\\xn[Keine]\\bPay close attention to the wording; I specifically said within Youkai Mountain!"))
  when :Novice_03
    pbMessage(_INTL("\\xn[Keine]\\bIf you need a refresher, Mr. Kirisame has a stand right next to this building."))
  when :Novice_08
    pbMessage(_INTL("\\xn[Keine]\\bPerhaps I need to lecture that shrine maiden some more if people forget she's the current shrine maiden..."))
  when :Novice_15
    pbMessage(_INTL("\\xn[Keine]\\bI would certainly love to see these other settlements if they did exist!"))
  when :Intermediate_03
    pbMessage(_INTL("\\xn[Keine]\\bAs a reminder, the Child of Miare is usually named numerically."))
  when :Intermediate_06
    pbMessage(_INTL("\\xn[Keine]\\bThis one may be challenging to remember, as we have been using the Gensokyo Epoch as the standard for nearly the past one-hundred and thirty years."))
  when :Expert_10
    pbMessage(_INTL("\\xn[Keine]\\bIt might seem tempting to just pick a certain answer here, but if you pay close attention to the history books, it will tell you the exact attributed cause."))
  end
end

def pbExplainAnswerCorrect
  case pbGet(5)
  when :Novice_01
    pbMessage(_INTL("\\xn[Keine]\\bThis incident was named after the scarlet fog that covered all of Gensokyo for several days."))
  when :Novice_02
    pbMessage(_INTL("\\xn[Keine]\\bThe Oni used to live on Youkai Mountain, and the Kappa live in Genbu Ravine. Only the Tengu actually populate the interior of the Mountain itself."))
  when :Novice_06
    pbMessage(_INTL("\\xn[Keine]\\bIt is said that the invasion was a lesson by Yukari Yakumo to teach the Youkai to not over-extend their territory."))
  when :Novice_10
    pbMessage(_INTL("\\xn[Keine]\\bFairies may populate the Bamboo Forest in great numbers, but the forest is home primarily to the Earth Rabbits, who have lived there for centuries."))
  when :Novice_14
    pbMessage(_INTL("\\xn[Keine]\\bWhile some traditions of the religion are observed in small sects within Gensokyo, Christianity as a whole is not considered one of the primary religions of the realm."))
  when :Intermediate_04
    pbMessage(_INTL("\\xn[Keine]\\bAll three of these are indeed relics of the Hakurei Shrine, only the Hakurei Yin-Yang Orb is defined as its sacred treasure, as it is said that the unknown deity of the Shrine manifests its power through it."))
  when :Intermediate_07
    pbMessage(_INTL("\\xn[Keine]\\bThis one was a trick question, as the Love Sign-type Spell Card is usually reserved for Marisa's signature attack, the Master Spark. Final Spark, however, is classified as Magicannon-type."))
  when :Expert_01
    pbMessage(_INTL("\\xn[Keine]\\bThe direction you started counting from mattered little, as you would have landed on the Heaven trigram regardless."))
  when :Expert_05
    pbMessage(_INTL("\\xn[Keine]\\bWe have very few accounts of the Lunar Capital from those who went to it in-person, as such we know very little about it. Let us hope we never have a reason to learn how threatening they are!"))
  when :Expert_06
    pbMessage(_INTL("\\xn[Keine]\\bIn the original draft for the Spell Card Rule, it clearly states that it was to reject a system wherein the strongest have the right to rule."))
  when :Expert_07
    pbMessage(_INTL("\\xn[Keine]\\bFun fact! The combined name for the landmass that the Kanto and Johto Regions occupy is known as the \"Tohjo Continent\"."))
  when :Expert_10
    pbMessage(_INTL("\\xn[Keine]\\bThough the Great Tohjo War was going on at the time, it was not the reason why the Gensokyo Edict was drafted up. This was a result of the Youkai raid on Brass Tower, as well as Humans advancing in technology and losing their fear of Youkai and belief of Gods."))
  end
end