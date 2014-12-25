class AddAnswerToQuestionClozequestion < ActiveRecord::Migration
  def change
    add_column :question_clozequestions, :answer, :string
  end
end
