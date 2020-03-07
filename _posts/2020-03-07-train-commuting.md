---
title: Train Commuting
date: 2020-03-07 04:00
excerpt: Does selecting at what point you access the train have anything to do with programming? 
tags:
- Thinking 
---

My favourite novel is [Microserfs](https://en.wikipedia.org/wiki/Microserfs) by [Douglas Coupland](https://coupland.com/). If you have never read it, I can only heartily recommend you do. Because it is a group of colleagues creating their own startup, it is probably slightly appealing to most people that would usually read this blog (all 4 of you ... nope, no metrics, pfffft). Anyway, at some point, towards the beginning of the novel, they talk about how, supposedly, Bill (yep, that Bill, Hello Bill!!) watches from the window of his office how people cross the campus, and you get promoted if you find good shortcuts. Quaint. But then I find the whole book charming.

# My Commuting

As a Londoner, I commute by public transport to work. Currently mostly using train lines (though I use the underground from time to time, especially when staying for events after work, like the [LSCC meetups](https://www.meetup.com/london-software-craftsmanship/) that you should join ;-) ).

One thing I noted not long ago is how I select my entry point in a train based on where do I end up when I leave the train. Well, I have been doing it for a long time, but didn't actively think about the implications until recently. For example: when I get the train back home from Blackfriars I enter through the third door from the front usually (when the train is 8 carriages), so when I leave I do it just in front of the stairs to leave the station I arrive to. If the train has only 4 carriages I select instead the second door.

This, in almost all cases, doesn't change the total number of steps I take during transitions (in a few cases, like when jumping on the Victoria Line at Oxford Circus it means less steps, in other cases a few more). What it does is: a) reduce the amount of time I spent changing trains or leaving the station, and b) allows me to avoid most of the human congestion that always happen (this last case I realized one day that I had jumped on the wrong side of the Victoria line metro and, on reaching Victoria, I was engulfed in a tide of commuters)

Most cases you can call it a micro-optimization, though on busy stations there could be a difference of up-to 3/4 minutes based on where you are located (like in the Victoria case). Although at a mental level, it helps me not to be surrounded by a herd of people for long. And if you do multiple changes on the underground, that could quickly add.

# My Computing

Is there any link to programming? Well, of course. Have you ever played [Human Resource Machine](https://tomorrowcorporation.com/humanresourcemachine)? Is a delightful game of ... assembly coding, basically. You can do the different levels and then try to get the optimization bonuses (number of commands and number of steps). One of the basic optimizations that you need to do to reduce the number of steps needed to resolve a puzzle is to move the outputting of the result to the top. Changing the order in which you do things matter.

And so is the case with your code. I mean granted, in a lot of cases just changing the data structure used is enough. And avoiding double loops. And ... Ok, maybe is not one of the first things that you need to use. But is a tool that you need to learn to use. Certainly I remember a couple of occassions in which rearranging the code (both times involving if statments) improved the time characteristics (not changing the big O, but definitely making it quicker).
