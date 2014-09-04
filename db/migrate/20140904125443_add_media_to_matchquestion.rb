class AddMediaToMatchquestion < ActiveRecord::Migration
  def change
    add_column :matchquestions, :media, :string
  end
end
