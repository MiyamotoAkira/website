---
title: Practical Microservices Review
date: 2020-05-25 04:00
excerpt: A quick review of the book Practical Microservices by Ethan Garofolo
tags:
- Books
---

My usual approach to reading technical books is to read them once quickly, without trying to assimilate the whole of it. Then practice, and then go back to it which then solidifies my understanding of the themes of the book. Sometimes, if I have been able to solidify that understanding exclusively through the practice, I don't go back to the book. Sometimes I read different books for the solidification. Which means that I tend not to enjoy as much books with a lot of code that is linked all the way through. Small pieces of code for which the context is found exclusively in the code and the two paragraphs before and after is all good. Furthermore, the longer the code is, the more linked through the book, the more important is the tech being used around. Which if is a book about that specific technology is fine but, otherwise, is a distraction.

I wanted to have that up front, as it will always colour my experience and my book reviews. Nevertheless, [Practical Microservices](https://pragprog.com/book/egmicro/practical-microservices) is a book that you should read if you haven't experimented yet with asynchronous microservices. As a starting point into your adventure it has a good balance of the theory, ideas and techniques behind the approach and the demonstration code. The examples are good, easy to implement, and maintains good quality through out the book. Of course, like nearly all practical books (other than testing books), the tests are left to a single chapter at the end of the book.

As with all books that use a single app sample through out the book, it takes a bit of time setting up the skeleton over which the code, the demonstration, goes. And after that, each new feature also takes a bit to setup. But explanations and concepts are interleaved often enough that you can still learn new things on each single chapter.

One thing that probably was left, based on my own experience, is that you want to have something to test that the different events are following the correct format, using something like [Pact](https://docs.pact.io/).

So, if you haven't deal with asynchronous microservices before, go and give it a read. Enjoyable introduction.
