class AddSupergroupToVocabulary < ActiveRecord::Migration
  def change
    add_column :vocabularies, :supergroup, :string
  end
end
