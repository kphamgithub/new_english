class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  helper_method :current_user
  
  private
  def current_user
	#@current_user = User.find(session[:remember_token]) if session[:remember_token]
	@current_user = User.find(session["user_id"]) if session["user_id"]
	#current_user = User.find(1)
  end
end
