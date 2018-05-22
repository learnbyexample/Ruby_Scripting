# <a name="arrays"></a>Arrays

**Table of Contents**

* [Assignment and Indexing](#assignment-and-indexing)

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

