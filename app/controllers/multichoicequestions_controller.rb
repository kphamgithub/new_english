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
     #render text: params.inspect
     @multichoicequestion = Multichoicequestion.find(params[:id])
  end
  
    def update
	  #render text: params.inspect
      @multichoicequestion = Multichoicequestion.find(params[:id])
	  #if @multichoicequestion.update(params[:multichoicequestion].permit(:name, :quiz_id, :question,:media, :audio, :image, :choice_label_display_mode, :choice1, :choice2, :choice3, :answer))
	  
	  #Multichoicequestion.new(multichoicequestion_params)
	  
	  if @multichoicequestion.update(multichoicequestion_params)
	  	redirect_to vocabulary_multichoicequestion_path
	  else
	    render 'edit'
	  end 
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
	params.require(:multichoicequestion).permit(:name, :quiz_id, :question, :media, :audio, :image, :choice_label_display_mode, :choice1, :choice2, :choice3, :answer)
  end
end
