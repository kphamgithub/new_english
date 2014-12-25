class AddQuizpageIdToQuestionClozequestion < ActiveRecord::Migration
  def change
    add_column :question_clozequestions, :quizpage_id, :integer
  end
end
