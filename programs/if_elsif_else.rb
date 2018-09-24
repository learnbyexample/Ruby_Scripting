#!/usr/bin/env ruby

num = 42

print 'Enter an integer: '
guess = Integer(gets)

if guess == num
  puts 'Whoa! you guessed it right'
elsif guess > num
  puts 'Oops, you guessed too high'
else
  puts 'Oops, you guessed too low'
end

