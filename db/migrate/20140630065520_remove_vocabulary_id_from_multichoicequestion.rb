class RemoveVocabularyIdFromMultichoicequestion < ActiveRecord::Migration
  def change
    remove_column :multichoicequestions, :vocabulary_id, :integer
  end
end
