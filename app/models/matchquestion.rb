class Matchquestion < ActiveRecord::Base
    has_many :matches, dependent: :destroy
	has_one :quizquestion, dependent: :destroy
end
