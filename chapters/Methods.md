# <a name="methods"></a>Methods

**Table of Contents**

* [Defining a method](#defining-a-method)

<br>

In this chapter we'll see how to define and use methods of your own

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

*A sample run of the above script*

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

```bash
>> def user_greeting
>>   print 'Enter name: '
>>   name = gets.chomp
>>   puts "Hello #{name}, have a nice day"
>> end
=> :user_greeting

>> user_greeting()
Enter name: learnbyexample
Hello learnbyexample, have a nice day
=> nil

>> user_greeting()
Enter name: foo
Hello foo, have a nice day
=> nil
```

**Further Reading**

* [ruby-doc: methods](https://ruby-doc.org/core-2.5.0/doc/syntax/methods_rdoc.html)
* [ruby-doc: calling methods](https://ruby-doc.org/core-2.5.0/doc/syntax/calling_methods_rdoc.html)
* [ruby-doc: keywords](https://ruby-doc.org/core-2.5.0/doc/keywords_rdoc.html)

