class RemoveImageFromMultichoicequestion < ActiveRecord::Migration
  def change
    remove_column :multichoicequestions, :image, :string
  end
end
