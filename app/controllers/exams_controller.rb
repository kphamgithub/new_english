class ExamsController < ApplicationController
  def new
  end

  def index
	@exams = Exam.all
  end

  def show
	@exam = Exam.find(params[:id])
  end
  
  def create
	  #render text: params[:exam].inspect    
	  @exam = Exam.create(exam_params)
	  redirect_to @exam
  end
  
  private
  def exam_params
	params.require(:exam).permit(:name)
  end
end
