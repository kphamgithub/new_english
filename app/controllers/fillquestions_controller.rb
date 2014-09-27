class FillquestionsController < ApplicationController
  def index
     @fillquestions = Fillquestion.all
  end

  def new
     @quiz_id = params[:quiz_id]
	 @lesson_id = params[:lesson_id]
     #if params[:voca_id] != nil   # new question link from vocabulary path
	  #   @vocabulary = Vocabulary.find(params[:voca_id])
     #end

  end
  
  def show
	 @fillquestion = Fillquestion.find(params[:id])
  end
  
  def edit
     @fillquestion = Fillquestion.find(params[:id])
  end
  
  def create
	  #render text: params[:fillquestion].inspect    
	  #render text: params.inspect    
	  fillquestion = Fillquestion.new(fillquestion_params)
	  fillquestion.save
	  #logic for add to quiz
	  if params['add_to_quiz'] != nil
       qqrow = {quiz_id: params[:quiz_id],name: fillquestion.name, origin_id: fillquestion.id, qtype: 'Fillquestion' }
	   quizquestion = Quizquestion.new(qqrow)
    	quizquestion.save 
	  end
	  redirect_to lesson_quiz_path(params[:lesson_id], params[:quiz_id])
  end
  
  private
  def fillquestion_params
	params.require(:fillquestion).permit(:name, :question, :answer, :quiz_id)
  end
end
