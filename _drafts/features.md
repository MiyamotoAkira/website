---
title: Features for project structure
date: 2016-03-03 23:00:00
---

### Setup

A few days ago I made a presentation about using layers vs features as a way to structure code. I have originally seen the idea on this <a href="">presentation</a> of NDC Oslo by XXX. It was one of these ideas that immediatly made the tiny bulb on my head go on.

Of course, I played a bit around and made my own presentation to understand how this works (I like using the preparation of presentation/tutoring to force myself to acquire better knowledge). You can find the presentation at <a href="http://github.com/MiyamotoAkira/featuresvslayers.git">my github account</a>. This post, then, is a companion to it.

### The issues with layers

You have to understand here that most of my work has been done, so far, on C#, a static language. When I say project, you can consider it a module, or a library.

The most common way (at least on my experience) to do layer separation is to create separate csproj files. One per layer. Then you point from one to the other. This has some major consequences:
* first - If you need to add some new functionality you have to recompile the whole layer project
* second - The amount of interfaces that proliferate are massive if you try to follow <a href="http://wikipedia.org/SOLID">SOLID</a> closely
* third - Because of the previous, you are modifying interfaces and implementations of code that affect parts of the system that shouldn't be touched.
* fourth - If a specific flow doesn't need a layer either you need to add an additional reference to the layer below, or you create some dummy code to just pass the information.

The first issue is easy to overcome. Without strong signing you can just drop the dll and restart. With strong signing you need to set up binding redirects and then restart.

Verbosity is a problem on static OO languages without Type Inference. Furthermore, you have to be careful about what interfaces you create if you follow <a href="http://wikipedia.org/SOLID">SOLID</a>.

Delegates instead of interfaces. You can declare the declare the delegates to give them a name, you achieve the same as interfaces with a single method.

### A Solution?

Features is what I found as a possible solution to the issue. Each feature that you want to use is an encapsulated project (or module, or however is called on the language that you are using). At most, the feature will have dependencies on your database project/module, and the only piece that will depend on it will be the part of your application that will need to call the feature.

Again, this is mostly from my work trying to do REST Apis on C#, so the controller classes of my WebAPI project will be the ones that will depend on the features. All information willb e passed down to the feature.

With this I achieve that the code that each feature has is not mixed with the code of other features. Taking away a single feature is just eliminating the dependency on my controller class and eliminating the project. Any change will only affect the specific feature project (unless, of course, there is a change on the underlying datastore that I need to take into acount).

Interestingly, each feature will still have layers. But they will not control the structure of your solution.

### Issues

**Duplication**

You will see some more "duplicated" code. Funnily enough, the reason that I started looking into features was some deduplicated code, that had if statements inside. Didn't sit very well with me. I realized that duplication doesn't meant two pieces of code that are the same. Duplication means code that does the same job and change for the same reasons. But still, it could very well happen. Therefore, you have to check what code is repeated, and if it makes sense to take it out into a separate project.

**Number of Features**

One issue that you will find is that you go very granular  (in case of kind-of-REST Apis I was working on, that meant one feature per endpoint/verb combination), you could have an explosion of features if the REST api is broad.

**Suitability**

What about working on other projects, let's say a desktop GUI application? Will it make sense to use features there? I haven't tried it yet. So I couldn't say. I am interested on trying to get something done with WCF or Kivy to see how it goes.
