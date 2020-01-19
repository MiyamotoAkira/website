---
title: Names do matter
date: 2020-01-19 05:00
excerpt: Which one should we use?
tags:
- Software Design
---

At some point last December [Ron Jeffries](https://www.ronjeffries.com/), I think it was him, made a great analogy: if you call it chess but move your knights diagonally, it isn't chess.

# The Setup

I am always stop myself from being pedantic on tweets, and at some point even got around the idea of a "joke" that somehow goes `how can I not be pedantic? I was educated by computers`

How many times have you had issues during development where, after talking with stakeholders, you realize you wrote the wrong thing because what you were referring as `foo` (where `foo` can be order, transport, loan, document ...) it was, for the stakeholder, actually something different? Definitely a few cases on top of my head. How many times have you thought: next time I should clarify things better.

# The Wisdom

When Eric Evans came with [Domain Driven Design](https://www.goodreads.com/book/show/179133.Domain_Driven_Design?from_search=true&qid=uowqWQpF1T&rank=4), between so much wisdom and information, the concept of [Ubiquitous language](https://www.martinfowler.com/bliki/UbiquitousLanguage.html)(that is a link to small post by Martin Fowler) was formalized. When I read it, it just gave name to something I was trying to do (probably not that succesfully) for a while, that's it, try to communicate with stakeholders within the business domain language, rather than the programming vocabulary. It went a bit further, as it indicated that different parts of the business (and therefore of your system), will have different language, with names being overloaded, therefore were context was important (I keep mention it here and there: context is really meaningful)

# The Disgruntlement

I do get slightly peeved whenever someone uses either overloaded words or words incorrectly, and doesn't want to change them. They are actively making communication more difficult (of course, context again, we are not talking about poetry or prose, but business/technical communication). Using the right terminology matters. It matters so much that is part of Clean Code. Because giving proper names makes communication so much more clear.

You read code, and where you read `transport` you should read `consingment` (I was trying to remember a more egregious case that I had with a previous client, but memory is not my forte), and because of that seemingly small difference, you get confused when your autocomplete shows you methods that you don't expect. How many hours have you lost because a badly name variable was throwing you off (and yes, I have seen `completed` being used as `not_completed`, I hope that wasn't me)

Naming things correctly is important.

# The Social Aspect

Of course there is a social/cultural aspect to it. Unless a language is truly dead (Latin, e.g.), languages are evolving. We don't talk the same English as 50 years ago, or 250 years ago. Culture changes, new words appear (for example, because certain wordsmith needs to do a rhyme), others go out of use. Some words get new meaning, others lose some of them. And some of them are so charged culturally that you want to exercise some discretion to their usage. There is `master/slave`, for example, or `whitelist/blacklist`, words that replacing them is something we should all strive for. Without the cultural baggage, they don't even describe properly what they intend to (`safelist/blocklist` is so much more meaningful)

# Name Things Properly

Aim to improve your communications. Do be a bit pedantic in a business/technical environment. Stop wasting your time, and your clients time.
