class AddQuestionIdToQuizquestionresult < ActiveRecord::Migration
  def change
    add_column :quizquestionresults, :question_id, :integer
  end
end
