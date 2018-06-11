# <a name="arrays"></a>Arrays

**Table of Contents**

* [Assignment and Indexing](#assignment-and-indexing)
* [Slicing](#slicing)
* [Copying](#copying)
* [Looping](#looping)
* [Modifying elements](#modifying-elements)
* [Filtering](#filtering)
* [Sorting and company](#sorting-and-company)
* [Transforming whole array](#transforming-whole-array)
* [Miscellaneous](#miscellaneous)
* [Getting Array as user input](#getting-array-as-user-input)

<br>

## <a name="assignment-and-indexing"></a>Assignment and Indexing

* as comma separated values inside `[]`
* elements can be of mixed data type
* index starts from `0`
* if negative index is given, size of the array is added to it
    * so, if array size is `3`, an index of `-1` would be interpreted as `-1+3` giving the last element of array
    * similarly, `-2` will give last but one element and so on
* use `fetch` method to get an error instead of `nil` for out of bound index

```ruby
>> nums = [3, 12]
=> [3, 12]
>> fruits = ['apple', 'mango', 'orange']
=> ["apple", "mango", "orange"]
>> student = ['learnbyexample', 25, '101CS18']
=> ["learnbyexample", 25, "101CS18"]

>> nums[0]
=> 3
>> puts fruits[1]
mango
=> nil
>> student[-1]
=> "101CS18"

# out of bound index
>> nums[2]
=> nil
>> nums.fetch(2)
IndexError (index 2 outside of array bounds: -2...2)
```

* variables and expressions can also be used instead of values

```ruby
>> a = 3.14
=> 3.14
>> nums = [a, Math.sqrt(45), 46%4]
=> [3.14, 6.708203932499369, 2]

>> items = ["foo\nbaz", "123\n42\n65", '=' * 3]
=> ["foo\nbaz", "123\n42\n65", "==="]
>> puts items[1]
123
42
65
=> nil
```

* an array element can itself be another array
* and element of inner array can be another array and so on...

```ruby
>> records = [[4, 6, 53], [101, 104, 107, 123]]
=> [[4, 6, 53], [101, 104, 107, 123]]
>> records[0]
=> [4, 6, 53]
>> records[0][-1]
=> 53

>> a = [[1, 'a'], [[6, 3], [7, 6]]]
=> [[1, "a"], [[6, 3], [7, 6]]]
>> a[1]
=> [[6, 3], [7, 6]]
>> a[1][0]
=> [6, 3]
>> a[1][0][1]
=> 3
```

* `%w` percent string is useful to create an array of strings
* space is used to separate the strings, which can be escaped if needed

```ruby
>> fruits = %w[apple mango orange]
=> ["apple", "mango", "orange"]

>> books = %w{Harry\ Potter Stormlight\ Archive Kingkiller\ Chronicle}
=> ["Harry Potter", "Stormlight Archive", "Kingkiller Chronicle"]

>> items = %w("foo\nbaz" "123\n42\n65")
=> ["\"foo\\nbaz\"", "\"123\\n42\\n65\""]
```

* arrays can also be created using `new` method of Array class
    * helpful to initialize the array with same default value
* `range/step` etc can be converted to array using the `to_a` method

```ruby
>> nums = Array.new(5, 0)
=> [0, 0, 0, 0, 0]
# or use repetition operator
>> nums = [0] * 5
=> [0, 0, 0, 0, 0]

>> Array.new(2)
=> [nil, nil]

# to avoid same mutable object as default, use the block form
>> a = Array.new(5) { 'foo' }
=> ["foo", "foo", "foo", "foo", "foo"]
>> a[0].equal?(a[1])
=> false

>> nums = 2.step(31, 6).to_a
=> [2, 8, 14, 20, 26]
```

* multiple variable assignment
* See also [ruby-doc: Array to Arguments Conversion](https://ruby-doc.org/core-2.5.0/doc/syntax/calling_methods_rdoc.html#label-Array+to+Arguments+Conversion)

```ruby
>> a, b = [2, 42]
=> [2, 42]
>> a
=> 2
>> b
=> 42

# [] is optional
>> a, b = b, a
=> [42, 2]
>> a
=> 42
>> b
=> 2

>> nums = [3, 12, 17, 25, 100]
=> [3, 12, 17, 25, 100]
>> a, *b, c = nums
=> [3, 12, 17, 25, 100]
>> a
=> 3
>> b
=> [12, 17, 25]
>> c
=> 100
```

**Further Reading**

* [ruby-doc: Array](https://ruby-doc.org/core-2.5.0/Array.html)
* [ruby-doc: Enumerable](https://ruby-doc.org/core-2.5.0/Enumerable.html)
    * Array is enumerable, so all Enumerable methods are applicable to Array objects as well
    * If any method mentioned in this chapter is not found in Array docs, check under Enumerable docs

<br>

## <a name="slicing"></a>Slicing

* slicing allows to access one or more contiguous elements
* See [ruby-doc: slice](https://ruby-doc.org/core-2.5.0/Array.html#method-i-slice) for details

```ruby
>> primes = [2, 3, 5, 7, 11, 13]
=> [2, 3, 5, 7, 11, 13]

# range can be used to specify start and end index
>> primes[2..4]
=> [5, 7, 11]
>> primes[1..-2]
=> [3, 5, 7, 11]

# starting index and number of elements needed from that index
>> primes[1, 3]
=> [3, 5, 7]
>> primes[-3, 2]
=> [7, 11]
>> primes[1, 0]
=> []
>> primes[1, -2]
=> nil
```

* the elements specified by slice can be replaced by any another value

```ruby
>> foo = [42, 904, 'good', 12, 'xyz']
=> [42, 904, "good", 12, "xyz"]

>> foo[1, 3] = 'treat'.chars
=> ["t", "r", "e", "a", "t"]
>> foo
=> [42, "t", "r", "e", "a", "t", "xyz"]

>> foo[2..-2] = 'baz'
=> "baz"
>> foo
=> [42, "t", "baz", "xyz"]
```

* related methods - these allow only accessing elements, not modification

```ruby
>> primes = [2, 3, 5, 7, 11, 13]
=> [2, 3, 5, 7, 11, 13]

# n elements from start
>> primes.first(3)
=> [2, 3, 5]

# last n elements
>> primes.last(2)
=> [11, 13]

# except n elements from start
>> primes.drop(2)
=> [5, 7, 11, 13]

# elements specified by given index/slice
>> primes.values_at(1, 3, 0, -1)
=> [3, 7, 2, 13]
>> primes.values_at(1, 3..5)
=> [3, 7, 11, 13]
```

* the splat operator `*` can be used to pass multiple valued object as separate arguments to a method
* See also [ruby-doc: Array to Arguments Conversion](https://ruby-doc.org/core-2.5.0/doc/syntax/calling_methods_rdoc.html#label-Array+to+Arguments+Conversion)

```ruby
>> primes = [2, 3, 5, 7, 11, 13]
=> [2, 3, 5, 7, 11, 13]

>> primes.values_at(*(0...primes.length).step(2))
=> [2, 5, 11]

>> primes.reverse
=> [13, 11, 7, 5, 3, 2]
>> primes.values_at(*(primes.length-1).step(0, -2))
=> [13, 7, 3]
```

<br>

## <a name="copying"></a>Copying

* arrays are mutable like strings
* so, assigning an array variable to another will result in both variables pointing to same object
* use `equal?` method to check if two variables are references to same object

```ruby
>> nums = [3, 61]
=> [3, 61]
>> nums_copy = nums
=> [3, 61]
>> nums_copy.equal?(nums)
=> true

>> nums_copy[0] = 'foo'
=> "foo"
>> nums_copy
=> ["foo", 61]
>> nums
=> ["foo", 61]
```

* passing a variable to a method will have same effect as above example

```ruby
>> def foo(a)
>>   a[1] = 'baz'
>> end
=> :foo

>> nums = [1, 2, 3]
=> [1, 2, 3]
>> foo(nums)
=> "baz"
>> nums
=> [1, "baz", 3]
```

* assigning an element of array clone to new value won't affect the original array irrespective of mutability

```ruby
>> a = [1, 'good']
=> [1, "good"]
>> b = a.clone
=> [1, "good"]

>> a.equal?(b)
=> false
>> a[1].equal?(b[1])
=> true

>> b[0] = 42
=> 42
>> b[1] = 'bad'
=> "bad"
>> b
=> [42, "bad"]
>> a
=> [1, "good"]
```

* modifying a mutable element of array clone will affect the original array as well

```ruby
>> fruits = %w[apple mango guava]
=> ["apple", "mango", "guava"]
>> fruits_copy = fruits.clone
=> ["apple", "mango", "guava"]

>> fruits_copy.equal?(fruits)
=> false
>> fruits_copy[0].equal?(fruits[0])
=> true

>> fruits_copy[0][0] = 'A'
=> "A"
>> fruits_copy
=> ["Apple", "mango", "guava"]
>> fruits
=> ["Apple", "mango", "guava"]
```

* one way to avoid this is cloning each element needed, instead of cloning the array

```ruby
>> fruits = %w[apple mango guava]
=> ["apple", "mango", "guava"]

>> my_fruit = fruits[0].clone
=> "apple"
>> my_fruit.equal?(fruits[0])
=> false

>> my_fruit[0] = 'A'
=> "A"
>> my_fruit
=> "Apple"
>> fruits
=> ["apple", "mango", "guava"]

# cloning all the elements
# map/zip is covered later in the chapter
>> fruits_copy = fruits.map(&:clone)
=> ["apple", "mango", "guava"]
>> fruits_copy.zip(fruits) { |i, j| puts i.equal?(j) }
false
false
false
=> nil
```

* however, above solution would fail for nested arrays and other cases 
* using `Marshal` module is one way to create a copy of array without worrying if it contains mutable objects
* See [ruby-doc: Marshal](https://ruby-doc.org/core-2.5.0/Marshal.html) for caveats

```ruby
>> foo = [42, [12, 5, 63], ['foo', [7, 6]]]
=> [42, [12, 5, 63], ["foo", [7, 6]]]
>> baz = Marshal.load(Marshal.dump(foo))
=> [42, [12, 5, 63], ["foo", [7, 6]]]

>> baz[0] = 'good'
=> "good"
>> baz[1][2] = 42
=> 42
>> baz[2][1][0] = 1000
=> 1000
>> baz[2][0].upcase!
=> "FOO"

>> baz
=> ["good", [12, 5, 42], ["FOO", [1000, 6]]]
>> foo
=> [42, [12, 5, 63], ["foo", [7, 6]]]
```

<br>

## <a name="looping"></a>Looping

* for loop

```ruby
>> numbers = [2, 12, 3, 25, 624, 21, 5, 9, 12]
=> [2, 12, 3, 25, 624, 21, 5, 9, 12]

>> for num in numbers
>>   puts num if num%2 == 0
>> end
2
12
624
12
=> [2, 12, 3, 25, 624, 21, 5, 9, 12]
```

* using array methods

```ruby
>> fruits = %w[apple mango guava orange]
=> ["apple", "mango", "guava", "orange"]

>> fruits.each { |f| puts f }
apple
mango
guava
orange
=> ["apple", "mango", "guava", "orange"]

>> fruits.reverse_each do |f|
?>   puts f
>> end
orange
guava
mango
apple
=> ["apple", "mango", "guava", "orange"]
```

* if index is needed

```ruby
>> books = %w[Elantris Martian Dune Alchemist]
=> ["Elantris", "Martian", "Dune", "Alchemist"]

>> books.each_index { |i| puts "#{i+1}) #{books[i]}" }
1) Elantris
2) Martian
3) Dune
4) Alchemist
=> ["Elantris", "Martian", "Dune", "Alchemist"]

>> books.each_with_index { |b, i| puts "#{i+1}) #{b}" }
1) Elantris
2) Martian
3) Dune
4) Alchemist
=> ["Elantris", "Martian", "Dune", "Alchemist"]

>> numbers = [2, 12, 3, 25, 624, 21, 5, 9, 12]
=> [2, 12, 3, 25, 624, 21, 5, 9, 12]
>> (0...numbers.length).step(3) { |i| puts numbers[i] }
2
25
5
=> 0...9
```

* iterating over two or more arrays simultaneously
* if lengths of arrays are different, `nil` is used to fill absent values

```ruby
>> odd = [1, 3, 5]
=> [1, 3, 5]
>> even = [2, 4, 6]
=> [2, 4, 6]

>> odd.zip(even) { |i, j| puts "#{i} #{j}" }
1 2
3 4
5 6
=> nil
```

<br>

## <a name="modifying-elements"></a>Modifying elements

* using slicing

```ruby
>> books = %w[Dune Martian]
=> ["Dune", "Martian"]

>> books[0] = 'Harry Potter'
=> "Harry Potter"
>> books
=> ["Harry Potter", "Martian"]

# elements can be added beyond current length of array
>> books[4] = 'Alchemist'
=> "Alchemist"
>> books
=> ["Harry Potter", "Martian", nil, nil, "Alchemist"]

>> books[2..3] = %w[Dune Elantris]
=> ["Dune", "Elantris"]
>> books
=> ["Harry Potter", "Martian", "Dune", "Elantris", "Alchemist"]
```

* `append` method

```ruby
>> primes = [2, 3]
=> [2, 3]
>> primes.append(5)
=> [2, 3, 5]
>> primes.append(7, 11, 13)
=> [2, 3, 5, 7, 11, 13]

>> a = ['foo', 'baz']
=> ["foo", "baz"]
>> b = [2]
=> [2]
>> b.append(a)
=> [2, ["foo", "baz"]]
>> b.append(*a)
=> [2, ["foo", "baz"], "foo", "baz"]
```

* concatenation

```ruby
>> primes = [2, 3]
=> [2, 3]
>> primes + [5]
=> [2, 3, 5]
>> primes + [5, 7, 11, 13]
=> [2, 3, 5, 7, 11, 13]

# in-place concatenation
>> nums = [-5, 2]
=> [-5, 2]
>> nums << 42
=> [-5, 2, 42]
>> nums << ['foo', 'baz']
=> [-5, 2, 42, ["foo", "baz"]]

# same as: nums.append(*primes)
>> nums.concat(primes)
=> [-5, 2, 42, ["foo", "baz"], 2, 3]
```

* deleting elements based on index

```ruby
>> primes = [2, 3, 5, 7, 11, 13, 17]
=> [2, 3, 5, 7, 11, 13, 17]

# single index
>> primes.slice!(3)
=> 7
>> primes
=> [2, 3, 5, 11, 13, 17]

# range
>> primes.slice!(1..3)
=> [3, 5, 11]
>> primes
=> [2, 13, 17]

# starting index and length
>> primes.slice!(0, 2)
=> [2, 13]
>> primes
=> [17]
```

* nested array example

```ruby
>> arr_2d = [[1, 3, 2, 10], [1.2, -0.2, 0, 2]]
=> [[1, 3, 2, 10], [1.2, -0.2, 0, 2]]

>> arr_2d[0].slice!(3)
=> 10
>> arr_2d
=> [[1, 3, 2], [1.2, -0.2, 0, 2]]

>> arr_2d.slice!(1)
=> [1.2, -0.2, 0, 2]
>> arr_2d
=> [[1, 3, 2]]
```

* `pop` method - to delete element(s) from end of array
* `clear` method - to delete all elements

```ruby
>> primes = [2, 3, 5, 7, 11]
=> [2, 3, 5, 7, 11]

>> primes.pop
=> 11
>> primes
=> [2, 3, 5, 7]

>> primes.pop(2)
=> [5, 7]
>> primes
=> [2, 3]

>> primes.clear
=> []
>> primes
=> []
```

* deleting element(s) based on value(s)

```ruby
# single value
>> nums = [1, 5, 2, 1, 3, 1, 2]
=> [1, 5, 2, 1, 3, 1, 2]
>> nums.delete(1)
=> 1
>> nums
=> [5, 2, 3, 2]
>> nums.delete(12)
=> nil

# multiple values
>> primes = [2, 3, 5, 7, 11]
=> [2, 3, 5, 7, 11]
>> primes = primes - [3]
=> [2, 5, 7, 11]
>> primes = primes - [7, 2]
=> [5, 11]
```

* inserting element(s)

```ruby
>> books = %w[Elantris Martian Dune]
=> ["Elantris", "Martian", "Dune"]

>> books.insert(1, 'Harry Potter')
=> ["Elantris", "Harry Potter", "Martian", "Dune"]

>> books.insert(3, 'Alchemist', 'Mort')
=> ["Elantris", "Harry Potter", "Martian", "Alchemist", "Mort", "Dune"]
```

<br>

## <a name="filtering"></a>Filtering

* check if an element is present and how many times it is present

```ruby
>> books = %w[Elantris Martian Dune]
=> ["Elantris", "Martian", "Dune"]
>> books.include?('Dune')
=> true
>> books.include?('Alchemist')
=> false

>> nums = [15, 99, 19, 382, 43, 19]
=> [15, 99, 19, 382, 43, 19]
>> nums.count(99)
=> 1
>> nums.count(19)
=> 2
>> nums.count(23)
=> 0
```

* get index of an element based on value/condition

```ruby
>> nums = [1, 5, 2, 1, 3, 1, 2]
=> [1, 5, 2, 1, 3, 1, 2]

# based on value
# first match
>> nums.index(1)
=> 0

# last match
>> nums.rindex(1)
=> 5

>> nums.index(12)
=> nil

# based on a condition
>> nums.index { |n| n > 2 && n < 4 }
=> 4
>> nums.rindex { |n| n > 1 }
=> 6
```

* get first element or all elements/indices based on a condition

```ruby
>> nums = [1, 5, 2, 1, 3, 1, 2]
=> [1, 5, 2, 1, 3, 1, 2]

>> nums.find { |n| n > 2 }
=> 5
>> nums.select { |n| n > 2 }
=> [5, 3]
>> nums.each_index.select { |i| nums[i] > 2 }
=> [1, 4]

# select has opposite called reject, similar to if-unless
>> nums.select { |n| n <= 2 }
=> [1, 2, 1, 1, 2]
>> nums.reject { |n| n > 2 }
=> [1, 2, 1, 1, 2]

# in-place modification
>> nums.select! { |n| n < 3 }
=> [1, 2, 1, 1, 2]
>> nums
=> [1, 2, 1, 1, 2]
```

* use `partition` to get both matching and non-matching elements

```ruby
>> nums = [1, 5, 2, 1, 3, 1, 2]
=> [1, 5, 2, 1, 3, 1, 2]
>> nums.partition { |n| n > 2 }
=> [[5, 3], [1, 2, 1, 1, 2]]

>> gt2, lt2 = nums.partition { |n| n > 2 }
=> [[5, 3], [1, 2, 1, 1, 2]]
>> gt2
=> [5, 3]
>> lt2
=> [1, 2, 1, 1, 2]
```

* random element(s)

```ruby
>> primes = [2, 3, 5, 7, 11, 13, 17]
=> [2, 3, 5, 7, 11, 13, 17]

>> primes.sample
=> 13
>> primes.sample
=> 7

>> primes.sample(3)
=> [2, 13, 3]
```

<br>

## <a name="sorting-and-company"></a>Sorting and company

* default sort

```ruby
>> nums = [1, 5.3, 321, 0, 1, 2]
=> [1, 5.3, 321, 0, 1, 2]
>> nums.sort
=> [0, 1, 1, 2, 5.3, 321]
>> nums.sort.reverse
=> [321, 5.3, 2, 1, 1, 0]

>> ['good', 'foo', 'baz'].sort
=> ["baz", "foo", "good"]

>> [2, 'bad'].sort
ArgumentError (comparison of Integer with String failed)

# in-place sorting
>> nums.sort!
=> [0, 1, 1, 2, 5.3, 321]
>> nums
=> [0, 1, 1, 2, 5.3, 321]
```

* before we continue on more sorting stuff, let's see the `<=>` operator
* it gives `1` if LHS is greater than RHS, `-1` if lesser than RHS and `0` if equal to RHS

```ruby
>> 4 <=> 2
=> 1
>> 4 <=> 20
=> -1
>> 4 <=> 4
=> 0

>> 'good' <=> 'bad'
=> 1
>> 'good' <=> 'tool'
=> -1
>> 'good' <=> 'good'
=> 0
```

* to define a custom sorting operation, block expression has to return `1/-1/0` for comparison between two elements
    * `1` and `-1` can be any positive and negative number respectively

```ruby
>> nums = [1, 5.3, 321, 0, 1, 2]
=> [1, 5.3, 321, 0, 1, 2]
# same as: nums.sort
>> nums.sort { |a, b| a <=> b }
=> [0, 1, 1, 2, 5.3, 321]
# same as: nums.sort.reverse
>> nums.sort { |a, b| b <=> a }
=> [321, 5.3, 2, 1, 1, 0]

>> words = %w[fuliginous crusado morello irk seam]
=> ["fuliginous", "crusado", "morello", "irk", "seam"]
>> words.sort { |a, b| a.length <=> b.length }
=> ["irk", "seam", "crusado", "morello", "fuliginous"]

>> nums = [1, 4, 5, 2, 51, 3, 6, 22]
=> [1, 4, 5, 2, 51, 3, 6, 22]
# bring even numbers to the front, keeping order intact
>> nums.sort { |a, b| a%2 == 0 ? -1 : b%2 == 0 ? 1 : 0 }
=> [4, 2, 6, 22, 1, 5, 51, 3]
# bring odd numbers to the front, keeping order intact
>> nums.sort { |a, b| a%2 == 1 ? -1 : b%2 == 1 ? 1 : 0 }
=> [1, 5, 51, 3, 4, 2, 6, 22]
```

* use array to define one or more tie-breaker conditions

```ruby
>> words = %w[foo bad good teal nice how]
=> ["foo", "bad", "good", "teal", "nice", "how"]

# foo/bad/how have same length of 3
# by default, their order will be same as in input array
>> words.sort { |a, b| a.length <=> b.length }
=> ["foo", "bad", "how", "good", "teal", "nice"]
# one or more tie-breakers can be defined for such cases
>> words.sort { |a, b| [a.length, a] <=> [b.length, b] }
=> ["bad", "foo", "how", "good", "nice", "teal"]

# negating will give reverse order for methods returning a numeric value
# here, we get longer words first, ascending alphabetic order as tie-breaker
>> words.sort { |a, b| [-a.length, a] <=> [-b.length, b] }
=> ["good", "nice", "teal", "bad", "foo", "how"]
# here, we get longer words first, descending alphabetic order as tie-breaker
>> words.sort { |a, b| [-a.length, b] <=> [-b.length, a] }
=> ["teal", "nice", "good", "how", "foo", "bad"]
```

* often, sorting is required based on a method applied to each element of array
    * for ex: sorting words in an array by length of the word
* in such cases, use `sort_by` for simpler syntax
    * See [ruby-doc: sort_by](https://ruby-doc.org/core-2.5.0/Enumerable.html#method-i-sort_by) for details on performance considerations
* which can further be shortened by using `&` operator and method's symbol
    * See also [stackoverflow: What does &:name mean in Ruby?](https://stackoverflow.com/questions/1217088/what-does-mapname-mean-in-ruby)
* to debug an issue with `sort_by`, replace it with `map` - that would show the mapping based on which you are trying to sort the array

```ruby
>> words = %w[foo bad good teal nice how]
=> ["foo", "bad", "good", "teal", "nice", "how"]
>> words.sort_by { |w| w.length }
=> ["foo", "bad", "how", "good", "teal", "nice"]
>> words.sort_by { |w| [w.length, w] }
=> ["bad", "foo", "how", "good", "nice", "teal"]

# use map instead of sort_by for debugging/working on a solution
>> ['foo1', 'foo21', 'foo3'].map { |s| s.split('foo')[1].to_i }
=> [1, 21, 3]
>> ['foo1', 'foo21', 'foo3'].sort_by { |s| s.split('foo')[1].to_i }
=> ["foo1", "foo3", "foo21"]

>> str_nums = %w[4.3 55 -42 64]
=> ["4.3", "55", "-42", "64"]
# same as: str_nums.sort_by { |s| s.to_f }
>> str_nums.sort_by(&:to_f)
=> ["-42", "4.3", "55", "64"]
```

* `min` and `max` values
* kinda syntactical sugar for `sort` method

```ruby
>> nums = [431, 4, 5, -2, 51, 3, 6, -22]
=> [431, 4, 5, -2, 51, 3, 6, -22]

>> nums.sort[0]
=> -22
>> nums.min
=> -22
>> nums.sort[0, 2]
=> [-22, -2]
>> nums.min(2)
=> [-22, -2]

>> nums.sort[-1]
=> 431
>> nums.max
=> 431
>> nums.sort { |a, b| b <=> a }[0, 3]
=> [431, 51, 6]
>> nums.max(3)
=> [431, 51, 6]
```

* block can be passed as well

```ruby
>> words = %w[fuliginous crusado Morello Irk seam]
=> ["fuliginous", "crusado", "Morello", "Irk", "seam"]

>> words.min { |a, b| a.upcase <=> b.upcase }
=> "crusado"
>> words.min_by(&:upcase)
=> "crusado"

>> words.max { |a, b| a.length <=> b.length }
=> "fuliginous"
>> words.max_by(&:length)
=> "fuliginous"

>> words.max_by(2) { |w| w.upcase }
=> ["seam", "Morello"]

# nice way to obfuscate code ;)
>> words.max(2) { |a, b| b.upcase <=> a.upcase }
=> ["crusado", "fuliginous"]
```

* to get both min and max values in one shot

```ruby
>> nums = [431, 4, 5, -2, 51, 3, 6, -22]
=> [431, 4, 5, -2, 51, 3, 6, -22]
>> nums.minmax
=> [-22, 431]

>> words = %w[fuliginous crusado Morello Irk seam]
=> ["fuliginous", "crusado", "Morello", "Irk", "seam"]
>> words.minmax { |a, b| a.upcase <=> b.upcase }
=> ["crusado", "seam"]
>> words.minmax_by(&:upcase)
=> ["crusado", "seam"]
```

* removing duplicate entries from array

```ruby
>> chars = ["3", "b", "a", "c", "d", "1", "d", "c", "2", "3", "1", "b"]
=> ["3", "b", "a", "c", "d", "1", "d", "c", "2", "3", "1", "b"]
# unique entries will be in same order as in original array
>> chars.uniq
=> ["3", "b", "a", "c", "d", "1", "2"]

>> [3, -2, 4, 1, -3, -4].uniq { |n| n.abs }
=> [3, -2, 4, 1]
>> [3, -2, 4, 1, -3, -4].uniq(&:abs)
=> [3, -2, 4, 1]
```

<br>

## <a name="transforming-whole-array"></a>Transforming whole array

* we've seen some examples of transforming in previous sections
* `shuffle` will randomize order of array elements
    * use `shuffle!` for in-place modification

```ruby
>> nums = [23, 756, -983, 5, 42, 13]
=> [23, 756, -983, 5, 42, 13]
>> nums.shuffle
=> [13, 23, 756, 42, 5, -983]
```

* `map` allows to define a transformation function for each array element
    * use `map!` for in-place transformation
* multiple statements can be used inside the block, value of last expression will be used to replace the element

```ruby
>> nums = [3, -2, 4, 1, -78, -42]
=> [3, -2, 4, 1, -78, -42]
>> nums.map(&:abs)
=> [3, 2, 4, 1, 78, 42]
>> nums.map { |n| n**2 }.sum
=> 7878

>> words = %w[fuliginous crusado Morello Irk seam]
=> ["fuliginous", "crusado", "Morello", "Irk", "seam"]
# downcase and shuffle each string element
# multiline version for illustration
>> words.map do |w|
?>   arr = w.downcase.chars
>>   arr.shuffle.join
>> end
=> ["nsfguuiilo", "rsdoauc", "orllemo", "ikr", "eams"]
# single line version
>> words.map { |w| w.downcase.chars.shuffle.join }
=> ["lfiguniosu", "coadsur", "oollrme", "rik", "asem"]
```

<br>

## <a name="miscellaneous"></a>Miscellaneous

* `reduce` allows to apply a transformation between elements of the array to get single output value
    * a few variables/methods in Ruby have aliases, `reduce` has one as `inject`
* See [ruby-doc: reduce](https://ruby-doc.org/core-2.5.0/Enumerable.html#method-i-reduce) for details
* See [reduce series](https://blog.lerner.co.il/summary-reduce-series/) for more examples and ways to implement `map` and `select` with `reduce`

```ruby
>> nums = [3, -2, 4, 1, -78, -42]
=> [3, -2, 4, 1, -78, -42]
>> nums.sum
=> -114
>> nums.reduce(:+)
=> -114
>> nums.reduce(:*)
=> -78624

# supplying an initial value
>> nums.reduce(100, :+)
=> -14
>> nums.reduce(2, :*)
=> -157248

# here 0 is initial value
# op is name of accumulator, which gets the initial value
# and n gets each element of the array
>> nums.reduce(0) { |op, n| op + n**2 }
=> 7878
```

* `sum` accepts an initial value and block too

```ruby
>> nums = [3, -2, 4, 1, -78, -42]
=> [3, -2, 4, 1, -78, -42]
# same as: nums.reduce(0) { |op, n| op + n**2 }
>> nums.sum { |n| n**2 }
=> 7878
>> nums.sum(10000) { |n| n**2 }
=> 17878

>> p1 = [1, 3, 5]
=> [1, 3, 5]
>> p2 = [3, 214, 53]
=> [3, 214, 53]
>> p1.zip(p2).sum { |i, j| i * j }
=> 910
```

* `all?` returns `true` if all conditions are `true`
* `any?` returns `true` if at least one condition is `true`
* `none?` returns `true` if all conditions are `false`
* `one?` returns `true` if exactly one condition is `true`

```ruby
>> nums = [4, 2, 51]
=> [4, 2, 51]
>> nums.all? { |n| n%2 == 0 }
=> false
>> nums.all?(Integer)
=> true
>> nums.any? { |n| n%2 == 0 }
=> true
>> nums.any?(String)
=> false

# if array elements themselves are used as conditions
# only nil and false values evaluate to false, others are true conditions
>> [0, 1, -1, ""].all?
=> true
>> [0, 1, -1, "", false].all?
=> false
>> [0, 1, -1, "", nil].all?
=> false

>> [].any?
=> false
```

* `flatten` method will convert nested arrays to one-dimensional array
    * optional argument allows to limit level of flattening
* `compact` method will remove all `nil` elements from the array
    * `nil` values within nested array won't be removed
* append `!` to these methods for in-place modification

```ruby
>> foo = [42, [12, 5, 63], ['foo', [7, 6]]]
=> [42, [12, 5, 63], ["foo", [7, 6]]]
>> foo.flatten
=> [42, 12, 5, 63, "foo", 7, 6]
>> foo.flatten(1)
=> [42, 12, 5, 63, "foo", [7, 6]]

>> baz = [42, 'good', nil, 7, nil, 'nice']
=> [42, "good", nil, 7, nil, "nice"]
>> baz.compact
=> [42, "good", 7, "nice"]
```

* `&` operator will return common elements between two arrays
* `|` operator will return union of two arrays
* these are similar to set operations, there won't be duplicate elements in output

```ruby
>> nums = [3, 2, 4, 1, 78, 42]
=> [3, 2, 4, 1, 78, 42]
>> primes = [2, 3, 5, 7, 11, 13, 17]
=> [2, 3, 5, 7, 11, 13, 17]

>> nums & primes
=> [3, 2]
>> primes & nums
=> [2, 3]

>> nums | primes
=> [3, 2, 4, 1, 78, 42, 5, 7, 11, 13, 17]
>> primes | nums
=> [2, 3, 5, 7, 11, 13, 17, 4, 1, 78, 42]
```

* use `rotate` to rotate the array clockwise or anti-clockwise
    * use `rotate!` for in-place modification
* `transpose` will change rows to columns and vice versa, length of sub-arrays should be same
    * no in-place modification, have to manually re-assign if needed

```ruby
>> primes = [2, 3, 5, 7, 11, 13, 17]
=> [2, 3, 5, 7, 11, 13, 17]
>> primes.rotate
=> [3, 5, 7, 11, 13, 17, 2]
>> primes.rotate(2)
=> [5, 7, 11, 13, 17, 2, 3]
>> primes.rotate(-2)
=> [13, 17, 2, 3, 5, 7, 11]

>> nums = [[42, 4], [5, 63], [3, 7]]
=> [[42, 4], [5, 63], [3, 7]]
>> nums.transpose
=> [[42, 5, 3], [4, 63, 7]]
```

<br>

## <a name="getting-array-as-user-input"></a>Getting Array as user input

* `gets` will always get a string from user
* when array input is needed, one way is to ask the user to separate the elements with a delimiter and then use `split+map`
    * assuming elements of same data type

```ruby
>> puts 'Enter array elements separated by space'
Enter array elements separated by space
=> nil
>> usr_ip = gets
32 -5 43 65
=> "32 -5 43 65\n"
>> nums = usr_ip.split.map(&:to_i)
=> [32, -5, 43, 65]

>> puts 'Enter words separated by colon'
Enter words separated by colon
=> nil
>> usr_ip = gets.chomp
foo:baz:123:good
=> "foo:baz:123:good"
>> words = usr_ip.split(':')
=> ["foo", "baz", "123", "good"]
```

* another way is to ask the user to use Array syntax and let Ruby interpret it
* **Note:** use this method only if you can trust the user input or have some means of preventing malicious use

```ruby
>> nums = eval(gets)
[2, 3, 5, 7]
=> [2, 3, 5, 7]
>> nums
=> [2, 3, 5, 7]

>> fruits = eval(gets)
%w[apple mango orange]
=> ["apple", "mango", "orange"]
>> fruits
=> ["apple", "mango", "orange"]
```

