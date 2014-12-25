class AddQuestionTypeToQuizquestionresult < ActiveRecord::Migration
  def change
    add_column :quizquestionresults, :question_type, :string
  end
end
