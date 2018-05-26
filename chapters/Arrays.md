# <a name="arrays"></a>Arrays

**Table of Contents**

* [Assignment and Indexing](#assignment-and-indexing)
* [Slicing](#slicing)
* [Copying Arrays](#copying-arrays)

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
* See [ruby-doc: Array](https://ruby-doc.org/core-2.5.0/Array.html) for details

```ruby
>> nums = Array.new(5, 0)
=> [0, 0, 0, 0, 0]

>> Array.new(2)
=> [nil, nil]
```

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

## <a name="copying-arrays"></a>Copying Arrays

* arrays are mutable like strings
* when a variable is assigned to another variable or passed as argument to a method, only the variable's reference is used
* so, copying an array will result in two variables pointing to same object

```ruby
>> nums = [3, 61]
=> [3, 61]
>> nums_copy = nums
=> [3, 61]

>> nums_copy[0] = 'foo'
=> "foo"
>> nums_copy
=> ["foo", 61]
>> nums
=> ["foo", 61]

>> def foo(a)
>>   a[1] = 'baz'
>> end
=> :foo
>> foo(nums)
=> "baz"
>> nums
=> ["foo", "baz"]
>> nums_copy
=> ["foo", "baz"]
```

* as long as each object of the array is immutable, clone or slice of the array cannot affect the original array

```ruby
>> nums = [3, 61]
=> [3, 61]
>> nums_copy = nums.clone
=> [3, 61]

>> nums_copy[0] = 'foo'
=> "foo"
>> nums_copy
=> ["foo", 61]
>> nums
=> [3, 61]
```

* if array contains mutable objects like string or another array, a clone or its slice will affect the original array as well

```ruby
>> fruits = %w[apple mango guava]
=> ["apple", "mango", "guava"]
>> my_fruit = fruits[1]
=> "mango"

>> my_fruit.upcase!
=> "MANGO"
>> fruits
=> ["apple", "MANGO", "guava"]

# one way to avoid this is cloning the element
>> foo = fruits[0].clone
=> "apple"
>> foo[0] = 'A'
=> "A"
>> foo
=> "Apple"
>> fruits
=> ["apple", "MANGO", "guava"]
```

* using `Marshal` module is one way to create a copy of array without worrying if it is a nested array or contains mutable objects
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

