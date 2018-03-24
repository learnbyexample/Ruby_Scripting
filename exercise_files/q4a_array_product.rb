#!/usr/bin/env ruby

def product(ip)
  # code your solution here
end

raise unless product([1, 4, 21]) == 84
raise unless product([-4, 2.3e12, 77.23, 982, 0b101]) == -3.48863356e+18
raise unless product([-3, 11, 2]) == -66
raise unless product([8, 300]) == 2400
raise unless product([234, 121, 23, 945, 0]) == 0
raise unless product(1..5) == 120

puts 'all tests passed'

