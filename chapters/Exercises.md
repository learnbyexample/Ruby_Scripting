# <a name="exercises"></a>Exercises

1) [Variables and Print](#variables-and-print)
2) [Functions](#functions)
3) [Control structures](#control-structures)
4) [List](#list)
5) [File](#file)
6) [Text processing](#text-processing)

<br>

* For some questions, Ruby program with `raise` statements is provided to automatically test your solution in the [exercise_files](https://github.com/learnbyexample/Ruby_Scripting/tree/master/exercise_files) directory
* You can also solve these exercises on [repl.it](https://repl.it/community/classrooms/53963), with an option to submit them for review
    * or use [gitter group chat](https://gitter.im/learnbyexample/scripting_course) for discussion

<br>

## <a name="variables-and-print"></a>1) Variables and Print

**Q1a)** Ask user information, for ex: `name`, `department`, `college` etc and display them using print function

```
# Sample of how program might ask user input and display output afterwards
$ ./usr_ip.rb 
Please provide the following details
Enter your name: learnbyexample
Enter your department: ECE
Enter your college: PSG Tech

------------------------------------
Name       : learnbyexample
Department : ECE
College    : PSG Tech
------------------------------------
```

<br>

## <a name="functions"></a>2) Functions

**Q2a)** Write a function to return length of integer numbers

```ruby
irb(main):001:0> len_int(962306349871524124750813401378124)
=> 33
irb(main):002:0> len_int(+42)
=> 2
irb(main):003:0> len_int(-42)
=> 2

# len_int('a') should give
TypeError (provide only integer input)
```

**Q2b)** Compare if two strings are same irrespective of case

```ruby
irb(main):001:0> str_cmp('nice', 'nice')
=> true
irb(main):002:0> str_cmp('how', 'who')
=> false
irb(main):003:0> str_cmp('GoOd DaY', 'gOOd dAy')
=> true
irb(main):004:0> str_cmp('foo', 'food')
=> false
```

**Q2c)** Compare if two strings are anagrams (assume input consists of ASCII alphabets only)

```ruby
irb(main):001:0> str_anagram('god', 'Dog')
=> true
irb(main):002:0> str_anagram('beat', 'table')
=> false
irb(main):003:0> str_anagram('Tap', 'paT')
=> true
irb(main):004:0> str_anagram('beat', 'abet')
=> true
irb(main):005:0> str_anagram('seat', 'teal')
=> false
```

**Q2d)** Write a function to return corresponding integer or floating-point number for given number/string input

```ruby
# number input
irb(main):001:0> num(3)
=> 3
irb(main):002:0> num(0x1f)
=> 31
irb(main):003:0> num(3.32)
=> 3.32

# string input
irb(main):004:0> num('123')
=> 123
irb(main):005:0> num('-78')
=> -78
irb(main):006:0> num(" 42  \n ")
=> 42
irb(main):007:0> num('3.14')
=> 3.14
irb(main):008:0> num('3.982e5')
=> 398200.0

irb(main):009:0> s = '56'
=> "56"
irb(main):010:0> num(s) + 44
=> 100
```

Raise exception if input is not valid or if the input cannot be converted to a number

```ruby
# num(['1', '2.3'])
TypeError (not a valid input)

# num('foo')
ArgumentError (could not convert string to int or float)
```

<br>

## <a name="control-structures"></a>3) Control structures

**Q3a)** Write a function that returns

* 'Good' for numbers divisible by 7
* 'Food' for numbers divisible by 6
* 'Universe' for numbers divisible by 42
* 'Oops' for all other numbers
* Only one output, divisible by 42 takes precedence

```ruby
irb(main):001:0> six_by_seven(66)
=> "Food"
irb(main):002:0> six_by_seven(13)
=> "Oops"
irb(main):003:0> six_by_seven(42)
=> "Universe"
irb(main):004:0> six_by_seven(14)
=> "Good"
irb(main):005:0> six_by_seven(84)
=> "Universe"
irb(main):006:0> six_by_seven(235432)
=> "Oops"
```

*bonus*: use a loop to print number and corresponding string for numbers 1 to 100

```
1 Oops
2 Oops
3 Oops
4 Oops
5 Oops
6 Food
7 Good
...
41 Oops
42 Universe
...
98 Good
99 Oops
100 Oops
```

**Q3b)** Write a function that

* accepts two integers
* for all integers in the range defined by them, find all numbers that are simultaneously palindromes in decimal, binary and octal representations - for example, **585** is palindrome in all three representations
* return the result as list of lists
* first list should contain pairs of decimal and binary numbers
* second list should contain groups of decimal, binary and octal numbers

```ruby
irb(main):001:0> num_palindrome(6, 20)
=> [[["7", "111"], ["9", "1001"]], [["7", "111", "7"], ["9", "1001", "11"]]]
irb(main):002:0> num_palindrome(300, 600)
=> [[["313", "100111001"], ["585", "1001001001"]], [["585", "1001001001", "1111"]]]
```

<br>

## <a name="list"></a>4) List

**Q4a)** Write a function that returns product of all numbers of a list/range

```ruby
irb(main):001:0> product([1, 4, 21])
=> 84
irb(main):002:0> product([-4, 2.3e12, 77.23, 982, 0b101])
=> -3.48863356e+18
irb(main):003:0> product([-3, 11, 2])
=> -66
irb(main):004:0> product([8, 300])
=> 2400
irb(main):005:0> product([234, 121, 23, 945, 0])
=> 0
irb(main):006:0> product(1..5)
=> 120
```

**Q4b)** Write a function that returns nth lowest of a list/string. Return the lowest if second argument is not specified

*Note* that duplicates shouldn't affect determining nth lowest

```ruby
irb(main):001:0> nums = [42, 23421341, 234.2e3, 21, 232, 12312, -2343]
=> [42, 23421341, 234200.0, 21, 232, 12312, -2343]
irb(main):002:0> nth_lowest(nums, 3)
=> 42
irb(main):003:0> nth_lowest(nums, 5)
=> 12312

irb(main):004:0> nums = [1, -2, 4, 2, 1, 3, 3, 5]
=> [1, -2, 4, 2, 1, 3, 3, 5]
irb(main):005:0> nth_lowest(nums)
=> -2
irb(main):006:0> nth_lowest(nums, 4)
=> 3

irb(main):007:0> nth_lowest('unrecognizable', 3)
=> "c"
irb(main):008:0> nth_lowest('jump', 2)
=> "m"
irb(main):009:0> nth_lowest('abracadabra', 5)
=> "r"
```

<br>

## <a name="file"></a>5) File

**Q5a)** Print sum of all numbers from a file containing only single column numbers (integer or float)

```
$ cat f1.txt 
8
53
3.14
84
73e2
100
2937

$ ./col_sum.rb 
10485.14
```

**Q5b)** Print sum of all numbers (assume only positive integer numbers) from a file containing arbitrary string

```
$ cat f2.txt 
Hello123 World 35
341 2
Good 13day
How are 1784 you

$ ./extract_sum.rb 
2298
```

<br>

## <a name="text-processing"></a>6) Text processing

**Q6a)** Check if two words are same or differ by only one character (irrespective of case), input strings should have same length

See also [Levenshtein distance](https://en.wikipedia.org/wiki/Levenshtein_distance)

```ruby
irb(main):001:0> is_one_char_diff('bar', 'bar')
=> true
irb(main):002:0> is_one_char_diff('bar', 'Baz')
=> true
irb(main):003:0> is_one_char_diff('Food', 'fold')
=> true
irb(main):004:0> is_one_char_diff('A', 'b')
=> true

irb(main):005:0> is_one_char_diff('a', '')
=> false
irb(main):006:0> is_one_char_diff('Bar', 'Bark')
=> false
irb(main):007:0> is_one_char_diff('Bar', 'art')
=> false
irb(main):008:0> is_one_char_diff('Food', 'fled')
=> false
irb(main):009:0> is_one_char_diff('ab', '')
=> false
```

**Q6b)** Check if each word of a sentence(separated by whitespace) is in ascending/descending alphabetic order or not (irrespective of case)

```ruby
irb(main):001:0> is_alpha_order('bot')
=> true
irb(main):002:0> is_alpha_order('AborT')
=> true
irb(main):003:0> is_alpha_order('toe')
=> true

irb(main):004:0> is_alpha_order('are')
=> false
irb(main):005:0> is_alpha_order('Flee')
=> false

irb(main):006:0> is_alpha_order('Toe got bit')
=> true
irb(main):007:0> is_alpha_order('All is well')
=> false
irb(main):008:0> is_alpha_order('Food is good')
=> false
```

**Q6c)** Find the maximum nested depth of curly braces

Unbalanced, empty or wrongly ordered braces should return `-1`

Hint: Iterate over string characters or use regular expressions

```ruby
irb(main):001:0> max_nested_braces('a*b')
=> 0
irb(main):002:0> max_nested_braces('{a+2}*{b+c}')
=> 1
irb(main):003:0> max_nested_braces('{{a+2}*{{b+{c*d}}+e*d}}')
=> 4
irb(main):007:0> max_nested_braces('{{a+2}*{b+{c*d}}+e}')
=> 3

irb(main):004:0> max_nested_braces('a*b+{}')
=> -1
irb(main):005:0> max_nested_braces('}a+b{')
=> -1
irb(main):006:0> max_nested_braces('a*b{')
=> -1
```




<br>

<br>

<br>

*More to come*
