class QuizquestionresultsController < ApplicationController
  def index
     #render text: params.inspect
	 #{"action"=>"index", "controller"=>"quizquestionresults", "user_id"=>"2", "quiz_id"=>"9"}
	 
	 @user = User.find(params[:user_id])
	 @quiz = Quiz.find(params[:quiz_id])
	 @results_arr = Array.new
	 results_hash = Hash.new
	 @quizquestionresults = Quizquestionresult.where("user_id = ? and quiz_id = ?", params[:user_id], params[:quiz_id] )
	 @quizquestionresults.each do |qqr|
		quizquestion = Quizquestion.find(qqr.quizquestion_id)
		#origin_id = quizquestion.origin_id
		#question_type = quizquestion.qtype
		question = nil
		results_hash = Hash.new
		if quizquestion.qtype == "Multichoicequestion"
		    results_hash["qtype"] = "Multichoicequestion"
		    question = quizquestion.multichoicequestion
			correct_answer = question.instance_eval(question.answer)
			results_hash[:key] = correct_answer
			results_hash[:user_answer] = qqr.answ						
			#if question.answer == qqr.answer
			if correct_answer == qqr.answer
			   results_hash[:status] = "correct"
			else
			   results_hash[:status] = "incorrect"
			end
		elsif quizquestion.qtype == "Fillquestion"
			results_hash["qtype"] = "Fillquestion"
		    question = quizquestion.fillquestion
			results_hash[:key] = question.answer
			results_hash[:user_answer] = qqr.answer
			if question.answer == qqr.answer
			   results_hash[:status] = "correct"
			else
			   results_hash[:status] = "incorrect"
			end
			#@results_arr.push(results_hash)			
		elsif quizquestion.qtype == "Clozequestion"
		    results_hash["qtype"] = "Clozequestion"
		    clozequestion = Clozequestion.find(quizquestion.clozequestion_id)
			array_of_bracketed_strings = clozequestion.question.scan( /\[.*?\]/ )
	        # [ [ee], [test,blah], [foo,bar,been], [oo] ]
			@number_of_inputs = array_of_bracketed_strings.count
			answer_keys_array = Array.new
			
			array_of_bracketed_strings.each do |bracketed_strings|
			    # bracketed_strings = "[ee]"
				# bracketed_strings = "[test,blah]"
				# removes brackets
				non_bracketed_strs = bracketed_strings.gsub(/[\[\]]/, '')             
				# split strs_in_bracket into an array
				
				array_of_strings_in_a_pair_of_brackets = non_bracketed_strs.strip.split(",")
				# array_of_strings_in_a_pair_of_brackets[0] is the answer key
				answer_keys_array.push(array_of_strings_in_a_pair_of_brackets[0])		
				
				results_hash[:correct_answer] = array_of_strings_in_a_pair_of_brackets
				results_hash[:user_answer] = "test"
			end
			
		elsif quizquestion.qtype == "Matchquestion"
		    #render text: params.inspect
			results_hash["qtype"] = "Matchquestion"
		    user_answer_hash = eval(qqr.answer)
			question = quizquestion.matchquestion
			matches = []
			question.matches.each do |match,index|
			   #save all answer keys in an array
			   #key = question.left + ' ' + question.right 
			   matches.push(match.match)   #left = match,  #right = answer
			end
			
			if question.mode != 'game'
				user_answers = []
				user_answer_hash.each_with_index do |(key, val),index|
					user_answers.push(val)
				end
			
				answer_keys = []
				question.matches.each do |match,index|
				   #save all answer keys in an array
				   #key = question.left + ' ' + question.right 
				   answer_keys.push(match.answer)   #left = match,  #right = answer
				end
				
				myresults = []
				user_answers.each_with_index do |ans,index|			    
					if ans == answer_keys[index]
						myresults.push("correct")
					else
						myresults.push("incorrect")
					end
				end
				results_hash["mode"] = "exercise"
				results_hash["matches"] =  matches
				results_hash["user_answers"] =  user_answers
				results_hash["answer_keys"] = answer_keys
				results_hash["my_results"] =  myresults
			else
			    results_hash["mode"] = "game"
			    results_hash["matches"] =  matches
			end
		end		
		@results_arr.push(results_hash)
	end	
  end
  
  def show
	 @user = User.find(params[:user_id])
	 @quiz = Quiz.find(params[:quiz_id])  
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
