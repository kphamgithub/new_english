class AddVocabularyToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :vocabulary, :string
  end
end
