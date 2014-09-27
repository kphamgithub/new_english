class ClozequestionsController < ApplicationController
  def new
      #@people = [{"name"=>"NameA", "id"=>"1"}]
	 @quiz_id = params[:quiz_id]
	 @lesson_id = params[:lesson_id]
  end

  def show

	 @quiz_id = params[:quiz_id]
	 @lesson_id = params[:lesson_id]
  
  @clozequestion = Clozequestion.find(params[:id])
  
  #@people = [{"name"=>"NameA", "id"=>"001"}, {"name"=>"NameB", "id"=>"002"}]
  
	str = "jupiter,mars,saturn,sun"
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
  end

  def index
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
	  
	  array_of_bracketed_strings = clozequestion.question.scan( /\[.*?\]/ )
	  
	  array_of_strings_without_brackets = Array.new
	  array_of_bracketed_strings.each do |string| 
	      array_of_strings_without_brackets.push(strip_brackets_from_string(string))
	  end
	  
	  answers_array = Array.new
	  array_of_strings_without_brackets.each do |string| 
		 if string.index(',') == nil
			answers_array.push(string)	
		 else
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
	  
	  clozequestion.answer = answers_string
	  clozequestion.save
	  #logic for add to quiz
	  if params['add_to_quiz'] != nil
       qqrow = {quiz_id: params[:quiz][:id],name: clozequestion.name, origin_id: clozequestion.id, qtype: 'Clozequestion' }
	   quizquestion = Quizquestion.new(qqrow)
    	quizquestion.save 
	  end
	  #redirect_to clozequestions_path
	  	  redirect_to lesson_quiz_path(params[:lesson_id], params[:quiz_id])
	   
  end

    def update
	  #render text: params.inspect
      clozequestion = Clozequestion.find(params[:id])
	  #if @multichoicequestion.update(params[:multichoicequestion].permit(:name, :quiz_id, :question,:media, :audio, :image, :choice_label_display_mode, :choice1, :choice2, :choice3, :answer))
	  
	  #Multichoicequestion.new(multichoicequestion_params)
	  
	  if clozequestion.update(clozequestion_params)
	  	redirect_to clozequestion_path
	  else
	    render 'edit'
	  end 
  end

  
  private
  def clozequestion_params
	params.require(:clozequestion).permit(:name, :instruction, :question, :quiz_id)
  end
  
end
