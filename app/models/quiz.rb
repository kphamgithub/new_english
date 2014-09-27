class Quiz < ActiveRecord::Base
	belongs_to :lesson
	belongs_to :exam
	has_many :quizquestions, dependent: :destroy
end
 