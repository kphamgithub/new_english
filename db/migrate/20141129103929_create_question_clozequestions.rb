class CreateQuestionClozequestions < ActiveRecord::Migration
  def change
    create_table :question_clozequestions do |t|
      t.string :question

      t.timestamps
    end
  end
end
