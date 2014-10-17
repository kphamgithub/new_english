class Quizquestion < ActiveRecord::Base
	belongs_to :quiz
	has_one :quizquestionresult, dependent: :destroy
	#has_many :matchquestions
	belongs_to :matchquestion
	def next
		quiz.quizquestions.where("id > ?", id).order("id ASC").first
	end
end
