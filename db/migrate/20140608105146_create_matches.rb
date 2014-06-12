class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
	  t.belongs_to :matchquestion
      t.string :name
      t.string :match_id
      t.string :left
      t.string :right

      t.timestamps
    end
  end
end
