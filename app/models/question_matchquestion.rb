class QuestionMatchquestion < ActiveRecord::Base
	belongs_to :quizpage
	has_one :quizquestionresult, dependent: :destroy
end
