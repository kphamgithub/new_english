class MultichoicequestionsController < ApplicationController
  def new
      @multichoicequestion = Multichoicequestion.new
	  if params[:voca_id] != nil   # new question link from vocabulary path
	     @vocabulary = Vocabulary.find(params[:voca_id])
	  end
      2.times { @multichoicequestion.question_multichoices.build}
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
	  #if @multichoicequestion.update(params[:multichoicequestion].permit(:name, :quiz_id, :question,:media, :audio, :image, :choice_label_display_mode, :choice1, :choice2, :choice3, :answer))
	  
	  #Multichoicequestion.new(multichoicequestion_params)
	  
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
      render text: params.inspect
	  #{"utf8"=>"✓", "authenticity_token"=>"SSLE9rOJRwfvIny6E7TTQLw7fdqYF8BX3eavLMBpzu4=", "multichoicequestion"=>{"name"=>"very last", "question_multichoices_attributes"=>{"0"=>{"content"=>"c"}, "1"=>{"content"=>"b"}, "2"=>{"content"=>"b"}}, "vocabulary"=>"", "media"=>"", "choice_label_display_mode"=>"text", "choice1"=>"n", "choice2"=>"n", "choice3"=>"n", "answer"=>""}, "quiz"=>{"id"=>"21"}, "commit"=>"Create Multichoicequestion", "action"=>"create", "controller"=>"multichoicequestions"	  
	  
	  #{"utf8"=>"✓", "authenticity_token"=>"m1JUns4y4vL/SCy6te24DcIL06jxCR/osQi+zt3eR2c=", "multichoicequestion"=>{"name"=>"", "question"=>"", "vocabulary"=>"", "media"=>"", "choice1"=>"", "choice2"=>"", "choice3"=>"", "answer"=>"", "nothing"=>"this"}, "quiz"=>{"id"=>"20"}, "commit"=>"Save Multichoicequestion", "action"=>"create", "controller"=>"multichoicequestions"}
	  
  end

  private
  
  
    def multichoicequestion_params
	params.require(:multichoicequestion).permit(:name, :question, :media, :choice_label_display_mode, :choice1, :choice2, :choice3, :answer)
  end

end
