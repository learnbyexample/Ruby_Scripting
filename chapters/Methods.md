# <a name="methods"></a>Methods

**Table of Contents**

* [Defining a method](#defining-a-method)
* [Arguments and Return](#arguments-and-return)
* [Default valued arguments](#default-valued-arguments)
* [Keyword arguments](#keyword-arguments)
* [Special method names](#special-method-names)

<br>

In this chapter we'll see how to define and use methods of your own. Some aspects of method definition/usage will be covered in later chapters

<br>

## <a name="defining-a-method"></a>Defining a method

* the `def` and `end` keywords are used to define the beginning and end of method
* the method name is given after the `def` keyword
* the usual guideline is to indent the body of method with two space characters
    * parenthesis are optional, for both defining and calling the method
    * the body is optional too - helpful to create placeholder methods
* below example shows a simple method named `greeting` that displays three lines of greeting to the user when called

```ruby
#!/usr/bin/env ruby

# user defined method
def greeting
  puts "-----------------------------"
  puts "         Hello World         "
  puts "-----------------------------"
end

# calling method
greeting
```

*Running the above script*

```bash
$ ./greeting_method.rb
-----------------------------
         Hello World         
-----------------------------
```

* let's see another example - this method asks for user input and prints a greeting
* on `irb`, defining a method returns the method name prefixed by `:` - that is a symbol(we'll cover that topic later)
* by default, result of last expression executed by the method is the return value of that method
    * the return value is `nil` in below example as the last executed instruction is `puts` whose return value is always `nil`
    * we'll see explicit way of returning values later in the chapter

```ruby
>> def user_greeting
>>   print 'enter name '
>>   name = gets.chomp
>>   puts "hello #{name}, have a nice day"
>> end
=> :user_greeting

>> user_greeting()
enter name learnbyexample
hello learnbyexample, have a nice day
=> nil

>> user_greeting()
enter name foo
hello foo, have a nice day
=> nil
```

**Further Reading**

* [ruby-doc: methods](https://ruby-doc.org/core-2.5.0/doc/syntax/methods_rdoc.html)
* [ruby-doc: calling methods](https://ruby-doc.org/core-2.5.0/doc/syntax/calling_methods_rdoc.html)
* [ruby-doc: keywords](https://ruby-doc.org/core-2.5.0/doc/keywords_rdoc.html)

<br>

## <a name="arguments-and-return"></a>Arguments and Return

* `()` are optional - both in method definition and calling
    * we have seen `puts` calling examples without `()`
* but for user defined methods, we'll be using `()`
* use comma to separate multiple arguments

```ruby
#!/usr/bin/env ruby

def sum_two_nums(num1, num2)
  total = num1 + num2
  puts "#{num1} + #{num2} = #{total}"
end

sum_two_nums(2, 3)
sum_two_nums(42, 3.14)
```

*Running the above script*

```bash
$ ./num_sum.rb
2 + 3 = 5
42 + 3.14 = 45.14
```

* Use `return` instead of displaying results to save the output in a variable, use it as part of expression etc

```ruby
>> def num_sq(num)
>>   return num ** 2
>> end
=> :num_sq

>> num_sq(3)
=> 9
>> 21 + num_sq(3)
=> 30
```

<br>

## <a name="default-valued-arguments"></a>Default valued arguments

* method arguments can be given a default value by assigning a value during definition
    * we have previously seen examples for `gets` and `chomp` methods
* arguments with defaults must be grouped together - can be at start/end/middle, mixed with normal arguments
    * these are still positional - cannot be passed out-of-order while calling

```ruby
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
```

*Running the above script*

```
$ ./styled_greeting.rb
************
     hi     
************
============
     oh     
============
%%%%%%
  42  
%%%%%%
******
 3.14 
******
```

* Note that it is optional to use variable assignment while calling a method having default valued arguments
    * and the variable name used can be completely different
* See [ruby-doc: Default Positional Arguments](https://ruby-doc.org/core-2.5.0/doc/syntax/calling_methods_rdoc.html#label-Default+Positional+Arguments) for more complicated use cases

```ruby
>> def styled_line(char='*')
>>   puts char * 20
>> end
=> :styled_line

>> styled_line
********************
=> nil

>> styled_line(':')
::::::::::::::::::::
=> nil

>> styled_line(c='z')
zzzzzzzzzzzzzzzzzzzz
=> nil
>> c
=> "z"
```

<br>

## <a name="keyword-arguments"></a>Keyword arguments

* they are similar to default valued arguments but allows out-of-order passing of arguments while calling
* if there are positional arguments too, they must be defined before keyword arguments
* keyword arguments cannot be passed as positional argument, the keyword has to be always specified

```ruby
#!/usr/bin/env ruby

def greeting(msg, style_char: '*', fill: 5)
  gr_len = msg.size + 2*fill
  gr_dec = style_char * gr_len
  puts gr_dec, msg.center(gr_len), gr_dec
end

greeting('hi')
greeting('oh', style_char: '=')
greeting('42', fill: 2, style_char: '%')
greeting('3.14', fill: 1)    
```

*Running the above script*

```
$ ./keyword_args.rb 
************
     hi     
************
============
     oh     
============
%%%%%%
  42  
%%%%%%
******
 3.14 
******
```

<br>

## <a name="special-method-names"></a>Special method names

* method names ending with `!` are used to indicate that it modifies the object
* Note that this is a guideline and not enforced by Ruby

*Example for in-built String method*

```ruby
>> msg = 'hi there'
=> "hi there"
# replaces hi with hello, but doesn't change content of variable
>> msg.sub('hi', 'hello')
=> "hello there"
>> msg
=> "hi there"

# replaces hi with hello, in-place changes content of variable
>> msg.sub!('hi', 'hello')
=> "hello there"
>> msg
=> "hello there"
```

*Example for user defined method*

```bash
>> def add_hi!(str)
>>   str << 'hi'
>> end
=> :add_hi!

>> msg = 'foo'
=> "foo"
>> add_hi!(msg)
=> "foohi"
>> msg
=> "foohi"
```

* method names ending with `?` are used to indicate it returns `true/false`

```ruby
# in-built method to check if string has only ascii characters
>> 'foo-123'.ascii_only?
=> true
>> 'hi👍'.ascii_only?
=> false

# a basic palindrome method
>> def palindrome?(str)
>>   return str == str.reverse
>> end
=> :palindrome?
>> palindrome?('madam')
=> true
>> palindrome?('bad')
=> false
```

* the third and final special character for method names is `=` to indicate assignment method
    * this is usually used for methods defined inside a `class`

