class ExamquestionsController < ApplicationController
  def index
  end
  def new
     @exam = Exam.find(params[:exam_id])
	  #if @quiz.quiz_type == 'vocabulary'
		#   voca_quiz = true
	  #elsif @quiz.quiz_type == 'grammar'
		#   grammar_quiz = true
	  #elsif @quiz.quiz_type == 'general'
		#   general_quiz = true 
	  #end
	  @available_questions = []
        multichoicequestions = Multichoicequestion.all
		multichoicequestions.each do |mcq|
		    #search quiz questions
			found = false
			@exam.examquestions.each do |qq|
				if qq.qtype == "Matchquestion" and qq.origin_id == 	  mcq.id
					found = true
					break
				end
			end
			if found == false
			    #if voca_quiz and mcq.vocabulary_id != nil
				    #if mcq.vocabulary_id != nil
					@available_questions.push(mcq)
				#end
			end
	    end	   
	    #render text: @available_questions.count
		
		
		fillquestions = Fillquestion.all
		fillquestions.each do |fq|
		    #search quiz questions
			found = false
			@exam.examquestions.each do |qq|
				if qq.qtype == "Matchquestion" and qq.origin_id == 	  fq.id
					found = true
					break
				end
			end
			if found == false
				@available_questions.push(fq)
			end
	    end	   
      #render text: @available_questions.count
	  #render text: @quiz.id
		match_questions = Matchquestion.all
		match_questions.each do |mq|
		    #search quiz questions
			found = false
			@exam.examquestions.each do |qq|
				if qq.qtype == "Matchquestion" and qq.origin_id == mq.id
				found = true
				break
				end
			end
			if found == false
				@available_questions.push(mq)
			end
	    end	   

		#@sorted_available_questions = @available_questions.sort_by.reverse do |item|
		##	item[:created_at]
		#end 
		@sorted_available_questions = @available_questions.sort_by(&:created_at).reverse

  end
end
