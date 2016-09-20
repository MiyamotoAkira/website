---
title: Emacs helpful help system
date: 2016-08-07 08:00:00
excerpt: Emacs provides one of the best help systems that I have seen on a text editor/IDE. Here are a few things that you can do.
---

Small note, before we start, either you have Emacs 24 or older, or you have installed package.el (if not, you could always change some of the examples given for some other symbols)

## The Setup

I pointed a bit on my previous post at issues that I was having with my emacs configuration. First there were some issues with my packages configuration for [CIDER](https://cider.readthedocs.io/en/latest/). Then somehow (and we will see shortly why) ido-ubiquitous (I still have to try helm) started failing to load correctly. If I deleted the line setting up ido-ubiquitous then it will be rainbow-delimiters the one failing. After some wasted effort reading here and there, and trying different things I reverted to the previous version of my configuration. Everything worked, so started redoing the changes one by one.

## The culprit

The reason why my emacs configuration was going bananas was the line that I had modified from 

{% highlight elisp %}

(package-initialize)

{% endhighlight %}

to

{% highlight elisp %}

(package-initialize t)

{% endhighlight %}

I copied from somewhere without paying attention to what I was doing. But what this meant? Why it was failing? Time to look for help.

## apropos

If you have used any \*nix system probably you have crossed paths with *apropos*. *apropos* looks into man page names and descriptions for a string. *apropos* inside Emacs do similar: it looks for all the Lisp symbols that match the text. You can invoke it with **M-x apropos** or the shortcut **C-h a**. so invoking apropos on package-initialize would give me all the symbols that have that name (on my case two from the flycheck package and the one that I want). The help will give you the full name, plus the type of symbol it is (Variable, Function, Command) and even if they have property lists (plists), which are just paired elements that keep some miscellaneous information about the symbol. Furthermore, it provides links to the documentation of the symbol, so you could navigate and look about the concrete documentation of the symbol chosen.

But if you know that you are looking for a command, or function or even a library, you have additional **apropos** commands: **apropos-command**, **apropos-function**, **apropos-variable**, ... **apropos-library** is even quite nice tand shows you all the symbols defined on a library. That is it, it allows you to start investigating a new library that you have installed. I am not sure there is another system with such help.

## The describe system

But of course, apropos is nice to look for things that you don't know exactly what you are looking for or you just want a quick reminder. For more in-depth help, you can follow the links that apropos provide. If you know already what you are looking for, you can go directly to the in-depth help using the describe commands (incidentaly, if you want to know what is the difference between function and command execute **C-h i** select the Elisp manual and the press **i command**, where you will see the difference).

The describe commands are divided by the type of symbol, or the location, or some other,  for which you want to search for. You will have then, commands like: **describe-function**, **describe-mode**, **describe-font**, ... Those commands will try to look for the help associated to the element that you are looking for, and on some cases it will give you the current configuration. For the first case you can try **M-x describe-function RET package-initialize** (that RET means press return/enter after writing describe-function). For the second case you can try **M-x describe-font RET RET**

Very useful on the describe system is **M-x describe-mode**, which will give you information about the major mode active, which minor-modes are active, shortcuts available for the major mode, and will show specific information about minor-modes for which there is at least one shortcut defined (if they have not, only the list at the top would tell you the minor modes currently active).

## Shortcuts

Shortcuts are very important on Emacs. They allow you to have a flow, a rhythm of keystrokes to use quickly Emacs. If you want to see all the shortcuts defined on the current buffer **C-h b** will provide you with that information. This will provide you with all the shortcuts available and links to the function/commands help.

Imagine that you know the beginning of a chord (combination) but you want to know the options to finish the chord. In that case you write the beginning of the chord and then press **C-h**. Try pressing **C-x C-h** to see all the options avialable. If the chord has three elements you can even press the first two and complete with **C-h**, like, for example, **C-x 5 C-h** (which are commands related to frames)

If you want to check if a chord is being used then you can use **C-h k** and then the chord that you want to check for.

## How is achieved?

How do they get all this information? Emacs analyzes all packages source code (remember Emacs is 5% C, 95% Elisp) and extracts all symbol names and the associated documentation. And I think is important to highlight this, all packages tend to have quite a bit of documentation, much better than I have seen in some other IDEs extensions.

Which also means, if you want to release a package to be used, make sure that it has documentation that will be picked up by the help system of Emacs.

## Why is useful?

Discovery. When you install a new package it is very easy to start investigating all the options available. You will not use all options straight away, but seen all possibilities and options that the package gives you makes it much easier to learn the whole potential of the package..

## The Why

Back to

{% highlight elisp %}

(package-initialize t)

{% endhighlight %}

The reason it was giving issues is because that *t* there means that packages will not be activated (D'oh!). That should teach me to investigate what I am putting on my init file.
