class LessonsController < ApplicationController
  def index
     @lessons = Lesson.all
  end
  
  def new
  end

  def edit
	@lesson = Lesson.find(params[:id])
	@matches = Match.where("matchquestion_id = ?",5)
  end

  def add_user
     #render text: params.inspect
	 @lesson = Lesson.find(params[:id])
  end
  
  def save_user
	 #render text: params.inspect
	 @lesson = Lesson.find(params[:id])
	 found = false
	 @lesson.users.each do |usr| 
		if usr.id == params[:user][:id].to_i
		  found = true
		  break
		end
	 end
	 if found
	    render text: "user already exists for this lesson"
	 else
		user = User.find(params[:user][:id])
		@lesson.users << user
		redirect_to lessons_path
	 end

  end
  
  def add_vocabulary
	@lesson = Lesson.find(params[:id])
  end

  def save_vocabulary
	@lesson = Lesson.find(params[:id])
	#render text: params[:name]
	entry = Vocabulary.find_by name: params[:name]
	#render text: entry.definition
	if entry != nil
	  @lesson.vocabularies << entry
	  redirect_to @lesson
	else
	  redirect_to new_vocabulary_path
	end
  end
  
  def show_vocabulary
	@lesson = Lesson.find(params[:id])
  end
  
  def remove_vocabulary
     #render text: params.inspect 
	 lesson = Lesson.find(params[:id])
	 voca = lesson.vocabularies.find(params[:voca_id])
	 #render text: voca.name
	 lesson.vocabularies.delete(voca)
	 #voca.destroy
	 redirect_to show_vocabulary_lesson_path(params[:id])
  end
  
  def update
     @lesson = Lesson.find(params[:id])
	 if @lesson.update(lesson_params)
	  	redirect_to @lesson
	 else
	    render 'edit'
	 end
  end
  
  def create
	  #render text: params[:lesson].inspect    
	  @lesson = Lesson.create(lesson_params)
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
  
  def destroy
	  #render text: params[:id].inspect
      @lesson = Lesson.find(params[:id])
	  users_for_this_lesson = @lesson.users
	  users_for_this_lesson.each do |user|
		 user.lesson = nil
	  end
	  @lesson.destroy
	  redirect_to lessons_path
  end

  
  private
  def lesson_params
	params.require(:lesson).permit(:name, :content, :video, :level)
  end

end
