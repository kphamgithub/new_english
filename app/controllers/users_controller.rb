class UsersController < ApplicationController
  def index
     @users = User.all
  end
  def new
  end

  def add_lessons
      @user = User.find(params[:id])
  end
 
  def remove_lessons
      @user = User.find(params[:id])
  end
 
    def update_add_lessons
    #render text: params.inspect
	user = User.find(params[:id])
	if params["add_basic_lessons"] == "1"
	    all_lessons = Lesson.all
		all_lessons.each do |lesson|
			if lesson.level == 'Basic'
				user.lessons << lesson
			end
		end
	end
	 
	if params["add_intermediate_lessons"] == "1"
		Lesson.all.each do |lesson|
			if lesson.level == 'Intermediate'
				user.lessons << lesson
			end
		end
	 end
	 if params["add_advanced_lessons"] == "1"	    
		Lesson.all.each do |lesson|
			if lesson.level == 'Advanced'
				user.lessons << lesson
			end
		end
	 end
	 redirect_to users_path 
  end
  
  def update_remove_lessons
     #render text: params.inspect
	 user = User.find(params[:id])
	 if params["remove_basic_lessons"] == "1"
	    my_basic_lessons = Array.new
		user.lessons.each do |lesson|
			if lesson.level == 'Basic'
				my_basic_lessons.push(lesson)
			end
		end
		#go through the user_lesson association table and delete all basic lessons
		my_basic_lessons.each do |lesson|
			user.lessons.delete(lesson.id)
		end	 
	 end
	 
	 if params["remove_intermediate_lessons"] == "1"
	    my_intermediate_lessons = Array.new
		user.lessons.each do |lesson|
			if lesson.level == 'Intermediate'
				my_intermediate_lessons.push(lesson)
			end
		end
		#go through the user_lesson association table and delete all intermediate lessons
		my_intermediate_lessons.each do |lesson|
			user.lessons.delete(lesson.id)
		end	 
		
	 end
	 if params["remove_advanced_lessons"] == "1"
	    my_advanced_lessons = Array.new
		user.lessons.each do |lesson|
			if lesson.level == 'Advanced'
				my_advanced_lessons.push(lesson)
			end
		end
		#go through the user_lesson association table and delete all advanced lessons
		my_advanced_lessons.each do |lesson|
			user.lessons.delete(lesson.id)
		end	 
	 end
	 redirect_to remove_lessons_user_path 
  end
 
  def edit
  @user = User.find(params[:id])
  end
  
  def create	  
	  @user = User.new(user_params)
	  @user.save
	  redirect_to @user 	  
  end
  def show
	  @user = User.find(params[:id])
	  #@lesson = @user.lesson #Lesson.find(@user.lesson_id)
  end
  
  def assign_level
	@user = User.find(params[:id])
  end

  def update_level
	@user = User.find(params[:id])
	if @user.update(user_level_params)
	 	redirect_to users_path
	else
	    render 'edit'
	end
  end
  
  def update
       @user = User.find(params[:id])
	   if @user.update(user_params)
	  	redirect_to @user
	   else
	    render 'edit'
	   end
  end

  def destroy
	  #render text: params[:id].inspect
          @user = User.find(params[:id])
	  @user.destroy
	  redirect_to users_path
  end
    
  private
  def user_params
	params.require(:user).permit(:name,:real_name,:password, :level)
  end
  
  def user_level_params
	params.require(:user).permit(:level)
  end

  #ANY METHOD ADDED HEREAFTER will become private, BEWARE!!! kpham
end
              
