class AddAudioToVocabulary < ActiveRecord::Migration
  def change
    add_column :vocabularies, :audio, :string
  end
end
