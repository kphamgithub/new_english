module ApplicationHelper
  def replace_str(string)
	string.gsub( /\[.*?\]/,'*' )
  end
  def string_to_hash_array(string)
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
  def strip_brackets_from_string(string)
	str1 = string.chop # chops off the last character from string and returns a new string
	str1.slice!(0) # slice() remove the opening square bracket from str1
	return str1
  end
end
