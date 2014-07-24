class AddMediaToFillquestion < ActiveRecord::Migration
  def change
    add_column :fillquestions, :media, :string
  end
end
