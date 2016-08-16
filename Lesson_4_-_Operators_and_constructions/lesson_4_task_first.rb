a = 0

while a < 10
  rand = rand(0..9)
  
  puts "========="
  puts "The random number equals #{rand}"

  if rand.odd?
    puts "The number is odd = #{rand}"
  else
    puts "The number is even = #{rand}"
  end

  if rand <= 5 && rand != 0
    puts "The number is less than 5 or equals 5"
  elsif rand > 5
    puts "The number is more than 5"
  end

  case 
    when rand == 0
      puts "We've got 0"
    when rand <= 5 && rand != 0
      puts "The number is less than 5 or equals 5"
    else
      puts "The number is more than 5"
  end

  puts "=========" if a == 9

  a += 1
end
