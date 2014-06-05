class QuizquestionresultsController < ApplicationController
  def index
     #render text: params.inspect
	 #{"action"=>"index", "controller"=>"quizquestionresults", "user_id"=>"2", "quiz_id"=>"9"}
	 
	 @user = User.find(params[:user_id])
	 @quiz = Quiz.find(params[:quiz_id])
	 #@quizquestions = @quiz.quizquestions
	 #quizquestions.each do |qq|
		#origin_id = qq.origin_id
	 #end
	 @results_arr = Array.new
	 results_hash = Hash.new
	 @quizquestionresults = Quizquestionresult.where("user_id = ? and quiz_id = ?", params[:user_id], params[:quiz_id] )
	@quizquestionresults.each do |qqr|
		quizquestion = qqr.quizquestion
		origin_id = quizquestion.origin_id
		question_type = quizquestion.qtype
		question = nil
		results_hash = Hash.new
		if question_type == "Multichoicequestion"
		    results_hash["qtype"] = "Multichoicequestion"
		    question = Multichoicequestion.find(origin_id)
			results_hash[:key] = question.answer
			results_hash[:user_answer] = qqr.answer
			if question.answer == qqr.answer
			   results_hash[:status] = "correct"
			else
			   results_hash[:status] = "incorrect"
			end
		elsif question_type == "Fillquestion"
			results_hash["qtype"] = "Fillquestion"
		    question = Fillquestion.find(origin_id)
			results_hash[:key] = question.answer
			results_hash[:user_answer] = qqr.answer
			if question.answer == qqr.answer
			   results_hash[:status] = "correct"
			else
			   results_hash[:status] = "incorrect"
			end
			#@results_arr.push(results_hash)
		elsif question_type == "Matchquestion"
			results_hash["qtype"] = "Matchquestion"
		    user_answer_hash = eval(qqr.answer)
			questions = Matchquestion.where("match_id = ?",quizquestion.match_id)
			answer_keys = []
			questions.each_with_index do |question,index|
			   #save all answer keys in an array
			   key = question.left + ' ' + question.right 
			   answer_keys.push(key)
			end
			user_answers = []
			s = ' '
			user_answer_hash.each_with_index do |(key, val),index|
			   remainder = index%2
			   if remainder == 0
			       s = val
				   s << ' '
			   else
			       s << val
				   user_answers.push(s)
				   s = ' '
			   end 
			end
			results_hash["user_answers"] = user_answers
			results_hash["answer_keys"] = answer_keys
			#@results_arr.push(results_hash)
		end		
		@results_arr.push(results_hash)
	end	
  end
  
  def destroy
	 #@quizquestionresults = Quizquestionresult.where("user_id = ? and quiz_id = ?", params[:user_id], params[:quiz_id] )
	 @user = User.find(params[:user_id])
	 @quiz = Quiz.find(params[:quiz_id])
	 
	  @quizquestionresult = Quizquestionresult.find(params[:id])
	  @quizquestionresult.destroy
	  redirect_to user_quiz_quizquestionresults_path
  end  
end
