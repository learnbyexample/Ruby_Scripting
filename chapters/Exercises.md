# <a name="exercises"></a>Exercises

1) [Variables and Print](#variables-and-print)
2) [Functions](#functions)
3) [Control structures](#control-structures)

<br>

For some questions, Ruby program with `raise` statements is provided to automatically test your solution in the [exercise_files](https://github.com/learnbyexample/Ruby_Scripting/tree/master/exercise_files) directory

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

<br>

<br>

*More to come*
