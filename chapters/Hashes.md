# <a name="hashes"></a>Hashes

**Table of Contents**

* [Initialization](#initialization)
* [Accessing keys and values](#accessing-keys-and-values)
* [Looping](#looping)
* [Modifying elements](#modifying-elements)
* [Filtering](#filtering)
* [Transforming keys and values](#transforming-keys-and-values)
* [Mutable keys](#mutable-keys)
* [Miscellaneous](#miscellaneous)

<br>

## <a name="initialization"></a>Initialization

* as comma separated key-value pairs inside `{}`
* both key and value can be of any data type and be result of an expression
    * but having mutable data type as key requires careful usage
    * as a special case, [string keys are frozen](https://stackoverflow.com/questions/13044839/why-is-a-string-key-for-a-hash-frozen)

```ruby
>> marks = {'Foo' => 86, 'Bar' => 92, 'Baz' => 75}
=> {"Foo"=>86, "Bar"=>92, "Baz"=>75}

>> s = 'a'
=> "a"
>> h = {s+'g' => 5, 'c' => Math.sqrt(45)}
=> {"ag"=>5, "c"=>6.708203932499369}
```

* where possible, symbols are used instead of strings

```ruby
>> marks = {:Foo => 86, :Bar => 92, :Baz => 75}
=> {:Foo=>86, :Bar=>92, :Baz=>75}

# simpler alternate syntax
>> marks = {Foo: 86, Bar: 92, Baz: 75}
=> {:Foo=>86, :Bar=>92, :Baz=>75}
```

* hashes can also be created using `new` method of Hash class
    * helpful to declare a default value for keys
* See [ruby-doc: Hash](https://ruby-doc.org/core-2.5.0/Hash.html) for more details

```ruby
>> h = Hash.new
=> {}
>> h[2] = 'foo'
=> "foo"
>> h
=> {2=>"foo"}

# 0 will be default value for keys instead of nil
>> hist = Hash.new(0)
=> {}

# to avoid same mutable object as default, use the block form
>> greetings = Hash.new('good day')
=> {}
>> greetings[:foo].equal?(greetings[:baz])
=> true
>> greetings = Hash.new { 'good day' }
=> {}
>> greetings[:foo].equal?(greetings[:baz])
=> false
```

* array-hash conversion

```ruby
>> {1=>2, "foo"=>"baz"}.to_a
=> [[1, 2], ["foo", "baz"]]

>> [[1, 2], ['foo', 'baz']].to_h
=> {1=>2, "foo"=>"baz"}

>> [[:Foo, 86], [:Bar, 92], [:Baz, 75]].to_h
=> {:Foo=>86, :Bar=>92, :Baz=>75}
```

<br>

## <a name="accessing-keys-and-values"></a>Accessing keys and values

* accessing based on key and getting all keys/values

```ruby
>> marks = {Foo: 86, Bar: 92, Baz: 75}
=> {:Foo=>86, :Bar=>92, :Baz=>75}
>> marks[:Foo]
=> 86
>> marks['Foo'.to_sym]
=> 86

# key-value pair
>> marks.assoc(:Bar)
=> [:Bar, 92]

>> marks.keys
=> [:Foo, :Bar, :Baz]
>> marks.values
=> [86, 92, 75]
```

* if key doesn't exist

```ruby
>> marks = {Foo: 86, Bar: 92, Baz: 75}
=> {:Foo=>86, :Bar=>92, :Baz=>75}

# nil by default, or the value set as default using new/default= methods
>> marks[:xyz]
=> nil

# this will raise an exception irrespective of default value being set
>> marks.fetch(:xyz)
KeyError (key not found: :xyz)
# default value can be specified as 2nd argument/block
>> marks.fetch(:xyz, 60)
=> 60
```

* reverse look-up, getting the first key or key-value pair based on given value

```ruby
>> marks = {Foo: 86, Bar: 75, Baz: 75}
=> {:Foo=>86, :Bar=>75, :Baz=>75}

>> marks.key(75)
=> :Bar
>> marks.rassoc(75)
=> [:Bar, 75]

>> marks.key(100)
=> nil
```

* Hash slice

```ruby
>> marks = {Foo: 86, Bar: 92, Baz: 75, Lo: 73}
=> {:Foo=>86, :Bar=>92, :Baz=>75, :Lo=>73}

>> marks.slice(:Baz)
=> {:Baz=>75}

>> marks.slice(:Bar, :Lo)
=> {:Bar=>92, :Lo=>73}

# if key doesn't match
>> marks.slice(:Bar, :Low)
=> {:Bar=>92}
>> marks.slice(:Low)
=> {}
```

* getting multiple values

```ruby
>> marks = {Foo: 86, Bar: 92, Baz: 75, Lo: 73}
=> {:Foo=>86, :Bar=>92, :Baz=>75, :Lo=>73}

>> marks.values_at(:Bar, :Lo)
=> [92, 73]
# if key is not present, gives nil or the default value if set
>> marks.values_at(:Baz, :xyz)
=> [75, nil]

>> marks.fetch_values(:Baz, :Lo)
=> [75, 73]
>> marks.fetch_values(:Baz, :xyz)
KeyError (key not found: :xyz)
```

<br>

## <a name="looping"></a>Looping

* for loop and each method to iterate over key-value pairs
* **Note** that Hashes maintain the same order in which key-value pairs were added

```ruby
>> fav_books = {
?>   'fantasy' => ['Harry Potter', 'Stormlight Archive', 'Kingkiller Chronicle'],
?>   'sci-fi'  => ['Enders Game', 'Martian', 'Red Rising'],
?>   'classic' => ['Count of Monte Cristo', 'Jane Eyre', 'Scarlet Pimpernel']
>> }

>> for genre, books in fav_books
>>   puts "#{genre}: #{books.join(', ')}"
>> end
fantasy: Harry Potter, Stormlight Archive, Kingkiller Chronicle
sci-fi: Enders Game, Martian, Red Rising
classic: Count of Monte Cristo, Jane Eyre, Scarlet Pimpernel

>> fav_books.each { |genre, books| puts "#{genre}: #{books.join(', ')}" }
fantasy: Harry Potter, Stormlight Archive, Kingkiller Chronicle
sci-fi: Enders Game, Martian, Red Rising
classic: Count of Monte Cristo, Jane Eyre, Scarlet Pimpernel
```

* to iterate over all the keys or values

```ruby
>> fav_books.each_key { |k| puts k }
fantasy
sci-fi
classic

>> fav_books.each_value { |v| puts v.inspect }
["Harry Potter", "Stormlight Archive", "Kingkiller Chronicle"]
["Enders Game", "Martian", "Red Rising"]
["Count of Monte Cristo", "Jane Eyre", "Scarlet Pimpernel"]
```

<br>

## <a name="modifying-elements"></a>Modifying elements

* adding/modifying single/multiple elements

```ruby
>> marks = {foo: 86, baz: 75, lo: 73}
=> {:foo=>86, :baz=>75, :lo=>73}

>> marks[:foo] = 95
=> 95
>> marks[:baz], marks[:kek] = [80, 62]
=> [80, 62]

>> marks
=> {:foo=>95, :baz=>80, :lo=>73, :kek=>62}
```

* merging two hashes

```ruby
>> marks = {foo: 86, baz: 75}
=> {:foo=>86, :baz=>75}
>> new_marks = {foo: 95, baz: 80, lo: 73}
=> {:foo=>95, :baz=>80, :lo=>73}

# use merge! for in-place modification
>> marks.merge(new_marks)
=> {:foo=>95, :baz=>80, :lo=>73}

# block form
>> marks.merge(new_marks) { |k, v1, v2| v1 + v2/10 }
=> {:foo=>95, :baz=>83, :lo=>73}
```

* deleting elements

```ruby
# based on key
>> marks = {foo: 86, baz: 75, lo: 73}
=> {:foo=>86, :baz=>75, :lo=>73}
>> marks.delete(:foo)
=> 86
>> marks
=> {:baz=>75, :lo=>73}

# based on a condition
>> marks = {foo: 86, baz: 75, lo: 73}
=> {:foo=>86, :baz=>75, :lo=>73}
>> marks.delete_if { |k, v| v < 80 }
=> {:foo=>86}
>> marks
=> {:foo=>86}

# delete all elements
>> marks.clear
=> {}
```

<br>

## <a name="filtering"></a>Filtering

* check if a key/value is present

```ruby
>> fruits = {'apple' => 5, 'mango' => 10, 'guava' => 6}
=> {"apple"=>5, "mango"=>10, "guava"=>6}

# can also use the alias include?
>> fruits.key?('apple')
=> true
>> fruits.key?('orange')
=> false

>> fruits.value?(10)
=> true
>> fruits.value?(2)
=> false
```

* slicing based on a condition

```ruby
>> fruits = {'apple' => 5, 'mango' => 10, 'guava' => 6, 'orange' => 12}
=> {"apple"=>5, "mango"=>10, "guava"=>6, "orange"=>12}

# use select! for in-place modification
>> fruits.select { |k, v| v > 5 }
=> {"mango"=>10, "guava"=>6, "orange"=>12}
# apply keys/values methods when needed
>> fruits.select { |k, v| v > 5 }.keys
=> ["mango", "guava", "orange"]
>> fruits.select { |k, v| v > 5 }.values
=> [10, 6, 12]

>> fruits.select { |k, v| k.length > 5 }
=> {"orange"=>12}

>> fruits.select { |k, v| k[0] < 'o' && v > 5 }
=> {"mango"=>10, "guava"=>6}
```

* Like arrays, one can use [ruby-doc: Enumerable](https://ruby-doc.org/core-2.5.0/Enumerable.html) methods for hashes as well
* use `partition` to get both matching and non-matching elements

```ruby
>> fruits = {'apple' => 5, 'mango' => 10, 'guava' => 6, 'orange' => 12}
=> {"apple"=>5, "mango"=>10, "guava"=>6, "orange"=>12}

# returns array of arrays
>> fruits.partition { |k, v| k.length > 5 }
=> [[["orange", 12]], [["apple", 5], ["mango", 10], ["guava", 6]]]

# convert to hash if needed
>> m_h, nm_h = fruits.partition { |k, v| k.length > 5 }.map(&:to_h)
=> [{"orange"=>12}, {"apple"=>5, "mango"=>10, "guava"=>6}]
>> m_h
=> {"orange"=>12}
>> nm_h
=> {"apple"=>5, "mango"=>10, "guava"=>6}
```

<br>

## <a name="transforming-keys-and-values"></a>Transforming keys and values

* changing keys

```ruby
>> fruits = {'apple' => 5, 'mango' => 10, 'guava' => 6, 'orange' => 12}
=> {"apple"=>5, "mango"=>10, "guava"=>6, "orange"=>12}

>> fruits.transform_keys { |k| k.capitalize }
=> {"Apple"=>5, "Mango"=>10, "Guava"=>6, "Orange"=>12}

# in-place modification
>> fruits.transform_keys! { |k| k.capitalize }
=> {"Apple"=>5, "Mango"=>10, "Guava"=>6, "Orange"=>12}

>> fruits.transform_keys(&:to_sym)
=> {:Apple=>5, :Mango=>10, :Guava=>6, :Orange=>12}
```

* changing values

```ruby
>> marks = {"foo" => 90, "baz" => 80, "lo" => 73, "kek" => 62}
=> {"foo"=>90, "baz"=>80, "lo"=>73, "kek"=>62}

>> marks.transform_values { |v| v + 5 }
=> {"foo"=>95, "baz"=>85, "lo"=>78, "kek"=>67}

# in-place modification
>> marks.transform_values! { |v| v - 5 }
=> {"foo"=>85, "baz"=>75, "lo"=>68, "kek"=>57}
```

* use `map` to work with keys and values together

```ruby
>> marks = {"foo" => 90, "baz" => 80, "lo" => 73, "kek" => 62}
=> {"foo"=>90, "baz"=>80, "lo"=>73, "kek"=>62}

>> marks.map { |k, v| marks[k] = v + 5 if k[0] > 'c' }
=> [95, nil, 78, 67]
>> marks
=> {"foo"=>95, "baz"=>80, "lo"=>78, "kek"=>67}
```

<br>

## <a name="mutable-keys"></a>Mutable keys

* strings used as hash key are frozen and cannot be modified - they act like immutable keys much like integers

```ruby
>> s = 'foo'
=> "foo"
>> h = { s => 42 }
=> {"foo"=>42}

>> s.object_id
=> 47309460553140
>> h.keys[0].object_id
=> 47309460712980

>> s.upcase!
=> "FOO"
>> h
=> {"foo"=>42}

>> h.keys[0].capitalize!
FrozenError (can't modify frozen String)
```

* using mutable types like array and hash as key requires careful usage
* changing the mutable key will leave the hash with old hash value unless recalculated using `rehash` method
    * until rehashing, it will also be possible to add another key with same value as the modified mutable key
* See also [softwareengineering.stackexchange: why use mutable keys?](https://softwareengineering.stackexchange.com/questions/197982/why-would-you-want-to-use-an-array-or-hash-as-hash-key-in-ruby)

```ruby
>> a = [3.14, 42]
=> [3.14, 42]
>> h = { a => 'foo' }
=> {[3.14, 42]=>"foo"}

>> a.equal?(h.keys[0])
=> true

>> a[1] = 100
=> 100
>> h
=> {[3.14, 100]=>"foo"}

>> h[a]
=> nil
>> h[[3.14, 100]]
=> nil

>> h.rehash
=> {[3.14, 100]=>"foo"}
>> h[a]
=> "foo"
>> h[[3.14, 100]]
=> "foo"
```

<br>

## <a name="miscellaneous"></a>Miscellaneous

* `flatten` method will convert hash to array with each key-value pair forming two elements
    * optional argument allows to specify depth of flattening
* `compact` method will remove all keys with `nil` value
    * keys with `nil` value within nested hash won't be removed

```ruby
>> marks = {"foo" => 90, "baz" => 80, "lo" => 73}
=> {"foo"=>90, "baz"=>80, "lo"=>73}
>> marks.flatten
=> ["foo", 90, "baz", 80, "lo", 73]

>> h = { 'a' => [1, 2, 4], 'b' => %w[foo baz] }
=> {"a"=>[1, 2, 4], "b"=>["foo", "baz"]}
>> h.flatten
=> ["a", [1, 2, 4], "b", ["foo", "baz"]]
>> h.flatten(2)
=> ["a", 1, 2, 4, "b", "foo", "baz"]

>> h = { 'a' => 42, 'b' => 'foo', 'c' => nil }
=> {"a"=>42, "b"=>"foo", "c"=>nil}
# use compact! for in-place modification
>> h.compact
=> {"a"=>42, "b"=>"foo"}
```

* `invert` will swap key-value pairs
* in case of multiple keys with same value, the last key-value pair will win

```ruby
>> h = { 'a' => 42, 'b' => 'foo', 'c' => 3, 'd' => 42 }
=> {"a"=>42, "b"=>"foo", "c"=>3, "d"=>42}
>> h.invert
=> {42=>"d", "foo"=>"b", 3=>"c"}
>> h.length == h.invert.length
=> false

>> h = { foo: 90, baz: 80 }
=> {:foo=>90, :baz=>80}
>> h.invert
=> {90=>:foo, 80=>:baz}
>> h.length == h.invert.length
=> true
```

* getting user input
* manually convert based on agreed upon delimiter or use `eval` if input can be trusted

```ruby
>> usr_ip = gets.chomp
foo:baz:123:good
=> "foo:baz:123:good"
>> h = usr_ip.split(':').each_slice(2).to_h
=> {"foo"=>"baz", "123"=>"good"}

>> usr_ip = gets.chomp
{ a: 42, b: 78, c: 99 }
=> "{ a: 42, b: 78, c: 99 }"
>> h = eval(usr_ip)
=> {:a=>42, :b=>78, :c=>99}
```

