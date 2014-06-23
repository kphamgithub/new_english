class MultichoicequestionsController < ApplicationController
  def new
	  #render text: params.inspect
	  voca = Vocabulary.find(params[:vocabulary_id])
	  @voca_name = voca.name
	  @voca_audio = voca.audio
	  @voca_image = voca.image
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
	  redirect_to multichoicequestions_path
  end
	
  def create
	  #render text: params.inspect    
	  @multichoicequestion = Multichoicequestion.new(multichoicequestion_params)
	  @multichoicequestion.vocabulary_id = params[:vocabulary_id]
	  @multichoicequestion.save
	  redirect_to vocabulary_multichoicequestions_path
  end
  private
  def multichoicequestion_params
	params.require(:multichoicequestion).permit(:name, :quiz_id, :question, :audio, :image, :choice1, :choice2, :choice3, :answer)
  end
end
