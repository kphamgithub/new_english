class MatchquestionsController < ApplicationController
  def index
  end
  def new
  end
  def show
	 @matchquestion = Matchquestion.find(params[:id])
  end

  def create
      rows = []
	  row = nil
      params.each do |key,value|
		if key.include? "left"
		   row = Hash.new
		   row["match_id"] = params["match_id"]
		   row["left"] = value
		elsif key.include? "right"
		   row["right"] = value
		   rows.push(row)
		   row = nil
		end
	  end
	  #render text: params.inspect
	  #render text: rows.inspect
	  rows.each_with_index do |r|
		 match = Match.new(r)
		 match.save
	  end
	  render text: rows.inspect
	  
	  #@matchquestion = Matchquestion.new(matchquestion_params)
	  #@matchquestion.save
	  #redirect_to @matchquestion
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
