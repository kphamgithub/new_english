class AddExamIdToQuiz < ActiveRecord::Migration
  def change
    add_column :quizzes, :exam_id, :integer
  end
end
