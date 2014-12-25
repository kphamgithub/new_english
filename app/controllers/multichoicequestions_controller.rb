class MultichoicequestionsController < ApplicationController
  def new
      @multichoicequestion = Multichoicequestion.new
	  if params[:voca_id] != nil   # new question link from vocabulary path
	     @vocabulary = Vocabulary.find(params[:voca_id])
	  end
      2.times { @multichoicequestion.choices_multichoicequestions.build}
 end

  def index
     #render text: params.inspect
     @multichoicequestions = Multichoicequestion.all
  end
    
  def edit
     #render text: params.inspect
     @multichoicequestion = Multichoicequestion.find(params[:id])
  end
  
  def update
	  #render text: params.inspect
      @multichoicequestion = Multichoicequestion.find(params[:id])
	  if @multichoicequestion.update(multichoicequestion_params)
	  	redirect_to multichoicequestion_path
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
	  #{"utf8"=>"✓", "authenticity_token"=>"DaUan07uA8esQLoNc7jnoWx7DeSF/zyYZGUD8GR/nx0=", "multichoicequestion"=>{"name"=>"ee", "question_multichoices_attributes"=>{"0"=>{"content"=>"a"}, "1"=>{"content"=>"b"}}, "choice_label_display_mode"=>"text"}, "commit"=>"Create Multichoicequestion", "action"=>"create", "controller"=>"multichoicequestions"}
	  #render text:
	  
	  multichoicequestion = Multichoicequestion.new(multichoicequestion_params)
	  
	  multichoicequestion.save
	  	  	  
	  render text: "done"
	  end

  private
 	
    def multichoicequestion_params
	params.require(:multichoicequestion).permit(:name, :question, :media,:choice_label_display_mode, :answer, choices_multichoicequestions_attributes: [:id,:choice])
	
	#note: kpham. put the parameters for the nested forms(in this case question_multichoices_attributes) at the end of the list. Otherwise it won't work. Took me a lot of debugging to find out. 11/26/2014
	
	end

end
