class CreateExamquestions < ActiveRecord::Migration
  def change
    create_table :examquestions do |t|
      t.string :name
      t.integer :exam_id
      t.integer :origin_id
      t.string :qtype

      t.timestamps
    end
  end
end
