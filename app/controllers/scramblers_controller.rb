class ScramblersController < ApplicationController
  def index
  end
  
  def new
	 @quiz_id = params[:quiz_id]
	 @lesson_id = params[:lesson_id]
  end
  
  def create
  	  scrambler = Scrambler.new(scrambler_params)
	  scrambler.save
	  #logic for add to quiz
	  if params['add_to_quiz'] != nil
        qqrow = {quiz_id: params[:quiz_id],name: scrambler.name,    scrambler_id: scrambler.id, qtype: 'Scrambler' }
	    quizquestion = Quizquestion.new(qqrow)
    	quizquestion.save 
	  end
	  redirect_to lesson_quiz_path(params[:lesson_id], params[:quiz_id])
  end

    private
  def scrambler_params
	params.require(:scrambler).permit(:name,:q1, :q2, :q3)
  end
  
end
