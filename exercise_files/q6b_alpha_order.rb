#!/usr/bin/env ruby

def is_alpha_order(ip)
  # code your solution here
end

raise unless is_alpha_order('bot')
raise unless is_alpha_order('art')
raise unless is_alpha_order('toe')
raise unless is_alpha_order('AborT')

raise if is_alpha_order('are')
raise if is_alpha_order('boat')
raise if is_alpha_order('Flee')

raise unless is_alpha_order('Toe got bit')
raise if is_alpha_order('All is well')
raise if is_alpha_order('Food is good')

puts 'all tests passed'

