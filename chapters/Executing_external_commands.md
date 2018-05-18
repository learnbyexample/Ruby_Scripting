# <a name="executing-external-commands"></a>Executing external commands

**Table of Contents**

* [Issuing commands](#issuing-commands)
    * [Exit status](#exit-status)

<br>

## <a name="issuing-commands"></a>Issuing commands

* Ruby has various ways to execute external commands
* Use `system` if the program should wait for the issued command to finish and continue executing the Ruby script
* entire command can be passed as a string
    * the command will be interpreted by shell before executing just like on a commandline (`/bin/sh` is the default on Unix-like systems)
    * do not use this way to execute arbitrary user input, that'd be a security risk
* or command name and arguments can be separated out
    * user has to perform necessary expansion before passing the command (methods like `Dir.glob` help in that aspect)
    * this way is preferred when accepting arbitrary user input

```ruby
#!/usr/bin/env ruby

system('clear')
system('echo Hello $USER')
```

*Running the above script*

```
$ ./screen_clear.rb
# screen clears followed by below output

Hello learnbyexample
```

* Some more examples

```
$ irb --simple-prompt
>> system('echo $HOME')
/home/learnbyexample
=> true

>> system('seq', '-s,', '10')
1,2,3,4,5,6,7,8,9,10
=> true

>> system('seq -s, 10 > out.txt')
=> true

>> system('ls *.txt')
out.txt
=> true
>> exit

$ cat out.txt
1,2,3,4,5,6,7,8,9,10
```

<br>

#### <a name="exit-status"></a>Exit status

* use return value of `system`
    * `true` indicates zero exit status
    * `false` indicates non-zero exit status
    * `nil` indicates command execution failure
* or special variable `$?` to know details of the command issued like PID/exit status/etc

```ruby
#!/usr/bin/env ruby

cmd1 = 'ls out.txt'
cmd2 = 'grep "foo" out.txt'
cmd3 = 'xyz'

for cmd in [cmd1, cmd2, cmd3]
  puts "Command: #{cmd}"
  rv = system(cmd)

  # inspect method will display human readable representation of object
  puts "system return value: #{rv.inspect}"
  puts "Command exit status: #{$?.exitstatus}"
  puts '-' * 30
end
```

*Running the above script*

```
$ ls out.txt; echo $?
out.txt
0
$ grep "foo" out.txt; echo $?
1
$ xyz; echo $?
xyz: command not found
127

$ ./exit_status.rb
Command: ls out.txt
out.txt
system return value: true
Command exit status: 0
------------------------------
Command: grep "foo" out.txt
system return value: false
Command exit status: 1
------------------------------
Command: xyz
system return value: nil
Command exit status: 127
------------------------------
```

**Further Reading**

* [ruby-doc: system](https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-system)
* [ruby-doc: exec](https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-exec)
* [ruby-doc: Process::Status](https://ruby-doc.org/core-2.5.0/Process/Status.html)
* [stackoverflow: difference between exec, system and %x or backticks](https://stackoverflow.com/questions/6338908/ruby-difference-between-exec-system-and-x-or-backticks)

