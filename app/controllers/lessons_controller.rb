class LessonsController < ApplicationController
  def index
     @lessons = Lesson.all
  end
  
  def new
  end

  def edit
	@lesson = Lesson.find(params[:id])
  end

  def update
     @lesson = Lesson.find(params[:id])
	 if @lesson.update(params[:lesson].permit(:name,:content,:video,:level))
	  	redirect_to @lesson
	 else
	    render 'edit'
	 end
  end
  
  def create
	  #render text: params[:lesson].inspect    
	  @lesson = Lesson.new(lesson_params)
	  @lesson.save
	  redirect_to @lesson
  end

  def add_quiz
      @lesson = Lesson.find(params[:id])
	  #render text: lesson.name
	  redirect_to new_quiz_path
  end
  
  def take_quizzes
      @lesson = Lesson.find(params[:id])
	  #@quiz = Quiz.find(@lesson.quiz_id)
	  @quizzes = @lesson.quizzes
      #redirect_to take_quizzes_lesson_path(@lesson)	  
	  #render text: @lesson.quizzes.count
  end

  def show
      @lesson = Lesson.find(params[:id])
	  #@quiz = Quiz.find(@lesson.quiz_id)
	  #@quiz = @lesson.quiz
	  #@take_quiz_link = "location.href=" + "'" + take_quiz_lesson_path + "'"
	  #@take_quizzes_link = "location.href=" + "'" + lesson_quizs_path + "'"
	  @take_quizzes_link = "location.href=" + "'" + lesson_quizs_path(@lesson) + "'"
	  #redirect_to lesson_quizs_path(@lesson)
  end
  
  private
  def lesson_params
	params.require(:lesson).permit(:content, :level)
  end

end
