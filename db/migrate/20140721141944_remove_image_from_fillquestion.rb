class RemoveImageFromFillquestion < ActiveRecord::Migration
  def change
    remove_column :fillquestions, :image, :string
  end
end
