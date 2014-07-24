class UsersController < ApplicationController
  def index
     @users = User.all
  end
  def new
  end

  def add_lesson
      @user = User.find(params[:id])
	  all_lessons = Lesson.all
	  render text: @user.lessons.count
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
  def update_lesson
     #render text: params[].inspect
	 lesson = Lesson.find(params[:lesson][:lesson_id])
	 user = User.find(params[:id])
	 user.lessons << lesson
	 redirect_to users_path  
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
    
  private
  def user_params
	params.require(:user).permit(:name,:password)
  end
  
  def user_level_params
	params.require(:user).permit(:level)
  end

  #ANY METHOD ADDED HEREAFTER will become private, BEWARE!!! kpham
end
              
