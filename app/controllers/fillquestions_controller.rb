class FillquestionsController < ApplicationController
  def index
     @fillquestions = Fillquestion.all
  end

  def new
     if params[:voca_id] != nil   # new question link from vocabulary path
	     @vocabulary = Vocabulary.find(params[:voca_id])
	  end

  end
  
  def show
	 @fillquestion = Fillquestion.find(params[:id])
  end
  
  
  def create
	  #render text: params[:fillquestion].inspect    
	  #render text: fillquestion_params
	  @fillquestion = Fillquestion.new(fillquestion_params)
	  @fillquestion.save
	  #add to quiz
	  if params['create_quizquestion'] != nil
            	   qqrow = {quiz_id: params[:quiz][:id],name: params[:multichoicequestion][:name], origin_id: multichoicequestion.id, qtype: 'Multichoicequestion' }
	    quizquestion = Quizquestion.new(qqrow)
		quizquestion.save 
	  end
	  redirect_to @fillquestion
  end
  
  private
  def fillquestion_params
	params.require(:fillquestion).permit(:name, :question, :quiz_id)
  end
end
