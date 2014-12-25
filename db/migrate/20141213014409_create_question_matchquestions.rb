class CreateQuestionMatchquestions < ActiveRecord::Migration
  def change
    create_table :question_matchquestions do |t|
      t.string :question
      t.string :answer
      t.integer :quizpage_id

      t.timestamps
    end
  end
end
