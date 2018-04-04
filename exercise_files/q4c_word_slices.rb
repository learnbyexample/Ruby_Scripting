#!/usr/bin/env ruby

def word_slices(s)
  # code your solution here
end

raise unless word_slices('i') == ["i"]
raise unless word_slices('to') == ["to"]
raise unless word_slices('are') == ["ar", "are", "re"]
raise unless word_slices('boat') == ["bo", "boa", "boat", "oa", "oat", "at"]
raise unless word_slices('table') == ["ta", "tab", "tabl", "table", "ab",
                                      "abl", "able", "bl", "ble", "le"]

puts 'all tests passed'

