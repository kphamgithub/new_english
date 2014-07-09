class RemoveVocabularyFromLesson < ActiveRecord::Migration
  def change
    remove_column :lessons, :vocabulary, :string
  end
end
