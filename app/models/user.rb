class User < ActiveRecord::Base
	belongs_to :lesson
	has_many :quizquestionresults, dependent: :destroy
end
