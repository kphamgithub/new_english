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
		    #render text: params.inspect
			results_hash["qtype"] = "Matchquestion"
		    user_answer_hash = eval(qqr.answer)
			questions = Matchquestion.where("match_id = ?",quizquestion.match_id)
			
			matches = []
			questions.each_with_index do |question,index|
			   #save all answer keys in an array
			   #key = question.left + ' ' + question.right 
			   matches.push(question.left)   #left = match,  #right = answer
			end
			
			answer_keys = []
			questions.each_with_index do |question,index|
			   #save all answer keys in an array
			   #key = question.left + ' ' + question.right 
			   answer_keys.push(question.right)   #left = match,  #right = answer
			end
			user_answers = []
			s = ' '
			user_answer_hash.each_with_index do |(key, val),index|
				user_answers.push(val)
			end
			
			myresults = []
			user_answers.each_with_index do |ans,index|			    
				if ans == answer_keys[index]
					myresults.push("correct")
				else
				    myresults.push("incorrect")
				end
			end
			results_hash["matches"] =  matches
			results_hash["user_answers"] =  user_answers
			results_hash["answer_keys"] = answer_keys
			results_hash["my_results"] =  myresults
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
