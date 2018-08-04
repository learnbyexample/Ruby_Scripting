# <a name="regular-expressions"></a>Regular Expressions

**Table of Contents**

* [Why is it needed?](#why-is-it-needed)
* [Syntax and operators](#syntax-and-operators)

<br>

## <a name="why-is-it-needed"></a>Why is it needed?

* useful for text processing defined by *regular* structure
    * replace something only at start/end of string
    * extract portions defined by set of characters - for ex: words, integers, floats, hex, etc
    * replace something only if it matches a surrounding condition
* modern regular expressions implemented in high level languages support non-regular features like recursion too, so usage of the term is different than the mathematical concept

**Further Reading**

* [softwareengineering.stackexchange: Is it a must for every programmer to learn regular expressions?](https://softwareengineering.stackexchange.com/questions/133968/is-it-a-must-for-every-programmer-to-learn-regular-expressions)
* [softwareengineering.stackexchange: When you should NOT use Regular Expressions?](https://softwareengineering.stackexchange.com/questions/113237/when-you-should-not-use-regular-expressions)
* [wikipedia: Regular expression](https://en.wikipedia.org/wiki/Regular_expression) for discussion as a formal language as well as various implementations

<br>

## <a name="syntax-and-operators"></a>Syntax and operators

Quoting from [ruby-doc: Regexp](https://ruby-doc.org/core-2.5.0/Regexp.html)

>Regular expressions (*regexps*) are patterns which describe the contents of a string. They're used for testing whether a string contains a given pattern, or extracting the portions that match. They are created with the `/pat/` and `%r{pat}` literals or the `Regexp.new` constructor.

* for now, let's see normal string matching using regexp without introducing regexp features

```ruby
>> sentence = 'This is a sample string'
=> "This is a sample string"

# check if string argument is present or not
>> sentence.include?('is')
=> true
>> sentence.include?('z')
=> false

# check if pattern specified by regexp argument is present or not
>> sentence.match?(/is/)
=> true
>> sentence.match?(/z/)
=> false

# a 2nd argument can be given to specify starting index
>> sentence.match?(/is/, 6)
=> false
```

* regexp literals can be saved in a variable
* like double quoted string, it allows interpolation as well

```ruby
>> r = /is/
=> /is/
>> 'this'.match?(r)
=> true
>> 'hello'.match?(r)
=> false

>> ip = gets.chomp
hi
=> "hi"
>> r = /t#{ip}s/
=> /this/
>> 'thistle'.match?(r)
=> true

>> r = /t#{ip.upcase}s/
=> /tHIs/
>> r = /t#{2*3}s/
=> /t6s/
```

* the `=~` match operator returns index of first match or `nil` if no match is found
* the `!~` match operator returns `true` if string doesn't contain the given regexp, `false` otherwise
* both `=~` and `!~` can be used in conditional statement instead of `match?` method
* a key difference from `match?` is that these operators will also set some global variables (will be covered later)

```ruby
>> sentence = 'This is a sample string'
=> "This is a sample string"

# can also use: /is/ =~ sentence
>> sentence =~ /is/
=> 2
>> sentence =~ /z/
=> nil

# can also use: /z/ !~ sentence
>> sentence !~ /z/
=> true
>> sentence !~ /is/
=> false
```

