class SessionsController < ApplicationController
  protect_from_forgery with: :exception
  include SessionsHelper
    def new
	
	end
	
	def create
	   #user = User.find_by(name: "kevinpham")
	   user = User.find_by(name: params[:session][:name])
	   if user
		  #render text: params[:session][:name].inspect 
		  #sign_in user
		  #session[:remember_token] = user.id
		  session["user_id"] = user.id
		  redirect_to welcome_index_path
	   else
	      flash.now[:error] = 'Invalid email/password combination'
	      #render text: params[:session].inspect 
		  render 'new'
	   end
	end
	def destroy
	    session["user_id"] = nil
		redirect_to welcome_index_path
	end
end
