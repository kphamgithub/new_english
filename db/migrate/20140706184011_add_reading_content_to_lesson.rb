class AddReadingContentToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :reading_content, :string
  end
end
