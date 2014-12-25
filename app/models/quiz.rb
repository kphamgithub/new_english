class Quiz < ActiveRecord::Base
    has_many :quizpages, dependent: :destroy
	belongs_to :lesson
	#has_many :quizquestions, dependent: :destroy
end
 