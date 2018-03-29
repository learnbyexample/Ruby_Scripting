# <a name="introduction"></a>Introduction

**Table of Contents**

* [Installation](#installation)
* [Hello World example](#hello-world-example)
* [Ruby REPL](#ruby-repl)

<br>

From [wikipedia](https://en.wikipedia.org/wiki/Ruby_(programming_language))
>Ruby is a dynamic, reflective, object-oriented, general-purpose programming language. It was designed and developed in the mid-1990s by Yukihiro "Matz" Matsumoto in Japan. According to the creator, Ruby was influenced by Perl, Smalltalk, Eiffel, Ada, and Lisp. It supports multiple programming paradigms, including functional, object-oriented, and imperative. It also has a dynamic type system and automatic memory management

<br>

## <a name="installation"></a>Installation

* Get Ruby for your OS from official website - https://www.ruby-lang.org/en/downloads/
    * See [installation guide](https://www.ruby-lang.org/en/documentation/installation/) for details, which also has info on tools like Ruby enVironment Manager (RVM)
* You can also try Ruby online
    * [repl.it](https://repl.it/) - programming environment for various languages including Ruby
    * [tryruby](http://tryruby.org/) - interactive tutorial that lets you try out Ruby right in your browser
* Examples presented here is for **Unix-like systems**, Ruby version **2.5.0p0** and uses **bash** shell
* It is assumed that you are familiar with command line. If not, check out [this basic tutorial on ryanstutorials](https://ryanstutorials.net/linuxtutorial/) and [this list of curated resources for Linux](https://github.com/learnbyexample/scripting_course/blob/master/Linux_curated_resources.md)

<br>

## <a name="hello-world-example"></a>Hello World example

* Let's start with simple a Ruby program and how to run it
* Use your favorite text editor to open a new file, type `puts 'hello there!'` and save the file as `hello.rb`
    * `puts` writes content of objects and adds a newline if not already present
    * in this example, it gets written to `stdout`
* Running it is as simple as invoking `ruby` command and passing `hello.rb` as argument

```ruby
$ cat hello.rb
puts 'hello there!'

$ ruby hello.rb
hello there!
```

* An alternate way to run is using [shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))

```bash
$ type env ruby
env is /usr/bin/env
ruby is /usr/local/bin/ruby

$ cat hello_world.rb
#!/usr/bin/env ruby

puts 'Hello World'

$ chmod +x hello_world.rb
$ ./hello_world.rb
Hello World
```

**Further Reading**

* [ruby-doc: version 2.5.0](https://ruby-doc.org/core-2.5.0/)
* [ruby-doc: puts](https://ruby-doc.org/core-2.5.0/IO.html#method-i-puts)

<br>

## <a name="ruby-repl"></a>Ruby REPL

* It is generally used to execute snippets of Ruby language as a means to learning Ruby or for debugging purposes
* Some of the topics in coming chapters will be complemented with examples using this
* A special variable `_` holds the result of last printed expression
* use `exit` to end the interactive session

```ruby
$ irb
irb(main):001:0> puts 'hi'     
hi
=> nil
irb(main):002:0> abc
Traceback (most recent call last):
        2: from /usr/local/bin/irb:11:in `<main>'
        1: from (irb):2
NameError (undefined local variable or method `abc' for main:Object)
irb(main):003:0> num = 5
=> 5
irb(main):004:0> num
=> 5
irb(main):005:0> 3 + 4
=> 7
irb(main):006:0> 12 + _
=> 19
irb(main):007:0> exit
```

* `irb` can be customized in many ways, see document link for details
* in coming chapters, `irb --simple-prompt` will be used for simplicity

```ruby
$ alias irb='irb --simple-prompt'

$ irb
>> 34 + 3.14
=> 37.14
>> exit
```

**Further Reading**

* [ruby-doc: interactive Ruby](https://ruby-doc.org/stdlib-2.5.0/libdoc/irb/rdoc/IRB.html)
* [pry](https://github.com/pry/pry)

