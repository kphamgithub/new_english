class Multichoicequestion < ActiveRecord::Base
    belongs_to :vocabulary
	has_many :quizquestions, dependent: :destroy
end
