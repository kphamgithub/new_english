class AddMultichoicequestionIdToQuizquestion < ActiveRecord::Migration
  def change
    add_column :quizquestions, :multichoicequestion_id, :integer
  end
end
