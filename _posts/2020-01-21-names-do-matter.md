---
title: Names do matter
date: 2020-01-21 05:00
excerpt: Which one should we use?
tags:
- Software Design
---

At some point last December [Ron Jeffries](https://www.ronjeffries.com/), I think it was him, made a great analogy: if you call it chess but move your knights diagonally, it isn't chess.

# The Setup

I always stop myself from being pedantic on tweets, and at some point even got around the idea of a "joke" that somehow goes `how can I not be pedantic? I was educated by computers` (I am not a comedian, very clearly, so I am leaving that to people better prepared)

How many times have you had issues during development where, after talking with stakeholders, you realize you wrote the wrong thing because what you were referring as `foo` (where `foo` can be order, transport, loan, document ...) it was, for the stakeholders, actually something different? Definitely a few cases on top of my head. How many times have you thought: next time I should clarify things better.

# The Wisdom

When Eric Evans came with [Domain Driven Design](https://www.goodreads.com/book/show/179133.Domain_Driven_Design?from_search=true&qid=uowqWQpF1T&rank=4), between so much wisdom and information, the concept of [Ubiquitous language](https://www.martinfowler.com/bliki/UbiquitousLanguage.html) (small post by Martin Fowler) was formalized. When I read it, it just gave name to something I was trying to do (probably not that succesfully) for a while. That's it, try to communicate with stakeholders within the business domain language, rather than the programming vocabulary. Evans went a bit further, as he indicated that different parts of the business (and therefore of your system), will have different languages (different subdomains), with names being overloaded, therefore were context was important (I keep mention it here and there: context is really meaningful)

How many times have you read about `theories`, and how things are called `theories`, and then learn that the common usage has a different meaning than the technical usage? (`theory` in common usage is an `hypothesis` on technical usage). Within a business/tech (sub)domain, a word can have a different meaning to what you are used to: sometimes completely changed, sometimes more nuanced. 

Learning the concepts and naming them accordingly makes communication easier.

# The Disgruntlement

I do get slightly peeved whenever someone uses words incorrectly within a business/tech domain, and doesn't want to change their usage. They are actively making communication more difficult (of course, context again, we are not talking about poetry or prose, but business/technical communication). Using the right terminology matters. It matters so much that is part of Clean Code. Because giving proper names makes communication so much more clear.

You are reading some code, and where you read `transport` you should read `consingment` (I was trying to remember a more egregious case that I had with a previous client, but memory is not my forte) and, because of that seemingly small difference, you get confused when your autocomplete shows you methods that you don't expect. How many hours have you lost because a badly name variable was throwing you off (and yes, I have seen `completed` being used as `not_completed`, I hope that wasn't me)

I am going to bring a similarity to tests in terms of: `if you don't know how to name something, do you understand what you are naming?` I will go a bit futher and ask: Do the person that reads your code easily understand what the code is doing, based on the name that you have given to your class/method/function? As a recent example a colleague ([Dan Cohen](https://twitter.com/hackingdandan)) and I were discussing the name of this method that we were working on. We had an object log, and we wanted to add tracing. The object was just a facade with some helper methods to another logging library. The method would receive a name of a trace and the code that we wanted to trace. So first we looked at adding a method `trace`. But there was a method `trace` already exposed. We could overload, but that would mean that two methods called the same had very different behaviours. So we changed it to `tracing`, but that wasn't ideal either (could work on English, barely). Next step was to use `traceFor`. And at this moment the realization came that what we wanted was to change it to `trace.for` Our log object was trying to do too many things. The issues with the naming lead us to realize that we were doing the incorrect thing, and corrected course because of it.

Naming things correctly is important.

# The Social Aspect

Of course there is a social/cultural aspect to it. Unless a language is truly dead (Latin, e.g.), languages are continuosly evolving: We don't talk the same English as 50 years ago, or 250 years ago. Culture changes, new words appear (for example, because certain [wordsmith needs to do a rhyme](https://www.litcharts.com/blog/shakespeare/words-shakespeare-invented/)), others go out of use. Some words get new meaning, others lose some of them. And some are so charged culturally that you want to exercise some discretion to their usage. There is `master/slave`, for example, or `whitelist/blacklist`; words that we should all strive to replace. Without the cultural baggage, they don't even describe properly what they intend to (`safelist/blocklist` is so much more meaningful)

# The Disclaimer

Not long ago, a colleague described my naming as whimsical, which is ... more or less correct. I usually give names first within the ballpark (where the ballpark is London-size), and then on second or third revision I try to improve them (make things work, make things right, make things fast). Also, I don't name things the same when I am on my own, than when I am doing pair programming; the latter tends to be far better.

# Name Things Properly

Aim to improve your communications. We do communicate and read code more than what we write. So do be a bit pedantic in a business/technical environment. Stop wasting your time, your coworkers time, and your clients time. Try to make communication more precise.
