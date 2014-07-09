class RemoveTypeFromQuiz < ActiveRecord::Migration
  def change
    remove_column :quizzes, :type, :string
  end
end
