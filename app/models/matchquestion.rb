class Matchquestion < ActiveRecord::Base
    has_many :matches, dependent: :destroy
	has_many :quizquestions, dependent: :destroy
end
