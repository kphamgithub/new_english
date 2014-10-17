class AddMediaToScrambler < ActiveRecord::Migration
  def change
    add_column :scramblers, :media, :string
  end
end
