class QuizquestionresultsController < ApplicationController
  def index
     render text: params.inspect
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
		    clozequestion = quizquestion.clozequestion
			array_of_normal_text = Array.new
			@array_of_arrays_of_answer_keys = Array.new
			@array_of_arrays_of_correct_sentence = Array.new
			@array_of_arrays_of_bracketed_strings = Array.new
			
			user_answer_array = Array.new
            user_answers = qqr.answer.split(',')
			# ['kitchen-mouse', 'animal']
            array_of_normal_text.each_with_index do |arr,index|
				user_answer_array.push(arr)
				if index == (user_answers.count)
                    break
                else
                    uanswer = user_answers[index].strip
                    key = answer_keys_array[index].strip
                    #if user_answers[index].to_s == answer_keys_array[index]
                    if key == uanswer
                       user_answer_array.push(uanswer << '*')
                    else
                       user_answer_array.push(uanswer << '@')
                    end
                end
            end

			
=begin
			clozequestion.question_clozequestions.each do |my_question|
			   	@array_of_arrays_of_bracketed_strings.push(my_question.question.scan( /\[.*?\]/ ))
				array_of_answer_keys = my_question.answer.split(',')
				@array_of_arrays_of_answer_keys.push(array_of_answer_keys)	
				temp = my_question.question.gsub( /\[.*?\]/,'*' )  
				# My name is * and * and *
				array_of_normal_text = temp.split('*')
				
				@array_of_arrays_of_normal_text.push(array_of_normal_text)
				
				correct_sentence_array = Array.new
                array_of_normal_text.each_with_index do |arr,index|
					correct_sentence_array.push(arr)
					if index == (array_of_answer_keys.count)
						break
					else
						answer_key = array_of_answer_keys[index] + '*'
						correct_sentence_array.push(answer_key)
					end
                end				
				@array_of_arrays_of_correct_sentence.push(correct_sentence_array)
				
				
				user_answer_array = Array.new
                user_answers = qqr.answer.split(',')
                array_of_normal_text.each_with_index do |arr,index|
					user_answer_array.push(arr)
					if index == (user_answers.count)
                        break
                    else
                        uanswer = user_answers[index].strip
                        key = answer_keys_array[index].strip
                        #if user_answers[index].to_s == answer_keys_array[index]
                        if key == uanswer
                           user_answer_array.push(uanswer << '*')
                        else
                           user_answer_array.push(uanswer << '@')
                        end
                    end
                end
				
			end
=end	
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
