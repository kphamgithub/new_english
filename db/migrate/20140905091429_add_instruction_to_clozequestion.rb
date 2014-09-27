class AddInstructionToClozequestion < ActiveRecord::Migration
  def change
    add_column :clozequestions, :instruction, :string
  end
end
