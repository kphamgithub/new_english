class WelcomeController < ApplicationController
  def index
     #@todos = Todo.all
     if current_user
	    #@my_lesson = current_user.lesson
	    #@my_lesson = Lesson.find(current_user.lesson_id)
	    #render text: @my_lesson.name
	 end
  end
  
  def index_user
     if current_user
	    #@my_lessons = current_user.lessons
	    #@my_lesson = Lesson.find(current_user.lesson_id)
	    #render text: @my_lesson.name
	 end
  end

  def index_story
     if current_user
		@stories = Array.new
		current_user.lessons.each do |lesson|
			if lesson.content_type == 'story'
				@stories.push(lesson)
			end 
		end
	 end
  end

  
end