class RemoveM1FromMatchquestion < ActiveRecord::Migration
  def change
    remove_column :matchquestions, :m1, :string
  end
end
