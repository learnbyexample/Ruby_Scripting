# <a name="hashes"></a>Hashes

**Table of Contents**

* [Initialization](#initialization)
* [Accessing keys and values](#accessing-keys-and-values)
* [Looping](#looping)
* [Modifying elements](#modifying-elements)

<br>

## <a name="initialization"></a>Initialization

* as comma separated key-value pairs inside `{}`
* both key and value can be of any data type and be result of an expression
    * but having mutable data type as key requires careful usage

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
>> greetings = Hash.new { |h, k| h[k] = 'good day' }
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

* accessing a value based on key and getting all keys/values

```ruby
>> marks = {Foo: 86, Bar: 92, Baz: 75}
=> {:Foo=>86, :Bar=>92, :Baz=>75}
>> marks[:Foo]
=> 86
>> marks['Foo'.to_sym]
=> 86

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

* reverse look-up, getting the first key based on given value

```ruby
>> marks = {Foo: 86, Bar: 75, Baz: 75}
=> {:Foo=>86, :Bar=>75, :Baz=>75}

>> marks.key(75)
=> :Bar

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
```

* getting multiple values

```ruby
>> marks = {Foo: 86, Bar: 92, Baz: 75, Lo: 73}
=> {:Foo=>86, :Bar=>92, :Baz=>75, :Lo=>73}

>> marks.values_at(:Bar, :Lo)
=> [92, 73]
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

```ruby
>> fav_books = {
?>   'fantasy' => ['Harry Potter', 'Stormlight Archive', 'Kingkiller Chronicle'],
?>   'sci-fi'  => ["Ender's Game", 'Martian', 'Red Rising'],
?>   'classic' => ['Count of Monte Cristo', 'Jane Eyre', 'Scarlet Pimpernel']
>> }

>> for genre, books in fav_books
>>   puts "#{genre}: #{books.join(', ')}"
>> end
fantasy: Harry Potter, Stormlight Archive, Kingkiller Chronicle
sci-fi: Ender's Game, Martian, Red Rising
classic: Count of Monte Cristo, Jane Eyre, Scarlet Pimpernel

>> fav_books.each { |genre, books| puts "#{genre}: #{books.join(', ')}" }
fantasy: Harry Potter, Stormlight Archive, Kingkiller Chronicle
sci-fi: Ender's Game, Martian, Red Rising
classic: Count of Monte Cristo, Jane Eyre, Scarlet Pimpernel
```

* to iterate over key or value

```ruby
>> fav_books.each_key { |k| puts k }
fantasy
sci-fi
classic

>> fav_books.each_value { |v| puts v.inspect }
["Harry Potter", "Stormlight Archive", "Kingkiller Chronicle"]
["Ender's Game", "Martian", "Red Rising"]
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




