class CreateQuizquestionresults < ActiveRecord::Migration
  def change
    create_table :quizquestionresults do |t|
	  t.belongs_to :quizquestion
	  t.belongs_to :user
	  t.belongs_to :quiz
      t.string :answer

      t.timestamps
    end
  end
end
