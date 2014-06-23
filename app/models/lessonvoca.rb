class Lessonvoca < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :vocabulary
end
