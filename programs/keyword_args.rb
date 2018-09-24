#!/usr/bin/env ruby

def greeting(msg, style_char: '*', fill: 5)
  gr_len = msg.size + 2*fill
  gr_dec = style_char * gr_len
  puts gr_dec, msg.center(gr_len), gr_dec
end

greeting('hi')
greeting('oh', style_char: '=')
greeting('42', fill: 2, style_char: '%')
greeting('3.14', fill: 1)    

