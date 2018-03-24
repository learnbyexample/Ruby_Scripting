#!/usr/bin/env ruby

def nth_lowest()
  # code your solution here
end

nums = [42, 23421341, 234.2e3, 21, 232, 12312, -2343]
raise unless nth_lowest(nums, 3) == 42
raise unless nth_lowest(nums, 5) == 12312

nums = [1, -2, 4, 2, 1, 3, 3, 5]
raise unless nth_lowest(nums) == -2
raise unless nth_lowest(nums, 4) == 3

raise unless nth_lowest('unrecognizable', 3) == 'c'
raise unless nth_lowest('jump', 2) == 'm'
raise unless nth_lowest('abracadabra', 5) == 'r'

puts 'all tests passed'

