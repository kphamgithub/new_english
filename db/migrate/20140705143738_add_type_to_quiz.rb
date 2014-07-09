class AddTypeToQuiz < ActiveRecord::Migration
  def change
    add_column :quizzes, :type, :string
  end
end
