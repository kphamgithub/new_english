class AddImageToVocabulary < ActiveRecord::Migration
  def change
    add_column :vocabularies, :image, :string
  end
end
