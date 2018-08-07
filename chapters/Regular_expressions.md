# <a name="regular-expressions"></a>Regular Expressions

**Table of Contents**

* [Why is it needed?](#why-is-it-needed)
* [Syntax and operators](#syntax-and-operators)
* [Anchors](#anchors)
    * [Line anchors](#line-anchors)
    * [String anchors](#string-anchors)
    * [Word anchors](#word-anchors)

<br>

Examples in this chapter will deal with ASCII characters only unless otherwise specified

<br>

## <a name="why-is-it-needed"></a>Why is it needed?

* useful for text processing defined by *regular* structure, for ex:
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

<br>

## <a name="anchors"></a>Anchors

* Often, search must match from beginning of line or towards end of line
    * for ex: a method definition at start of line and method arguments at end of line
* We'll see built-in regexp boundary features in this section
    * later sections will cover how to create your own custom boundary

<br>

#### <a name="line-anchors"></a>Line anchors

* a string input may contain single or multiple lines
    * line is distinguished from another by a newline character
* the `^` metacharacter anchors the regexp pattern to start of line
* the `$` metacharacter anchors the regexp pattern to end of line
* in later sections we'll see how to specify `^` and `$` literally

```ruby
>> s = 'cat and dog'
=> "cat and dog"

# without anchors, matching happens anywhere in the string
>> s.match?(/cat/)
=> true
>> s.match?(/dog/)
=> true

# match only at start of line
>> s.match?(/^cat/)
=> true
>> s.match?(/^dog/)
=> false

# match only at end of line
>> s.match?(/dog$/)
=> true

# match complete line
>> s.match?(/^dog$/)
=> false
```

* multiline examples

```ruby
>> "hi hello\ntop spot".match?(/^top/)
=> true
>> "hi hello\ntop spot".match?(/^hello/)
=> false

>> "spare\npar\ndare".match?(/^par$/)
=> true
>> "spare\npar\ndare".match?(/^are$/)
=> false
```

* the `sub` and `gsub` methods allow to use regexp as well

```ruby
>> s = 'catapults concatenate cat scat'
=> "catapults concatenate cat scat"

>> s.gsub('cat', 'XYZ')
=> "XYZapults conXYZenate XYZ sXYZ"
>> s.gsub(/cat/, 'XYZ')
=> "XYZapults conXYZenate XYZ sXYZ"

>> s.gsub(/^cat/, 'XYZ')
=> "XYZapults concatenate cat scat"
>> s.gsub(/cat$/, 'XYZ')
=> "catapults concatenate cat sXYZ"

>> "catapults\nconcatenate\ncat\nscat\n".gsub(/^cat/, 'XYZ')
=> "XYZapults\nconcatenate\nXYZ\nscat\n"
>> "catapults\nconcatenate\ncat\nscat\n".gsub(/cat$/, 'XYZ')
=> "catapults\nconcatenate\nXYZ\nsXYZ\n"
```

* adding something to start/end of line

```ruby
>> s = "catapults\nconcatenate\ncat"
=> "catapults\nconcatenate\ncat"
>> puts s.gsub(/^/, '1: ')
1: catapults
1: concatenate
1: cat

>> puts s.gsub(/^/).with_index(1) { |m, i| "#{i}: " }
1: catapults
2: concatenate
3: cat

>> puts s.gsub(/$/, '.')
catapults.
concatenate.
cat.
```

* if there is a newline character at end of string, there is an additional end of line match

```ruby
>> puts "a\nb\n".gsub(/^/, 'foo ')
foo a
foo b
>> puts "a\n\n".gsub(/^/, 'foo ')
foo a
foo 

>> puts "a\nb\n".gsub(/$/, ' baz')
a baz
b baz
 baz
>> puts "a\n\n".gsub(/$/, ' baz')
a baz
 baz
 baz
```

<br>

#### <a name="string-anchors"></a>String anchors

* similar to line anchors, but for whole input string instead of individual lines
* `\A` will match start of string

```ruby
>> "hi hello\ntop spot".match?(/^top/)
=> true
>> "hi hello\ntop spot".match?(/\Atop/)
=> false

>> "hi hello\ntop spot".match?(/^hi/)
=> true
>> "hi hello\ntop spot".match?(/\Ahi/)
=> true
```

* `\z` will match end of string

```ruby
>> "spare\npar\ndare".gsub(/are$/, 'ABC')
=> "spABC\npar\ndABC"

>> "spare\npar\ndare".gsub(/are\z/, 'ABC')
=> "spare\npar\ndABC"
# can also use sub as there can be only one end of string
>> "spare\npar\ndare".sub(/are\z/, 'ABC')
=> "spare\npar\ndABC"
```

* `\Z` will also match end of string
* but if newline is last character, then it matches just before newline character

```ruby
# same result for both \z and \Z
>> "spare\npar\ndare".sub(/are\z/, 'ABC')
=> "spare\npar\ndABC"
>> "spare\npar\ndare".sub(/are\Z/, 'ABC')
=> "spare\npar\ndABC"

# different results as there is a \n at end
>> "spare\npar\ndare\n".sub(/are\z/, 'ABC')
=> "spare\npar\ndare\n"
>> "spare\npar\ndare\n".sub(/are\Z/, 'ABC')
=> "spare\npar\ndABC\n"
```

<br>

#### <a name="word-anchors"></a>Word anchors

* **word** character is any alphabet (irrespective of case), digit and the underscore character
* word anchors help in matching or not matching boundaries of a word
    * for example, to distinguish between `par`, `spar` and `apparent`
* `\b` matches word boundary
    * unlike line/string anchors, `\b` matches both start/end of word

```ruby
>> s = 'par spar apparent spare part'
=> "par spar apparent spare part"

# replace 'par' irrespective of where it occurs
>> s.gsub(/par/, 'X')
=> "X sX apXent sXe Xt"
# replace 'par' only at start of word
>> s.gsub(/\bpar/, 'X')
=> "X spar apparent spare Xt"
# replace 'par' only at end of word
>> s.gsub(/par\b/, 'X')
=> "X sX apparent spare part"
# replace 'par' only if it is not part of another word
>> s.gsub(/\bpar\b/, 'X')
=> "X spar apparent spare part"

# add something at word boundaries
>> s.gsub(/\b/, ':')
=> ":par: :spar: :apparent: :spare: :part:"
>> puts s.gsub(/\b/, "'").gsub(/ /, ',')
'par','spar','apparent','spare','part'
>> puts 'foo_12a:_:3b'.gsub(/\b/, "'")
'foo_12a':'_':'3b'
```

* `\B` is opposite of `\b`, it matches non-word boundaries

```ruby
>> s = 'par spar apparent spare part'
=> "par spar apparent spare part"

# replace 'par' if it is not start of word
>> s.gsub(/\Bpar/, 'X')
=> "par sX apXent sXe part"
# replace 'par' at end of word but not whole word 'par'
>> s.gsub(/\Bpar\b/, 'X')
=> "par sX apparent spare part"
# replace 'par' if it is not end of word
>> s.gsub(/par\B/, 'X')
=> "par spar apXent sXe Xt"
# replace 'par' if it is surrounded by word characters
>> s.gsub(/\Bpar\B/, 'X')
=> "par spar apXent sXe part"

# add something at non-word boundaries
>> puts 'foo_1 3b'.gsub(/\B/, ':')
f:o:o:_:1 3:b
```








