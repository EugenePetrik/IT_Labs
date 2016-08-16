# -*- encoding : utf-8 -*-

# 1. Create a method which will take a natural number as an argument and will find a sum of all its digits

puts "===== Task #1 =====" 

def sum_number(number)
  number.to_s.split("").map(&:to_i).inject(:+)
end

puts "A sum of digits equals - #{sum_number(1234)}" 



# 2. There is a string. Find a maximum number of digits placed in a row in it

puts "===== Task #2 =====" 

str = "There is a str22ing w3ith 0000000159753. And it's t311oo123 string - 745862"

puts str.scan(/\d+/).max_by(&:length)



# 3. There is a string. Find a maximal number (not a digit) in it

puts "===== Task #3 =====" 

str = "There is a str22ing w3ith 0000000159753. And it's t311oo123 string - 745862"

puts str.scan(/\d+/).max_by(&:to_i)



# 4. There are two strings. Find number of first chars from first string matching first chars of the second string. Consider two cases:

    # strings are definitely different
    # strings can completely match

puts "===== Task #4 =====" 

str1 = "strings are definitely different"
str2 = "strings can completely match"

ar2 = str2.split //

count = 0

str1.split(//).each_with_index { |element, index|  ar2[index] == element ? count += 1 : (break if count !=0) }

count



# 5. There is an array of integers. First puts elements with even indexes and then with odd indexes

puts "===== Task #5 =====" 

arr = [45, 89, 123, 89, 46, 3, 9, 10, 98]

puts "Odd indexes:"
arr.each_with_index do |element, index|
  if index.odd?
    puts "Index #{index} = #{element}"
  end
end

puts "Even indexes:"
arr.each_with_index do |element, index|
  if index.even?
    puts "Index #{index} = #{element}"
  end
end



# 6. There is an array of integers (ary). Puts the index of the last element where ary[0]<ary[i]<ary[-1]

puts "===== Task #6 =====" 

last = arr.select {|i| i > arr[0] && i < arr[-1]}.last
arr.rindex(last)



# 7. There is an array of integers (ary). Modify it with adding ary[0] (first element of the array) to each even number. 
# Don't do it for first and last elements

puts "===== Task #7 =====" 

a = [10, 456, 45, 78, 314, 1, 63, 8, 19]

a.each_with_index do |element, index|
  next if a.last == element || a.first == element

  a[index] += a[0] if element.even?
end

puts a



# 8. There is a hash where keys and values are strings. Modify it: all keys should be symbols and all values should be integers. 
# If you couldn't modify some value set it to nil

puts "===== Task #8 =====" 

hh8 = { 'name1' => 'John', 'last_name1' => 'Smith', 'age1' => '20', 'name2' => 'Matt', 'last_name2' => 'Walker', 'age2' => '25' }

# puts hh8.each { |key, value| puts "#{key.to_sym} = #{value}" }

# puts hh8.inject({}){ |memo,(key,value)| memo[key.to_sym] = value; memo }

puts result = hh8.inject({}) { |result,(key, value)|
    if value.match(/\d/)
            result[key.to_sym] = value.to_i
    else
            result[key.to_sym] = nil
    end
    result
}



# 9. There is a hash where keys are symbols and values are integers. Modify it: remove all pairs where symbols start with "s" character

puts "===== Task #9 =====" 

hh9 = { last_name1: 1, surname1: 1, age1: 20, name2: 2, surname2: 2, age2: 25 }

puts hh9.delete_if { |k, _| k.to_s[0] == 's' }

puts hh9.delete_if { |k, _| k.to_s.start_with? == 's' }



# 10. There is a hash where keys are symbols and values are integers. Modify it: leave only pairs where value is natural number and more than 0

puts "===== Task #10 =====" 

hh10 = { last_name1: 0, surname1: 1.5, age1: 20, name2: 2.9, surname2: 2.1, age2: 25.6 }

puts hh10.delete_if { |_, value| value%1 != 0 || value < 1 }
