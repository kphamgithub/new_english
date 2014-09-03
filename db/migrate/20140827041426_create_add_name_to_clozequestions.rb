class CreateAddNameToClozequestions < ActiveRecord::Migration
  def change
    create_table :add_name_to_clozequestions do |t|
      t.string :name

      t.timestamps
    end
  end
end
