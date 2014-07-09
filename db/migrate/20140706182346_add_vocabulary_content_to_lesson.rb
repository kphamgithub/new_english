class AddVocabularyContentToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :vocabulary_content, :string
  end
end
