class AddMatchquestionIdToQuizquestion < ActiveRecord::Migration
  def change
    add_column :quizquestions, :matchquestion_id, :integer
  end
end
