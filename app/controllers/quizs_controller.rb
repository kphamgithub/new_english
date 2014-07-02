class QuizsController < ApplicationController
  def index
     #render text: params.inspect
	 #{"action"=>"index", "controller"=>"quizs", "lesson_id"=>"2"}
     #@quizs = Quiz.all
	 @quizs = Quiz.where("lesson_id = ?", params[:lesson_id])
  end
  def new 
	 @lesson = Lesson.find(params[:lesson_id])
	 #@quiz = Quiz.new(:lesson=>@lesson)
	 @quiz = Quiz.new
  end
  def show
	@quiz = Quiz.find(params[:id])
  end
  def create
	  #render text: quiz_params.inspect
	  @quiz = Quiz.new(quiz_params)
	  @quiz.save
	  redirect_to lesson_quiz_path(@quiz.lesson,@quiz)
  end

  def take_quiz
	  #render text: params.inspect
	  @quiz = Quiz.find(params[:id])
	  #@quiz = Quiz.find(params[:lesson_id])
	  #@user = current_user
	  #render text: @quiz.quizquestions.first.qtype
	  redirect_to take_lesson_quiz_quizquestion_path(@quiz.lesson,@quiz,@quiz.quizquestions.first)
	  #@quizquestion = @quiz.quizquestions.first
	  #render text: @quizquestion.id
	  #render text: @quizquestion.next.id
	  #render text: @quizquestion.qtype
	  #if @quizquestion.qtype == "Fillquestion"
		 
	  #end
		#	redirect_to take_fillquestion_path(@quizquestion.origin_id)
		#elsif @quizquestion.qtype == "Multichoicequestion"
		#	redirect_to take_multichoicequestion_path(@quizquestion.origin_id)
  end
  
  def destroy
	  #render text: params[:id].inspect
      @quiz = Quiz.find(params[:id])
	  @quiz.destroy
	  redirect_to lesson_quizs_path
  end
  
  def list_questionresults
     #render text: params.inspect
	 @user = User.find(params[:user_id])
	 @quiz = Quiz.find(params[:id])
	 @quizquestionresults = Quizquestionresult.where("user_id = ? and quiz_id = ?", params[:user_id], params[:id] )

  end

  def delete_questionresults
     #render text: params.inspect
	 #{"utf8"=>"✓", "authenticity_token"=>"bX0gY+HVOMRksdgzieoBe3T3BjurJwvp/2owxnE6N0Q=", "delete_4"=>"1", "delete_5"=>"1", "commit"=>"Delete selection", "method"=>"delete", "action"=>"delete_questionresults", "controller"=>"quizs", "user_id"=>"3", "id"=>"9"}
	  @user = User.find(params[:user_id])
	  @quiz = Quiz.find(params[:id])
	  #find the question results that are selected for deletion
	  mykeys = params.keys  
	  mykeys.each do |k|
	   if (k.include? "delete")
	    arr = k.split('_')		
		# arr[0]    #the word 'delete' 
		# arr[1]    #id
		quizquestionresult = Quizquestionresult.find(arr[1])
		quizquestionresult.destroy
		quizquestionresult.save
		end
	  end
	  redirect_to list_questionresults_user_quiz_path

	 #@quizquestionresults = Quizquestionresult.where("user_id = ? and quiz_id = ?", params[:user_id], params[:id] )
	 #render text: @quizquestionresults.count
  end

  def add_questions
        #render text: params.inspect  
		# "lesson_id"=>"16", "id"=>"14"
		@lesson = Lesson.find(params[:lesson_id])
		@quiz = Quiz.find(params[:id])
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
				@available_questions.push(mcq)
			end
	    end	   

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
	end
    
    def add_questions_error
    end
  
  def save_questions
      #error = false
	  @quiz = Quiz.find(params[:id])
	  #render text: params.inspect
	  mykeys = params.keys  
	  #params format:   questionTYPE_questionID => 1  (selected)
	  #examples: 		Multichoicequestion_9 => 1
	  # 		        Fillquestion_1 => 1
		 
	  mykeys.each do |k|
	   if (k.include? "Multichoicequestion") or (k.include? "Fillquestion") or (k.include? "Matchquestion")
	    arr = k.split('_')		
		origin_id = arr[1].to_i
		if k.include? "Multichoicequestion"
		    question_name = Multichoicequestion.find(origin_id)
		elsif  k.include? "Fillquestion"
			question_name = Multichoicequestion.find(origin_id)
		elsif k.include? "Matchquestion"
		    question_name = Multichoicequestion.find(origin_id)
		end
		#render text: arr[0]    #type 
		#render text: arr[1]    #id
	   row = {quiz_id: params[:id],name: question_name.name, origin_id: arr[1],qtype: arr[0] }
	    @quizquestion = Quizquestion.new(row)
		@quizquestion.save
		end
	  end
	  redirect_to lesson_quiz_path

  end
  
  private
  def quiz_params
	params.require(:quiz).permit(:name, :lesson_id)
  end
end
