class Vocabulary < ActiveRecord::Base
   has_many :lessonvocas
   has_many :lessons, :through => :lessonvocas
   
   has_many :uservocas
   has_many :users, :through => :uservocas
   
   has_many :multichoicequestions
end
