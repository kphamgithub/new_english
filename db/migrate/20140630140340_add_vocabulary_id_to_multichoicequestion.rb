class AddVocabularyIdToMultichoicequestion < ActiveRecord::Migration
  def change
    add_column :multichoicequestions, :vocabulary_id, :integer
  end
end
