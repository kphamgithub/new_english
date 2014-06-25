class AddMediaToMultichoicequestion < ActiveRecord::Migration
  def change
    add_column :multichoicequestions, :media, :string
  end
end
