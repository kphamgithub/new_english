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
	 @all_users = User.order(:name)
  end
  
  def save_user
	  #render text: params.inspect
	  @lesson = Lesson.find(params[:id])
	  mykeys = params.keys  
	  #params format:   user_ID => 1 (selected)
	  #examples         user_1 => 1
	  #         		user_9 => 1
		 
	  mykeys.each do |k|
	   if (k.include? "user")
	    arr = k.split('_')		
		user_id = arr[1].to_i
		    @user = User.find(user_id)
			@lesson.users << @user
		end
	  end
	  redirect_to lessons_path
  end

  def delete_user
     #render text: params.inspect
	 @lesson = Lesson.find(params[:id])
  end

  def remove_user
     #render text: params.inspect
	 @lesson = Lesson.find(params[:id])
	 mykeys = params.keys  
	  #params format:   user_ID => 1 (selected)
	  #examples         user_1 => 1
	  #         		user_9 => 1
		 
	  mykeys.each do |k|
	   if (k.include? "user")
	    arr = k.split('_')		
		user_id = arr[1].to_i
		    @user = User.find(user_id)
			if @lesson.users.include?(@user)
			   @lesson.users.delete(@user)
			end
		end
	  end
	  redirect_to lessons_path
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
	  	#redirect_to @lesson
		render 'edit'
	 else
	    render 'edit'
	 end
  end
  
  def create
  	  @lesson = Lesson.create(lesson_params)
	  #render text: params[:lesson][:level].inspect 
	  #render text: params.inspect
	  if params["add_students"] == "1"
	      lesson_level = params[:lesson][:level]
		  users_at_this_level = User.where("level = ?",lesson_level)
		  users_at_this_level.each do |user|	   	    
			@lesson.users << user		
		  end	
	  end
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
	  my_quizzes = @lesson.quizzes
	  #@voca_quiz = Quiz.find_by quiz_type: 'vocabulary'
	  my_quizzes.each do |quiz|
	     if quiz.quiz_type == "vocabulary"
		    @voca_quiz = quiz
			break
		 end
	  end

	  my_quizzes.each do |quiz|
	     if quiz.quiz_type == "grammar"
		    @grammar_quiz = quiz
			break
		 end
	  end

	  my_quizzes.each do |quiz|
	     if quiz.quiz_type == "phonics"
		    @phonics_quiz = quiz
			break
		 end
	  end

	  my_quizzes.each do |quiz|
	     if quiz.quiz_type == "general"
		    @general_quiz = quiz
			break
		 end
	  end
	  
	  #@grammar_quiz = Quiz.find_by quiz_type: 'grammar'
	  #@phonics_quiz = Quiz.find_by quiz_type: 'phonics'
	  #@general_quiz = Quiz.find_by quiz_type: 'general'
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
		 user.lessons.delete(@lesson)
	  end
	  @lesson.destroy
	  redirect_to lessons_path
  end

  private
  def lesson_params
	params.require(:lesson).permit(:name, :reading_content, :vocabulary_content, :grammar_content, :phonics_content, :lyrics_content, :video, :level, :content_type)
  end

end
