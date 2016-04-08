---
title: Features for project structure
date: 2016-03-03 23:00:00
---

### Setup

A few days ago, I made a presentation about using layers vs features as a way to structure code at my work place. I have originally seen the idea on this <a href="https://vimeo.com/131633177">presentation</a> of NDC Oslo by XXX. It was one of these ideas that immediatly made the tiny bulb on my head go on.

Of course, I played a bit around and made my own presentation to understand how this works (I like using the preparation of presentation/tutoring to force myself to acquire better knowledge). You can find the presentation at <a href="https://github.com/MiyamotoAkira/FeaturesVsLayers">my github account</a>. This post, then, is a companion/rehash to it.

### The issues with layers

You have to understand here that most of my work has been done, so far, on *C#*, a static language. When I say project, you can consider it a module, or a library, in another language.

The most common way (at least on my experience) to do layer separation is to create separate csproj files. One per layer. Then you point from one to the other. This has some major consequences: 

- first: The amount of interfaces that proliferate is massive if you try to follow <a href="https://en.wikipedia.org/wiki/SOLID_(object-oriented_design)">SOLID</a> closely
- second: If you need to modify interfaces and implementations of code that affect parts of the system that shouldn't be touched.
- third: If a specific flow doesn't need a layer either you need to add an additional reference to the layer below, or you create some dummy code to just pass the information.

Verbosity is a problem on static OO languages without Type Inference. Furthermore, you have to be careful about what interfaces you create if you follow *SOLID*. You can use delegates instead of interfaces. If you declare the delegates to give them a name, you achieve the same as interfaces with a single method. You barely reduce the verbosity. If you are use dynamic languages, the problem dissapears.

The second and third points are a reflection of using layers to architecture your system. Which, the more I use, the less correct it appears to me.

### A Solution?

Feature based architecture is what I found as a possible solution to the issues I have mentioned. Each feature that you want to use is an **encapsulated** project. At most, the feature will have dependencies on your database project, and the only piece that will depend on it will be the part of your application that will need to call the feature.

Again, this is mostly from my work trying to do REST Apis on C#, so on that situation the controller classes of my WebAPI project will be the ones that will depend on the features. All information will be passed down to the feature.

With this I achieve that the code that each feature has is not mixed with the code of other features. Taking away a single feature is just eliminating the dependency on my controller class and eliminating the project. Any change will only affect the specific feature project (unless, of course, there is a change on the underlying datastore that I need to take into acount).

Interestingly, each feature could still have layers, as you could subdivide the feature based on classes/methods/functions that separate the concerns of the layers. But they would not control the structure of your solution. The layers would become an implementation detail.

### Issues

**Duplication**

You will see some more "duplicated" code. Funnily enough, the reason that I started looking into features was some deduplicated code, that had *if* statements inside. That didn't sit very well with me. I realized that duplication doesn't meant two pieces of code that are the same. Duplication means code that does the same job and change for the same reasons. But still, it could very well happen. Therefore, you have to check what code is repeated, and if it makes sense to take it out into a separate project.

**Number of Features**

One issue that you will find is that you go very granular  (in case of kind-of-REST Apis I was working on, that meant one feature per endpoint/verb combination), you could have an explosion of feature projects if the REST api is broad. Is it a bad thing? Certainly could mean that you could need too much injection on your controllers. So maybe does require thinking how you subdivide your controllers. Furthermore, Visual Studio started to strugle at some point with the number of projects: I had at some point a solution that had 102 projects, that took ages to compile. Not very proud of it.

**Suitability**

What about working on other projects, let's say a desktop GUI application? Will it make sense to use features there? I haven't tried it yet. Hence, I couldn't say. I am interested on having a go in WPF or Kivy to see how it goes.
