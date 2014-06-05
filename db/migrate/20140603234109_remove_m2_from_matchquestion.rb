class RemoveM2FromMatchquestion < ActiveRecord::Migration
  def change
    remove_column :matchquestions, :m2, :string
  end
end
