---
title: Clojure, Liberator and Emacs
date: 2016-08-04 09:00
excerpt: A quick recount of my current state trying to get a rest API working using Liberator.
---

## The Background

I like creating good simple solutions to problems. Most of the time is difficult because I work on code already written and working, and is difficult to break those monoliths into something more appropriate. I don't think certain languages help on that regard. I wish the whole *.Net world* moved to [F#](http://fhsarp.org) just because of the impossibility of creating circular dependencies inside a library. How annoying is that.

At my previous work it kind of fell on me the need to setup the rules to create REST APIs, as our new Dev Director wanted to move into the direction of SOA (ok, I was looking for a revamp of our system, so I kind of put a foot forward). It was interesting because I have no previous experience, and as far as I could gather, no one else on the company had (later on, some clever people, that worked with the Dev Director before, came to the company). So a "Rest in Practice" book and a few videos later, I actually had a basic idea of what I was doing. And I loved it. The easiness of doing separation of concerns, reducing the possibility of creating very dependent monsters is amazing. Furthermore, it made very easy for teams to work fully independent of each other (as long as the contract was respected, of course). REST APIs are not appropriate for all systems, though. Sometimes, a Majestic Monolith (TM DHH) is what you actually need. Sometimes what you want are channels. Sometimes, is something else.

## The Language

I love [Clojure](http://clojure.org/). I am not as proficient with it as I should be taking into account when I started dabbling on it. But never had the opportunity of doing it professionally. And I am a better worker at the office that I am at home. But the language, its simplicity (I do have simplicity in high esteem), the easiness on which certain algorithms can be written, and its immutability, are fantastic. It takes a bit to get around FP if you haven't done it before, and probably the parenthesis use could throw you a bit off (though, compared to other lisps, Clojure does use far less, as it uses curly and square brackets to complement). But that shouldn't stop you from trying it. I think Rich Hickley created a very well crafted language. And so far the *wat* surprises have been reduced to a minimum. I want to create some big application on it, though, to learn if the language idiosyncrasies and shortcomings get in the way (I feel lately this happening on C#)

## The Framework/Library

I have read before that on Clojure you have libraries that you use rather than frameworks. [Liberator](http://clojure-liberator.github.io/liberator/) provides a specific flow of actions to be taken but is actually a library, not a framework and, therefore, does the one thing, and the rest is up to you. It was created based on Ring, which is the de-facto standard htpp library on Clojure. Other than that you are free to use whatever you want to create your API. Freya is trying to do something similar on the F# space. My first two attempts on it have been pure disasters, but keep learning new things, and I'm starting to believe that for the quick creation of a REST APIs is superb (definitely much quicker than trying to use WebAPI on .Net). The way that resources are defined makes it very easy to follow all the possible options that will happen to it.

Look at this example from the Liberator page:

{% highlight Clojure %}
(defresource entry-resource [id]
  :allowed-methods [:get :put :delete]
  :known-content-type? #(check-content-type % ["application/json"])
  :exists? (fn [_]
             (let [e (get @entries id)]
                    (if-not (nil? e)
                      {::entry e})))
  :existed? (fn [_] (nil? (get @entries id ::sentinel)))
  :available-media-types ["application/json"]
  :handle-ok ::entry
  :delete! (fn [_] (dosync (alter entries assoc id nil)))
  :malformed? #(parse-json % ::data)
  :can-put-to-missing? false
  :put! #(dosync (alter entries assoc id (::data %)))
  :new? (fn [_] (nil? (get @entries id ::sentinel))))
  
{% endhighlight %}

I think that the above code makes quite clear what are the possible things happening to the resource. You still need to learn the order on which the actions are being handled but, on their page, Liberator provides an svg with the diagram of decisions.

## The IDE

I was interested for a long while on giving a try to both [Emacs](https://www.gnu.org/software/emacs/) and [Vim](http://www.vim.org/). While choosing an IDE for Clojure I did try [Counterclockwise](http://doc.ccw-ide.org/) for Eclipse. But I never really got into Eclipse, didn't like the way it worked. So I decided to try Emacs. And, oh boy, do I like Emacs. I must admit that after a bit I gave up and had a look at Vim. But due to a Pair Programming session at the London Software Craftsmanship Meetup I went back to Emacs (I still use Vim when I'm on the terminal and don't want to switch back to Emacs). Full on text manipulation, and barely any clutter on the screen are fantastic. But the ability to do everything by typing and the ability to define everything with shortcuts is the selling point. Whenever I go to Visual Studio and I need to pick the mouse I get annoyed. Of course, Emacs isn't perfect. With great power comes great configuration issues. In part is due to my lack of expertise on Emacs, but I do keep having troubles with configuration. Spent a while having issues with the configuration for [Cider](https://cider.readthedocs.io/en/latest/). And once I was done with it, I was having some other trouble which was related to the use of packages (and was solved first by reverting my changes and then the awesome M-x describe-function). But I'm ok paying the price, whenever I manage to get the rhythm Emacs is transparent to your coding efforts, it doesn't get in the way, like other IDEs that I have tried (Vim is another case in which your editor doesn't stop your flow)


## The Work

What I'm currently trying to do first is an API to handle queues of work. The QA at my current work use Skype for saying who is merging into Main (let's not go into what is wrong there this time, but here we are to fix it), and then put results back. But who wants to use Skype when Slack rocks? (Well, if you are an OS project, you shouldn't) I'm currently pushing for people to use, we are adding integrations and soon Slack will be tailored exactly to our needs (Well, I still need to get a VM so I can get the /pug bomb ready)

The basic idea idea is very simple: a couple of endpoints to add to the queue and to post results, and one to see the current state of the queue. The more interesting part will be to create the slack integration, which I am looking forward to. Probably will start with the slash command move, but would love to move into the full bot experience.
