class Uservoca < ActiveRecord::Base
  belongs_to :user
  belongs_to :vocabulary
end
