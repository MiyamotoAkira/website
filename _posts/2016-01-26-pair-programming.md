---
title: Pair Programming
date: 2016-01-26 11:42:00
excerpt: I love pair programming. Haven't used as much as I would like to, though. Some history here (pair programming and mine) that lead me into it.
---

## Motivation

Recently there was a post in Slashdot.org post about [Code Reviews vs. Pair Programming](http://developers.slashdot.org/story/16/01/21/1749247/code-reviews-vs-pair-programming#comments). I was surprised at the actual derision of pair programming. They speak from an experience completely separate to mine. Do read the original blog post by Mr Rayala, where he shows the upsides and downsides of [Code Review vs. Pair Programming](https://blog.mavenhive.in/pair-programming-vs-code-reviews-79f0f1bf926#.pxega8tjp)(post in medium) as he sees them.

But now, is time to talk a bit about my experience.

## The root

I read [Extreme Programming Explained: Embrace Change](http://www.amazon.com/Extreme-Programming-Explained-Embrace-Edition/dp/0321278658/), by Kent Beck, when I was at lectures. Nothing of what he wrote on it was explained at University. Nothing about test, nor tight feedback loops with the client, nor any of the rest.

There are ideas that I tend to latch into, and will remember them at a later point (usually some years later) and then I will try to act upon them. XP has been one of them.

## The first graduate job

After finishing University I joined a company called DST Output UK (after a few merges and a few name changes). The job I that started doing there had the benefit of being exposed to very rapid feeback loop with the clients. You could send proofs a few times a day, depending on the job. Compared to previous jobs (back in Spain), where I wouldn't get any kind of feedback for a few months, it was a stark difference. I discovered that yes, quick feedback loops (ok, they can be slightly longer, say two weeks **wink, wink**), did improve the speed at which I was able to deliver the correct program.

As time passed, I joined what we called the platform team, where the job was a bit more like I expected to do (far longer development periods, much bigger codebase, ...). There I started to realize that there were other things on xp that could benefit greatly our work: Tests, Continuous Integration, small schedules, .... Once I had the opportunity, we started using them.

But there was one that I couldn't out in practice: Pair Programming. It was, well, it is, by far, the most difficult proposition to sell of all the principles outlined on Kent Beck's book. All the other principles they did create good value, reducing bugs, improving speed of delivery and creating better code. Why then, not try that last principle?

Well, in fact, I have (and probably you have as well) tried it a bit, while debugging?. Haven't you called a colleague when you can't find the issue with some code, when there is a hotfix that needs to be deployed as quickly as possible?. I do like to find the issues myself, but the ego has to be put aside when a production issue comes around.

## The chance

Currently, I'm working with a small team, where we tend to sit (or remote) together some times. So far, I have found that is easier to iterate through different approaches to a problem, that is easier to concentrate on problems (especially those that wouldn't be interesting to me), and that the distribution of knowledge is much simpler and quicker. One additional benefit, is easier to stop the Cowboy programmer. I do expect to increase the amount of time that we spend pair programming.

## What about Code Reviews?

Keep doing it. We do, in fact, get code reviews from the "free" member. Is easy to fall into Hive mentality while coding, so that additional set of eyes to make sure that what we do actually makes sense (you know [WTFs/minute](http://www.osnews.com/story/19266/WTFs_m))


## Conclussions?

Try it, if you haven't done it before. Force yourself for a couple of hours a day. Changing keyboard driver every half hour or so. And then decide for yourself if it fits your team. I think it fits mine.
