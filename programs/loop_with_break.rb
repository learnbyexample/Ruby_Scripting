#!/usr/bin/env ruby

while true
  rand_num = rand(1..500)
  break if rand_num%4 == 0 && rand_num%6 == 0
end

puts "Random number divisible by 4 and 6: #{rand_num}"

