class AddModeToMatchquestion < ActiveRecord::Migration
  def change
    add_column :matchquestions, :mode, :string
  end
end
