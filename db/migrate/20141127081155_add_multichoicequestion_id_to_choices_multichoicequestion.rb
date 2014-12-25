class AddMultichoicequestionIdToChoicesMultichoicequestion < ActiveRecord::Migration
  def change
    add_column :choices_multichoicequestions, :multichoicequestion_id, :integer
  end
end
