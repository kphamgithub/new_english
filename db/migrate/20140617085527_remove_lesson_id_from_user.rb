class RemoveLessonIdFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :lesson_id, :integer
  end
end
