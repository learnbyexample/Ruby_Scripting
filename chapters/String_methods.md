# <a name="string-methods"></a>String Methods

**Table of Contents**

* [String formatting](#string-formatting)
* [Looping](#looping)
* [Case conversion](#case-conversion)
* [Search and Replace](#search-and-replace)

<br>

## <a name="string-formatting"></a>String formatting

See [ruby-doc: sprintf](https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-sprintf) for details on all the available formatting options, includes examples as well

* floating point precision

```ruby
>> appx_pi = 22.0 / 7
=> 3.142857142857143

>> '%f' % appx_pi
=> "3.142857"
>> '%.2f' % appx_pi
=> "3.14"
# rounding happens if digit after required precision is >= 5
>> '%.3f' % appx_pi
=> "3.143"

# E-scientific notation
>> '%e' % appx_pi
=> "3.142857e+00"
>> '%.5e' % (42 ** 35)
=> "6.51216e+56"
```

* different base

```ruby
>> num = 42
=> 42

>> '%d' % num
=> "42"
>> '%b' % num
=> "101010"
>> '%o' % num
=> "52"

# along with prefix
# use B/O/X for uppercase
>> '%#b' % num
=> "0b101010"
>> '%#x' % num
=> "0x2a"
```

* number aligning and zero filling

```ruby
# left or right align number using space character
>> 'foo:%5d:baz' % 42
=> "foo:   42:baz"
>> 'foo:%-5d:baz' % 42
=> "foo:42   :baz"

# adding sign and negative number input
>> 'foo:%+5d:baz' % 42
=> "foo:  +42:baz"
>> 'foo:%5d:baz' % -42
=> "foo:  -42:baz"

# number length greater than format specified
>> 'foo:%5d:baz' % 12345678
=> "foo:12345678:baz"

# zero fill instead of space
>> 'foo:%010.2f:baz' % (22.0/7)
=> "foo:0000003.14:baz"
```

* for strings

```ruby
# truncates string if precision is less than string length
>> '%.3s' % 'foobaz'
=> "foo"

# left or right align string using space character
# use ljust/rjust methods for padding with other than space character
>> '123:%10s:456' % 'hello'
=> "123:     hello:456"
>> '123:%-10s:456' % 'hello'
=> "123:hello     :456"
```

* multiple arguments

```ruby
>> 'I bought %d %s' % [5, 'apples']
=> "I bought 5 apples"

>> 'I bought %<qty>d %<fruit>s' % {qty: 5, fruit: 'apples'}
=> "I bought 5 apples"

# specifying length and precision as arguments
>> 'foo:%01$*2$.2f:baz' % [22.0 / 7, 10]
=> "foo:0000003.14:baz"
>> 'foo:%01$*2$.*3$f:baz' % [22.0 / 7, 10, 3]
=> "foo:000003.143:baz"
```

* use `printf` method for print functionality with formatting
* `sprintf` method can be used instead of `%` operator to get formatted string

```ruby
>> printf "I bought %d %s\n", 5, 'apples'
I bought 5 apples
=> nil

>> s = sprintf("I bought %d %s", 5, 'apples')
=> "I bought 5 apples"
>> puts s
I bought 5 apples
=> nil
```

<br>

## <a name="looping"></a>Looping

* to iterate over a string character by character, convert the string to an array using `chars` method and use `for` loop

```ruby
>> s = 'hello'
=> "hello"

>> for c in str.chars
>>   puts c
>> end
h
e
l
l
o
=> ["h", "e", "l", "l", "o"]
```

* or use `each_char` method

```ruby
>> str = 'hello'
=> "hello"

>> str.each_char { |c| puts c }
h
e
l
l
o
=> "hello"
```

<br>

## <a name="case-conversion"></a>Case conversion

* Examples below shown only for ASCII letters
    * See [ruby-doc: downcase](https://ruby-doc.org/core-2.5.0/String.html#method-i-downcase) for details on encoding and options
* use `!` versions for in-place modification
    * also, the `!` versions return `nil` if no changes were made, useful for decision making

```ruby
>> s = 'hi tHeRe. haVe A GooD Day'
=> "hi tHeRe. haVe A GooD Day"

# change first character to upper case, rest all lower case
>> s.capitalize
=> "Hi there. have a good day"
>> '12 heLLo'.capitalize
=> "12 hello"

# change all characters to lower case
>> s.downcase
=> "hi there. have a good day"

# change all characters to upper case
>> s.upcase
=> "HI THERE. HAVE A GOOD DAY"

# change upper case characters to lower case and vice versa
>> s.swapcase
=> "HI ThErE. HAvE a gOOd dAY"
```

<br>

## <a name="search-and-replace"></a>Search and Replace

Regular expression based processing will be covered separately in next chapter

* check whether a string is sub-string of another

```ruby
>> sentence = 'This is a sample string'
=> "This is a sample string"

>> sentence.include?('is')
=> true
>> sentence.include?('is a')
=> true
>> sentence.include?('amp')
=> true

>> sentence.include?('this')
=> false
>> sentence.downcase.include?('this')
=> true
```

* number of non-overlapping matches

```ruby
# scan returns all matches as an array
>> 'This is a sample string'.scan('is')
=> ["is", "is"]
>> 'This is a sample string'.scan('is').length
=> 2

>> 'phototonic'.scan('oto')
=> ["oto"]
>> 'phototonic'.scan('oto').length
=> 1
```

* number of times given character(s) are present

```ruby
>> 'hello'.count('l')
=> 2
>> 'hello'.count('lh')
=> 3

>> 'This is a sample string'.count('i')
=> 3
>> 'This is a sample string'.count(' ')
=> 4
>> 'This is a sample string'.count('is')
=> 7
```

* matching start/end of string
* more than one argument can be given to be checked

```ruby
>> words = %w[hello hi history healing]
=> ["hello", "hi", "history", "healing"]

>> words[0].start_with?('he')
=> true
>> words[1].start_with?('he')
=> false

>> words[2].end_with?('ry')
=> true
>> words[3].end_with?('ry')
=> false

>> words.select { |w| w.start_with?('he', 'his') }
=> ["hello", "history", "healing"]
>> words.select { |w| w.end_with?('i', 'e', 'g') }
=> ["hi", "healing"]
```

* replace first/all matching string with another
* use `!` versions for in-place modification

```ruby
# replace only first match
>> 'hi there'.sub('hi', 'hello')
=> "hello there"
>> '2 be or not 2 be'.sub('2', 'to')
=> "to be or not 2 be"

# replace all matches
>> '2 be or not 2 be'.gsub('2', 'to')
=> "to be or not to be"
```





