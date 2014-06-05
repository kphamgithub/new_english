class MatchquestionsController < ApplicationController
  def index
  end
  def new
  end
  def show
	 @matchquestion = Matchquestion.find(params[:id])
  end

  def create
	  #render text: params[:multichoicequestion].inspect    
	  @matchquestion = Matchquestion.new(matchquestion_params)
	  @matchquestion.save
	  redirect_to @matchquestion
  end
  def take
      @matchquestion = Matchquestion.find(params[:id])
	  @people = {"id"=> "1", "name" => "kevin"}
	  
  end
  def process_question
      #render text: "proceess"
	  render text: params.inspect
  end
  
  private
  def matchquestion_params
	params.require(:matchquestion).permit(:name, :question, :match_id, :m1, :m2)
  end
end
