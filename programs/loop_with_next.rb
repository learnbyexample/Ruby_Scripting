#!/usr/bin/env ruby

for i in 1..9
  next if rand(2)%2 == 0

  chr = rand(20)%3 == 1 ? '*' : '-'
  str = rand(10).to_s * i
  puts str.center(20, chr)
end

