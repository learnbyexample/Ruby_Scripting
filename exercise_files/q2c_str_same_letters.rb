#!/usr/bin/env ruby

def str_anagram(s1, s2)
  # code your solution here
end

raise unless str_anagram('god', 'Dog')
raise unless str_anagram('beat', 'abet')
raise unless str_anagram('Tap', 'paT')
raise if str_anagram('beat', 'table')
raise if str_anagram('seat', 'teal')

puts 'all tests passed'
