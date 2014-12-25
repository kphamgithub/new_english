class AddQuizIdToQuizpage < ActiveRecord::Migration
  def change
    add_column :quizpages, :quiz_id, :integer
  end
end
