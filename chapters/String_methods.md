# <a name="string-methods"></a>String Methods

**Table of Contents**

* [String formatting](#string-formatting)
* [Looping](#looping)
* [Condition checks](#condition-checks)
* [Case conversion](#case-conversion)
* [Search and Replace](#search-and-replace)
* [Splitting](#splitting)
* [Character manipulations](#character-manipulations)
* [Miscellaneous](#miscellaneous)

<br>

Some of the methods like `chomp` were covered in earlier chapters and won't be discussed here

Slicing syntax is similar to arrays, see [Array slicing](./Arrays.md#slicing) section for details

```ruby
>> s = 'hello'
=> "hello"

>> s[1]
=> "e"

>> s[1..3]
=> "ell"
>> s[-2..-1]
=> "lo"

>> s[1..-2] = 'al'
=> "al"
>> s
=> "halo"
```

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

* padding given characters(default is space) if input string length is less than specified output string size

```ruby
>> 'hello'.ljust(10)
=> "hello     "
>> 'hello'.ljust(10, '*')
=> "hello*****"
>> 'hello'.ljust(10, 'XYZ')
=> "helloXYZXY"

>> 'hello'.rjust(10)
=> "     hello"
>> 'hello'.rjust(10, '-')
=> "-----hello"
>> 'hello'.rjust(10, 'ABC')
=> "ABCABhello"

>> 'hi'.center(10)
=> "    hi    "
>> 'hi'.center(10, '*')
=> "****hi****"
>> '123'.center(10, 'ab')
=> "aba123abab"
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

* or, use `each_char` method

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

* `each_line` method will iterate by splitting the input string into records
    * default record separator is newline character
    * if empty string is given as separator, iteration happens over paragraphs - i.e split happens when there is one or more consecutive empty lines
* the items so obtained every iteration will include the record separator as well
    * for paragraph mode, more than 2 consecutive newlines are trimmed off
* See [ruby-doc: each_line](https://ruby-doc.org/core-2.5.0/String.html#method-i-each_line) for more options and details

```ruby
>> s = "foo\nbaz\n123"
=> "foo\nbaz\n123"
>> s.each_line { |line| puts line.inspect }
"foo\n"
"baz\n"
"123"
=> "foo\nbaz\n123"

>> 'a:b:c:'.each_line(':') { |f| puts "--#{f}--" }
--a:--
--b:--
--c:--
=> "a:b:c:"

>> "1\n\n\n\n\n2\n\n3".each_line('') { |line| puts line.inspect }
"1\n\n"
"2\n\n"
"3"
=> "1\n\n\n\n\n2\n\n3"
```

* when record separator is not given while calling `each_line` method, it uses the global variable `$/` whose default value is newline character
* the `chomp` method uses the `$/` variable as well if no argument is passed

```ruby
>> puts $/.inspect
"\n"
=> nil

>> $/ = ':'
=> ":"

>> 'a:b:c:'.each_line { |f| puts "--#{f}--" }
--a:--
--b:--
--c:--
=> "a:b:c:"

>> 'a:b:c:'.each_line { |f| puts "--#{f.chomp}--" }
--a--
--b--
--c--
=> "a:b:c:"
```

* the `lines` method is a shortcut for `each_line(sep).to_a`

```ruby
>> puts $/.inspect
"\n"
=> nil
>> "foo\nbaz\n123".lines
=> ["foo\n", "baz\n", "123"]

>> '1:2:3:'.lines(':')
=> ["1:", "2:", "3:"]

>> $/ = '-'
=> "-"
>> 'a-b-c'.lines
=> ["a-", "b-", "c"]
```

<br>

## <a name="condition-checks"></a>Condition checks

* whether the string is ASCII or not

```ruby
>> 'hi5'.ascii_only?
=> true

>> 'hi👍'.ascii_only?
=> false
>> 'foo — baz'.ascii_only?
=> false
```

* compare strings irrespective of case

```ruby
>> 'hi tHeRe'.casecmp?('Hi THERe')
=> true
>> 'hi there'.casecmp?('Hi There!')
=> false

>> 'ｇｏｏＤ ｍＯＲＮｉｎｇ'.casecmp?('Ｇｏｏｄ Ｍｏｒｎｉｎｇ')
=> true
```

* checking if a string has any characters or not

```ruby
>> s = ''
=> ""

>> s == ''
=> true
>> s.empty?
=> true

>> 'a'.empty?
=> false
```

* See also [Search and Replace](#search-and-replace) section for some more condition check methods

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

Regular expression based processing is be covered separately in [next chapter](./Regular_expressions.md)

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

* deleting part of string at start/end
* use `!` versions for in-place modification

```ruby
>> 'hello'.delete_prefix('he')
=> "llo"
>> 'hello'.delete_prefix('hey')
=> "hello"

>> 'history'.delete_suffix('ry')
=> "histo"

>> words = %w[spare hear rare spear]
=> ["spare", "hear", "rare", "spear"]
>> words.map { |w| w.delete_prefix('sp') }
=> ["are", "hear", "rare", "ear"]
>> words.map { |w| w.delete_suffix('re') }
=> ["spa", "hear", "ra", "spear"]
```

* replace first/all matching string with another
    * `block` form is also supported
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

# block form illustration
>> 'hi there'.sub('hi') { 'hello' }
=> "hello there"
>> 'hi there'.sub('hi') { |s| s.upcase }
=> "HI there"
>> 'hi there'.sub('hi') do |s|
?>   a = 2 ** 4
>>   "#{s.capitalize} #{a}"
>> end
=> "Hi 16 there"
```

<br>

## <a name="splitting"></a>Splitting

* by default, `split` uses contiguous sequence of whitespace characters to divide the given string
    * whitespace characters are space, tab(both horizontal and vertical), newline, carriage return and form feed
* in addition, leading and trailing whitespace characters are trimmed from input string
* this behavior is also the case when single space character is specified as the separator
* See [ruby-doc: split](https://ruby-doc.org/core-2.5.0/String.html#method-i-split) for details

```ruby
>> "      a  \v\f  ate b\tc   \r\n123          ".split
=> ["a", "ate", "b", "c", "123"]
>> "      a  \v\f  ate b\tc   \r\n123          ".split(' ')
=> ["a", "ate", "b", "c", "123"]

>> 'This is a sample string'.split
=> ["This", "is", "a", "sample", "string"]
>> 'This is a sample string'.split('is')
=> ["Th", " ", " a sample string"]

>> 'foo:baz:good:hi'.split(':')
=> ["foo", "baz", "good", "hi"]

# same as: 'hello'.chars
>> 'hello'.split('')
=> ["h", "e", "l", "l", "o"]
```

* a count can be given as second argument to specify max number of elements in output array
* a negative count is needed if trailing empty fields should not be removed

```ruby
>> 'foo:baz:good:hi'.split(':', 2)
=> ["foo", "baz:good:hi"]
>> 'foo:baz:good:hi'.split(':', 10)
=> ["foo", "baz", "good", "hi"]

>> ',a,b,,d,,'.split(',')
=> ["", "a", "b", "", "d"]
>> ',a,b,,d,,'.split(',', -2)
=> ["", "a", "b", "", "d", "", ""]

>> ' a b'.split(' ', -1)
=> ["a", "b"]
>> ' a b   '.split
=> ["a", "b"]
>> ' a b   '.split(' ', -1)
=> ["a", "b", ""]
# use regex(covered in next chapter) to avoid default whitespace trimming
>> ' a b   '.split(/ /, -1)
=> ["", "a", "b", "", "", ""]
```

* when no separator is passed to `split` or if `nil` is passed as separator, value of global variable `$;` is used
* by default, value of `$;` is `nil`

```ruby
>> $;.inspect
=> "nil"

>> 'foo bar'.split
=> ["foo", "bar"]
>> 'foo bar'.split(nil)
=> ["foo", "bar"]

>> $; = ':'
=> ":"
>> '1:2:3:4'.split
=> ["1", "2", "3", "4"]
>> '1:2:3:4'.split(nil)
=> ["1", "2", "3", "4"]
```

* `partition` method splits string with given separator and returns three parts
    * first is part of string before the first occurrence of separator
    * second is the separator itself
    * third is rest of the string
* if input string doesn't contain the separator, last two elements of array will be empty string
* `rpartition` will split based on last occurrence of separator

```ruby
>> 'good day'.partition(' ')
=> ["good", " ", "day"]
>> '42abc100'.partition('abc')
=> ["42", "abc", "100"]
>> 'foo:baz:good:hi'.partition(':')
=> ["foo", ":", "baz:good:hi"]

>> 'hi there'.partition('XYZ')
=> ["hi there", "", ""]

>> 'good day'.rpartition(' ')
=> ["good", " ", "day"]
>> 'foo:baz:good:hi'.rpartition(':')
=> ["foo:baz:good", ":", "hi"]
```

<br>

## <a name="character-manipulations"></a>Character manipulations

* mapping characters
* use `!` versions for in-place modification

```ruby
>> s = 'goad cry feet hulk'
=> "goad cry feet hulk"

# one to one mapping
>> s.tr('aeiou', '12345')
=> "g41d cry f22t h5lk"

# use - between characters to represent a range
>> s.tr('a-f', 'A-F')
=> "goAD Cry FEEt hulk"
>> s.tr('aeiou', '1-5')
=> "g41d cry f22t h5lk"

# last character of 2nd arg gets re-used if 2nd arg shorter than 1st
>> 'hunter2'.tr("\x00-\x7f", '*')
=> "*******"

# ^ at start of 1st arg means translate other than given characters
>> s.tr('^aeiou', '*')
=> "*oa*******ee***u**"
```

* escaping special characters and squeezing

```ruby
# use - at start or end of 1st arg
>> 'cat-bat^123'.tr('-', ':')
=> "cat:bat^123"
>> 'cat-bat^123'.tr('a-c-', '1-3:')
=> "31t:21t^123"

# use ^ other than first character of 1st arg
>> 'cat-bat^123'.tr('a^c', '1*3')
=> "31t-b1t*123"

# or use \ to escape them
>> 'cat-bat^123'.tr('\^a\-c', '*1:3')
=> "31t:b1t*123"

# to represent \ literally, it must be at end of arg
>> 'a\bc'.tr('\\', '/')
=> "a/bc"
>> 'a\bc'.tr('abc\\', 'ABC/')
=> "A/BC"

# use tr_s to squeeze consecutive same character replacements
>> 'feet food'.tr_s('fo', '12')
=> "1eet 12d"
```

* deleting characters
* similar to `tr`, deletes instead of translating
* use `!` version for in-place modification

```ruby
>> s = 'foo-123:baz.'
=> "foo-123:baz."

>> s.delete('aeiou')
=> "f-123:bz."
>> s.delete('^a-z')
=> "foobaz"

# if multiple args are given, common characters is used to delete
>> s.delete('abc123', '2b3o')
=> "foo-1:az."
# same as
>> s.delete('23b')
=> "foo-1:az."
```

* number of times given character(s) are present
* similar to `delete`, returns count instead of deleting

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

>> 'This is a sample string'.count('a-g')
=> 4
>> 'foo-123:baz.'.count('^a-z')
=> 6
>> 'foo-123:baz.'.count('abc123', '2b3o')
=> 3
```

* deleting whitespace characters from string start/end/both
* use `!` versions for in-place modification

```ruby
>> '    foo baz 123  '.strip
=> "foo baz 123"

>> '    foo baz 123  '.rstrip
=> "    foo baz 123"

>> '    foo baz 123  '.lstrip
=> "foo baz 123  "

>> "hello \t\r\n".rstrip
=> "hello"
```

<br>

## <a name="miscellaneous"></a>Miscellaneous

* use unary `-` to get a frozen version of string
    * use `freeze` method for in-place modification
* use unary `+` to get a mutable version of string

```ruby
>> s = 'Hello'
=> "Hello"
>> s.freeze
=> "Hello"
>> s[0] = 'h'
FrozenError (can't modify frozen String)

>> s1 = +s
=> "Hello"
>> s1.downcase!
=> "hello"

>> s2 = -s1
=> "hello"
>> s2.upcase!
FrozenError (can't modify frozen String)
```

* `clear` method will delete everything, does in-place modification

```ruby
>> s = 'hello'
=> "hello"

>> s.clear
=> ""
```

* in-place concatenation

```ruby
# for single argument, << can be used
>> s = 'hello'
=> "hello"
>> s << ' world'
=> "hello world"

# concat method accepts multiple arguments
>> s.concat('. ', 'how', ' are', ' you?')
=> "hello world. how are you?"

# use prepend to add text at start
>> 'how are you?'.prepend('hi', ' there. ')
=> "hi there. how are you?"
```

* use `index/rindex` to know where the first/last instance of given search string occurs

```ruby
>> s = 'hi there'
=> "hi there"

>> s.index('the')
=> 3
>> s.index('z')
=> nil

>> s.index('e')
=> 5
>> s.rindex('e')
=> 7

>> s.index('h')
=> 0
# second argument specifies offset to start searching
>> s.index('h', 1)
=> 4
# same as: s[0..3].rindex('h')
>> s.rindex('h', 3)
=> 0
```

* `insert` allows to add string at given index, modifies in-place

```ruby
>> 'he'.insert(0, 't')
=> "the"

>> 'he'.insert(1, 'i ther')
=> "hi there"

>> s = 'he'
=> "he"
$ # same as: s << 'ad'
>> s.insert(-1, 'ad')
=> "head"
```

* `succ` method is useful to get next alphanumeric sequence, carry over is taken care
* if there are no alphanumeric characters, then right most character is changed
* use `!` version for in-place modification

```ruby
>> '42'.succ
=> "43"
>> '42.9'.succ
=> "43.0"
>> '1-2-9-9'.succ
=> "1-3-0-0"
>> ',23,'.succ
=> ",24,"

>> 'foo'.succ
=> "fop"
>> 'baz'.succ
=> "bba"
>> 'baz9'.succ
=> "bba0"

>> '--:'.succ
=> "--;"
```

* to iterate over an alphanumeric range

```ruby
>> 'a'.upto('c') { |c| puts c }
a
b
c
=> "a"

# to exclude ending value
>> 'x8'.upto('y2', exclusive=true) { |s| puts s }
x8
x9
y0
y1
=> "x8"

>> 'x5'.upto('x9').to_a
=> ["x5", "x6", "x7", "x8", "x9"]
```

* `ord` gives integer ordinal value of given character
* `codepoints` gives array of integer of each character of given string
    * use `each_codepoints` to iterate over them
* string concatenation methods accept integer ordinal as arguments as well

```ruby
>> 'a'.ord
=> 97
>> '👍'.ord
=> 128077

>> a = 'hi👍'.codepoints
=> [104, 105, 128077]
>> 'bye'.each_codepoint { |c| puts c }
98
121
101
=> "bye"

>> 'h' << 105
=> "hi"
>> ''.concat(*a)
=> "hi👍"
```

