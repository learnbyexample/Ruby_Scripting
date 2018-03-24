#!/usr/bin/env ruby

def is_one_char_diff(w1, w2)
  # code your solution here
end

raise unless is_one_char_diff('bar', 'car')
raise unless is_one_char_diff('bar', 'Bat')
raise unless is_one_char_diff('bar', 'bar')
raise unless is_one_char_diff('bar', 'baZ')
raise unless is_one_char_diff('A', 'b')

raise if is_one_char_diff('a', '')
raise if is_one_char_diff('bar', 'bark')
raise if is_one_char_diff('bar', 'Art')
raise if is_one_char_diff('bar', 'bot')
raise if is_one_char_diff('ab', '')

raise unless is_one_char_diff('Food', 'good')
raise unless is_one_char_diff('food', 'fold')
raise if is_one_char_diff('food', 'Foody')
raise if is_one_char_diff('food', 'fled')

puts 'all tests passed'

