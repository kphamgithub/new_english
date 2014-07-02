class Lesson < ActiveRecord::Base
   has_many :lessonvocas
   has_many :vocabularies, :through => :lessonvocas
   
   has_many :userlessons
   has_many :users, :through => :userlessons
   
   has_many :quizzes, dependent: :destroy
end
