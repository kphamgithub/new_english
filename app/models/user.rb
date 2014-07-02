class User < ActiveRecord::Base
    has_many :uservocas
	has_many :vocabularies, :through => :uservocas
	
	has_many :userlessons
	has_many :lessons, :through => :userlessons
	
	has_many :quizquestionresults, dependent: :destroy
	
end
