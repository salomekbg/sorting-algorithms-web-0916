

# Sorting Algorithms

## Objective

Build your own sort method. It does not have to be fancy, any sort will do.

## What is a Proc, Anyway?

According to the Ruby documentation, "Proc objects are blocks of code that have been bound to a set of local variables. Once bound, the code may be called in different contexts and still access those variables." But what does that really _mean_?

![Huh?](http://media.giphy.com/media/zkSFsZpQMZuG4/giphy.gif)

Let's do some experimentation with Procs.

```ruby
proc = Proc.new{ |phrase| phrase.upcase }
  => #<Proc:0x007f99a20904c8@(irb):1> 

proc.call("hello!")
  => "HELLO!"
```

So it looks like a proc is a set of instructions inside of a variable. If I run the `#call` method on the proc, the arguments that I pass into `#call` will be passed into the block. Since I entered `proc.call("hello!")`, Ruby returned `"hello!".upcase`. Likewise, `proc.call("how's it going?")` returns `"HOW'S IT GOING?"`.

Let's try a longer one:

```ruby
capital_split = Proc.new do |phrase|
  phrase.upcase!
  phrase.split("")
end
  => #<Proc:0x007fb182859ce8@(irb):1>

capital_split.call("bingo")
  => ["B", "I", "N", "G", "O"]
```

Again, whatever we pass into `#call` gets passed into our block. This is starting to make sense!

## Normalizing Ruby Blocks

One important use of procs is their ability to set a *default block* for a Ruby method. Consider the method `#do_something` that takes a word and passes it into a block:

```ruby
def do_something(word)
  yield(word)
end

do_something("hello"){ |word| word.capitalize }
  => "Hello" 
```

But what if we want `#do_something` to capitalize its argument if if we don't call it with a block. As it stands, we'll get an error if we try to call `#do_something` without a block:

```ruby
do_something("hello")
LocalJumpError: no block given (yield)
```

If we pass in another argument that starts with `&`, our block gets captured in that variable, as a proc. So we can rewrite our `#do_something` method as:

```ruby
def do_something(word, &block)
  block.call(word)
end

do_something("hello"){ |word| word.capitalize }
  => "Hello"

do_something("hello")
NoMethodError: undefined method `call' for nil:NilClass
```

Now, setting a default block is a breeze:

```ruby
def do_something(word, &block)
  normalized_block = block || Proc.new{ |word| word.capitalize }
  normalized_block.call(word)
end

do_something("hello")
  => "Hello" 
do_something("hello"){ |word| word.capitalize }
  => "Hello" 
do_something("hello"){ |word| word.upcase }
  => "HELLO"
```

## Sorting Algorithms

There are many listed [here](http://en.wikipedia.org/wiki/Sorting_algorithm#Summaries_of_popular_sorting_algorithms).
 
Insertion sort and selection sort are probably easiest.

The purpose is to let the user customize how you sort the array by submitting a block that tells you which
element goes first. If a block is given, your method should use the block to determine the sorting order.
 
Rules for spaceship operator (Java calls it compareTo):
  Given two elements, the proc should return -1 if the first element goes first
  It should return 1 if the second argument goes first
  It should return 0 if it doesn't matter which order the elements go

If no block is given, use the spaceship operator <=> to determine it

EXTRA POINTS FOR:
   Normalizing the input (the proc) at the start, rather than checking to see if it is there every time
   you wish to use it. (Hint: if no block is submitted, the proc variable will be nil)


 EXAMPLE: 

 sorting numbers:
```ruby
 your_sort [24, 0, 68, 44, 68, 47, 42, 66, 89, 22]             # => [0, 22, 24, 42, 44, 47, 66, 68, 68, 89]

 your_sort [24, 0, 68, 44, 68, 47, 42, 66, 89, 22] do |a,b|
   if a < b
     -1
   elsif a > b
     1
   else
     0
   end
 end   # => [0, 22, 24, 42, 44, 47, 66, 68, 68, 89]
```
 
 sorted by second letter (don't worry about things like 'the' vs 'The'):
 ```ruby
 your_sort %w(The quick brown fox jumps over the lazy dog) do |a,b|
   a[1..1] <=> b[1..1]
 end   # => ["lazy", "The", "the", "fox", "dog", "brown", "jumps", "quick", "over"]
```
 
 placing all strings first, integers second, and floats last, each sorted within themselves
 ```ruby
 your_sort [ 2.5 , 'r' , 1 , 4 , 'a' , 9 , 3 , 9.0 , 'm' , 25.8 ] do |a,b|
   a_class_val = [ String , Fixnum , Float ].index a.class
   b_class_val = [ String , Fixnum , Float ].index b.class
   if a_class_val == b_class_val
     a <=> b
   else
     a_class_val <=> b_class_val
   end
 end       # => ["a", "m", "r", 1, 3, 4, 9, 2.5, 9.0, 25.8]
```


<p data-visibility='hidden'>View <a href='https://learn.co/lessons/sorting-algorithms' title='Sorting Algorithms'>Sorting Algorithms</a> on Learn.co and start learning to code for free.</p>
