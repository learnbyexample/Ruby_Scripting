# <a name="arrays"></a>Arrays

**Table of Contents**

* [Assignment and Indexing](#assignment-and-indexing)
* [Slicing](#slicing)

<br>

## <a name="assignment-and-indexing"></a>Assignment and Indexing

* as comma separated values inside `[]`
* elements can be of mixed data type
* index starts from `0`
* if negative index is given, size of the array is added to it
    * so, if array size is `3`, an index of `-1` would be interpreted as `-1+3` giving the last element of array
    * similarly, `-2` will give last but one element and so on

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

# out of bound index returns nil
>> nums[2]
=> nil
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





