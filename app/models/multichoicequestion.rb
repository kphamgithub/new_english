class Multichoicequestion < ActiveRecord::Base
    belongs_to :vocabulary
	has_many :question_multichoices, dependent: :destroy
	accepts_nested_attributes_for :question_multichoices, :allow_destroy => true
	has_many :quizquestions, dependent: :destroy
end
