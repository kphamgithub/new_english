class AddGroupToVocabulary < ActiveRecord::Migration
  def change
    add_column :vocabularies, :group, :string
  end
end
