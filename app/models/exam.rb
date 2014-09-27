class Exam < ActiveRecord::Base
	   has_many :quizzes, dependent: :destroy
end
