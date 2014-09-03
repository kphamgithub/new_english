	question = "[ee] My name is [test,blah] and [foo,bar,been] but his name is [oo]"
	bracket_start = false
    if question.index("[") == 0 
		bracket_start = true;
	end
	# replace bracketed option text with stars (for splitting purpose only)
	temp = question.gsub( /\[.*?\]/,'*' )  # My name is * and * and *
	array_of_normal_text = temp.split('*')

	array_of_options = question.scan( /\[.*?\]/ )
	
    @joined_array = Array.new
	#@array_of_options.each_with_index do |arr,index| 
	#	@joined_array.push(arr)
	#	@joined_array.push(array_of_normal_text[index])
	#end
	puts "size of normal text"
	puts array_of_normal_text.count

	puts "size of option array"
	puts array_of_options.count
	
	array_of_normal_text.each_with_index do |arr,index| 
		@joined_array.push(arr)
		if index == (array_of_options.count)
		  break
		else
			@joined_array.push(array_of_options[index])		
		end
	end
	puts "size of joined array"
	puts @joined_array.count
	
#array_of_strings.each do |arr| 
    #puts arr
	#arr1 = arr.chop # chops off the last character from arr and returns a new string
	#arr1.slice!(0) # slice() remove the closing square bracket from arr1
	#puts arr1
#end

"hello".gsub(/[aeiou]/, '*')                  #=> "h*ll*"
"hello".gsub(/([aeiou])/, '<\1>')             #=> "h<e>ll<o>"
"hello".gsub(/./) {|s| s.ord.to_s + ' '}      #=> "104 101 108 108 111 "
"hello".gsub(/(?<foo>[aeiou])/, '{\k<foo>}')  #=> "h{e}ll{o}"
'hello'.gsub(/[eo]/, 'e' => 3, 'o' => '*')    #=> "h3ll*"



#
string = "My phone number is [1332] 456 [99] ."  
#phone_re = /\[(\d+)\]\s+(\d{3})-(\d{4})/  
phone_re = /(\[(\d+)\]\s)/  
m = phone_re.match(string)  
unless m  
  puts "There was no match..."  
  exit  
end  
print "The whole string we started with: "  
puts m.string  
print "The entire part of the string that matched: "  
puts m[0]  
puts "The three captures: "  
3.times do |index|  
  puts "Capture ##{index + 1}: #{m.captures[index]}"  
end  
puts "Here's another way to get at the first capture:"  
print "Capture #1: "  
puts m[1]  



str = "sun,jupiter,mars,earth"
arr = str.split(',')
# arr is now:  ['sun','jupiter','mars','earth']
#puts arr.to_s
hash_array = Array.new

arr.each_with_index do |item, index|
    h = Hash.new
	h['name'] = item
	h['id'] = index.to_s
	#puts h.to_s
	hash_array.push(h)
end
#hash_array is now: [{"name"=>"sun", "id"=>"1"}, {"name"=>"jupiter", "id"=>"2"}]
#puts hash_array.to_s

grades = { "Jane Doe" => "10", "Jim Doe" => "6" }
grades1 = { "Jane Doe" => "0", "Jim Doe" => "1" }
arr = Array.new

arr.push(grades)
arr.push(grades1)

arr.each do |a|
puts a.to_s
end

  def string_to_hash(string)
	arr = string.split(',')
	hash_array = Array.new
	arr.each_with_index do |item, index|
		h = Hash.new
		h['name'] = item
		h['id'] = index.to_s
		hash_array.push(h)
	end
	return hash_array
  end

h1 = string_to_hash("test1,test2, test3");
puts h1.to_s
puts "ENDENDEND"


params = {"choice1"=>"test", "choice3"=>"foo", "answer5"=>"gg", "commit"=>"Submit", "action"=>"processquestion", "controller"=>"quizquestions", "lesson_id"=>"16", "quiz_id"=>"20", "id"=>"14"}

puts params[:choice1]