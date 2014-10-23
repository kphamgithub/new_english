class Fillquestion < ActiveRecord::Base
	has_many :quizquestions, dependent: :destroy
end
