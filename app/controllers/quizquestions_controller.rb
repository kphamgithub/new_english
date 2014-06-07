class QuizquestionsController < ApplicationController
  def index
	@quizquestions = Quizquestion.all
  end
  
  def take
    #render text: params.inspect
	#{"action"=>"take", "controller"=>"quizquestions", "lesson_id"=>"1", "quiz_id"=>"9", "id"=>"32"}
	@quizquestion = Quizquestion.find(params[:id])
	@source_question = nil
	if @quizquestion.qtype == "Multichoicequestion"
		@source_question = Multichoicequestion.find(@quizquestion.origin_id)
		#render text: "MULTI"
	elsif @quizquestion.qtype == "Fillquestion"
	    #render text: "FILL"
		@source_question = Fillquestion.find(@quizquestion.origin_id)
    elsif @quizquestion.qtype == "Matchquestion"
	    @source_question = Matchquestion.where(@quizquestion.match_id)
		#render text: params.inspect	
	end	
  end
  
  def processquestion
    @quizquestion = Quizquestion.find(params[:id])
	@quiz = Quiz.find(params[:quiz_id])
    #render text: params.inspect
	
	if @quizquestion.qtype == "Multichoicequestion"
		uanswer = params[:choice]
	elsif @quizquestion.qtype == "Fillquestion"
		uanswer = params[:answer]
	elsif @quizquestion.qtype == "Matchquestion"
	    #uanswer = params[:matchquestion].to_s
		uanswer =  params[:matchquestion].to_s		
		#"matchquestion"=>{"answer0"=>"sky", "answer1"=>"tree"},
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
  
  def destroy
    #render text: params.inspect
	# "action"=>"destroy", "controller"=>"quizquestions", "lesson_id"=>"1", "quiz_id"=>"9", "id"=>"27"}

	@quizquestion = Quizquestion.find(params[:id])
	my_quiz = Quiz.find(@quizquestion.quiz_id)
	@quizquestion.destroy
	@quizquestion.save
	redirect_to lesson_quiz_path(my_quiz.lesson,my_quiz)
  end
end


