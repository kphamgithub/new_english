class MultichoicequestionsController < ApplicationController
  def new
	 
  end

  def index
     @multichoicequestions = Multichoicequestion.all
  end
    
  def edit
     @multichoicequestion = Multichoicequestion.find(params[:id])
  end
	
  def show
	 @multichoicequestion = Multichoicequestion.find(params[:id])
  end
    
  def destroy
	  #render text: params[:id].inspect
      @multichoicequestion = Multichoicequestion.find(params[:id])
	  @multichoicequestion.destroy
	  redirect_to multichoicequestion_path
  end

  def remove_from_quiz
	  #render text: params[:id].inspect
      @multichoicequestion = Multichoicequestion.find(params[:id])	  
	  @multichoicequestion.quiz_id = 0
	  @multichoicequestion.save
	  redirect_to multichoicequestion_path
  end
	
  def create
	  #render text: params[:multichoicequestion].inspect    
	  @multichoicequestion = Multichoicequestion.new(multichoicequestion_params)
	  @multichoicequestion.save
	  redirect_to @multichoicequestion
  end
  private
  def multichoicequestion_params
	params.require(:multichoicequestion).permit(:name, :quiz_id, :question, :choice1, :choice2, :choice3, :answer)
  end
end
