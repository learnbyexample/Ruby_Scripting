# <a name="control-structures"></a>Control Structures

**Table of Contents**

* [Boolean expressions](#boolean-expressions)
* [if](#if)
* [for](#for)
* [while](#while)
* [next and break](#next-and-break)
* [Variable Scope](#variable-scope)

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
    * using `unless` keyword instead of `if` will conditionally execute code when condition is `false`
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

* like the example above, the body might consist of single expression only
* for such cases, one can use single line version
    * more than one expression can be specified, but such forms are best left for code golfing(See [Ruby one-liners](https://github.com/learnbyexample/Command-line-text-processing/blob/master/ruby_one_liners.md) for examples)

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

# conditionally execute code if boolean expression evaluates to false
>> b = 42 unless b > a
=> 42
```

* to execute code depending on true/false cases, add `else` portion

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

* as an alternate for `if-else`, the ternary operator `?:` can be used

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
    * iterating over objects like array, string, etc will be covered later
* the traditional `for(i=0; i<5; i++)` can be done using Range object
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

* to do something `n` number of times, use the `times` method on an integer value
* in the example below, the code within `{}` and `do...end` is called a `block` (we'll see this form more often here on)

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

* `while` loop allows us to execute code as long as the given boolean expression evaluates to `true`
    * use `until` keyword instead of `while` to loop as long as boolean expression evaluates to `false`

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

* like `if/unless`, one can specify `while/until` after an expression

```ruby
>> s = 'spittoon'
=> "spittoon"

# recursively delete 'to' as long as string contains 'to'
>> s.sub!('to', '') while s.match('to')
=> nil
>> s
=> "spin"
```

<br>

## <a name="next-and-break"></a>next and break

* use `next` to skip rest of code in the loop and start next iteration

```ruby
#!/usr/bin/env ruby

for i in 1..9
  next if rand(2)%2 == 0

  chr = rand(20)%3 == 1 ? '*' : '-'
  str = rand(10).to_s * i
  puts str.center(20, chr)
end
```

*Running the above script*

```
$ ./loop_with_next.rb
--------000---------
-------99999--------
-------666666-------
******55555555******
-----222222222------

$ ./loop_with_next.rb
---------55---------
--------0000--------
*****777777777******
```

* use `break` to skip rest of code in the loop (if any) and exit loop

```ruby
#!/usr/bin/env ruby

while true
  rand_num = rand(1..500)
  break if rand_num%4 == 0 && rand_num%6 == 0
end

puts "Random number divisible by 4 and 6: #{rand_num}"
```

*Running the above script*

```
$ ./loop_with_break.rb
Random number divisible by 4 and 6: 216
$ ./loop_with_break.rb
Random number divisible by 4 and 6: 456
$ ./loop_with_break.rb
Random number divisible by 4 and 6: 60
```

* the *while_loop.rb* example can be re-written using `break`

```ruby
>> while true
>>   print 'Enter a palindrome word: '
>>   ip_str = gets.chomp.upcase
>>   break if ip_str == ip_str.reverse
>> end
Enter a palindrome word: hi
Enter a palindrome word: bye
Enter a palindrome word: gag
=> nil
```

* in case of nested loops, `next` and `break` only affect the immediate parent loop
* See also [stackoverflow: using redo in a loop](https://stackoverflow.com/questions/29269421/rubys-redo-method-vs-while-loop)

<br>

## <a name="variable-scope"></a>Variable Scope

* the `if/for/while` control structures have same scope as the code within which they are used

```ruby
>> for i in 1..3
>>   for j in 1..3
>>     num = i * j
>>   end
>> end
=> 1..3
>> num
=> 9
```

* blocks create a new scope
* the block arguments defined within `||` won't affect variable of same name in the outer scope
    * they are similar to argument names used while defining a method
    * block here means both `{}` and `do..end` forms

```ruby
>> i = 'foo'
=> "foo"

>> (2..3).each do |i|
?>   puts i
>> end
2
3
=> 2..3
>> i
=> "foo"

>> 5.downto(3) { |i| puts i }
5
4
3
=> 5
>> i
=> "foo"
```

* variables created within block are local to that block and not visible outside

```ruby
>> 2.times { foo = 10; puts 'hi' }
hi
hi
=> 2
>> foo
Traceback (most recent call last):
        2: from /usr/local/bin/irb:11:in `<main>'
        1: from (irb):2
NameError (undefined local variable or method `foo' for main:Object)
```

* existing variables in the outer scope will be visible inside the block and can be modified

```ruby
>> num = 25
=> 25

>> 2.times { puts num }
25
25
=> 2

>> 3.times { num *= num }
=> 3
>> num
=> 152587890625
```

* to create a new local variable of same name as that of a variable in outer scope, declare it after a `;` in the block arguments
* See also [ruby-doc: Block Local Arguments](https://ruby-doc.org/core-2.5.0/doc/syntax/calling_methods_rdoc.html#label-Block+Local+Arguments)

```ruby
>> num = 25
=> 25

>> 3.times { |i| puts "#{i}: #{num.inspect}" }
0: 25
1: 25
2: 25
=> 3

>> 3.times { |i; num| puts "#{i}: #{num.inspect}" }
0: nil
1: nil
2: nil
=> 3
```

