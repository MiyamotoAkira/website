---
title: Dynamic vs Static Tests
date: 2020-01-07 05:00
excerpt: Do we need more tests on a dynamic language?
tags:
- Languages
- Testing
---

Last week we had a London Software Craftsmanship Community (LSCC for shorts) Round Table meetup. For the discussion topics I added "Do we need more tests on a dynamic language?". I thought it in the moment, so my ideas were not as clear as they could have been. But the discussion was interesting.

# The Setup

Robert Martin is in love with Clojure. And because he tends to express himself a lot, he wrote that he didn't need more tests on a dynamic language than he needs on a statically compiled language. This, of course, ruffled some feathers in the community of Static Languages, and also of some part of Academia.

I'm not an expert on language design (though I want to spend some of this year improving on that area), so if I say anything incorrect, I'm happy to be corrected. Well, I would be happy to be corrected even if I were an expert.

# The Basics

When a piece of code (method, function, procedure, ...) is on a vacuum (and here we mean as not being linked to deployed software), I think it will be easy to demonstrate that a dynamic language requires more tests (even if those test are manual). Easy way to demonstrate this is using a Sum type on F# or Haskell. I don't need to test that a variable, value or parameter is within that Sum type, because otherwise the system will not compile. Ruby or Javascript will happily let you run with a value that is not part of the Sum type. If I want to assert that my code will not break when running, I need to have tests (and additional defensive code, I must add) so I can guarantee that the code is correct.

There is a second issue. It is oh-so-easy to introduce mispelling errors in your code. You write `paht` when you wanted to write `path`. A statically compiled language will stop you in your tracks, while a dynamic language will give you a "nice" `paht is undefined` or similar at runtime. Tests allow you to get back again some of the benefits of a static compiler.

Therefore, it will seem that dynamic languages require more tests.

# Expanding The View

Let me ask you this question: When doing End to End tests, or Acceptance Tests, do you take into account if the language in which the code was created is dynamic or static? Hopefully the answer is no.

Business logic is independent of the language that you use. The tests that you create to confirm that business logic works, how the application performs, and its usability should be the same independently of the language that you have used to implement it. So, in this regard, a dynamic language doesn't mean that you need more tests.

When you are testing the business logic, you are testing indirectly, at the same time, that the information flowing through your methods and functions and processes has the right shape. That is not the main purposes, but they do provide that benefit. Data coming in, or going out (as much as possible, you should do tests as if the methods and functions are black boxes). If the business logic indirectly checks that the shape of the data/objects is correct, why should I be creating specific tests for those checks? That would be unneeded duplication. Eliminate them.

You still have the boundaries of your system, where you are communicating with a different system, and you are trying to transform incoming data (protobufs, or simple strings, or whatever else) into the shape that your application will be using. But again, you will need to do these kind of tests independent of the language you have chosen.

Therefore, it will seem that dynamic languages don't require more tests.

# The Extended Universe

What happens when you look at code after a certain amount of time has passed? Do you remember everything about the code? Types help you on understanding what data, what objects are being passed around. But does that mean I need more tests? The business logic tests will still be there and provide information. Maybe is not a quick, but you will gather information. And how much do they help? An `Int->Int->Int` signature tells me very little about what is going inside the function. The name of the function (remember, good naming is important) and the tests will help me ellucidate what is going on.

What happens when a new dev joins? Pretty much the same as the above paragraph. Most probably it will be easier to understand what is going on if you know exactly the types that are going inside a method/function, but only up to a certain point. For further insights, they will be back into reading the tests and other documentation (well designed tests document what the system does).

Business logic tests are those tests. So I don't see how a dynamic language will require further tests.

Back in [The Basics](#the-basics), I briefly mentioned defensive code. Defensive code needs to be tested, make sure that is doing the right thing. But what is the point of defensive code? Making sure that the types are correct? Gracefully fail when the data is incorrect? Defensive code is like exceptions, it shouldn't be all over your code, only where it makes sense (I have written in the past unneeded defensive code). And most cases is not about the shape of the data, but the actual values (e.g., your divisor is 0). And in those cases, there is no difference between dynamic and static.

# Conclusions

So do dynamics languages require more tests? I don't know. I think I am missing more arguments on both sides. If I were to have had an opinion yesterday (and I do mean yesterday), probably I would have said no. Today, as I finish this post, I will say probably yes. But I don't think you would have to write enough of them to actually even register on the reasons why to choose a language.
