class AddModeToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :mode, :string
  end
end
