---
title: Wat Considerations
date: 2016-07-17 18:01
excerpt: A language shouldn't surprise you. The more surprises you get, the more difficult is to write correct code.
---

### Wat?

A few months back, I put a post called [Wat Weirdness]({% post_url 2016-04-15-wat-weirdiness %}). It was motivated because in a single week I saw the video linked in the post and I learned about the issue with the Java integer optimization.

One of the multiple things that have always annoyed me of JavaScript and PHP (I have used the first professionally, not the second), is the amount of *wat* weirdness that is present. In a totally unscientific estimation, I haven't used any language with as many strange cases and outright weirdness as JavaScript. Every language has some (after all, it tends to be a question of trade-offs), but with a well designed language those tend to be reduced or diminished.

I believe that the more weirdness present, the more difficult is to program in a language (the more cases you have to remember), the more difficult is to read, and the more probabilities are of creating bugs.

### Choosing a language

I have another post title [Shaving]({% post_url 2015-08-31-shaving %}) about using the correct tool for the job. The language that you use should be great for the problem at hand. You shouldn't use a single language for everything. Elements to take into consideration are: how the language maps to the domain of the problem, size of the language (I prefer smaller languages), size of the code produced (the less code the better), performance of the compiled/interpreted code, and, as you may have guessed by the subject of this post, number of *wat* cases of the language.

### Javascript and PHP cases

I am of the belief that, if you are working on a greenfield project, you should never choose Javascript nor PHP as languages. For the latter one there are a myriad of options available. For the former, you should treat it like Assembly. Use a better language (ELM, Clojurescript, something else) and forget about JavaScript altogether. My code compiles into machine code, IL, Bytecode. I barely look into it, unless there is a need to get that 0.1% performance improvement. You should treat JavaScript the same.


### Big Languages

I mentioned before that the size of the language is a factor to take into account. The first thing to consider is that photo comparing "JavaScript: The Definitive Guide" with "JavaScript: The Good Parts". Our minds have limits about how much they can juggle on the active side of memory. The bigger surface of the language, the more difficult is to know everything that is available or currently happening (hey, one of the reasons why the Single Resposibility Principle is important). The bigger the surface of the language, the more *wats* are you going to find. The bigger the surface, the more different possibilities to do the same and the more knowledge you need to have.

One of the reasons I like Clojure is because the language itself is very small. There is not much that you need to remember to have full knowledge of it. Most of the constructs that you are using are, in fact, functions and macros created out of the basic set. In that regards, is a very well designed language.

### Conclusion?

Use the right language. Choose one that will make your life and the life of the ones coming behind easier. Don't get stuck on the single one you know.
