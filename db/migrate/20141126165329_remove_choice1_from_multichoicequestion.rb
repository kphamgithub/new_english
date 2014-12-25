class RemoveChoice1FromMultichoicequestion < ActiveRecord::Migration
  def change
    remove_column :multichoicequestions, :choice1, :string
  end
end
