class CreateVocabularies < ActiveRecord::Migration
  def change
    create_table :vocabularies do |t|
      t.string :name
      t.string :definition

      t.timestamps
    end
  end
end
