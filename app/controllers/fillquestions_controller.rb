class FillquestionsController < ApplicationController
  def index
     @fillquestions = Fillquestion.all
  end

  def new
  end
  
  def show
	 @fillquestion = Fillquestion.find(params[:id])
  end
  
  
  def create
	  #render text: params[:fillquestion].inspect    
	  #render text: fillquestion_params
	  @fillquestion = Fillquestion.new(fillquestion_params)
	  @fillquestion.save
	  redirect_to @fillquestion
  end
  
  private
  def fillquestion_params
	params.require(:fillquestion).permit(:name, :question, :quiz_id)
  end
end
