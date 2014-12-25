class CreateQuizpages < ActiveRecord::Migration
  def change
    create_table :quizpages do |t|
      t.string :name

      t.timestamps
    end
  end
end
