---
title: Tabs vs Spaces
date: 2020-01-13 05:00
excerpt: Which one should we use?
tags:
- Languages
- Accesibility
---

Ah, after the post about tests on dynamic languages, I thought it was time for something a bit more relaxed, and there it pops a tweet that makes me think.

# The Setup
On thursday, this tweet appeared in the wild: [One "real" reason to use tabs instead of spaces](https://twitter.com/aarnott/status/1214968169493778432). I recommend you to read the [reddit OP](https://t.co/HtfMNkOU3l?amp=1). You can skip the rest of the waffle in the thread. That is why you are here, to read *my* waffle.

The basic premise is that tabs allow people with impairments to modify the display to their needs.

# Some Precedents

Tab vs Spaces is one of those religious wars, like the position of curly brackets (I use whatever is common on the language) or Vim vs Emacs (the solution for this last one is the Evil mode for Emacs, of course).

Probably the main arguments for eacha are: spaces are consistent all across environments, IDEs, or any other software, which means you can keep alignment more easily; tabs give that individual flexibility.

I kind of assumed that spaces won, because that is what I use everywhere. Also because GitHub took the decision of using 8 spaces for tabs without allowing you to change the value.

There is, as well, a distinction that we have to do between indentation and alignment. We use the first one to group code within the same scope. We use the second one to group somehow syntatic elements that have some relation (proximity, repetition, ...) While you can do indentation with both spaces and tabs, you can't do alignment with tabs. 

Steve McConell argued against trying to keep alignment in his seminal book [Code Complete](https://www.goodreads.com/book/show/4845.Code_Complete). If you change names, the alignment dissapears and then you have to realign all manually. Furthermore, it means also that there are changes on your source control that were not really wanted.

# Which one looks better?

Which code example do you prefer?

1
```c#
rover.turn(Rotate.Right).turn(Rotate.Left).Move(Direction.Forward);
```

2
```c#
rover.turn(Rotate.Right)
.turn(Rotate.Left)
.Move(Direction.Forward);
```

3
```c#
rover.turn(Rotate.Left)
  .turn(Rotate.Right)
  .Move(Direction.Forward);
```

4
```c#
rover.turn(Rotate.Left)
     .turn(Rotate.Right)
     .move(Direction.Forward);
```

And here?

```

```

```
```


1, 3 and 4 pass what [Sandi Metz](https://www.sandimetz.com/) calls the squint test (don't know if she is the first one that came with the term, but is the first one I heard using it). 3 and 4 make it clear that is a multi-step process. 4 provides a nice composition.

# The Emacs Experience

When I started using Emacs I was confounded by TAB, which is not tabbing. Well, depends on the mode, really. But for most programming modes TAB actually calls `tab-for-indent-command`, which will indent based on some logic setup on the mode. The indentation is based on rules for the language. And I think this is imporant, indentation is based on the context.


# The Smart Indentation indicator

No system is created perfect. Most (if not all) are based on previous systems. The way that our keyboards and text editors work is based on the typewriter. Furthermore, on the typewriter that was being used at the time that computers started to get devised. The slanted keys on the keyboard. The key distribution. And the use of the tab. But why we should be constrained by it? The same way some keyboard manufacturers have been moving away from the "traditional" format to new styles (orthilinears, different location for the special keys). We can do the same with the way that we handle text editing. Why a tab is just a fixed tab? Should a tab be based in something more similar to what a `tab-for-indent-command` is? By default a tab should be behave like a fixed tab. . Hitting tab circles between current indentation, next indentation, previous indentantion and no indentation. 

You can decide to display as variable alignment or fixed alingment

But what character or escaped character can you use?
