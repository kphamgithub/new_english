class RemoveVocabularyIdFromLesson < ActiveRecord::Migration
  def change
    remove_column :lessons, :vocabulary_id, :integer
  end
end
