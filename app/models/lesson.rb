class Lesson < ActiveRecord::Base
   has_many :quizzes, dependent: :destroy
   has_many :users   
end
