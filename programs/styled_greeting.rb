#!/usr/bin/env ruby

def greeting(msg, style_char='*', fill=5)
  gr_len = msg.size + 2*fill
  gr_dec = style_char * gr_len
  puts gr_dec, msg.center(gr_len), gr_dec
end

# both style_char and fill left out to use their defaults
greeting('hi')
# changing style_char, fill will use the default
greeting('oh', style_char='=')
# changing both the defaults
greeting('42', style_char='%', fill=2)
# cannot change fill alone due to these being positional arguments
greeting('3.14', style_char='*', fill=1)    

