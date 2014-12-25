class RemoveChoice3FromMultichoicequestion < ActiveRecord::Migration
  def change
    remove_column :multichoicequestions, :choice3, :string
  end
end
