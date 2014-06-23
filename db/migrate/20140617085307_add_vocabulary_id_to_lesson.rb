class AddVocabularyIdToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :vocabulary_id, :integer
  end
end
