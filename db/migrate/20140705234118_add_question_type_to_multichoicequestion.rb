class AddQuestionTypeToMultichoicequestion < ActiveRecord::Migration
  def change
    add_column :multichoicequestions, :question_type, :string
  end
end
