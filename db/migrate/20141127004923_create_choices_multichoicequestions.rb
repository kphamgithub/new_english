class CreateChoicesMultichoicequestions < ActiveRecord::Migration
  def change
    create_table :choices_multichoicequestions do |t|
      t.string :name
      t.string :choice

      t.timestamps
    end
  end
end
