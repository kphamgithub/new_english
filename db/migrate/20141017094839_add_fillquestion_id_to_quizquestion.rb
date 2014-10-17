class AddFillquestionIdToQuizquestion < ActiveRecord::Migration
  def change
    add_column :quizquestions, :fillquestion_id, :integer
  end
end
