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
* Result of entered expression is displayed with a prefix `=>`
    * also, a special variable `_` holds the result of last expression in the interactive session
* use `exit` to end the interactive session

```ruby
$ # puts always returns nil
$ irb
irb(main):001:0> puts 'hi'     
hi
=> nil
irb(main):002:0> exit
```

* `irb` can be customized in many ways, see document link for details
* here on, `irb --simple-prompt` will be used for simplicity

```ruby
$ alias irb='irb --simple-prompt'

$ irb
>> num = 5
=> 5
>> num
=> 5
>> 3 + 4
=> 7
>> 12 + _
=> 19
>> exit
```

* Often, you'd want to re-use previous instructions or correct a mistake
* On Linux, you need to install the `rb-readline` extension module. Invoking `irb` after that will allow arrow keys for navigation, `ctrl+r` for search, etc
    * If you are not using environment manager like `RVM`, use `gem install --user-install rb-readline`

**Further Reading**

* [ruby-doc: interactive Ruby](https://ruby-doc.org/stdlib-2.5.0/libdoc/irb/rdoc/IRB.html)
* [pry](https://github.com/pry/pry)
* [stackoverflow - installing gems](https://stackoverflow.com/questions/2119064/sudo-gem-install-or-gem-install-and-gem-locations)

