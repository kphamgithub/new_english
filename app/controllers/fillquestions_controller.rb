class FillquestionsController < ApplicationController
  def index
     @fillquestions = Fillquestion.all
  end

  def new
     #render text: params.inspect
	 #{"lesson_id"=>"16", "quiz_id"=>"20", "action"=>"new", "controller"=>"fillquestions"}
	 @quiz = Quiz.find(params[:quiz_id])
     if params[:voca_id] != nil   # new question link from vocabulary path
	     @vocabulary = Vocabulary.find(params[:voca_id])
	 end
  end
  
  
  def show
	 @fillquestion = Fillquestion.find(params[:id])
  end
  
  
  def create
	  render text: params.inspect 
#"fillquestion"=>{"name"=>"v", "question"=>"v", "vocabulary"=>"d"}, "quiz"=>{"id"=>"20"}, "create_quizquestion"=>"1", "commit"=>"Save Fillquestion", "action"=>"create", "controller"=>"fillquestions"}


	  
  end
  
  private
  def fillquestion_params
	params.require(:fillquestion).permit(:name, :question, :quiz_id)
  end
end
