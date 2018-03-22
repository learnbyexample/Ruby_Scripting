#!/usr/bin/env ruby

def str_cmp(s1, s2)
  # code your solution here
end

raise unless str_cmp('abc', 'Abc')
raise unless str_cmp('Hi there', 'hi there')
raise if str_cmp('foo', 'food')
raise unless str_cmp('nice', 'nice')
raise unless str_cmp('GoOd DaY', 'gOOd dAy')
raise if str_cmp('how', 'who')

puts 'all tests passed'
