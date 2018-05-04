# <a name="numbers-and-strings"></a>Numbers and Strings

**Table of Contents**

* [Numbers](#numbers)
* [String](#string)
* [Objects and Expressions](#objects-and-expressions)

<br>

Variable data type is automatically determined by Ruby. They only need to be assigned some value before using it elsewhere

<br>

## <a name="numbers"></a>Numbers

* Integer examples
* see documentation links at end of this section for details on operators/methods for respective data types

```ruby
>> num1 = 7
=> 7
>> num2 = 42
=> 42
>> total = num1 + num2
=> 49
>> puts total
49
=> nil

# no limit to integer precision, only limited by available memory
>> 34 ** 32
=> 10170102859315411774579628461341138023025901305856

>> 9 / 5
=> 1

>> 9 % 5
=> 4
```

* Floating point examples

```ruby
>> 9.0 / 5
=> 1.8

>> area = 42.16
=> 42.16
>> area + 100
=> 142.16
```

* the [E scientific notation](https://en.wikipedia.org/wiki/Scientific_notation#E_notation) can be used as well

```ruby
>> sci_num1 = 3.982e5
=> 398200.0
>> sci_num2 = 9.32e-1
=> 0.932
>> sci_num1 + sci_num2
=> 398200.932

>> 2.13e21 + 5.23e22
=> 5.443e+22
```

* Binary numbers are prefixed with `0b` or `0B` (i.e digit 0 followed by lower/upper case letter b)
* Similarly, Hexadecimal numbers are prefixed with `0x` or `0X`
* Octal numbers are prefixed with `0`. Can also use `0o` or `0O` (i.e digit 0 followed by lower/upper case letter o)

```ruby
>> bin_num = 0b101
=> 5
>> oct_num = 0o12
=> 10
>> oct_num = 012
=> 10
>> hex_num = 0xF
=> 15

>> oct_num + hex_num
=> 25
```

* `_` can be used for readability
    * but not at start of number and not more than one consecutively

```ruby
>> 1_000_000
=> 1000000

>> 1_000.3_352
=> 1000.3352

>> 0xdead_beef
=> 3735928559
```

**Further Reading**

* [ruby-doc: Integer](https://ruby-doc.org/core-2.5.0/Integer.html)
* [ruby-doc: Float](https://ruby-doc.org/core-2.5.0/Float.html)
* [ruby-doc: Numeric](https://ruby-doc.org/core-2.5.0/Numeric.html)
* [ruby-doc: BigDecimal](https://ruby-doc.org/stdlib-2.5.0/libdoc/bigdecimal/rdoc/BigDecimal.html)
* [ruby-doc: Complex](https://ruby-doc.org/core-2.5.0/Complex.html)
* [ruby-doc: Rational](https://ruby-doc.org/core-2.5.0/Rational.html)

<br>

## <a name="string"></a>String

* single quoted strings
* no interpolation or escape sequences
    * except for allowing `\'` when single quote itself is needed

```ruby
>> greeting = 'Hello World'
=> "Hello World"

>> colors = 'Blue\nRed\nGreen'
=> "Blue\\nRed\\nGreen"
>> puts colors
Blue\nRed\nGreen
=> nil

>> msg = 'It\'s so good'
=> "It's so good"
>> puts msg
It's so good
=> nil
```

* double quoted strings
* allows escape sequences like `\n` for newline, `\t` for tab, etc
* allows interpolation when an expression is embedded inside `#{}`

```ruby
>> colors = "Blue\nRed\nGreen"
=> "Blue\nRed\nGreen"
>> puts colors
Blue
Red
Green
=> nil

>> str1 = 'Hello'
=> "Hello"
>> msg = "#{str1} there"
=> "Hello there"

>> c = 5
=> 5
>> "I want #{c} apples and #{c*2} mangoes"
=> "I want 5 apples and 10 mangoes"
```

* String concatenation and repetition

```ruby
>> str1 = 'Hello'
=> "Hello"
>> str2 = ' World'
=> " World"
>> str1 + str2
=> "Hello World"

# in-place concatenation
>> str1 << str2
=> "Hello World"

>> fmt = '-' * 27
=> "---------------------------"
>> puts "#{fmt}\n\t#{str1}\n#{fmt}"
---------------------------
        Hello World
---------------------------
=> nil
```

* Percent strings allow different delimiters than `'` and `"` for representing strings

>If you are using “(”, “[”, “{”, “<” you must close it with “)”, “]”, “}”, “>” respectively. You may use most other non-alphanumeric characters for percent string delimiters such as “%”, “|”, “^”, etc

```ruby
# %q for single quoted strings
>> msg = %q(It's so good)
=> "It's so good"

# %Q for double quoted strings
>> f1 = 'mango'
=> "mango"
>> f2 = 'orange'
=> "orange"
>> puts %Q/I like "#{f1}" and "#{f2}"/
I like "mango" and "orange"
=> nil
```

**Further Reading**

* [ruby-doc: strings](https://ruby-doc.org/core-2.5.0/String.html)
* [ruby-doc: Percent Strings](https://ruby-doc.org/core-2.5.0/doc/syntax/literals_rdoc.html#label-Percent+Strings)
* [ruby-doc: List of Escape Sequences and more info on strings](https://ruby-doc.org/core-2.5.0/doc/syntax/literals_rdoc.html#label-Strings)

<br>

## <a name="objects-and-expressions"></a>Objects and Expressions

* Everything in Ruby is an object

```ruby
>> 42.class
=> Integer

>> 3.2e3.class
=> Float

>> 'hello'.class
=> String

>> foo = [1, 4]
=> [1, 4]
>> foo.class
=> Array

>> nil.class
=> NilClass
```

* Use `help` within `irb` to get documentation for a method(assumes [Ruby Docs is installed](https://stackoverflow.com/questions/3178900/how-do-i-install-the-ruby-ri-documentation/13886612#13886612))
    * ex: `help 'Integer.lcm'` for [ruby-doc: Integer.lcm](https://ruby-doc.org/core-2.5.0/Integer.html#method-i-lcm)

```ruby
>> Integer.sqrt(25)
=> 5
>> 2.lcm(3)
=> 6
>> 64.gcd(36)
=> 4

>> 'hello'.upcase
=> "HELLO"
```

* Everything in Ruby is an expression

```ruby
# num1 is assigned 5
# return value of this expression is 5
>> num1 = 5
=> 5

# return value of 'num1 = 42' is 42
# so num2 also is assigned the value 42
>> num2 = num1 = 42
=> 42
>> num1
=> 42
>> num2
=> 42

# return value of puts is always nil value
>> a = puts('hi')
hi
=> nil
>> a
=> nil
```

* Unlike Python, strings in Ruby are mutable

```ruby
# in-place changing either str1 or str2 will affect the other
>> str2 = str1 = 'hello'
=> "hello"
>> str1.object_id
=> 47109181848080
>> str2.object_id
=> 47109181848080
>> str1 << ' there'
=> "hello there"
>> str2
=> "hello there"

# reassigning won't change the other
>> str1 = 'foo'
=> "foo"
>> str2
=> "hello there"
```

**Further Reading**

* [Official Ruby FAQ](https://www.ruby-lang.org/en/documentation/faq/1/)
* [ruby-doc: Object](https://ruby-doc.org/core-2.5.0/Object.html)
* [wikipedia: Object-oriented programming](https://en.wikipedia.org/wiki/Object-oriented_programming)

