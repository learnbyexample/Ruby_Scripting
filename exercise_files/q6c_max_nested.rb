#!/usr/bin/env ruby

def max_nested_braces(expr)
  # code your solution here
end

raise unless max_nested_braces('a*b') == 0
raise unless max_nested_braces('a*b{') == -1
raise unless max_nested_braces('a*{b+c}') == 1
raise unless max_nested_braces('{a+2}*{b+c}') == 1
raise unless max_nested_braces('a*{b+c*{e*3.14}}') == 2
raise unless max_nested_braces('a*{b+c*{e*3.14}}}') == -1
raise unless max_nested_braces('a*{b+c}}') == -1
raise unless max_nested_braces('}a+b{') == -1
raise unless max_nested_braces('{{a+2}*{b+c}+e}') == 2
raise unless max_nested_braces('{{a+2}*{b+{c*d}}+e}') == 3
raise unless max_nested_braces('{{a+2}*{{b+{c*d}}+e*d}}') == 4
raise unless max_nested_braces('{{a+2}*{{b}+{c*d}}+e*d}}') == -1
raise unless max_nested_braces('a*b+{}') == -1
raise unless max_nested_braces('a*{b+{}+c*{e*3.14}}') == -1

puts 'all tests passed'

