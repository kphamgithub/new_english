class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :name
      t.string :content
      t.string :level
      t.string :video

      t.timestamps
    end
  end
end
