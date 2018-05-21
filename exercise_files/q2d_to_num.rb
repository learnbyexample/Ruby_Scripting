#!/usr/bin/env ruby

def num(ip)
  # code your solution here
end

raise unless num(3) == 3
raise unless num(0x1f) == 31
raise unless num(0b101) == 5
raise unless num(010) == 8
raise unless num(3.32) == 3.32
raise unless num('123') == 123
raise unless num('-78') == -78
raise unless num(" 42  \n ") == 42
raise unless num('3.14') == 3.14
raise unless num('3.982e5') == 398200.0
s = '56'
raise unless num(s) + 44 == 100
s = '8' * 10
raise unless num(s) == 8888888888

raise unless num('42').class == Integer
raise unless num('1.23').class == Float

begin
  num('foo')
rescue ArgumentError => e
  raise unless e.message == 'could not convert string to int or float'
end

begin
  num(['1', '2.3'])
rescue TypeError => e
  raise unless e.message == 'not a valid input'
end

puts 'all tests passed'
