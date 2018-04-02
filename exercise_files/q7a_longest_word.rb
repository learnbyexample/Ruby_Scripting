#!/usr/bin/env ruby

# code your solution here

ip_path = 'poem.txt'
raise unless longest_word(ip_path) == 'Violets'

# The Scarlet Pimpernel
ip_path = 'https://www.gutenberg.org/files/60/60.txt'
raise unless longest_word(ip_path, true) == 'misunderstandings'

puts 'all tests passed'

