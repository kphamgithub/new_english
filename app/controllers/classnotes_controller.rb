class ClassnotesController < ApplicationController
  def index
	@classnotes = Classnote.all
  end

  def new
	  
  end
  
  def edit
	@classnote = Classnote.find(params[:id])
  end
  
  def show
	@classnote = Classnote.find(params[:id])
  end
  
  def update
     @classnote = Classnote.find(params[:id])
	 if @classnote.update(classnote_params)
	  	redirect_to @classnote
	 else
	    render 'edit'
	 end
  end
  
  def create
	  @classnote = Classnote.create(classnote_params)
	  redirect_to @classnote
  end
  
  private
  def classnote_params
	params.require(:classnote).permit(:name, :content)
  end
end
