class UsersController < ApplicationController
  def index
     @users = User.all
  end
  def new
  end

  def edit
  @user = User.find(params[:id])
  end
  def create
      #@user = User.new(name: "bee",
       # password: "n", password_confirmation: "n")
      #render text: params["user"].inspect
	  #render text: params[:user][:name]
	  
	  @user = User.new(user_params)
	  @user.save
	  redirect_to @user 	  
  end
  def show
	  @user = User.find(params[:id])
	  @lesson = Lesson.find(@user.lesson_id)
  end
  
  def update
      @user = User.find(params[:id])
	  if @user.update(params[:user].permit(:lesson_id, :level))
	  	redirect_to @user
	  else
	    render 'edit'
	  end 
  end
    
  private
  def user_params
	#params.require(:user).permit(:name, :password, :password_confirmation, :level)
	params.require(:user).permit(:name,:lesson_id, :level)
  end
  #ANY METHOD ADDED HEREAFTER will become private, BEWARE!!! kpham
end
              
