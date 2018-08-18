# <a name="regular-expressions"></a>Regular Expressions

**Table of Contents**

* [Why is it needed?](#why-is-it-needed)
* [Syntax and operators](#syntax-and-operators)
* [Anchors](#anchors)
    * [Line anchors](#line-anchors)
    * [String anchors](#string-anchors)
    * [Word anchors](#word-anchors)
* [Alternation and Grouping](#alternation-and-grouping)
* [Escaping metacharacters](#escaping-metacharacters)
* [Dot metacharacter and Quantifiers](#dot-metacharacter-and-quantifiers)
    * [Greedy quantifiers](#greedy-quantifiers)
    * [Non-greedy quantifiers](#non-greedy-quantifiers)
    * [Possessive quantifiers](#possessive-quantifiers)
* [match, scan and globals](#match-scan-and-globals)
* [Character class](#character-class)

<br>

Examples in this chapter will deal with ASCII characters only unless otherwise specified

<br>

## <a name="why-is-it-needed"></a>Why is it needed?

* useful for text processing defined by *regular* structure, for ex:
    * replace something only at start/end of string
    * extract portions defined by set of characters - for ex: words, integers, floats, hex, etc
    * replace something only if it matches a surrounding condition
    * validate string format
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

<br>

## <a name="alternation-and-grouping"></a>Alternation and Grouping

* multiple regexps can be combined using `|` metacharacter to match either of them
* regexp on either side of `|` can have their own independent anchors

```ruby
>> 'I like cats'.match?(/cat|dog/)
=> true
>> 'I like dogs'.match?(/cat|dog/)
=> true
>> 'I like parrots'.match?(/cat|dog/)
=> false

>> 'catapults concatenate cat scat'.gsub(/^cat|cat\b/, 'X')
=> "Xapults concatenate X sX"
>> 'cat dog bee parrot fox'.gsub(/cat|dog|fox/, 'mammal')
=> "mammal mammal bee parrot mammal"
```

* beware of corner cases - the regexp that matches earliest in the string wins

```ruby
>> s = 'cat dog bee parrot fox'
=> "cat dog bee parrot fox"
>> s.index('cat')
=> 0
>> s.index('dog')
=> 4
# index of 'cat' < index of 'dog'
# so 'cat' will be replaced irrespective of order of regexp
>> s.sub(/cat|dog/, 'mammal')
=> "mammal dog bee parrot fox"
>> s.sub(/dog|cat/, 'mammal')
=> "mammal dog bee parrot fox"

# if the result is confusing, unroll gsub loop to two sub
# and calculate index for both regexp before each sub
>> 'far fear'.gsub(/ar|ear/, 'Y')
=> "fY fY"
>> 'far fear'.gsub(/ear|ar/, 'Y')
=> "fY fY"
```

* if index is same, then precedence is left to right
* See also [regular-expressions: alternation](https://www.regular-expressions.info/alternation.html)

```ruby
>> s = 'handful'
=> "handful"
>> s.index('hand')
=> 0
>> s.index('handful')
=> 0
>> s.sub(/hand|handful/, 'X')
=> "Xful"
>> s.sub(/handful|hand/, 'X')
=> "X"

# if the result is confusing, unroll gsub loop to multiple sub
# and calculate index for all three regexps before each sub
>> 'hand handy handful'.gsub(/hand|handy|handful/, 'X')
=> "X Xy Xful"
>> 'hand handy handful'.gsub(/handy|hand|handful/, 'X')
=> "X X Xful"
>> 'hand handy handful'.gsub(/handy|handful|hand/, 'X')
=> "X X X"
```

* common portion can be grouped inside `()` metacharacters
* Similar to `a(b+c) = ab + ac` in maths, `a(b|c) = ab|ac` in regexp

```ruby
>> 'red reform read rest'.gsub(/reform|rest/, 'X')
=> "red X read X"
>> 'red reform read rest'.gsub(/re(form|st)/, 'X')
=> "red X read X"

>> 'par spare part party'.gsub(/\bpar\b|\bpart\b/, 'X')
=> "X spare X party"
>> 'par spare part party'.gsub(/\b(par|part)\b/, 'X')
=> "X spare X party"
>> 'par spare part party'.gsub(/\bpar(|t)\b/, 'X')
=> "X spare X party"
```

* use `Regexp.union` method to build alternation from a list of arguments
    * if argument is not a regexp, the method will try to convert it to regexp first

```ruby
>> Regexp.union('par', 'part')
=> /par|part/

>> words = %w[cat dog fox]
=> ["cat", "dog", "fox"]
>> 'cat dog bee parrot fox'.gsub(Regexp.union(words), 'mammal')
=> "mammal mammal bee parrot mammal"
```

<br>

## <a name="escaping-metacharacters"></a>Escaping metacharacters

* we have seen metacharacters like `^`, `$`, `\`, `|`, `(`, etc so far
* to match them literally, escape them by prefixing `\` character

```ruby
# even though ^ is not being used as anchor, it won't be matched literally
>> 'cost^2 + a^5'.sub(/cost^2/) { |s| s.upcase }
=> "cost^2 + a^5"
# escaping will work
>> 'cost^2 + a^5'.sub(/cost\^2/) { |s| s.upcase }
=> "COST^2 + a^5"

>> 'pa$$ed'.gsub(/\$/, 's')
=> "passed"

>> '(a*b) + c'.gsub(/\(|\)/, '')
=> "a*b + c"

>> 'a || b'.gsub(/\|/, '&')
=> "a && b"

>> '\foo\bar\baz'.gsub(/\\/, '/')
=> "/foo/bar/baz"
```

* use `Regexp.escape` to let Ruby handle escaping all the metacharacters present in a string
* to avoid escaping altogether, use string argument instead of regexp when regexp features are not needed

```ruby
>> puts Regexp.escape('(a^b)')
\(a\^b\)

>> eqn = 'f*(a^b) - 3*(a^b)'
=> "f*(a^b) - 3*(a^b)"
>> s = '(a^b)'
=> "(a^b)"

>> eqn.gsub(s, 'c')
=> "f*c - 3*c"

# use Regexp.escape if additional regexp features are needed
>> eqn.gsub(/#{s}$/, 'c')
=> "f*(a^b) - 3*(a^b)"
>> eqn.gsub(/#{Regexp.escape(s)}$/, 'c')
=> "f*(a^b) - 3*c"
```

* use `%r` percent string to use any other delimiter than the default `/`

```ruby
>> '/foo/bar/baz/123'.match?('o/bar/baz/1')
=> true

>> '/foo/bar/baz/123' =~ /o\/bar\/baz\/1/
=> 3
>> '/foo/bar/baz/123' =~ %r{o/bar/baz/1}
=> 3

>> '/foo/bar/baz/123'.sub(/o\/bar\/baz\/1/, '/c/4')
=> "/fo/c/423"
>> '/foo/bar/baz/123'.sub(%r(o/bar/baz/1), '/c/4')
=> "/fo/c/423"
```

<br>

## <a name="dot-metacharacter-and-quantifiers"></a>Dot metacharacter and Quantifiers

* the `.` metacharacter matches any character except newline character
    * later on, we'll see how to match newline as well

```ruby
>> 'tac tin cat abc;tuv acute'.gsub(/c.t/, 'X')
=> "taXin X abXuv aXe"

>> 'breadth markedly reported overrides'.gsub(/r..d/) { |s| s.upcase }
=> "bREADth maRKEDly repoRTED oveRRIDes"

>> "42\t33".sub(/2.3/, '8')
=> "483"
```

<br>

#### <a name="greedy-quantifiers"></a>Greedy quantifiers

* quantifiers help to specify how many times to match a character or grouping
* the `?` quantifier will match `0` or `1` times

```ruby
# same as: /far|fear/
>> 'far feat flare fear'.gsub(/fe?ar/, 'X')
=> "X feat flare X"
# same as: /ear|ar/
>> 'far feat flare fear'.gsub(/e?ar/, 'X')
=> "fX feat flXe fX"

# same as: /\bpar(t|)\b/
>> 'par spare part party'.gsub(/\bpart?\b/, 'X')
=> "X spare X party"

# same as: /\b(re.d|red)\b/
>> 'red read ready re;d redo reed'.gsub(/\bre.?d\b/, 'X')
=> "X X ready X redo X"

# same as: /part|parrot/
>> 'par part parrot parent'.gsub(/par(ro)?t/, 'X')
=> "par X X parent"
# same as: /part|parrot|parent/
>> 'par part parrot parent'.gsub(/par(en|ro)?t/, 'X')
=> "par X X X"
```

* the `*` quantifier will match `0` or more times

```ruby
>> 'tr tear tare steer sitaara'.gsub(/ta*r/, 'X')
=> "X tear Xe steer siXa"
>> 'tr tear tare steer sitaara'.gsub(/t(e|a)*r/, 'X')
=> "X X Xe sX siXa"

>> '3111111111125111142'.gsub(/1*2/, 'X')
=> "3X511114X"
>> '3111111111125111142'.partition(/1*2/)
=> ["3", "11111111112", "5111142"]
>> '3111111111125111142'.rpartition(/1*2/)
=> ["311111111112511114", "2", ""]

>> '3111111111125111142'.split(/1*/)
=> ["3", "2", "5", "4", "2"]
>> '3111111111125111142'.split(/1*/, -1)
=> ["3", "2", "5", "4", "2", ""]
```

* the `+` quantifier will match `1` or more times

```ruby
>> 'tr tear tare steer sitaara'.gsub(/ta+r/, 'X')
=> "tr tear Xe steer siXa"
>> 'tr tear tare steer sitaara'.gsub(/t(e|a)+r/, 'X')
=> "tr X Xe sX siXa"

>> '3111111111125111142'.gsub(/1+2/, 'X')
=> "3X5111142"
>> '3111111111125111142'.split(/1+/)
=> ["3", "25", "42"]
```

* the `{}` quantifier forms allow using numbers
    * `{m, n}` will match `m` to `n` times
    * `{m,}` will match at least `m` times
    * `{,n}` will match up to `n` times (including `0` times)
    * `{n}` will match exactly `n` times

```ruby
>> s = 'abc ac adc abbc bbb bc abbbbbc'
=> "abc ac adc abbc bbb bc abbbbbc"

>> s.gsub(/ab{1,4}c/, 'X')
=> "X ac adc X bbb bc abbbbbc"

>> s.gsub(/ab{2,}c/, 'X')
=> "abc ac adc X bbb bc X"

>> s.gsub(/ab{,3}c/, 'X')
=> "X X adc X bbb bc abbbbbc"

>> s.gsub(/ab{2}c/, 'X')
=> "abc ac adc X bbb bc abbbbbc"
```

* the quantifiers we've seen so far are all greedy in nature
* other than `{n}`, rest of them can match varying quantities of preceding character or group
* so, in cases where there can be multiple ways to satisfy the regexp, the longest match would win
    * See also [ruby-doc: Regexp Performance](https://ruby-doc.org/core-2.5.0/Regexp.html#class-Regexp-label-Performance)

```ruby
>> s = 'that is quite a fabricated tale'
=> "that is quite a fabricated tale"

# .* means any character any number of times
# /t.*a/ would match from first 't' to last 'a' in the line
>> s.sub(/t.*a/, 'X')
=> "Xle"
>> 'star'.sub(/t.*a/, 'X')
=> "sXr"

>> s.sub(/f.*t/, 'X')
=> "that is quite a Xale"

# overall regexp has to match
# matching first 't' to last 'a' for t.*a won't work for these cases
# so, the regexp engine backtracks until .*q matches and so on
>> s.sub(/t.*a.*q.*f/, 'X')
=> "Xabricated tale"
>> s.sub(/t.*a.*u/, 'X')
=> "Xite a fabricated tale"
```

* longest match wins nature of greedy quantifier is preferable over equivalent regexp defined using alternation 

```ruby
# same as: /handy|handful|hand/
>> 'hand handy handful'.gsub(/hand(y|ful)?/, 'X')
=> "X X X"

# same as: /ear|ar/
>> 'far fear'.gsub(/e?ar/, 'Y')
=> "fY fY"

>> puts 'blah \< foo < bar \< blah < baz'
blah \< foo < bar \< blah < baz
# same as: /\\<|</
>> puts 'blah \< foo < bar \< blah < baz'.gsub(/\\?</, '\<')
blah \< foo \< bar \< blah \< baz
```

<br>

#### <a name="non-greedy-quantifiers"></a>Non-greedy quantifiers

* appending a `?` to greedy quantifiers will change matching from greedy to non-greedy i.e match as minimally as possible
    * also known as lazy quantifier

```ruby
>> s = 'that is quite a fabricated tale'
=> "that is quite a fabricated tale"

>> s.sub(/t.*?a/, 'X')
=> "Xt is quite a fabricated tale"
>> s.sub(/f.*?t/, 'X')
=> "that is quite a Xed tale"

# overall regexp has to match
>> s.sub(/t.*?te/, 'X')
=> "X a fabricated tale"
# greedy version
>> s.sub(/t.*te/, 'X')
=> "Xd tale"

>> '123456789'.sub(/.{2,5}?/, '')
=> "3456789"
>> '123456789'.sub(/.{2,5}/, '')
=> "6789"
```

<br>

#### <a name="possessive-quantifiers"></a>Possessive quantifiers

* appending a `+` to greedy quantifiers will change matching from greedy to possessive matching
* it is like greedy matching but without backtracking
    * if both greedy and possessive nature yields same results, possessive would be faster
    * if results are different, usage depends on which one is required
* See also [stackoverflow: Greedy vs Reluctant vs Possessive Quantifiers](https://stackoverflow.com/questions/5319840/greedy-vs-reluctant-vs-possessive-quantifiers)

```ruby
# same results, possessive would be faster
>> 'abc ac adc abbbc'.gsub(/ab*c/, 'X')
=> "X X adc X"
>> 'abc ac adc abbbc'.gsub(/ab*+c/, 'X')
=> "X X adc X"

# different results
>> 'feat ft feaeat'.gsub(/f(a|e)*at/, 'X')
=> "X ft X"
# (a|e)*+ would match 'a' or 'e' as much as possible
# no backtracking, so another 'a' can never match
>> 'feat ft feaeat'.gsub(/f(a|e)*+at/, 'X')
=> "feat ft feaeat"
```

<br>

## <a name="match-scan-and-globals"></a>match, scan and globals

* similar to `match?`, the `match` method accepts a regexp and optional starting index
    * both these methods treat string argument as a regexp, unlike sub/split/etc
* the return value is of type `MatchData` from which various information can be extracted
    * See [ruby-doc: MatchData](https://ruby-doc.org/core-2.5.0/MatchData.html) for details

```ruby
>> 'abc ac adc abbbc'.match(/ab*c/)
=> #<MatchData "abc">
>> 'abc ac adc abbbc'.match(/ab*c/)[0]
=> "abc"

# string argument is treated same as a regexp
>> 'abc ac adc abbbc'.match('ab*c', 1)
=> #<MatchData "ac">
>> 'abc ac adc abbbc'.match('ab*c', 1)[0]
=> "ac"

>> 'abc ac adc abbbc'.match(/ab*c/, 7)
=> #<MatchData "abbbc">
>> 'abc ac adc abbbc'.match(/ab*c/, 7)[0]
=> "abbbc"
```

* another way to get matched string is providing regexp within `[]` on a string value

```ruby
>> s = 'abc ac adc abbbc'
=> "abc ac adc abbbc"

>> s[/ab*c/]
=> "abc"
>> s[1..-1][/ab*c/]
=> "ac"

>> s[/ab{2,}c/]
=> "abbbc"
```

* `scan` method returns all the matched strings as an array

```ruby
>> 'abc ac adc abbbc'.scan(/ab*c/)
=> ["abc", "ac", "abbbc"]
>> 'abc ac adc abbbc'.scan(/ab+c/)
=> ["abc", "abbbc"]
>> 'par spar apparent spare part'.scan(/\bs?pare?\b/)
=> ["par", "spar", "spare"]

# greedy vs non-greedy
>> 'that is quite a fabricated tale'.scan(/t.*a/)
=> ["that is quite a fabricated ta"]
>> 'that is quite a fabricated tale'.scan(/t.*?a/)
=> ["tha", "t is quite a", "ted ta"]

# use block to iterate over matched strings
>> 'abc ac adc abbbc'.scan(/ab+c/) { |s| puts s.upcase }
ABC
ABBBC
```

* global variables also hold information related to matched data
    * as noted before, `match?` method won't affect these variables
* `$~` contains `MatchData`
* <code>$`</code> contains string before the matched string
* `$&` contains matched string
* `$'` contains string after the matched string

```ruby
>> s = 'that is quite a fabricated tale'
=> "that is quite a fabricated tale"
>> s =~ /q.*b/
=> 8

>> $~
=> #<MatchData "quite a fab">
>> $~[0]
=> "quite a fab"
>> $`
=> "that is "
>> $&
=> "quite a fab"
>> $'
=> "ricated tale"
```

* for multiple matches, global variables will update for every match

```ruby
# same as: { |s| puts s.upcase }
>> 'abc ac adc abbbc'.scan(/ab+c/) { puts $&.upcase }
ABC
ABBBC

# referring to them after the instruction will have info only for last match
>> 'par spar apparent spare part'.scan(/\bpar\b|\bspare\b/)
=> ["par", "spare"]
>> $~
=> #<MatchData "spare">
>> $`
=> "par spar apparent "
>> $&
=> "spare"
>> $'
=> " part"
```

* `$1` will have string matched by first group
* `$2` will have string matched by second group and so on
* `$+` will have string matched by last group
* default value is `nil` if the group number didn't have a match

```ruby
>> s = 'that is quite a fabricated tale'
=> "that is quite a fabricated tale"

>> s =~ /(th.*q).*(b.*c)/
=> 0
>> $1
=> "that is q"
>> $2
=> "bric"
>> $+
=> "bric"

>> s =~ /s.*(q.*(f.*b).*c).*d/
=> 6
>> $&
=> "s quite a fabricated"
>> $1
=> "quite a fabric"
>> $2
=> "fab"
```

* group data can also be retrieved from MatchData
* negative index can be used, makes it easier to get last match, second last, etc

```ruby
>> s = 'that is quite a fabricated tale'
=> "that is quite a fabricated tale"
>> s =~ /(q.*(f.*b).*c).*d/
=> 8

>> $~
=> #<MatchData "quite a fabricated" 1:"quite a fabric" 2:"fab">
>> $~.to_a
=> ["quite a fabricated", "quite a fabric", "fab"]
>> $~[-2]
=> "quite a fabric"

>> s[/(q.*(f.*b).*c).*d/]
=> "quite a fabricated"
>> s[/(q.*(f.*b).*c).*d/, 0]
=> "quite a fabricated"
>> s[/(q.*(f.*b).*c).*d/, 1]
=> "quite a fabric"
>> s[/(q.*(f.*b).*c).*d/, 2]
=> "fab"
```

<br>

## <a name="character-class"></a>Character class

* `.` meta character provides a way to match any character
* character class provides a way to match any character among a specified set of characters enclosed within `[]`
* quantifiers applies to characters class as well

```ruby
# same as: /c(o|u)t/
>> 'cut cat cot coat'.gsub(/c[ou]t/, 'X')
=> "X cat X coat"

# same as: /(a|o)+t/
>> 'oat ft boa foot'.gsub(/[ao]+t/, 'X')
=> "X ft boa fX"

>> 'foo5932baz'.sub(/[0123456789]+/, '')
=> "foobaz"
```

* matching any alphabet, number, hexadecimal number etc becomes cumbersome if every character has to be individually specified
* so, there's a shortcut, using `-` to construct a range

```ruby
>> 'foo5932baz'.sub(/[0-9]+/, '')
=> "foobaz"

# whole words made up of lowercase alphabets only
>> 'coat Bin food tar12 best'.scan(/\b[a-z]+\b/)
=> ["coat", "food", "best"]

# whole words made up of lowercase alphabets and digits only
>> 'coat Bin food tar12 best'.scan(/\b[a-z0-9]+\b/)
=> ["coat", "food", "tar12", "best"]

# whole words made up of lowercase alphabets, starting with p to z
>> 'coat tin food put stoop best'.scan(/\b[p-z][a-z]+\b/)
=> ["tin", "put", "stoop"]

# whole words made up of a to f, p to t lowercase alphabets
>> 'coat tin food put stoop best'.scan(/\b[a-fp-t]+\b/)
=> ["best"]
```

* some simple cases of numeric range can be constructed using character class
    * use block form for the rest
* See also [Matching Numeric Ranges with a Regular Expression](https://www.regular-expressions.info/numericranges.html)

```ruby
# numbers between 10 to 29
>> '23 154 12 26 98234'.scan(/\b[12][0-9]\b/)
=> ["23", "12", "26"]

# numbers >= 100
>> '23 154 12 26 98234'.scan(/\b[0-9]{3,}\b/)
=> ["154", "98234"]

# numbers >= 100 if there are leading zeros
>> '0501 035 154 12 26 98234'.scan(/\b0*[1-9][0-9]{2,}\b/)
=> ["0501", "154", "98234"]

>> '45 349 651 593 4 204'.gsub(/[0-9]+/) { $&.to_i < 350 ? 0 : 1 }
=> "0 0 1 1 0 0"
```

* character class has its own set of metacharacters
* we've already seen `-` which helps to form a range
* using `^` as first character inside `[]` will result in matching characters other than those specified

```ruby
# deleting characters from start of line based on a delimiter
>> 'foo=42; baz=123'.sub(/^[^=]+/, '')
=> "=42; baz=123"
>> 'foo=42; baz=123'.sub(/^[^=]+=/, '')
=> "42; baz=123"

# deleting characters at end of line based on a delimiter
>> 'foo=42; baz=123'.sub(/=[^=]+$/, '')
=> "foo=42; baz"

# filtering words without vowels
>> words = %w[tryst glyph pity why]
=> ["tryst", "glyph", "pity", "why"]
# can also use: { |w| w =~ /\b[^aeiou]+\b/ }
>> words.select { |w| w.match?(/\b[^aeiou]+\b/) }
=> ["tryst", "glyph", "why"]
```

* use `&&` to define intersection of two or more character classes

```ruby
# [^aeiou] will match any non-vowel character
>> 'tryst glyph pity why'.scan(/\b[^aeiou]+\b/)
=> ["tryst glyph ", " why"]

# [a-z&&[^aeiou]] will be intersection of a-z and non-vowel characters
>> 'tryst glyph pity why'.scan(/\b[a-z&&[^aeiou]]+\b/)
=> ["tryst", "glyph", "why"]
```






