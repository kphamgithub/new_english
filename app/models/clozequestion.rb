class Clozequestion < ActiveRecord::Base
	has_many :quizquestions, dependent: :destroy
end
