class QuizpagesController < ApplicationController
  def index
  end

  def new
     #render text: params.inspect
	 @quiz_id = params[:quiz_id]
	 @quiz_page = Quizpage.new
	 @question_type = params[:question_type]
	 @lesson_id = params[:lesson_id]
	 #@lesson = Lesson.find(params[:lesson_id])
	 #@quiz = Quiz.find(params[:quiz_id])
	 if @question_type == 'clozequestion'
		2.times {@quiz_page.question_clozequestions.build}
	 elsif @question_type == 'matchquestion'
	    3.times {@quiz_page.question_matchquestions.build}
	 elsif @question_type == 'multichoicequestion'
	    1.times {@quiz_page.question_multichoicequestions.build}
	 end
  end
  
  def create
	 #render text: params.inspect

#{"utf8"=>"✓", "authenticity_token"=>"V4cihIN2JaMs5c0n0Rn6oov2CEWbRWO+V4X4OAtnjTI=", "quizpage"=>{"question_type"=>"matchquestion", "name"=>"eee", "instruction"=>"", "question_matchquestions_attributes"=>{"0"=>{"question"=>"a", "answer"=>"a"}, "1"=>{"question"=>"b", "answer"=>"b"}}}, "quiz"=>{"id"=>"21"}, "commit"=>"Create Quizpage", "action"=>"create", "controller"=>"quizpages", "lesson_id"=>"16", "quiz_id"=>"21"}
	  quizpage = Quizpage.new(quizpage_params)
	  if params['add_to_quiz'] != nil
		 quizpage.quiz_id = params[:quiz_id]
	  end
	  quizpage.save	  
	  redirect_to welcome_index_path
  end
    
  def take
	 #render text: params.inspect
	 @quizpage = Quizpage.find(params[:id])
	 if @quizpage.question_type == 'clozequestion'
	     @hash_of_joined_arrays = take_cloze_question
	 elsif
		@quizpage.question_type == 'matchquestion'
		take_match_question
	 end
=begin
	 @quizpage = Quizpage.find(params[:id]) 
	 @hash_of_joined_arrays = Hash.new
	 @quizpage.question_clozequestions.each do |my_question|
		temp = my_question.question.gsub( /\[.*?\]/,'*' )  # My name is * and * and *
		array_of_normal_text = temp.split('*')
		array_of_bracketed_strings = my_question.question.scan( /\[.*?\]/ )
		# [ [ee], [test,blah], [foo,bar,been], [oo] ]
		joined_array = Array.new
		array_of_normal_text.each_with_index do |arr,index|
			joined_array.push(arr)
			if index == (array_of_bracketed_strings.count)
				break
			else
				joined_array.push(array_of_bracketed_strings[index])
			end
		end		
		@hash_of_joined_arrays[my_question.id] = joined_array
	end
	#render text: @hash_of_joined_arrays.inspect
	#{9=>["a monkey is an ", "[animal, vehicle, tool]", " and lives in the ", "[jungle, house, school]"], 10=>["5 reads ", "[five, six, seven]"]}
=end
  end

  
  def take_match_question

  end
  
  def processpage
      #render text: params.inspect
	  quiz_id = params[:quiz_id]
	  quiz = Quiz.find(quiz_id)
	  quizpage = Quizpage.find(params[:id])
	  answer_params_hash = Hash.new
	if quizpage.question_type == 'clozequestion'
	  	  params.each do |key, value|
			if (key.include? "answer")
			   answer_params_hash[key] = value
			end
		  end
		  #answer_params_hash is now: { "answer_9_1"=>" tool", "answer_9_3"=>"jungle", "answer_10_1"=>" six" } where 9 and 10 are question_clozequestion ids
	  
		  #let's create a new hash that contains: { "9"=>" tool, jungle","10"=>" six" } to easily store the key/value pairs into quizquestionresults dbase rows
    elsif quizpage.question_type == 'matchquestion'
	  	  params[:matches].each do |key, value|
			if (key.include? "answer")
			   answer_params_hash[key] = value
			end
		  end
    elsif quizpage.question_type == 'multichoicequestion'
	#{..."1_choice"=>"b", "commit"=>"Submit", "action"=>"processpage", "controller"=>"quizpages", "lesson_id"=>"16", "quiz_id"=>"27", "id"=>"13"}
	    #render text: params.inspect
		#1_answer  (1 = question id)
	  	  params.each do |key, value|
			if (key.include? "answer")
			   answer_params_hash[key] = value
			end
		end		
    end

	saved_id = nil
	answer_str = ''
	question_results_hash = Hash.new  
	#render text: answer_params_hash.inspect
	#key=question id,#value=string of commas separated answers
 
	answer_params_hash.each_with_index do |(key, value), index|
		   temp_arr = key.split('_')
		   cloze_question_id = temp_arr[1].to_i	
		   if index == 0 || cloze_question_id == saved_id   # first time thru loop OR answer param has same   id as previous param
			  if index == 0
			    answer_str << value
			  else
				answer_str << ','
				answer_str << value
			  end
		   end
		   if (index > 0) # not at begin of loop
				if cloze_question_id != saved_id
		          question_results_hash[saved_id] = answer_str
				  answer_str = ''   #empty answer string 
				  answer_str << value
				end
			end
			saved_id = cloze_question_id
			if index == answer_params_hash.length - 1
		       #last answer params
			   question_results_hash[saved_id] = answer_str
		    end			
	  end  # each answer_params_hash
		@user = current_user
		question_results_hash.each do |key, value|
			qqr = Quizquestionresult.find_by(user_id: @user.id, quiz_id: params[:quiz_id], question_id: key, question_type: quizpage.question_type)
		    if qqr == nil
				qqr = Quizquestionresult.new(user_id: @user.id, quiz_id: params[:quiz_id], question_id: key,answer: value, question_type: quizpage.question_type)
				qqr.save
			else
				qqr.update(user_id: @user.id, quiz_id: params[:quiz_id], answer: answer_str)
				qqr.save
			end
        end
		
		if quizpage.next
			redirect_to take_lesson_quiz_quizpage_path(quiz.lesson,quiz, quizpage.next.id)
		else
			redirect_to user_quiz_quizquestionresults_path(@user,quiz)
		end

  end
  
  def add_clozequestion
	
  end
  
  
  def take_cloze_question
	quizpage = Quizpage.find(params[:id]) 
	hash_of_joined_arrays = Hash.new
	quizpage.question_clozequestions.each do |my_question|
		temp = my_question.question.gsub( /\[.*?\]/,'*' )  # My name is * and * and *
		array_of_normal_text = temp.split('*')
		array_of_bracketed_strings = my_question.question.scan( /\[.*?\]/ )
		# [ [ee], [test,blah], [foo,bar,been], [oo] ]
		joined_array = Array.new
		array_of_normal_text.each_with_index do |arr,index|
			joined_array.push(arr)
			if index == (array_of_bracketed_strings.count)
				break
			else
				joined_array.push(array_of_bracketed_strings[index])
			end
		end		
		hash_of_joined_arrays[my_question.id] = joined_array
	end
	return hash_of_joined_arrays
  end

  private
  def quizpage_params
  params.require(:quizpage).permit(:name, :instruction,:quiz_id,:question_type, question_clozequestions_attributes: [:id,:question],question_matchquestions_attributes: [:id,:question, :answer],question_multichoicequestions_attributes: [:id, :question, :choice1, :choice2, :choice3] )
  end

end
