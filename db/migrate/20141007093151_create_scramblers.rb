class CreateScramblers < ActiveRecord::Migration
  def change
    create_table :scramblers do |t|
      t.string :q1
      t.string :q2
      t.string :q3

      t.timestamps
    end
  end
end
