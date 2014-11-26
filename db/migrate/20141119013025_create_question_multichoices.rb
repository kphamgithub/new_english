class CreateQuestionMultichoices < ActiveRecord::Migration
  def change
    create_table :question_multichoices do |t|
      t.string :name
      t.string :content
      t.integer :multichoicequestion_id

      t.timestamps
    end
  end
end
