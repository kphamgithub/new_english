class AddNameToScrambler < ActiveRecord::Migration
  def change
    add_column :scramblers, :name, :string
  end
end
