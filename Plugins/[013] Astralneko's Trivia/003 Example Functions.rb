# Asks num_questions questions whose ids are root_idX where root_id is root_id below, and X is a number
# As there is no way for the script to know how many there are, max_id is required
# Lightning Rounds should be 1-indexed, see the default_trivia.txt that came with this plugin for details
# Returns the number of questions the player got right
def anLightningRound(root_id, num_questions = 3, max_id = 5)
	questions_to_choose = []
	while questions_to_choose.length < num_questions
		ret = rand(num_questions) + 1
		questions_to_choose.push(ret) if !questions_to_choose.include?(ret)
	end
	score = 0
	for q in questions_to_choose
		true_id = root_id + q.to_s
		score += anTriviaQuestion(true_id) ? 1 : 0
	end
	return score
end