class AddNameToClozequestion < ActiveRecord::Migration
  def change
    add_column :clozequestions, :name, :string
  end
end
