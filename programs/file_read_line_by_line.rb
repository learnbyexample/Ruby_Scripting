#!/usr/bin/env ruby

filename = 'greeting.txt'
File.open(filename) do |f|
  puts "Contents of #{filename}:"
  f.each { |line| puts line }
end

