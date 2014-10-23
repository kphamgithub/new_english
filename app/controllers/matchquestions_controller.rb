class MatchquestionsController < ApplicationController
  def index
    @matchquestions = Matchquestion.all
  end
  def new
     #render text: params.inspect
	 @quiz_id = params[:quiz_id]
	 @lesson_id = params[:lesson_id]
  end
  def show
	 @matchquestion = Matchquestion.find(params[:id])
  end

  def edit
	 @matchquestion = Matchquestion.find(params[:id])
  end

  def create
      #render text: params.inspect
	  matchquestion = Matchquestion.new(matchquestion_params)
      rows = []
	  row = nil
      params.each do |key,value|
		if key.include? "match_"
		   row = Hash.new
		   row["match"] = value
		elsif key.include? "answer_"
		   row["answer"] = value
		   rows.push(row)
		   row = nil
		end
	  end
	  #render text: params.inspect
	  #render text: rows.inspect
	  matchquestion.save
	  rows.each do |r|
	     matchquestion.matches.create(r)
	  end 
	  
	  if params['add_to_quiz'] != nil
        qqrow = {quiz_id: params[:quiz][:id],name: params[:matchquestion][:name], matchquestion_id: matchquestion.id, qtype: 'Matchquestion' }
	    quizquestion = Quizquestion.new(qqrow)
		quizquestion.save 
	  end
	  
	  if params['add_to_quiz'] != nil
	    my_quiz = Quiz.find(params[:quiz][:id])
		redirect_to lesson_quiz_path(my_quiz.lesson.id, params[:quiz][:id])
	  else 
	     redirect_to matchquestions_path
      end
  end
  
  def update 
	  #render text: params.inspect
      #{"utf8"=>"✓", "_method"=>"patch", "authenticity_token"=>"Ch2HUrOzZcfWQnxvIyeh5eLScLHyjELiT24voHOBNAs=", "matchquestion"=>{"name"=>"4th match question", "mode"=>"game"}, "match0"=>"car", "answer0"=>"vehicle", "match1"=>"hammer", "answer1"=>"tool", "commit"=>"Save Matchquestion", "action"=>"update", "controller"=>"matchquestions", "id"=>"9"}
	  @matchquestion = Matchquestion.find(params[:id])
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
	  
	  @matchquestion.matches.each_with_index do |match, index|
		 match.update(rows[index])
		 match.save
	  end
	  @matchquestion.update(matchquestion_params)
	  redirect_to matchquestions_path
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
	params.require(:matchquestion).permit(:name, :question, :mode)
  end
    
end
