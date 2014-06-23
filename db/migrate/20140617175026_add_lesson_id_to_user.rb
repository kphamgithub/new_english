class AddLessonIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :lesson_id, :integer
  end
end
