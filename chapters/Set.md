# <a name="set"></a>Set

**Table of Contents**

* [Initialization](#initialization)
* [Set operations](#set-operations)
* [Miscellaneous](#miscellaneous)

<br>

* Set refers to unordered collection of objects
* Typically used to maintain unique sequence, perform set operations like intersection, union, difference, etc
* Set is part of [ruby-doc: stdlib](https://ruby-doc.org/stdlib-2.5.0/) and needs to be loaded before use
    * Data types like integers, strings, arrays, hashes and modules like Math, Kernel are part of [ruby-doc: core](https://ruby-doc.org/core-2.5.0/) and available for use by default

<br>

## <a name="initialization"></a>Initialization

* as comma separated values inside `Set[]` or `Set.new` method
* the values can be of any data type and be result of an expression
    * changing mutable element of Set can lead to unexpected behavior
    * as a special case, string values are frozen
* as far as I've tested, Set preserves order of insertion similar to Hash, however documentation doesn't explicitly mention the fact
* See [ruby-doc: Set](https://ruby-doc.org/stdlib-2.5.0/libdoc/set/rdoc/Set.html) for more details

```ruby
# loading the library before use
>> require 'set'
=> true

>> a = Set[]
=> #<Set: {}>
>> b = Set.new
=> #<Set: {}>

>> fruits = Set['apple', 'mango', 'orange']
=> #<Set: {"apple", "mango", "orange"}>
>> books = Set.new(['Harry Potter', 'Stormlight Archive'])
=> #<Set: {"Harry Potter", "Stormlight Archive"}>

# duplicates are automatically removed
>> nums = Set[3, 2, 5, 7, 1, 2, 3, 4]
=> #<Set: {3, 2, 5, 7, 1, 4}>
```

* array-set conversion

```ruby
>> nums = [3, 12, 17, 25, 100]
=> [3, 12, 17, 25, 100]

# can also use: Set[*nums]
>> s = nums.to_set
=> #<Set: {3, 12, 17, 25, 100}>

>> s.to_a
=> [3, 12, 17, 25, 100]

# for strings, convert to array first
>> book = 'Alchemist'
=> "Alchemist"
>> book.chars.to_set
=> #<Set: {"A", "l", "c", "h", "e", "m", "i", "s", "t"}>
```

* if needed, the collection could always be sorted by using `SortedSet` instead of `Set`

```ruby
>> require 'set'
=> true

>> nums = Set[3, 2, 5, 7, 1, 2, 3, 4]
=> #<Set: {3, 2, 5, 7, 1, 4}>

>> sorted_nums = SortedSet[3, 2, 5, 7, 1, 2, 3, 4]
=> #<SortedSet: {1, 2, 3, 4, 5, 7}>
```

<br>

## <a name="set-operations"></a>Set operations

* equality doesn't depend on order

```ruby
>> s1 = Set[1, 2, 3]
=> #<Set: {1, 2, 3}>
>> s2 = Set[3, 1, 2]
=> #<Set: {3, 1, 2}>

>> s1 == s2
=> true
>> s1 != s2
=> false
```

* union, common and difference

```ruby
>> nums_1 = Set[3, 2, 4, 1, 78, 42]
=> #<Set: {3, 2, 4, 1, 78, 42}>
>> nums_2 = Set[5, 3, 2, 6, 10, 42]
=> #<Set: {5, 3, 2, 6, 10, 42}>

# union of two sets, can also use + instead of |
>> nums_1 | nums_2
=> #<Set: {3, 2, 4, 1, 78, 42, 5, 6, 10}>

# common among two sets
>> nums_1 & nums_2
=> #<Set: {3, 2, 42}>

# difference between two sets, use 'subtract' method for in-place modification
>> nums_1 - nums_2
=> #<Set: {4, 1, 78}>
>> nums_2 - nums_1
=> #<Set: {5, 6, 10}>
# union of the above two results, i.e all unique elements
>> nums_1 ^ nums_2
=> #<Set: {5, 6, 10, 4, 1, 78}>
```

* subsets and supersets

```ruby
>> s1 = Set[4, 2, 1]
=> #<Set: {4, 2, 1}>
>> s2 = Set[1, 2]
=> #<Set: {1, 2}>
>> s3 = Set[3, 1]
=> #<Set: {3, 1}>

# s2 is subset of s1
>> s2 <= s1
=> true
# s3 is not a subset of s1
>> s3 <= s1
=> false
# s1 is superset of s2
>> s1 >= s2
=> true
```

* proper subset/superset - like subset/superset but length cannot be same

```ruby
# subset
>> Set[1, 2] <= Set[2, 1]
=> true
# proper subset
>> Set[1, 2] < Set[2, 1]
=> false
>> Set[1, 2] < Set[2, 1, 3]
=> true

# proper superset
>> Set[2, 1, 3] > Set[1, 2]
=> true
>> Set[2, 1, 3] > Set[1, 3, 2]
=> false
# superset
>> Set[2, 1, 3] >= Set[1, 3, 2]
=> true
```

* checking whether two sets have some common elements or not

```ruby
>> s1 = Set[4, 2, 1]
=> #<Set: {4, 2, 1}>
>> s2 = Set[1, 42]
=> #<Set: {1, 42}>
>> s3 = Set[3, 7]
=> #<Set: {3, 7}>

# at least one common element
>> s1.intersect?(s2)
=> true

# no common element
>> s2.disjoint?(s3)
=> true
```

* adding elements to existing set
* like union, but in-place modification

```ruby
>> nums = Set[3, 2, 4, 1]
=> #<Set: {3, 2, 4, 1}>
# same as: nums << 25
>> nums.add(25)
=> #<Set: {3, 2, 4, 1, 25}>

>> s = Set[12, 17, 42, 100]
=> #<Set: {12, 17, 42, 100}>
>> nums.merge(s)
=> #<Set: {3, 2, 4, 1, 25, 12, 17, 42, 100}>

# merge accepts any enumerable, not just set
>> a = [42, 5, 100, 8]
=> [42, 5, 100, 8]
>> s.merge(a)
=> #<Set: {12, 17, 42, 100, 5, 8}>
```

* the `add?` method behaves similarly to `add` but additionally allows to act upon whether the element already existed or not

```ruby
>> nums = [3, 2, 5, 7, 1, 2, 3, 4]
=> [3, 2, 5, 7, 1, 2, 3, 4]

>> seen = Set[]
=> #<Set: {}>
>> nums.each { |n| puts n if seen.add?(n) }
3
2
5
7
1
4
=> [3, 2, 5, 7, 1, 2, 3, 4]

>> seen = Set[]
=> #<Set: {}>
>> nums.each { |n| puts n if !seen.add?(n) }
2
3
=> [3, 2, 5, 7, 1, 2, 3, 4]
```

<br>

## <a name="miscellaneous"></a>Miscellaneous

* check if a value is present

```ruby
>> books = Set.new(['Harry Potter', 'Stormlight Archive'])
=> #<Set: {"Harry Potter", "Stormlight Archive"}>

>> books.include?('Harry Potter')
=> true
>> books.include?('Alchemist')
=> false
```

* create subsets based on a condition

```ruby
>> nums = Set[3, 2, 5, 7, 1, 4]
=> #<Set: {3, 2, 5, 7, 1, 4}>

>> nums.divide { |n| n.even? }
=> #<Set: {#<Set: {3, 5, 7, 1}>, #<Set: {2, 4}>}>

>> nums.divide { |n| n % 3 }
=> #<Set: {#<Set: {3}>, #<Set: {2, 5}>, #<Set: {7, 1, 4}>}>
```
