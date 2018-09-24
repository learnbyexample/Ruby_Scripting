#!/usr/bin/env ruby

cmd1 = 'ls out.txt'
cmd2 = 'grep "foo" out.txt'
cmd3 = 'xyz'

for cmd in [cmd1, cmd2, cmd3]
  puts "Command: #{cmd}"
  rv = system(cmd)

  # inspect method will display human readable representation of object
  puts "system return value: #{rv.inspect}"
  puts "Command exit status: #{$?.exitstatus}"
  puts '-' * 30
end

