---
title: Into Adventure - Part 1 - Binding and Assignment
date: 2015-09-22 08:50:00
excerpt: A small introduction to binding and assignment, a couple of operations that are usually conflated on OOP languages. On FP languages you need to understand the difference between them.
---


##### updates:
- Fixed issue with incorrect variable being called in a Ruby example 2015-09-24
- Added missing set_sentence method 2015-09-25
- Fixed indentation of Ruby and Elixir code 2015-09-25

## The starter

This was a secondary idea while creating the presentation. Wasn't sure if I would add it to the presentation. But then realized that is a quite important concept. 

The difference between binding and assignment didn't cross my mind until I was forced on FP to live without the latter. Some hybrid FP languages (like F#) allow you to use assignment, but shouldn't be your default option if you want to actually do proper functional programming.

## What is binding?
Binding is assigning some piece of code or data with a name, an identifier. The point of binding is to be able to easily use that piece of code or data inside the scope where the binding is used.

The key points in the previous paragraph are identifier and scope. The former is about being easily able to use that piece of code or data. The latter indicates that the identifier only lives inside the scope where the identifier has been declared.

## What is assignment?
Assignment is to change the value of data. The data is changed for the lifetime of the container of the data (that be a record, structure, object or collection).

To reiterate: Is a change for the full lifetime of the entity that you are changing. It is not limited by scope.

## The OOP way
As I just mentioned, there is no clear separation on OOP languages between asignment and binding. Both things are mostly conflated into assignment. And then you don't think of the cases where is clearly binding. Now if you are into the theory of computing, you will already know the difference. But, for all OO programmers that I know personally, there is no difference.

We are going to work through some code to see differences between each other.

### Binding through method calls
First is the binding that is a binding, even if you don't call it that.

{% highlight C# %}
// C#

public class MyExample
{
    public void MyCallerMethod()
    {
        int myNumber = 5;
        string mySentence = "This is a string";
        MyCalleeMethod(myNumber, mySentence);
    }

    public void MyCalleeMethod(int number, string sentence)
    {
    }
}

{% endhighlight %}

Above, what we are doing is, during the duration of the method, we bind *5* to **number**, and we bind *"This is a string"* to **sentence**. Once we leave the method, the names **number** and **sentence** dissapear. Yet the data that were representing (*5* and *This is a string*) do still exists, until the MyCallerMethod goes out of scope and they get eliminated by the GC (ok, not completely true regarding their lifetime, but we will leave it simplified like that)

### Binding inside a method/class
But you have seen already a different way of binding in that example. Which is the way that you bind inside a method.

{% highlight Ruby %}
# Ruby

x = 5

{% endhighlight %}

That is a binding. We are saying that in any subsequent code on the same scope we can use x instead of 5.

So, if we had:

{% highlight Ruby %}
# Ruby

def example()
  x = 5
  puts x
end

{% endhighlight %}

then when we are using **puts x** we are saying *puts the value of the piece of code/data referenced by x*

"Wait", you will say, "that is an assignment". And I will say is not. x only refers to 5 on the scope of example. Outside of example, 5 is still data that you can use, but x is no longer a way of referring to that data.

Here is another example to drive the idea home better.

{% highlight Ruby %}
# Ruby

class ExampleObject
  def initialize(sentence)
    @sentence = sentence
  end
  def to_s
    "#{@sentence}"
  end
end

x = MyExample.new "This is a string"

def print_value (y)
  z = y
  puts z
end

print_value x
puts x

{% endhighlight %}

Above we are binding the object MyExample to x, then to y when calling print_value, then to z inside print_value. Once we leave print_value, y and z dissapear. But x and the object do still exists. We are binding inside a scope, y and z in the scope of print_value, x in the global scope.

### Assignment inside a method
So the question, is then, how do we do assignment? Remember assigning is changing the value of some data.

{% highlight C# %}
// C#
public class MyObject
{
    public MyObject (string sentence)
    {
        Sentence = sentence;
    }

    public string Sentence {get; set;}
}

public class MyExample2
{
    private myObject = new MyObject("This is a string");
	
    public void MyAssignmentMethod()
    {
         myObject.Sentence = "New sentence";
    }
}

{% endhighlight %}

So above, we are creating an object of type **MyObject** and then, inside **MyAssignmentMethod** I am changing the value of the **Sentence** property. Unlike the binding done before, which is limited to the scope, we are changing the value here for the life of the object, not the scope of the method.

And here you have the exact reason why OO programmers don't know/don't care: Assignment and Binding use the same notation (the *=* sign)

Another example thsi time in Ruby. We are using the ExampleObject declared in the above Ruby code.
{% highlight Ruby %}
# Ruby
class ExampleObject
  def set_sentence(value)
    @sentence = value
  end
end

class TheAssigner
  attr_reader :example

  def add_object(newObject)
    @example = newObject
  end

  def modify_object(value)
    @example.set_sentence value
  end
end

assigner = TheAssigner.new

example = ExampleObject.new "An Object"
puts example

assigner.add_object example

puts assigner.example
assigner.modify_object "Another value"
puts assigner.example

puts example
{% endhighlight %}


First, we create an **ExampleObject** outside of the **assigner** object. We give it a sentence of *An Object*. Then we pass the object to **assigner** and then, inside **assigner** we change the value of the sentence to *Another value*. Which we can check using outputting the value of the **example** inside **assigner**. But now if we look at our **example** object outside **assigner** we can see that the value remains changed.

Again, assignment is for the lifetime of the entity.

## The FP way

FP works differently. First, the main point of Functional Programming is immutability. Therefore assignment is a no, no from the get-go. Of course, that means that you have to operate differently to achieve the same functionality. Not having assignment means that you can change values. It is not equal to being immutable, as you can mutate without assignment. But is a necessary part of it.

### Binding through function calls
This basically looks the same as the OOP counterpart.

{% highlight Fsharp %}
// F#

let myMethod number sentence =
    printfn "%s %d"sentence number

myMethod 5 "This is it"

{% endhighlight %}

On the code above we are declaring a function called myMethod to which we are going to pass a couple of values. During the duration of the function call we are using the names number and sentence instead of the values.

### Binding inside a function

But what about binding inside functions?

{% highlight FSharp %}
let myMethod2 () =
	let x = 5
	printf "%d" x
{% endhighlight %}

Again, quite similar to what we have done before.

### Assignment inside a function
But what about assignment?. Well, if it is something immutable, you can't. Which, again, is the default behaviour. Elixir, doesn't allow you to. Clojure, has no mutable local variables, and special cases for interoperability through the JVM (Ref and Agent). F# allows you to create mutable values, and anything that comes from C# is mutable.

{% highlight C# %}
// C#
public class MyObject
{
    public MyObject (string sentence)
    {
        Sentence = sentence;
    }

    public string Sentence {get; set;}
}

{% endhighlight %}

{% highlight FSharp %}
// F#
let x = MyObject "This is it"

x.Sentence <- "This is other"

{% endhighlight %}

See that F# uses a different symbol (<-) for assignment. There is never confusion. = is binding, and <- is assignment (when allowed).

Elixir, though, no luck. You can't assign

{% highlight Elixir %}
# Elixir
defmodule Card do
    defstruct mana: 0, cost: 0
end

defmodule UseCard do
    card = %Card{}

    def tryToChange do
        IO.puts card.mana
        card.mana = 5
        IO.puts card.mana
    end
	
end
{% endhighlight %}

If you try to execute the above code it will complain the following error

> (CompileError) structure.exs:10: cannot invoke remote function card.mana/0 inside match

You can, though, create new structure changing some of the values like so:
{% highlight Elixir %}
# Elixir

defmodule Card do
    defstruct mana: 0, cost: 0

    def tryToChange(card = %Card{}) do
        IO.puts card.mana
        card5 = %{card | mana: 5}
        IO.puts card5.mana
    end
end

{% endhighlight %}

## Rebinding

Now this is an special case. All OOP languages allows you to rebind a variable that has been declared in method, or, in fact, in an object

{% highlight Ruby %}
# Ruby

class MyExample
    def initialize(sentence)
        @sentence = sentence
    end
    def to_s
        "#{@sentence}"
    end
end

x = MyExample.new "This is a string"

puts x

x = MyExample.new "This is another"

puts x

{% endhighlight %}

Ruby doesn't allow you to rebind a parameter. But C# allows you to through the use of out parameters.

{% highlight C# %}
// C#
public class MyObject
{
    public MyObject (string sentence)
    {
        Sentence = sentence;
    }

    public string Sentence {get; set;}
}

public class Rebinder
{
    public void Rebind(out MyObject myObject)
    {
        myObject = new MyObject("This was changed");
    }
}

{% endhighlight %}

With the above you can rebind.

FP languages are slightly divided over here. Some don't allow you to rebind at all, like Erlang. Some others, like Elixir, Clojure and F#, do allow you to rebind, to make code more readable. 

{% highlight Elixir %}
# Elixir
defmodule Test do
    def myMethod do
        x = 5
        x = 7
    end
end
{% endhighlight %}

Above we are binding x to the value 5, and then we rebind x to the value 7. The idea is that you don't need to create multiple variables to hold each binding.

Of course, instead of rebinding we could use piping. Which we will see on another post.

## Conclusions?

Is interesting the fact that binding and assignment have the same notation in OOP languages. Most fo the time, you don't care what happens. You are considering the variable rather than the object.

Is important to know where that distinction is necessary (F#), otherwise not sure if it is. I think I need to think a bit more about it.


Go Back to [Into Adventure Intro]({% post_url 2015-09-22-into-adventure-intro%})
