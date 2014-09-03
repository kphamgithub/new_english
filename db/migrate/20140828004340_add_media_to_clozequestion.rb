class AddMediaToClozequestion < ActiveRecord::Migration
  def change
    add_column :clozequestions, :media, :string
  end
end
