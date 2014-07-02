class CreateVocadrills < ActiveRecord::Migration
  def change
    create_table :vocadrills do |t|
      t.integer :vocabulary_id
      t.integer :question_id

      t.timestamps
    end
  end
end
