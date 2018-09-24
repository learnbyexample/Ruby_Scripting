#!/usr/bin/env ruby

ip_str = 'foo'
while ip_str != ip_str.reverse
  print 'Enter a palindrome word: '
  ip_str = gets.chomp.upcase
end

