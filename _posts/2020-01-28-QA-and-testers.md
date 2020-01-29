---
title: QA and QE 
date: 2020-01-25 05:00
excerpt: Where do QA should fit within your process?
tags:
- Process
---

At some point I will go back to writing a blog post showing something from Emacs. Meanwhile, a topic for which just had some talks with colleagues.

# The Setup
I started programming Eons ago. But I didn't have dedicated testers until 5 years ago or so. Most of the time I was doing QA (really badly) on my code, with support at times (which was necessary). Then I started to have some testers, and it was clear to me that they rock. Where I lack the skill/discipline to evaluate multiple options, they have it on spades.

# The traditional QA process
Usually QA happened (well, in lots of places still happens) after main development has been done. The coders do their part, throw the resulting program over the wall where the testers go and do their stuff. If they find issues (and they will), they send it back to the developers to fix. Then the back and forth continues until the code is deemed good enough to go to production.

There are two great issues here:

- The feedback loop is painfully slow. Worst case, the developer sends the code after a few months (or years). The feedback loop is one of the major issues that the Agile movement tried to change. Which resulted, for people that didn't really embrace Agile, on having QA after more finely grained pieces of code got done. This reduced the feedback loop to two or three weeks from initial coding. But that is not enough. Not a good use of your personnel (aside note, will never use the term resources because is bloomin' dehumanizing)
- Creates a culture of separation and confrontation, where the coding team and the testing team don't care about the other, they only take responsibility of their parcel. I dislike that. I think is inneficient. I think it is not helpful. Your teams should work together helping each other to achieve a common objective. Collaboration and sharing of responsibilities are part of what the Agile movement wanted to achieve.

# Automated tests
I remember when I first started working and learned that I had to manually test how the application worked. Wasn't that impressed, and realized I don't have the will for it. I found it, personally, mind-numbigly boring (but then, I find most jobs mind-numbingly boring, so that one is on me). I thought that there had to be a better way of doing that. And then I got to read [XP Explained: Embrace Change](https://www.goodreads.com/book/show/67833.Extreme_Programming_Explained?from_search=true&qid=Z67GFhVsnW&rank=3),  by [Kent Beck](https://www.kentbeck.com/), and I discovered the concept of Automated Tests. What a brillant idea!!! Why didn't I think of it before? I could write most tests as code to run. And from there, once I got some experience, I moved into writing the tests up-front.

I have heard recently that Quality Engineers are using a terminology of `checks` for those kind of automated tests and `tests` for exploratory and other kind of manual tests. That is fine by me, as I think makes things a little more clear (check my blog post about [names]({% post_url 2020-01-21-names-do-matter %}))

# The Revised process

In my experience most tests will be `checks`. What are the chances that there is a [Pareto](https://en.wikipedia.org/wiki/Pareto_principle) peeking there? I will go further and say that for non-graphical systems, the amount of `checks` represent more than 95% of the total testable surface, dropping that to a lesser percentage but still high (I will posit 90%, but maybe someone is inclined to get the data) when there is a GUI involved.

Is at this point that the Quality Engineer main job is not longer testing themselves (again `tests` like exploratory testing will always be needed, and that needs working code), but help prepare in advance what will become the `checks`. They should be helping the PM/PO to prepare the requirements of the new functionality. That helps in making sure that the requirements are better understood by the PM/PO, the stakeholders have provided all the additional information needed, and the developers have the basis for their ATDD/BDD/Whatever tests that will help them in determining that they have achieved what was intended with the new functionality. They can, time permitting, sit down with the developers to write those `checks`, to help move things in the right direction, and to increase the collaboration and common knowledge between them, that it is, inside the team.

This achieves, in my experience, a better use of time for QEs and a much better result for the product that the company is building.
