class AddContentTypeToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :content_type, :string
  end
end
