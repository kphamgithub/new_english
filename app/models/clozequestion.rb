class Clozequestion < ActiveRecord::Base
	has_one :quizquestion, dependent: :destroy
end
