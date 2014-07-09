class RemoveGrammarFromLesson < ActiveRecord::Migration
  def change
    remove_column :lessons, :grammar, :string
  end
end
