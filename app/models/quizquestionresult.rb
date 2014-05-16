class Quizquestionresult < ActiveRecord::Base
	belongs_to :quizquestion
	belongs_to :user
	belongs_to :quiz
end
