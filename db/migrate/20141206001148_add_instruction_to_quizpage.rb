class AddInstructionToQuizpage < ActiveRecord::Migration
  def change
    add_column :quizpages, :instruction, :string
  end
end
