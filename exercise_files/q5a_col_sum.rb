#!/usr/bin/env ruby

total = 0
File.foreach('f1.txt', mode: 'r:ASCII') do |line|
  # code your solution here, result should be in total variable
end

raise unless total == 10485.14
puts 'test passed'

