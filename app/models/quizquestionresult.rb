class Quizquestionresult < ActiveRecord::Base
	#belongs_to :clozequestion
	belongs_to :user
	belongs_to :quiz
end
