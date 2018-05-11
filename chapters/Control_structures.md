# <a name="control-structures"></a>Control Structures

**Table of Contents**

* [Boolean expressions](#boolean-expressions)
* [if](#if)

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

* Let's see an example to conditionally change value of a variable
* the `if` and `end` keywords are used to define the beginning and end of this control structure
    * the boolean expression is provided after `if` keyword
* like method definition, the convention is to indent the body with two space characters
    * the body is optional - helpful to create placeholders
    * return value is the result of last expression that gets executed

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
