class CreateQuestionMultichoicequestions < ActiveRecord::Migration
  def change
    create_table :question_multichoicequestions do |t|
      t.string :question
      t.string :choice1
      t.string :choice2
      t.string :choice3
      t.string :answer
      t.integer :quizpage_id

      t.timestamps
    end
  end
end
