class CreateUserlessons < ActiveRecord::Migration
  def change
    create_table :userlessons do |t|
      t.string :user_id
      t.string :lesson_id

      t.timestamps
    end
  end
end
