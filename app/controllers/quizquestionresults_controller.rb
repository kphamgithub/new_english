class QuizquestionresultsController < ApplicationController
  def index
     #render text: params.inspect
	 #{"action"=>"index", "controller"=>"quizquestionresults", "user_id"=>"2", "quiz_id"=>"9"}
	@user = User.find(params[:user_id])
	@quiz = Quiz.find(params[:quiz_id])
	results_hash = Hash.new
	@answer_str = ''
	results_hash["qtype"] = "Clozequestion"
	@my_results = Hash.new
	
	quizquestionresults = Quizquestionresult.where("user_id = ? and quiz_id = ?", params[:user_id], params[:quiz_id])
	quizquestionresults.each do |qqr|
		if qqr.question_type == 'clozequestion'
			clozequestion = QuestionClozequestion.find(qqr.question_id)
			temp = clozequestion.question.gsub( /\[.*?\]/,'*' )  
			# A tiger is an * and a house is an *
			array_of_normal_text = temp.split('*')
			@array_of_answer_keys = Array.new
			#@array_of_arrays_of_correct_sentence = Array.new
			#@array_of_arrays_of_bracketed_strings = Array.new
			user_answer_array = Array.new
			user_answers = qqr.answer.split(',')
			answer_string = get_clozequestion_answer_string(clozequestion.question)
			answer_keys_array = answer_string.split(',')
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
			end  #each
			temp_str = qqr.id.to_s + '_' + 'user_answer'
			#temp_str = 'user_answer'
			@my_results[temp_str] = user_answer_array
		
			correct_answer_array = Array.new
			#answer_keys_array = clozequestion.answer.split(',')
			array_of_normal_text.each_with_index do |arr,index|
				correct_answer_array.push(arr)
				if index == (answer_keys_array.count)
                    break
                else
                    correct_answer = answer_keys_array[index].strip
                    correct_answer_array.push(correct_answer << '*')
                end
			end  #each
			temp_str = qqr.id.to_s + '_' + 'correct_answer'
			#temp_str = 'correct_answer'
			@my_results[temp_str] = correct_answer_array
		elsif qqr.question_type == 'matchquestion'
			matchquestion = QuestionMatchquestion.find(qqr.question_id)
			@my_results[qqr.id.to_s + '_' + 'user_answer'] = matchquestion.question + ' ' + qqr.answer
			@my_results[qqr.id.to_s + '_' + 'correct_answer'] = matchquestion.question + ' ' + matchquestion.answer
		elsif qqr.question_type == 'multichoicequestion'
			multichoicequestion = QuestionMultichoicequestion.find(qqr.question_id)			
			@my_results[multichoicequestion.id.to_s + '_' + 'user_answer'] = multichoicequestion.question + ' ' + qqr.answer
			@my_results[multichoicequestion.id.to_s  + '_' + 'correct_answer'] = multichoicequestion.question + ' ' + multichoicequestion.answer
		end  #if 
	end  #each quizquestionresult
  end  #method
  
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
  
    def get_clozequestion_answer_string(question)
     array_of_bracketed_strings = question.scan( /\[.*?\]/ )
	  #array_of_bracketed_strings will contain the strings: "[animals, vehicles, tools]" and "[vehicles, toys, buildings]"
	  
	  array_of_strings_without_brackets = Array.new
	  array_of_bracketed_strings.each do |string| 
	      array_of_strings_without_brackets.push(strip_brackets_from_string(string))
	  end
	  
	  answers_array = Array.new
	  array_of_strings_without_brackets.each do |string| 
		 if string.index(',') == nil   # there is only one choice string ( text field input)
			answers_array.push(string)	
		 else   # many choices, dropdown box
		    option_array = string.split(',')
		    answers_array.push(option_array[0])	
		 end
	  end
	  answers_string = ''
	  answers_array.each_with_index do |string,index|
	    answers_string << string
		if index < (answers_array.count-1)
			answers_string << ','
		end
	  end
	  return answers_string
  end  # function get_answer_string

  def strip_brackets_from_string(string)
	str1 = string.chop # chops off the last character from string and returns a new string
	str1.slice!(0) # slice() remove the closing square bracket from str1
	return str1
  end #function strip_brackets_from_string
end
