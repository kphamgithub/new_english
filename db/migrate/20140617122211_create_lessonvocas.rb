class CreateLessonvocas < ActiveRecord::Migration
  def change
    create_table :lessonvocas do |t|
      t.integer :lesson_id
      t.integer :vocabulary_id
      t.string :name

      t.timestamps
    end
  end
end
