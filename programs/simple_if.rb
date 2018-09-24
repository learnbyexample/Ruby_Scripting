#!/usr/bin/env ruby

print 'Enter an integer: '
num = Integer(gets)
char = '*'

if num%2 == 0
  char = '#'
end

fill = char * 10
puts fill + num.to_s + fill

