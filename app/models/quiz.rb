class Quiz < ActiveRecord::Base
	belongs_to :lesson
	has_many :quizquestions, dependent: :destroy
end
 