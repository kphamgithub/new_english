class Multichoicequestion < ActiveRecord::Base
    belongs_to :vocabulary
	has_one :quizquestion, dependent: :destroy
end
