class ClozequestionsController < ApplicationController
  def new
     #@people = [{"name"=>"NameA", "id"=>"1"}]
	 @quiz_id = params[:quiz_id]
	 @lesson_id = params[:lesson_id]
	 @clozequestion = Clozequestion.new
	 2.times { @clozequestion.question_clozequestions.build}
  end

  def show

	 @quiz_id = params[:quiz_id]
	 @lesson_id = params[:lesson_id]
  
  @clozequestion = Clozequestion.find(params[:id])
  
  #@people = [{"name"=>"NameA", "id"=>"001"}, {"name"=>"NameB", "id"=>"002"}]
      #@clozequestion.question_clozequestions.each do |my_question|
		#temp = my_question.question.gsub( /\[.*?\]/,'*' )  # My name is * and * and *
	  #end 
	  
=begin
	question = @clozequestion.question #"My name is [test,blah] and [foo,bar,been] but his name is [oo]"
	# replace bracketed option text with stars (for splitting purpose only)
	temp = question.gsub( /\[.*?\]/,'*' )  # My name is * and * and *
	array_of_normal_text = temp.split('*')

	array_of_bracketed_strings = question.scan( /\[.*?\]/ )
	# [ [ee], [test,blah], [foo,bar,been], [oo] ]
	
    @joined_array = Array.new
	array_of_normal_text.each_with_index do |arr,index| 
		@joined_array.push(arr)
		if index == (array_of_bracketed_strings.count)
		  break
		else
			@joined_array.push(array_of_bracketed_strings[index])
		end
	end
		
	arr = str.split(',')
	# arr is now:  ['sun','jupiter','mars','earth']
	#puts arr.to_s
	@hash_array = Array.new

	arr.each_with_index do |item, index|
		h = Hash.new
		h['name'] = item
		h['id'] = index.to_s
		#puts h.to_s
		@hash_array.push(h)
	end
=end
  end

  def index
    @clozequestions = Clozequestion.all
  end
  
  def strip_brackets_from_string(string)
	str1 = string.chop # chops off the last character from string and returns a new string
	str1.slice!(0) # slice() remove the closing square bracket from str1
	return str1
  end

  def edit
     @clozequestion = Clozequestion.find(params[:id])
  end
  
  def create
	  #render text: params.inspect    
	  #render text: params[][:quiz][:id]    
	  clozequestion = Clozequestion.new(clozequestion_params)
	  
	  # Example question: tigers are [animals, vehicles, tools] and cars are [vehicles, toys, buildings]
	  # the string "animals" and the string "vehicles" comprise the answer string
	  clozequestion.question_clozequestions.each do |my_question|
		my_question.answer = get_answer_string(my_question.question)
	  end # each question loop
	  
	  clozequestion.save
	  
	  #logic for add to quiz
	  if params['add_to_quiz'] != nil
       qqrow = {quiz_id: params[:quiz_id],name: clozequestion.name, clozequestion_id: clozequestion.id, qtype: 'Clozequestion' }
	   quizquestion = Quizquestion.new(qqrow)
    	quizquestion.save 
	  end
	  if params['add_to_quiz'] != nil
	    my_quiz = Quiz.find(params[:quiz_id])
		redirect_to lesson_quiz_path(my_quiz.lesson.id, params[:quiz_id])
	  else 
	     redirect_to clozequestions_path
      end	   
  end

    def update
	  #render text: params.inspect
      clozequestion = Clozequestion.find(params[:id])	  
	  clozequestion.question_clozequestions.each do |my_question|
		my_question.answer = get_answer_string(my_question.question) #answers_string
	  end # each question loop

	  if clozequestion.update(clozequestion_params)
	  	redirect_to clozequestion_path
	  else
	    render 'edit'
	  end 
  end

  def destroy
	  #render text: params[:id].inspect
      clozequestion = Matchquestion.find(params[:id])
	  clozequestion.destroy
	  redirect_to clozequestions_path
  end

  
  private
  def clozequestion_params
	params.require(:clozequestion).permit(:name, :instruction, :question, :quiz_id, question_clozequestions_attributes: [:id,:question])
  end
  def get_answer_string(question)
     array_of_bracketed_strings = question.scan( /\[.*?\]/ )
	  #array_of_bracketed_strings will contain the strings: "[animals, vehicles, tools]" and "[vehicles, toys, buildings]"
	  
	  array_of_strings_without_brackets = Array.new
	  array_of_bracketed_strings.each do |string| 
	      array_of_strings_without_brackets.push(strip_brackets_from_string(string))
	  end
	  
	  answers_array = Array.new
	  array_of_strings_without_brackets.each do |string| 
		 if string.index(',') == nil   # there is only one choice string ( text field input)
			answers_array.push(string)	
		 else   # many choices, dropdown box
		    option_array = string.split(',')
		    answers_array.push(option_array[0])	
		 end
	  end
	  answers_string = ''
	  answers_array.each_with_index do |string,index|
	    answers_string << string
		if index < (answers_array.count-1)
			answers_string << ','
		end
	  end
	  return answers_string
  end  # function get_answer_string
end
