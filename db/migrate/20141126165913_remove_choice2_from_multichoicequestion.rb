class RemoveChoice2FromMultichoicequestion < ActiveRecord::Migration
  def change
    remove_column :multichoicequestions, :choice2, :string
  end
end
