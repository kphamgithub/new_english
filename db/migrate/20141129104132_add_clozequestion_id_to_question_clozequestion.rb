class AddClozequestionIdToQuestionClozequestion < ActiveRecord::Migration
  def change
    add_column :question_clozequestions, :clozequestion_id, :integer
  end
end
