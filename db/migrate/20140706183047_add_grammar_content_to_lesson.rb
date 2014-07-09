class AddGrammarContentToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :grammar_content, :string
  end
end
