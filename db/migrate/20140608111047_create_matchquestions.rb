class CreateMatchquestions < ActiveRecord::Migration
  def change
    create_table :matchquestions do |t|
      t.string :name
      t.string :question

      t.timestamps
    end
  end
end
