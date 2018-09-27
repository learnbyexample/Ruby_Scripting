# <a name="file-processing"></a>File Processing

**Table of Contents**

* [Modes and Encoding](#modes-and-encoding)
* [Reading files](#reading-files)
    * [Line by line](#line-by-line)
    * [Processing entire file](#processing-entire-file)
* [Writing files](#writing-files)
* [Interacting with File System](#interacting-with-file-system)

<br>

The text and code files referenced in this chapter can be obtained from [Ruby_Scripting: programs](https://github.com/learnbyexample/Ruby_Scripting/tree/master/programs) directory

<br>

## <a name="modes-and-encoding"></a>Modes and Encoding

* We'll be seeing these modes in this chapter
    * `r` read mode, this is the default if mode is not specified
    * `w` write mode
    * `a` append mode
* default is text mode, so passing `r` or `rt` is equivalent
    * for binary mode, it would be `rb`, `wb` and so on

```ruby
>> Encoding.default_external
=> #<Encoding:UTF-8>
>> Encoding.default_internal
=> nil

>> 'hello'.encoding
=> #<Encoding:UTF-8>
>> 'hello'.force_encoding('US-ASCII').encoding
=> #<Encoding:US-ASCII>
```

* External encoding specifies the encoding used to read/write the file
* Internal encoding specifies the encoding used by Ruby for string processing
    * `nil` value means transcoding is not needed
* these values are usually specified along with mode for the file being processed instead of changing global level encoding settings

**Further Reading**

In this chapter, we'll be using `File` and `Dir` classes. `IO` includes the Enumerable module and `File` is a subclass of `IO`

* [ruby-doc: IO](https://ruby-doc.org/core-2.5.0/IO.html)
* [ruby-doc: File](https://ruby-doc.org/core-2.5.0/File.html)
* [ruby-doc: Dir](https://ruby-doc.org/core-2.5.0/Dir.html)
* [ruby-doc: Encoding](https://ruby-doc.org/core-2.5.0/Encoding.html)

<br>

## <a name="reading-files"></a>Reading files

#### <a name="line-by-line"></a>Line by line

```ruby
#!/usr/bin/env ruby

filename = 'greeting.txt'
File.open(filename) do |f|
  puts "Contents of #{filename}:"
  f.each { |line| puts line }
end
```

* here, the entire file processing is within the block passed to `File.open`
* `f` is the name of filehandle and gets automatically closed after the block is done
* the `each` method allows us to process the file line by line as defined by record separator `$/` (default is newline character)
    * we can also pass custom record separator as an argument, see `each_line` method in [String methods](./String_methods.md#looping) chapter for details
    * this method will get lines from the file one at a time, so input file size won't affect memory requirements
* we haven't specified mode/encoding while opening - default is read text mode and global encoding settings
    * See [ruby-doc: IO encoding](https://ruby-doc.org/core-2.5.0/Encoding.html#class-Encoding-label-IO+encoding+example) for examples
* if the given filename doesn't exist or if the read fails for some reason, you'd get an exception indicating the issue

```
$ ./file_read_line_by_line.rb
Contents of greeting.txt:
Hello World

Good day
How are you

Just do-it
Believe it
```

* having a filehandle, like the previous example, allows flexibility to use various File methods as needed
* for example, using `readline` to skip some lines and then using `each` to process rest of the lines
    * note that `readline` will require exception handling if end of file (EOF) was already reached
    * you can use `gets` instead if you don't want the exception to be raised

```ruby
>> File.open('greeting.txt') do |f|
?>   2.times { f.readline }
>>   f.each { |line| puts line }
>> end
Good day
How are you

Just do-it
Believe it
=> #<File:greeting.txt (closed)>
```

* if all you need is only the `each` method, you could use `File.foreach` instead of using a filehandle
    * arguments like record separator is specified after the file name argument
    * `foreach` won't be suitable if you need other `File.open` arguments like mode/encoding/etc

```ruby
>> File.foreach('greeting.txt') do |line|
?>   puts line if line.include?('e')
>> end
Hello World
How are you
Believe it

# can be further shortened by using grep
>> puts File.foreach('greeting.txt').grep(/y/)
Good day
How are you

# example for paragraph mode
>> File.foreach('greeting.txt', sep='').grep(/ell|it/)
=> ["Hello World\n\n", "Just do-it\nBelieve it\n"]
```

<br>

#### <a name="processing-entire-file"></a>Processing entire file

* reading entire file as a string or as an array
* suitable for small enough files which fit memory requirements

```ruby
>> s = File.read('greeting.txt')
=> "Hello World\n\nGood day\nHow are you\n\nJust do-it\nBelieve it\n"

>> s = File.readlines('hello.txt')
=> ["hello\n", "Χαίρετε\n"]
```

* applying string/enumerable methods

```ruby
# no. of words
>> File.read('greeting.txt').split.size
=> 11

# common lines
>> File.readlines('colors_1.txt') & File.readlines('colors_2.txt')
=> ["Blue\n", "Red\n"]

# lines from colors_1.txt not present in colors_2.txt
>> File.readlines('colors_1.txt') - File.readlines('colors_2.txt')
=> ["Brown\n", "Purple\n", "Teal\n", "Yellow\n"]
```

<br>

## <a name="writing-files"></a>Writing files

* specify mode as `w` when opening the file for writing
    * file will be overwritten if it already exists, otherwise a new file will be created for writing
* use `write` method on filehandle to add text to the file
    * if the arguments are not string, `to_s` method will be applied to convert into string before getting written
    * return value is total number of bytes written

```ruby
# external encoding changed to US-ASCII instead of default UTF-8
>> File.open('new_file.txt', 'w:US-ASCII') do |f|
?>   f.write("This is a sample line of text\n")
>>   f.write("Yet another line\n")
>> end
```

* sanity check

```
$ file new_file.txt
new_file.txt: ASCII text

$ cat new_file.txt
This is a sample line of text
Yet another line
```

* use `a` instead of `w` to open file for appending
    * a new file will be created for writing if it doesn't exist

```
$ irb --simple-prompt
>> File.open('new_file.txt', 'a:US-ASCII') do |f|
?>   f.write("Appending a line at end of file\n")
>> end
=> 32
>> exit

$ cat new_file.txt
This is a sample line of text
Yet another line
Appending a line at end of file
```

* you can also use `puts` on filehandle instead of `write` method

```
$ irb --simple-prompt
>> File.open('filtered_greeting.txt', 'w') do |f|
?>   f.puts File.foreach('greeting.txt', sep='').grep(/ell|it/)
>> end
=> nil
>> exit

$ cat filtered_greeting.txt
Hello World

Just do-it
Believe it
```

<br>

## <a name="interacting-with-file-system"></a>Interacting with File System

* `File` and `Dir` classes provide ways to work with file system
* Many of the methods emulate behavior of common unix commands, for ex:
    * `Dir.mkdir` creates directory, allows specifying permissions as well
    * `Dir.rmdir` to remove empty directory
    * `Dir.chdir` to change current working directory
    * `Dir.children` to list contents of given directory

```ruby
# current working directory
>> Dir.pwd
=> "/home/learnbyexample/Ruby_Scripting"

# home directory, optionally accepts username as an argument
>> Dir.home
=> "/home/learnbyexample"
```

* to determine if file/directory exists before processing them

```ruby
# check if given path exists
>> File.exist?('greeting.txt')
=> true
>> File.exist?('/home/learnbyexample')
=> true

# check if given path is a file
>> File.file?('greeting.txt')
=> true
>> File.file?('/home/learnbyexample')
=> false

# check if given path is a directory
>> Dir.exist?('greeting.txt')
=> false
>> Dir.exist?('/home/learnbyexample')
=> true
```

Consider the following directory structure:

```
$ tree -a
.
├── backups
│   ├── bookmarks_2018-09-25.html
│   └── dot_files
│       ├── .bashrc
│       ├── .inputrc
│       └── .vimrc
├── ch.sh
├── scripts
│   ├── hello_world.rb
│   ├── ip.txt
│   ├── palindrome.rb
│   ├── power.log
│   └── report.log
└── todo

3 directories, 11 files
```

* getting list of files and iterating over it for a given directory

```ruby
>> Dir.children('.')
=> ["ch.sh", "backups", "scripts", "todo"]
>> Dir.children('backups')
=> ["bookmarks_2018-09-25.html", "dot_files"]

>> Dir.entries('.')
=> ["ch.sh", "backups", "scripts", ".", "..", "todo"]

# use 'foreach' to include '.' and '..' entries as well
>> Dir.each_child('scripts') { |f| puts f }
report.log
ip.txt
power.log
hello_world.rb
palindrome.rb
```

* `Dir.glob` allows unix shell like wildcards
* helpful to filter based on filename and iterating recursively

```ruby
# can also use: Dir['**/*.rb']
>> Dir.glob('**/*.rb')
=> ["scripts/hello_world.rb", "scripts/palindrome.rb"]
# matching multiple extensions, don't use space after ,
>> Dir.glob('**/*.{log,sh}')
=> ["scripts/report.log", "scripts/power.log", "ch.sh"]
>> Dir.glob('[a-c]*')
=> ["ch.sh", "backups"]

>> Dir.glob('**/*') { |f| puts f if File.file?(f) }
ch.sh
backups/bookmarks_2018-09-25.html
scripts/report.log
scripts/ip.txt
scripts/power.log
scripts/hello_world.rb
scripts/palindrome.rb
todo
```

* let's see some more examples for `File` methods

```ruby
>> File.executable?('scripts/hello_world.rb')
=> true
>> File.executable?('scripts/report.log')
=> false

>> File.size('scripts/report.log')
=> 39120

>> File.absolute_path('ch.sh')
=> "/home/learnbyexample/misc/ch.sh"

# joins the given strings with / if not present
>> File.join('foo', 'baz/', 'a.txt')
=> "foo/baz/a.txt"
```


