class QuizquestionsController < ApplicationController
  def index
	@quizquestions = Quizquestion.all
  end
 
  def new
    #render text: params.inspect
	@lesson_id = params[:lesson_id]
	@quiz_id = params[:quiz_id]
	
	  @quiz = Quiz.find(params[:quiz_id])
	  if @quiz.quiz_type == 'vocabulary'
		   voca_quiz = true
	  elsif @quiz.quiz_type == 'grammar'
		   grammar_quiz = true
	  elsif @quiz.quiz_type == 'general'
		   general_quiz = true 
	  end
	  @available_questions = []
        multichoicequestions = Multichoicequestion.all
		multichoicequestions.each do |mcq|
		    #search quiz questions
			found = false
			@quiz.quizquestions.each do |qq|
				if qq.qtype == "Matchquestion" and qq.origin_id == 	  mcq.id
					found = true
					break
				end
			end
			if found == false
			    #if voca_quiz and mcq.vocabulary_id != nil
				    #if mcq.vocabulary_id != nil
					@available_questions.push(mcq)
				#end
			end
	    end	   
	    #render text: @available_questions.count
		
		
		fillquestions = Fillquestion.all
		fillquestions.each do |fq|
		    #search quiz questions
			found = false
			@quiz.quizquestions.each do |qq|
				if qq.qtype == "Matchquestion" and qq.origin_id == 	  fq.id
					found = true
					break
				end
			end
			if found == false
				@available_questions.push(fq)
			end
	    end	   
      #render text: @available_questions.count
	  #render text: @quiz.id
		match_questions = Matchquestion.all
		match_questions.each do |mq|
		    #search quiz questions
			found = false
			@quiz.quizquestions.each do |qq|
				if qq.qtype == "Matchquestion" and qq.origin_id == mq.id
				found = true
				break
				end
			end
			if found == false
				@available_questions.push(mq)
			end
	    end	   

		#@sorted_available_questions = @available_questions.sort_by.reverse do |item|
		##	item[:created_at]
		#end 
		@sorted_available_questions = @available_questions.sort_by(&:created_at).reverse

  end
 
  def take
    #render text: params.inspect
	#{"action"=>"take", "controller"=>"quizquestions", "lesson_id"=>"1", "quiz_id"=>"9", "id"=>"32"}
	@quizquestion = Quizquestion.find(params[:id])
	@source_question = nil
	if @quizquestion.qtype == "Multichoicequestion"
		@source_question = Multichoicequestion.find(@quizquestion.origin_id)
		@choice1_mp3_path = @source_question.choice1.strip
		@choice2_mp3_path = @source_question.choice2.strip
		@choice3_mp3_path = @source_question.choice3.strip
	elsif @quizquestion.qtype == "Fillquestion"
	    #render text: "FILL"
		@source_question = Fillquestion.find(@quizquestion.origin_id)
    elsif @quizquestion.qtype == "Clozequestion"
	    #render text: "FILL"
		@source_question = Clozequestion.find(@quizquestion.origin_id)
        #@people = [{"name"=>"NameA", "id"=>"1"}]
		question = @source_question.question  #"My name is [test,blah] and [foo,bar,been] but his name is [oo]"
	# replace bracketed option text with stars (for splitting purpose only)
	temp = question.gsub( /\[.*?\]/,'*' )  # My name is * and * and *
	array_of_normal_text = temp.split('*')

	array_of_bracketed_strings = question.scan( /\[.*?\]/ )
	# [ [ee], [test,blah], [foo,bar,been], [oo] ]
	
    @joined_array = Array.new
	array_of_normal_text.each_with_index do |arr,index| 
		@joined_array.push(arr)
		if index == (array_of_bracketed_strings.count)
		  break
		else
			@joined_array.push(array_of_bracketed_strings[index])
		end
	end
	
    elsif @quizquestion.qtype == "Matchquestion"
	    @source_question = Matchquestion.find(@quizquestion.origin_id)
		if @source_question.mode == "game"
		    @matches = Match.where("matchquestion_id = ?", @source_question.id)			
		end
		#render text: params.inspect	
	end	
	
	if !@media_path.blank? 
	@media_path = 'voca/' + @source_question.media[0] + '/' + @source_question.media
	end
  end
  
  def processquestion
    #render text: params.inspect
	#{.., "choice"=>"voca/basketball.mp3\r\n", "commit"=>"Submit", "action"=>"processquestion", "controller"=>"quizquestions", "lesson_id"=>"16", "quiz_id"=>"20", "id"=>"22"}
     #params_keys = params.keys  
	  #params format:   user_ID => 1 (selected)
	  #examples         user_1 => 1
	  #         		user_9 => 1
	
	@quizquestion = Quizquestion.find(params[:id])
	#test only
		#origin_id = quizquestion.origin_id
	    #myquestion = Multichoicequestion.find(origin_id)
		#@render text: myquestion.instance_eval('choice1')
		#object.instance_eval('attribute') = 'ololo'
	# end test
		
	#"matches"=>{"answer0"=>"b", "answer1"=>"d"}, 
    #render text: user_answer	
	@quiz = Quiz.find(params[:quiz_id])
	#"matches"=>{"answer0"=>"b", "answer1"=>"d"}, 
	if @quizquestion.qtype == "Multichoicequestion"
		uanswer = params[:choice]
	elsif @quizquestion.qtype == "Fillquestion"
		uanswer = params[:answer]
	elsif @quizquestion.qtype == "Clozequestion"
	  answer_string = ''
	  params.each_with_index do |(key, value), index|
		if (key.include? "answer")
		   answer_string << value
		   answer_string << ','
		end
	  end
	  uanswer = answer_string.chop # chop off the last comma
	elsif @quizquestion.qtype == "Matchquestion"
	#uanswer = params[:matchquestion].to_s
	uanswer =  params[:matches].to_s		
	#"matches"=>{"answer0"=>"sky", "answer1"=>"tree"},
	end
	@user = current_user
	uid = @user.id
	   #@quizquestionresults = Quizquestionresult.where("user_id = ? and quiz_id = ?  and quizquestion_id = ?", uid, @quiz.id, params[:id] )
		qqr = Quizquestionresult.find_by(user_id: uid, quiz_id: @quiz.id, quizquestion_id: params[:id])
		if qqr == nil
			qqr = Quizquestionresult.new(user_id: uid, quiz_id: @quiz.id, quizquestion_id: @quizquestion.id,answer: uanswer)
			qqr.save
	    else
		  qqr.update(quizquestion_id: @quizquestion.id, user_id: uid, quiz_id: @quiz.id, answer: uanswer)
		  qqr.save
	    end
	if @quizquestion.next
	redirect_to take_lesson_quiz_quizquestion_path(@quiz.lesson,@quiz,@quizquestion.next.id)
	else
	  redirect_to user_quiz_quizquestionresults_path(@user,@quiz)
	end
  end

  def create
	  #render text: params.inspect
	  #{"utf8"=>"✓", "authenticity_token"=>"JLjLAD8gA66/lLCvE6JVuwEYlMk+TPyM+ES6e9r/aPk=", "Multichoicequestion_18"=>"1", "commit"=>"Save selection", "method"=>"post", "action"=>"create", "controller"=>"quizquestions", "lesson_id"=>"16", "quiz_id"=>"20"}
	  #@quizquestion = Quizquestion.new(quizquestion_params)
	  #@quizquestion.save
	  #redirect_to quizquestion_path
	  
	  mykeys = params.keys  
	  #params format:   questionTYPE_questionID => 1  (selected)
	  #examples: 		Multichoicequestion_9 => 1
	  # 		        Fillquestion_1 => 1
      lesson_id = params[:lesson_id]
	  quiz_id = params[:quiz_id]
	  mykeys.each do |k|
	   if (k.include? "Multichoicequestion") or (k.include? "Fillquestion") or (k.include? "Matchquestion") or (k.include? "Clozequestion")
	    arr = k.split('_')		
		origin_id = arr[1].to_i
		if k.include? "Multichoicequestion"
		    question_name = Multichoicequestion.find(origin_id)
		elsif  k.include? "Fillquestion"
			question_name = Fillquestion.find(origin_id)
		elsif  k.include? "Clozequestion"
			question_name = Clozequestion.find(origin_id)		
		elsif k.include? "Matchquestion"
		    question_name = Matchquestion.find(origin_id)
		end
		#render text: arr[0]    #type 
		#render text: arr[1]    #id
	   row = {quiz_id: quiz_id,name: question_name.name, origin_id: arr[1],qtype: arr[0] }
	    @quizquestion = Quizquestion.new(row)
		@quizquestion.save
		end
	  end
	  redirect_to lesson_quiz_path(lesson_id, quiz_id)	  
  end
  
  def destroy
    #render text: params.inspect
	# "action"=>"destroy", "controller"=>"quizquestions", "lesson_id"=>"1", "quiz_id"=>"9", "id"=>"27"}

	@quizquestion = Quizquestion.find(params[:id])
	my_quiz = Quiz.find(@quizquestion.quiz_id)
	@quizquestion.destroy
	@quizquestion.save
	redirect_to lesson_quiz_path(my_quiz.lesson,my_quiz)
  end
  private
  def quizquestion_params
	params.require(:quiz).permit(:name, :quiz_id, :origin_id, :qtype)
  end
end

