class Vocabulary < ActiveRecord::Base
   has_many :lessonvocas
   has_many :lessons, :through => :lessonvocas
   has_many :multichoicequestions, dependent: :destroy
   has_many :fillquestions, dependent: :destroy
end
