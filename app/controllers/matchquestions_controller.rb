class MatchquestionsController < ApplicationController
  def index
    @matchquestions = Matchquestion.all
  end
  def new
	 @quiz_id = params[:quiz_id]
	 @lesson_id = params[:lesson_id]
  end
  def show
	 @matchquestion = Matchquestion.find(params[:id])
  end

  def create
      @matchquestion = Matchquestion.create({"name" => params["name"]})
      rows = []
	  row = nil
      params.each do |key,value|
		if key.include? "match"
		   row = Hash.new
		   row["match"] = value
		elsif key.include? "answer"
		   row["answer"] = value
		   rows.push(row)
		   row = nil
		end
	  end
	  #render text: params.inspect
	  #render text: rows.inspect
	  rows.each do |r|
	     @matchquestion.matches.create(r)
	  end
	  @matchquestion.save
	  #render text: rows.inspect	  
	  redirect_to lesson_quiz_path(params[:lesson_id], params[:quiz_id])

  end
  
  def destroy
	  #render text: params[:id].inspect
      matchquestion = Matchquestion.find(params[:id])
	  matchquestion.destroy
	  redirect_to matchquestions_path
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
