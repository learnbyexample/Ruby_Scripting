# <a name="exercises"></a>Exercises

1) [Variables and Print](#variables-and-print)
2) [Functions](#functions)

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

<br>

<br>

*More to come*
