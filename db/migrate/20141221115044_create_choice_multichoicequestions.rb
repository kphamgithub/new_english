class CreateChoiceMultichoicequestions < ActiveRecord::Migration
  def change
    create_table :choice_multichoicequestions do |t|
      t.string :choice
      t.integer :quizpage_id

      t.timestamps
    end
  end
end
