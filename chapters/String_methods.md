# <a name="string-methods"></a>String Methods

**Table of Contents**

* [String formatting](#string-formatting)
* [Looping](#looping)

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
>> '123:%010s:456' % 'hello'
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



