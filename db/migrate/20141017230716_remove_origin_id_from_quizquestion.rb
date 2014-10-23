class RemoveOriginIdFromQuizquestion < ActiveRecord::Migration
  def change
    remove_column :quizquestions, :origin_id, :integer
  end
end
