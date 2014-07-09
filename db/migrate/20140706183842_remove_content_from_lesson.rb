class RemoveContentFromLesson < ActiveRecord::Migration
  def change
    remove_column :lessons, :content, :string
  end
end
