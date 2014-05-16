class WelcomeController < ApplicationController
  def index
     if current_user
	 @my_lesson = Lesson.find(current_user.lesson_id)
	 #render text: @my_lesson.name
	 end
  end
end