class QuizquestionresultsController < ApplicationController
  def index
     #render text: params.inspect
	 #{"action"=>"index", "controller"=>"quizquestionresults", "user_id"=>"2", "quiz_id"=>"9"}
	 
	 @user = User.find(params[:user_id])
	 @quiz = Quiz.find(params[:quiz_id])
	 #@quizquestions = @quiz.quizquestions
	 #quizquestions.each do |qq|
		#origin_id = qq.origin_id
	 #end
	 @results = Array.new
	 @quizquestionresults = Quizquestionresult.where("user_id = ? and quiz_id = ?", params[:user_id], params[:quiz_id] )
	 @quizquestionresults.each do |qqr|
		quizquestion = qqr.quizquestion
		origin_id = quizquestion.origin_id
		qtype = quizquestion.qtype
		question = nil
		correct_answer = nil
		myresult = Hash.new
		question = Fillquestion.find(origin_id)
		correct_answer = question.answer

		myresult[:question] = question.question
		myresult[:user_answer] = qqr.answer
		myresult[:correct_answer] = correct_answer
		if qqr.answer == correct_answer
			myresult[:status] = "right"
		else
			myresult[:status] = "wrong"
		end
		@results.push(myresult)
	 end	 
  end
  
  def destroy
	 #@quizquestionresults = Quizquestionresult.where("user_id = ? and quiz_id = ?", params[:user_id], params[:quiz_id] )
	 @user = User.find(params[:user_id])
	 @quiz = Quiz.find(params[:quiz_id])
	 
	  @quizquestionresult = Quizquestionresult.find(params[:id])
	  @quizquestionresult.destroy
	  redirect_to user_quiz_quizquestionresults_path
  end  
end
