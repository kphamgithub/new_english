class Quizpage < ActiveRecord::Base
	belongs_to :quiz
	
	has_many :question_clozequestions, dependent: :destroy
	accepts_nested_attributes_for :question_clozequestions, :allow_destroy => true

	has_many :question_matchquestions, dependent: :destroy
	accepts_nested_attributes_for :question_matchquestions, :allow_destroy => true
	
	has_many :question_multichoicequestions, dependent: :destroy
	accepts_nested_attributes_for :question_multichoicequestions, :allow_destroy => true

	#has_many :quizquestions, dependent: :destroy
	
	def next
		quiz.quizpages.where("id > ?", id).order("id ASC").first
	end
	
end
