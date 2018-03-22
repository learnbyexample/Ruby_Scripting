#!/usr/bin/env ruby

def len_int(n)
  # code your solution here
end

raise unless len_int(123) == 3
raise unless len_int(2) == 1
raise unless len_int(+42) == 2
raise unless len_int(-42) == 2
raise unless len_int(572342) == 6
raise unless len_int(962306349871524124750813401378124) == 33

begin
  len_int('a')
rescue TypeError => e
  raise unless e.message == 'provide only integer input'
end

puts 'all tests passed'
