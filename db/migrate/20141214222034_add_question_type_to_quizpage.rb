class AddQuestionTypeToQuizpage < ActiveRecord::Migration
  def change
    add_column :quizpages, :question_type, :string
  end
end
