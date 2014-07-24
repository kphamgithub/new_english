class AddLyricsContentToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :lyrics_content, :string
  end
end
