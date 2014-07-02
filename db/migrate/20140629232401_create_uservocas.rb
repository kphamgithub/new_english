class CreateUservocas < ActiveRecord::Migration
  def change
    create_table :uservocas do |t|
      t.integer :user_id
      t.integer :vocabulary_id

      t.timestamps
    end
  end
end
