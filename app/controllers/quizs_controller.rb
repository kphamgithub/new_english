class QuizsController < ApplicationController
  def index
     #render text: params.inspect
	 #{"action"=>"index", "controller"=>"quizs", "lesson_id"=>"2"}
     #@quizs = Quiz.all
	 @quizs = Quiz.where("lesson_id = ?", params[:lesson_id])
	 @lesson = Lesson.find(params[:lesson_id])
  end
  def new 
	 @lesson = Lesson.find(params[:lesson_id])
	 qs = @lesson.quizzes
	 @quiz_number = (qs.count + 1).to_s
	 @quiz = Quiz.new
  end
  def show
	@quiz = Quiz.find(params[:id])
	@lesson = Lesson.find(params[:lesson_id])
  end
  def create
	  #render text: quiz_params.inspect
	  @quiz = Quiz.new(quiz_params)
	  @quiz.save
	  redirect_to lesson_quiz_path(@quiz.lesson,@quiz)
  end

  def take_quiz
	  #render text: params.inspect
	  #{"action"=>"take_quiz", "controller"=>"quizs", "lesson_id"=>"16", "id"=>"20"}
	  @quiz = Quiz.find(params[:id])
      #render text: first_quizquestion.name
	  if @quiz.quizquestions.count > 0
	     redirect_to take_lesson_quiz_quizquestion_path(@quiz.lesson,@quiz,@quiz.quizquestions.first)	  
	  else
	     render text: "Can't take quiz. There are no questions. Please add questions"
	  end
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
  
  private
  def quiz_params
	params.require(:quiz).permit(:name, :quiz_type, :lesson_id)
  end
end
