# <a name="file-processing"></a>File Processing

**Table of Contents**

* [Modes and Encoding](#modes-and-encoding)
* [Reading files](#reading-files)
    * [line by line](#line-by-line)

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
>> 'hello'.force_encoding('ASCII').encoding
=> #<Encoding:US-ASCII>
```

* External encoding specifies the encoding used to read/write the file
* Internal encoding specifies the encoding used by Ruby for string processing
    * `nil` value means transcoding is not needed
* these values are usually specified along with mode for the file being processed instead of changing global level encoding settings

**Further Reading**

In this chapter, we'll be using `File` which is a subclass of `IO` class. `IO` includes the Enumerable module

* [ruby-doc: IO](https://ruby-doc.org/core-2.5.0/IO.html)
* [ruby-doc: File](https://ruby-doc.org/core-2.5.0/File.html)
* [ruby-doc: Encoding](https://ruby-doc.org/core-2.5.0/Encoding.html)

<br>

## <a name="reading-files"></a>Reading files

#### <a name="line-by-line"></a>line by line

```ruby
#!/usr/bin/env ruby

filename = 'greeting.txt'
File.open(filename) do |f|
  puts "Contents of #{filename}:"
  f.each { |line| puts line }
end
```

* Here, the entire file processing is within the block passed to `File.open`
* `f` is the name of file handle and gets automatically closed after the block is done
* the `each` method allows us to process the file line by line as defined by record separator `$/` (default is newline character)
    * we can also pass custom record separator as an argument, see `each_line` method in [String methods](./String_methods.md#looping) chapter for details
    * this method will get lines from the file one at a time, so input file size won't affect memory requirements
* we haven't specified mode/encoding while opening - default is read text mode and global encoding settings

```
$ ./file_read_line_by_line.rb
Contents of greeting.txt:
Hello World

Good day
How are you

Just do-it
Believe it
```

* having a file handle, like the previous example, allows flexibility to use various File methods as needed
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

* if all you need is only the `each` method, you could use `File.foreach` instead of using a file handle
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

