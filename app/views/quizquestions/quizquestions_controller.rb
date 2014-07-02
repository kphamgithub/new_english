class QuizquestionsController < ApplicationController
  def index
	@quizquestions = Quizquestion.all
  end
 
  def new
        #render text: params.inspect
	@lesson_id = params[:lesson_id]
	@quiz_id = params[:quiz_id]
  end
 
  def take
    #render text: params.inspect
	#{"action"=>"take", "controller"=>"quizquestions", "lesson_id"=>"1", "quiz_id"=>"9", "id"=>"32"}
	@quizquestion = Quizquestion.find(params[:id])
	@source_question = nil
	if @quizquestion.qtype == "Multichoicequestion"
		@source_question = Multichoicequestion.find(@quizquestion.origin_id)
		#render text: "MULTI"
		@choice1_media_dir = "voca/"+ @source_question.choice1[0] + '/'
		@choice2_media_dir = "voca/"+ @source_question.choice2[0] + '/'
		@choice3_media_dir = "voca/"+ @source_question.choice3[0] + '/'
	elsif @quizquestion.qtype == "Fillquestion"
	    #render text: "FILL"
		@source_question = Fillquestion.find(@quizquestion.origin_id)
    elsif @quizquestion.qtype == "Matchquestion"
	    @source_question = Matchquestion.find(@quizquestion.origin_id)
		#render text: params.inspect	
	end	
	@media_path = 'voca/' + @source_question.media[0] + '/' + @source_question.media
  end
  
  def processquestion
    @quizquestion = Quizquestion.find(params[:id])
	@quiz = Quiz.find(params[:quiz_id])
    #render text: params.inspect
	#"matches"=>{"answer0"=>"b", "answer1"=>"d"}, 
	if @quizquestion.qtype == "Multichoicequestion"
		uanswer = params[:choice]
	elsif @quizquestion.qtype == "Fillquestion"
		uanswer = params[:answer]
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
	  #render text: quiz_params.inspect
	  @quizquestion = Quizquestion.new(quizquestion_params)
	  @quizquestion.save
	  redirect_to quizquestion_path
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

