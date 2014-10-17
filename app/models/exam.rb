class Exam < ActiveRecord::Base
	   has_many :examquestions, dependent: :destroy
end
