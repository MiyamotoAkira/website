---
title: Wat Weirdness
date: 2016-04-15 11:30:00
---

### Wat

A few days ago I saw this video by Gary Bernhardt titled <a href="https://www.destroyallsoftware.com/talks/wat">Wat</a>. It is a funny take on some quirkiness (mostly) of Javascript. Ok, I wouldn't call all of them quirky, some are rather bad design. They create inconsistent behaviour. Of course you can learn all the quirkiness, but you shouldn't need to. That is why, as well, C++ seems to me that can only be used by very good developers with very strict coding guidelines. Otherwise you could create the same scenarios as we see on JS.

### Erlang

Recently I discovered that Erlang has a difference between **=:=** and **==**. It doesn't seems as marked as the different of **==** and **===** is in JS. Right now not seeing the point, but maybe I need to work a bit more with it (I've just started with Erlang). Maybe is because is a dynamic language.

### Java

I believe that C# is the much better language than Java. Since 2.0 it has provided far better constructs for creating good readable code than Java. Now with dnx maybe .Net will get more use outside of Windows machines. I have been relatively happy as a C# developer (although there are better languages).

I said this as a disclosure for what it follows.

A colleague ... mmm, well, now ex-colleague, showed us the below Java code yesterday.

{% highlight Java %}
public class Main 
{
	public static void main (String[] args)
	{
		Integer a = 100;
		Integer b = 100;
		Integer c = 200;
		Integer d = 200;

		System.out.println(a == b);
		System.out.println(c == d);
	}
}

{% endhighlight %}

The interesting part is that these two equalities don't return the same value.
As we are, there were a few of us immediately testing if it was true. Which it was.

The first print will say that is *true*, while the second will says that is *false*. It seems that if the number is in the range -128 +127 it does caching of Integers.

On one side I think how often that could be an issue (probably not many times). On the other side, it creates inconsistent behaviour. As I do not work with Java, I don't know how much this is a good trade off based on pragmatism.

Not planning to learn Java itself. But as I'm dabbling with Clojure, I expect I need to be aware of this kind of things, just in case.
