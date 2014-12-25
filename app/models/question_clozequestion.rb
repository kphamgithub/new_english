class QuestionClozequestion < ActiveRecord::Base
	#belongs_to :Clozequestion
	belongs_to :quizpage
	has_one :quizquestionresult, dependent: :destroy
end
