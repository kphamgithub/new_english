class AddClozequestionIdToQuizquestion < ActiveRecord::Migration
  def change
    add_column :quizquestions, :clozequestion_id, :integer
  end
end
