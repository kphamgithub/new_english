class Clozequestion < ActiveRecord::Base
	has_many :question_clozequestions, dependent: :destroy
	accepts_nested_attributes_for :question_clozequestions, :allow_destroy => true
	has_many :quizquestions, dependent: :destroy
end
