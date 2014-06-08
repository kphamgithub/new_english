class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :name
      t.string :left
      t.string :right
      t.string :match_id

      t.timestamps
    end
  end
end
