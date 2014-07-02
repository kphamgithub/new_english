class VocabulariesController < ApplicationController
  def index
    @vocabularies = Vocabulary.all
  end

  def create
	  #render text: params[:lesson].inspect    
	  @vocabulary = Vocabulary.new(vocabulary_params)
	  @vocabulary.save
	  redirect_to vocabularies_path
  end
  
  def new
  end
  
  def edit
	 @vocabulary = Vocabulary.find(params[:id])
  end
  
  def show
	 @vocabulary = Vocabulary.find(params[:id])
  end

  def update
      @vocabulary = Vocabulary.find(params[:id])
	  if @vocabulary.update(params[:vocabulary].permit(:name, :definition, :group, :supergroup, :audio,:image))
	  	redirect_to vocabularies_path
	  else
	    render 'edit'
	  end
  end

  def questions
      #render text: params.inspect
      @vocabulary = Vocabulary.find(params[:id])
      @multichoicequestions = @vocabulary.multichoicequestions
  end
  
  private
  def vocabulary_params
	params.require(:vocabulary).permit(:name, :definition,:group, :supergroup, :audio, :image)
  end
end
