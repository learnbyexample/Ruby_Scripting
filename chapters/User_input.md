# <a name="getting-user-input"></a>Getting User input

**Table of Contents**

* [String input](#string-input)
    * [Changing record separator](#changing-record-separator)
    * [STDIN](#stdin)
* [Converting string to other data types](#converting-string-to-other-data-types)

<br>

## <a name="string-input"></a>String input

* use `gets` method to get a string input from user
* by default, a newline character marks the end of user input
    * known as **input record separator**, it is defined by Ruby special variable `$/`
* the record separator is also part of the string thus received
* to remove the record separator from string, use the `chomp` method
    * `chomp` also uses the special variable `$/` as default

```ruby
>> msg = gets
Good morning!
=> "Good morning!\n"

>> msg = gets.chomp
Good morning!
=> "Good morning!"
```

* To let user know what kind of input is being expected, display a message before using `gets`
* To keep the cursor on same line as message displayed, use `print` method instead of `puts`
    * there are other differences as well between `print` and `puts`, see documentation for details

```ruby
#!/usr/bin/env ruby

print "Hi there! What's your name? "
usr_name = gets.chomp
print 'And your favorite color is? '
usr_color = gets.chomp

puts "\n#{usr_name}, I like the #{usr_color} color too :)"
```

*A sample run of the above script*

```bash
$ ./user_input_str.rb
Hi there! What's your name? learnbyexample
And your favorite color is? blue

learnbyexample, I like the blue color too :)
```

**Further Reading**

* [ruby-doc: gets](https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-gets)
* [ruby-doc: print](https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-print)
* [ruby-doc: chomp](https://ruby-doc.org/core-2.5.0/String.html#method-i-chomp)

<br>

#### <a name="changing-record-separator"></a>Changing record separator

* by changing `$/` value

```ruby
>> $/ = ';'
=> ";"

>> foo = gets
hello
world;
=> "hello\nworld;"

>> foo.chomp
=> "hello\nworld"
```

* or, pass the string as `sep` argument of `gets` method
    * by default, `sep` uses the value of `$/` variable
    * default valued argument will be covered in more detail later

```ruby
>> baz = gets(sep='END')
hi
how are you?
cya tomorrow.END
=> "hi\nhow are you?\ncya tomorrow.END"

>> baz.chomp(separator='END')
=> "hi\nhow are you?\ncya tomorrow."
```

<br>

#### <a name="stdin"></a>STDIN

* `gets` first tries to read from files specified by command-line arguments passed to the script
    * command-line arguments will be covered in more detail later
* only if no file has been passed, `gets` reads from standard input
* if a script accepts files as command-line arguments and user input is also required, use `STDIN.gets` to read from standard input

```bash
$ # notice how the two lines 1 and 2 are read
$ # instead of waiting for user input
$ ./user_input_str.rb <(seq 2)
Hi there! What's your name? And your favorite color is? 
1, I like the 2 color too :)
```

<br>

## <a name="converting-string-to-other-data-types"></a>Converting string to other data types

* String class has handy methods to change strings to other data types
* for ex: `to_i` and `to_f` to get Integer and Floating point values
    * these methods ignore any whitespace characters at start of input string
    * characters after first Integer/Floating values are ignored as well
    * if there are no numbers or if a non-whitespace character occurs before a number, `0` is returned

```ruby
>> gets.to_i
42
=> 42
>> gets.to_i
  2good
=> 2

>> gets.to_f
3.14
=> 3.14
>> gets.to_f
5.35e4foo
=> 53500.0

>> gets.to_i
a2
=> 0
>> gets.to_i
hi
=> 0
```

* One can also use `Integer` and `Float` methods provided by `Kernel` module
    * Note that these are different from classes of same name
* These are more strict - only whitespace is allowed around the number present in the input string

```bash
>> Integer(gets)
42
=> 42

>> Integer('12c')
Traceback (most recent call last):
        3: from /usr/local/bin/irb:11:in `<main>'
        2: from (irb):2
        1: from (irb):2:in `Integer'
ArgumentError (invalid value for Integer(): "12c")
>> '12c'.to_i
=> 12

>> Float("\t 4.12 \n ")
=> 4.12

# handling non-decimal input
>> '0b100'.to_i(base=2)
=> 4
>> Integer('0b100')
=> 4
```

**Further Reading**

* [ruby-doc: to_i](https://ruby-doc.org/core-2.5.0/String.html#method-i-to_i)
* [ruby-doc: Integer method](https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-Integer)

