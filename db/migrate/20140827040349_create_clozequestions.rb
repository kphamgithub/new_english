class CreateClozequestions < ActiveRecord::Migration
  def change
    create_table :clozequestions do |t|
      t.string :question
      t.string :answer

      t.timestamps
    end
  end
end
