class AddGrammarToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :grammar, :string
  end
end
