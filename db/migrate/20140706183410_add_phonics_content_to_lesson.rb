class AddPhonicsContentToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :phonics_content, :string
  end
end
