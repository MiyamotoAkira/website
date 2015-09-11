---
title: Binding and Assignment
date: 2015-09-09 17:00:00
---

### The starter

This post started as an idea while preparing a presentation on moving from OOP to FP. I nearly didn't mention it on the presentation, and then decided to talk a bit about it.

The difference between binding and assignment didn't cross my mind until I was forced on FP to live without the latter (ok, some hybrid FP languages allow you to use assignment, but shouldn't be your default option)

### What is binding?
Binding is assigning some piece of code or data with a name, an identifier. The point of binding is to be able to easily use that piece of code or data inside the scope where the binding is used.

### What is assignemmt?
Assignment is to change the value of data. The data is changed for the lifetime of the container of the data (that be a record, structure, object or collection)

### The OOP way
As I just mentioned, there is no clear separation on OOP languages between asignment and binding. Both things are mostly conflated into assignment. And then you don't think of the cases where is clearly binding. Now if you are into the theory of computing, you will already know the difference. But, for all OO programmers that I know personally, there is no difference.

We are going to work through some code to see differences between each other.

#### Binding through method calls
First is the binding that is a binding, even if you don't call it that.
C#
{% highlight C# %}

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

#### Binding inside a method/class
But you have seen already a different way of binding in that example. Which is the way that you bind inside a method.
Ruby
{% highlight Ruby %}
x = 5
{% endhighlight %}
That is a binding. We are saying that in any subsequent code on the same scope we can use x instead of 5.

So, if we had
(% highlight Ruby %}
def example()
    x = 5
	puts x
end
{% endhighlight %}
then whehn we are using **puts x** we are saying *puts the value of the piece of code/data referenced by x*

"Wait", you will say, "that is an assignment". And I will say is not. x only refers to 5 on the scope of example. Outside of example, 5 is still data that you can use, but x is no longer a way of referring to that data.

Maybe another example
{% highlight Ruby %}
{% endhighlight %}

Assignment inside a method
{% highlight C# %}

{% endhighlight %}


### The FP way
Binding through function calls
{% highlight F# %}

{% endhighlight %}

{% highlight Clojure %}

{% endhighlight %}

Binding inside a method
{% highlight F# %}

{% endhighlight %}

{% highlight Clojure %}

{% endhighlight %}

Assignment inside a method
{% highlight F# %}

{% endhighlight %}

Rebinding
{% highlight F# %}

{% endhighlight %}

{% highlight Elixir %}

{% endhighlight %}

### Conclusions?