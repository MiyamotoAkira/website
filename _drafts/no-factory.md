---
title: No factory
---

I dislike boilerplate code. Every single piece of code that you need to write because the langugage forces you to do it, not because it helps solving your problem is a waste of time. Why should you be using time creating boilerplate code, when you could have finished the issue at hand? On the Toyota original Lean process all that boilerplate is Muda. And should be eliminated. Sometimes IDE tools allow you to easily create that boilerplate. But still, is a waste that you need to mantain. Ideally, that boilerplate shouldn't exist.

That is one of the reasons why I love Python and one of th reasons of my current love for functional programming. Most boilerplate gone. Python is just an elegant language that doesn't try to be on your way. Compared to Java or C#, there is so little waste, so few unnecesary constructs.

I've been doing SOLID for a few years. And because I was doing SOLID I ended using IoC containers. Mostly Autofac and SimpleInjector (of course, we are talking about the C# world here). Although they have been useful, there are things that I didn't like about them. I have been always a bit unclear about their lifetimes. And the fact that they favour so much constructor injection over method injection (which they do not support). Mind you, it didn't help that for a while I was with the mind of not allowing at all "new" outside of factories. 

Just recently I've seen a QCon keynote from 2013 by Greg Young <a name="return1"><a href="#1">[1]</a></a>. And while watching it, I saw his use of lambdas to pass new objects into method calls as a simpler way to do injection. I have used delegates and lambdas quite a bit. I have created interesting simpler solutions using them. And yet, did not cross my mind to use them as a way to create a factory without clutter.

Darn it, I say.

The below is some very simple code that I created to test that "factory" ability with constructor parameters.

{% highlight C# %}
using System;

namespace TestFactorySubstitute
{

    public class MyClass
    {
        public int Execute (Func<string, MyDependency> mydependency, int value)
        {
            return mydependency(DateTime.Now.ToShortTimeString()).Call(value);
        }
    }

    public class MyDependency
    {
        public MyDependency(string currentTime)
        {
            Console.WriteLine("Hey: " + currentTime);
        }

        public int Call(int value)
        {
            return value;
        }
    }

    public static class Program
    {
        public static void Main()
        {
            var myClass = new MyClass();
            Console.WriteLine(myClass.Execute(x =>new MyDependency(x), 5));
            Console.ReadLine();
        }
    }
}

{% endhighlight %}

This same day was applied as well at my work to eliminate three connected factories (not created by me, but it could as well have been), and replace them with a single lambda expression.

That doesn't mean that factories are bad. They are quite useful if there is some logic applied on the factory. Is just means that I will be able to skip them when there is no real need for them.

[1] <a href="http://www.infoq.com/presentations/8-lines-code-refactoring">http://www.infoq.com/presentations/8-lines-code-refactoring</a> <a name="1"><a href="#return1">back up</a></a>