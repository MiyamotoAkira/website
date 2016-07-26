---
title: Into Adventure - Part 4 - Classes/Interfaces vs Functions
date: 2016-07-16 17:00:00
excerpt: 
---

### Basic construct: Functions

The first thing that you will realize when using a Functional Programming (FP) language is that you will discard classes and interfaces for functions. That it is, the main building construct on FP are functions (even in those that support classes, like F#). 

Now, if you have worked your whole life on Object Oriented Programming (OOP), a function is a method that does not belong to a class. There is no state that can be used by the functions, and it depends exclusively on the data that is being passed as paramters.

In all their purity a function is supposed to have at least one parameter and will return something. A method can have no parameters a not return anything because it can easily be changing the state of the object to which it belongs (or really, some other object). 


### Side-effects

Side-effects is the main behaviour that FP tries to eliminate or handle. As a general idea, a side-effect is a change on the state of an element that has effect beyond the function.

Though, of course, full on pure programs are not really possible. Any interaction with input and output elements (screen, keyboard, printer). Different FP languages deal with this differently based on their upbringing:
  * Haskell confines side-effects to *Monads* (hard in theory, actually not that complicated to use). It tries to be as pure as possible, restricting the places where side-effects occur. 
  * Clojure, tries to limit side-effects to *do* statements. Less restrictive that the Monads of Haskell. But well differentiated. And because it supports Java libraries uses Ref and Atoms to provide object mutability. 
  * F# goes far more pragmatic, and completely allows you to use side-effects everywhere. If you function only creates side effects you will have to specify that your function returns *unit* **()** which is basically void in quite a few other languages.

### Classes and interfaces

Most of my work is done one 

### The winning moves.

The more you restrict side-effects, the easiest is to understand and predict the behaviour of a piece of code.

### The reduction
