---
title: Which language to use
date: 2016-09-01 17:00
excerpt: Are all languages equal? The answer is no. So, which one should we use? Maybe the one that requires less coding
tags:
- Languages
- Thinking
---

## The Setup

The other day I put a tweet up:
"The more I learn, the more I think that using static OO languages like Java and C# is kneecapping your ability to compete"

When I am talking about competing, I refer to the ability of the company/product. Not your individual capacity as developer.

## Are all languages equal?

Yes, but no. 

Some time ago I did a couple of talks about using the right tool for the job. One of the points that I talked about on the presentation was that all major languages (and most small) are Turing complete. That is, all of them are capable of creating the same applications. But, of course, if you try to code an application on C, Cobol, Java and Brainfuck, there would be a massive difference in terms of time used to develop them, performance capacity and readability.

A very easy, simple way to show it is trying to write hello world on several languages. Very simplistic, yet enough to start showing differences between languages. You can see below some examples that I extracted from [Hello World Collection](http://helloworldcollection.de/)

Brainfuck

{% highlight brainfuck %}

++++++++++[>+++++++>++++++++++>+++<<<-]>++.>+.+++++++
..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.

{% endhighlight %}

---

C#

{% highlight csharp %}

class HelloWorld
{
    static void Main()
    {
        System.Console.WriteLine("Hello, World!");
    }
}

{% endhighlight %}

---

C

{% highlight C %}

#include <stdio.h>
#include <stdlib.h>

int main(void)
{
  puts("Hello World!");
  return EXIT_SUCCESS;
}

{% endhighlight %}

---

Cobol

{% highlight cobol %}

*****************************
IDENTIFICATION DIVISION.
PROGRAM-ID. HELLO.
ENVIRONMENT DIVISION.
DATA DIVISION.
PROCEDURE DIVISION.
MAIN SECTION.
DISPLAY "Hello World!"
STOP RUN.
****************************

{% endhighlight %}

---

Clojure

{% highlight Clojure %}

(defn hello []
  (println "Hello world!"))

(hello)

;Or just 

(println "Hello world!")

{% endhighlight %}

---

Ocaml

{% highlight ocaml %}

print_string "Hello World!\n";;

{% endhighlight %}

---

Python

{% highlight python %}

print("Hello World")

{% endhighlight %}

---

As you can see, the code does vary a fair amount between some of the languages.

So let's go with the first rule:

**Languages are not equal**

Otherwise there wouldn't be new languages invented.

## Do all languages perform the same?

Hashrocket recently put up a blog post: [Websocket Shootout](https://hashrocket.com/blog/posts/websocket-shootout)

Clearly, performance varies. Give a look at [The Computer Language Benchmark Games](http://benchmarksgame.alioth.debian.org/). But, it depends on what you are trying to do. You are not going to get the same single thread performance from Erlang, as you will get from other languages like C#. But when it comes to multi-threaded environment (glossing over the fact of the differences on threading concept brought from the BEAM), their perfomance capabilities are going to change. And not always that performance is needed. Games that are using very realistic graphics will need a graphics engine that can deal with massive amount of operations in a very short time span, therefore you choose C++, but for the game logic, you don't need that kind of performance, so you select something that is easier to manipulate (LUA, for example). HFT companies need to react very quickly to market moves, so C++ is their answer. If you don't, then F# is being used more and more (at least in the City) because fits very nicely the domain.

Performance is one of the characteristics that you need to look into, but is not the only one. What kind of logic can you express?. Does it have a good numeric system? What are the memory usage performance? Does it have garbage collection or is it manual? What is the size of the compiled application? Does it need an additional runtime/VM? Where it can execute?

There are languages that are great for mathematical computations. You would do well staying away from Javascript if that is the most important part of your domain.

So, second rule.

**Learn the characteristics of different languages**

## Are languages equally useful in all domains?

Different languages have different verbosity. Look again at the simple examples above and compare how much more code you have to write for C# than you need to write for Python or OCaml. This becomes even worse the larger the program is. Languages like Java and C# are very verbose, very explicit and lack flexibility. You have to contort your code to achieve flexibility. Is very easy to find yourself in a corner from which is difficult to maneouver.

There are people that have compared the size of C# and F# applications. The more interesting one is this one:

**Missing link**

because it actually compared the same production ready application. Though there are others:

**Missing link**

As a CEO/CTO/Top Person, if you get such a reduction on the amount of code that needs to be written (and maintained), and the reduction on the number of people needed, and the reduction on time (and time is money) wouldn't you go for it? The fact is most don't. Because ... I have some ideas, but I'm not certain.

In the world of startups being able to deliver quick is important. That is why on the noughties Ruby and Ruby on Rails become so important. It provided a boon on delivery. Of course, Ruby suffers currently of problems with performance. So once you have established yourself, you look into options.

As a general rule, your client, and the world at large doesn't care about your language, or if you are doing SOA, microservices, event processing. But you should care. It is performance what you need? Is it quick development? What are the structures, elements and workflow of your domain.

Let me tell you something about most web applications and REST Apis: You get a call from outside with information, optionally you have information on your datastore, process the information and then return the results and optionally you store information on your data store. You know where in your application you are storing state for the next call? Nowhere. Is stored externally. Endpoints are functions, composed of functions. They map neatly to functional languages. Yet the majority (finger in the air estimate) are created using OO languages (Java, C#. Ruby, Python). So you have to go against the paradigm to create your web application or REST API. Does it sound right to you?

Of course, if you are doing a desktop GUI, or a game, or a backend service, that could and will change. Maybe they map better to OO, or to procedural. Maybe is a logic domain. You can't just use Java for everything. Well, you can (Turing Complete). But you would be wasting effort.

Third rule

**Know how languages map to the domain you will be working on**

## Equal languages for the domain.

What if two (or more) languages or two (or more) paradigms map equally well to the domain. Then you have to start looking a what each language brings to the table. Whatever language creates less errors, doesn't constrain you,  make it more maintable is where, speed of delivery, ... These are some of the characteristics that we have to look into.

Sometimes a language that doesn't constrain you is more prone to errors and bugs (OO dynamic languages come to mind). But are their maintenance, flexibility, and delivery speed qualities good enough to compensate?

The issue with static OO languages is that all that is supposed to make them good (like the compiler checking some of the correctness of the application) means that you will be writing far more code and that you will loose flexibility, which means that maintenance will be more difficult. SOLID and similar principles try to regain, and keep that flexibility. But they are just overcoming issues with the language (and the paradigm). Same with Software Design Patterns. I don't see them coming to life outside static OO languages.

There is this lovely slide from a presentation from Scott Wachlin in which he replaces all patterns and styles used by functions on FP:

**Missing link** 

Alan Kay has this to say about dynamic vs static on an [interview with the ACM](http://queue.acm.org/detail.cfm?id=1039523):

*If you’re using early-binding languages as most people do, rather than late-binding languages, then you really start getting locked in to stuff that you’ve already done. You can’t reformulate things that easily.*

Are all static languages bad? No. In fact, I quite like C# on the static OO category. But it is a language that gets in the way. You need to create all those interfaces if you want to achieve flexibility. But then, you are hampered in other ways. Starting with the amount of code that you have to write. Looking at F#, for example, it uses quite strong type inference. That is a much better way of dealing with static systems. There is still work to be done around interfaces and such if you need to use OO functionality. Of course, F# is a functional-first language, which helps in reducing the amount of cruft that you need to write. 

There are two sayings:

*A workman is only as good as his tools*

*A bad workman blames his tools*

I don't see them as being at odds with each other. You can have bad tools/languages and still create good work. Mostly, the difference becomes in the amount of effort needed. But if you want to be at the top, having better tools/languages is a must. I tend to say that we can write any software needed. Is just a question of time. And the more time you can save on the creation of a solution because of the language chosen, the better off your clients are, and the better off you are.

Fourth rule

**The language does matter**

## Which one then?

I currently believe that if you start a product and you are using C# or Java you are taking a bad decision. They don't offer anything beyond a bigger pool of candidates (not better candidates, mind you). Functional languages would be my first port of call for web systems (apps and APIs): Clojure if I need JVM, F# if I need .Net, Erlang (maybe Elixir) for distributed systems with zero downtime and high availability. Do I need to create basic infrastructure projects? Probably Rust and Go (depending on the domain). I believe games tend to map nicely to OO. Though those are my current views, and you should do your own thinking before starting a project.

One additional thing. Most of the time, performance is not a consideration for the project as a whole, but for specific parts of the project. Those parts you will look into dropping a lower level of abstraction to get a performance gain (if you hit a wall on your current language). That's it, create your application on the language more generally appropriate for the domain, and whatever needs to have a great increase on performance, gets rewritted on a more perfomant language. Measuring is the key here, to identify those parts.

## The Conclusion

It is all about choosing the right tool for the job, and just because everyone chooses the same blunted swiss army knifes, doesn't mean you should as well.
