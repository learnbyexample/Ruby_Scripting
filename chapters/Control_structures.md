# <a name="control-structures"></a>Control Structures

**Table of Contents**

* [Boolean expressions](#boolean-expressions)
* [if](#if)
* [for](#for)
* [while](#while)

<br>

## <a name="boolean-expressions"></a>Boolean expressions

* boolean expressions evaluate to true/false

```ruby
>> a = 2
=> 2
>> b = 5
=> 5

>> a == b
=> false
>> a != b
=> true
>> a > b
=> false
>> a < b
=> true
>> a >= b
=> false
>> a <= b
=> true

>> 'a' < 'b'
=> true
>> 'foo' == 'Foo'
=> false
>> 'foo' == 'Foo'.downcase
=> true
```

* use logical operators to combine boolean expressions

```ruby
>> num = 5
=> 5

# results in true if both expressions evaluate to true
# expression on right is evaluated only if left one is true
>> num > 3 && num <= 5
=> true
>> num > 3 && num <= 4
=> false

# results in true if either expression evaluate to true
# expression on right is evaluated only if left one is false
>> num%3 == 0 || num%5 == 0
=> true

>> !(num > 3 && num <= 5)
=> false
```

* true/false for values

```ruby
# nil is false in boolean context
>> !nil
=> true

# other than nil and false, all other values are true in boolean context
>> !0
=> false
>> !''
=> false
>> !5
=> false

>> num = 0
=> 0
>> !num
=> false
>> num == 0
=> true
```

* we'll cover Array data type in later chapters, but let's see a nice feature for condition checking

```ruby
# need to check if n is either 4 or 10 or 16
>> n = 10
=> 10
>> n == 4 || n == 10 || n == 16
=> true

# using array method include?
>> [4, 10, 16].include?(n)
=> true
>> [4, 10, 16].include?(5)
=> false
>> [4, 10, 16].include?(16)
=> true
```

<br>

## <a name="if"></a>if

* the `if` and `end` keywords are used to define the beginning and end of this control structure
    * the boolean expression is provided after `if` keyword
* like method definition, the convention is to indent the body with two space characters
    * the body is optional - helpful to create placeholders
    * return value is the result of last expression that gets executed
* let's see an example to conditionally change value of a variable

```ruby
#!/usr/bin/env ruby

print 'Enter an integer: '
num = Integer(gets)
char = '*'

if num%2 == 0
  char = '#'
end

fill = char * 10
puts fill + num.to_s + fill
```

*Running the above script*

```
$ ./simple_if.rb
Enter an integer: 42
##########42##########

$ ./simple_if.rb
Enter an integer: 17
**********17**********
```

* like the example above, often the body consists of single expression
* for such cases, one can use single line version
    * more than one expression can be specified, but such forms are best left for code golfing and [one-liners](https://github.com/learnbyexample/Command-line-text-processing/blob/master/ruby_one_liners.md)

```ruby
>> num = 42
=> 42
>> num = 29 if num < 50
=> 29

>> (a = 'foo'; b = 'baz') if num < 30
=> "baz"
>> a
=> "foo"
>> b
=> "baz"
```

* to execute code for both true/false cases, add `else` portion

```ruby
>> num = 3
=> 3
>> if num%2 == 0
>>   puts "#{num} is even"
>> else
>>   puts "#{num} is odd"
>> end
3 is odd
=> nil
```

* for short expressions, the ternary operator `?:` can be used

```ruby
>> puts num%2 == 0 ? "#{num} is even" : "#{num} is odd"
3 is odd
=> nil

>> num = 42
=> 42
# use parenthesis for clarity if needed
>> puts(num%2 == 0 ? "#{num} is even" : "#{num} is odd")
42 is even
=> nil

>> x = 23
=> 23
>> y = 65
=> 65
>> max = x > y ? x : y
=> 65
```

* use `elsif` if there are multiple conditions to check

```ruby
#!/usr/bin/env ruby

num = 42

print 'Enter an integer: '
guess = Integer(gets)

if guess == num
  puts 'Whoa! you guessed it right'
elsif guess > num
  puts 'Oops, you guessed too high'
else
  puts 'Oops, you guessed too low'
end
```

*Running the above script*

```
$ ./if_elsif_else.rb
Enter an integer: 42
Whoa! you guessed it right
$ ./if_elsif_else.rb
Enter an integer: 23
Oops, you guessed too low
$ ./if_elsif_else.rb
Enter an integer: 78
Oops, you guessed too high
```

* both the `if` structure and ternary operator can be nested for complicated cases
* See also [ruby-doc: if Expression](https://ruby-doc.org/core-2.5.0/doc/syntax/control_expressions_rdoc.html#label-if+Expression) and [ruby-doc: case Expression](https://ruby-doc.org/core-2.5.0/doc/syntax/control_expressions_rdoc.html#label-case+Expression)

<br>

## <a name="for"></a>for

* there are various ways in Ruby to achieve iteration depending on context
* the traditional `for(i=0; i<5; i++)` can be done using Range object and for loop
* Range is specified using start and end values separated by `..` or `...`
    * to include end value, use `..`
    * to exclude end value, use `...`
    * by default, `1` is the step value, can be changed by supplying different value to `step` method
* then use `for` and `in` keywords to iterate by supplying a variable to hold value for each iteration

```ruby
#!/usr/bin/env ruby

num = 9
for i in 1..5
  puts "#{num} * #{i} = #{num * i}"
end

puts
for i in (10..20).step(3)
  puts "#{num} * #{i} = #{num * i}"
end
```

*Running the above script*

```
$ ./for_loop.rb
9 * 1 = 9
9 * 2 = 18
9 * 3 = 27
9 * 4 = 36
9 * 5 = 45

9 * 10 = 90
9 * 13 = 117
9 * 16 = 144
9 * 19 = 171
```

* to iterate over a string value character by character, convert the string to an array using `chars` method

```ruby
>> str = 'hi there'
=> "hi there"
>> for c in str.chars
>>   puts c
>> end
h
i
 
t
h
e
r
e
=> ["h", "i", " ", "t", "h", "e", "r", "e"]
```

* to do something `n` number of times, use the `times` method on an integer value
* in the example below, the code within `{}` is a `block` (we'll see this form more often here on)

```ruby
>> 2.times { puts 'hi' }
hi
hi
=> 2

# to use it as an index
>> 3.times { |i| puts i }
0
1
2
=> 3

# for multiple statements, do...end is preferred
>> 2.times do |x|
?>   puts x
>>   puts 'hi'
>> end
0
hi
1
hi
=> 2
```

* Range has `each` method to iterate as well, instead of having to use `for`
* for descending order, either use `reverse_each` or use `downto/step` method on an integer

```ruby
>> (1..10).step(4).each { |i| puts i }
1
5
9
=> 1..10

>> (1..2).reverse_each { |i| puts i }
2
1
=> 1..2

>> 2.downto(1) { |i| puts i }
2
1
=> 2

>> 5.step(1, -2) { |i| puts i }
5
3
1
=> 5
```

**Further Reading**

* [ruby-doc: Range](https://ruby-doc.org/core-2.5.0/Range.html)
* [stackoverflow: explanation for Ruby blocks](https://stackoverflow.com/questions/4911353/best-explanation-of-ruby-blocks)

<br>

## <a name="while"></a>while

* while loop allows us to execute code until a condition is satisfied

```ruby
#!/usr/bin/env ruby

ip_str = 'foo'
while ip_str != ip_str.reverse
  print 'Enter a palindrome word: '
  ip_str = gets.chomp.upcase
end
```

*Running the above script*

```
$ ./while_loop.rb
Enter a palindrome word: Hi
Enter a palindrome word: bye
Enter a palindrome word: Wow
```



