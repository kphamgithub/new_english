class CreateClassnotes < ActiveRecord::Migration
  def change
    create_table :classnotes do |t|
      t.string :name
      t.string :content

      t.timestamps
    end
  end
end
