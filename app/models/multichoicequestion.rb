class Multichoicequestion < ActiveRecord::Base
    belongs_to :vocabulary
	has_many :choices_multichoicequestions, dependent: :destroy
	accepts_nested_attributes_for :choices_multichoicequestions, :allow_destroy => true
	has_many :quizquestions, dependent: :destroy
end
