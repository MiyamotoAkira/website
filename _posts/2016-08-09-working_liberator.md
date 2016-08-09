---
title: First working Liberator mini-project
date: 2016-08-09 20:30
excerpt: My first working Liberator mini-project, with a minimal amount of work being done, A Get and a Post
tags:
- REST API
- Clojure
- Liberator
---

### Weeeeeeee!

Finally my first working [Liberator](https://clojure-liberator.github.io/liberator/) project. You can find the code [here](https://gist.github.com/MiyamotoAkira/042dae266584936d8c56a8933158de6a). The rest is just adding the correct dependencies and plugins into your project.clj

So, why so happy? The Liberator documentation doesn't make it easy to understand a few elements. I think their documentation stands to improve a little, and will be communicating with them about it. Some of it I think it is due to me not being profficient enough on Clojure (which could mean other starters could have the same issues). Because I have been just dabbling in Clojure for a while, I have not internalized yet the mind mapping and the grammar of the language. But on it I am.

### The program

The program is a very easy API. It allows you to add the body-contents from the incoming JSON into a collection, and then retrieve all the data that you have added into the collection.

The important fact about the program is that I have tried to write the absolute minimum for an endpoint that will admit some json on the body of a POST request. There is nothing else in there. No data validation, no authorization, no external storage. I did think about being a little more clever with the `post!` function, but then I though I would loose some readability.

### The code

I will explain top to bottom to understand what is going on. You will see how uncomplicated is. 

First we have the setup of the namespace where the below code resides:

{% highlight clojure %}

(ns libtest2.core
  (:require [liberator.core :refer [defresource]]
            [liberator.dev :refer [wrap-trace]]
            [compojure.core :refer [defroutes ANY]]
            [clojure.data.json :as json]
            [clojure.java.io :as io]))
			
{% endhighlight %}

From Liberator we use a macro and a function. Resources is what Liberator uses to execute your code. A resource is a ring handler (basically, a function with a single argument and a map), an on it you can modify all the hooks that you want to deal with. Otherwise the default behaviour for that hook is being used. `defresource` is just a macro that allows you to give a name to the resource you have defined. `wrap-trace` will allow you to send back information on the response used for debugging.

From Compojure we have `defroutes` and `ANY`. The former allows you to define the routes that your application is going to answer to. The later is used to indicate which verbs a route is going to answer to. On this case, any verb. I think this is the first point in which you could find a decision taken in Liberator that is a bit of a trade-off. You have two places where you can indicate the allowed http verbs. In the route definition you can use Compojure decision making. Inside your resource there is `:allowed-methods` to specify which verbs the resource is going to handle. Doing the decision in one side or the other could change sligthly your code (no major difference so far in my brief experience). Two possible reasons to have it designed like this:

1. For completeness purpose of the decision flow of Liberator
2. In case Compojure is not used for routing
	
I do prefer to keep (at least at the moment) the verb check with the resource. So I am using `ANY` on my initial tries with Liberator.

`io` and `json` are used to read and write json from the request and into the response. They are standard libraries for Clojure.

### The meat of the code

Then the code goes:

{% highlight clojure %}

(defonce appointments (ref []))

{% endhighlight %}

This declares a single mutable variable that will be declared only once while the code is running. It will store the values that we are posting (on this case will be the name of the person that is making and appointment). For production level code you wouldn't do it this way. You would have some better storing (memcache, redis, couchbase, sql, ...). But, for the purposes of creating this simple example of Liberator, is more than enough.

Then comes the definition of the resource.

{% highlight clojure %}

(defresource handle-appointments []
  :allowed-methods [:post :get]
  :available-media-types ["application/json"]
  :post! (fn [ctx] (let [body (get-in ctx [:request :body])
                        converted (slurp (io/reader body))
                        data (json/read-str converted :key-fn keyword)]
                    (dosync (alter appointments conj {:name (data :name)}))))
  :handle-ok (fn [_] (json/write-str @appointments)))
  
{% endhighlight %}
  
Interesting fact over here: Samples on the Liberator page don't use a parameter vector in the definition. But if I don't put it I kept getting complaints that the resource cannot be casted to an `iFN`

As you can see, what I'm defining on the resource is a collection of key/value pairs. The keys are defined by Liberator, and while executing its decision flow it will check each possible key to see if we have overrided the behaviour with our own code or if it executes the default behaviour. You can find the massive svg with the whole flow at the [decision graph](https://clojure-liberator.github.io/liberator/tutorial/decision-graph.html) page.

`:allowed-methods` has been explained before, and `available-media-types` will indicate what kind of data can be returned.

`:handle-ok` will be executed whenever Liberator is going to return a 200 http message. Here we are just returning the contents of appointments as a json object. It needs to be setup as a function, because on same cases the results returned will be based on the state of the system at compile time. Although I'm ignoring the parameter passed in this case, that parameter is the context of the http request. You will have several handle keywords, for different possible responses. Couple of examples, you wil have `:handle-delete` and `:handle-created` to deal with DELETE and POST requests that are ok.

`:post!` is an action that will be executed when the POST verb is the action used on the request. Like `:handle-ok` above a function that receives the context of the call will be used. What I'm doing here is quite simple. We first retrieve the body of the request, then we convert it into a string and finally we transform it into a map. If you are new to Clojure or using json in clojure you have to pay attention to the keyword `:key-fn` used on the `json/read-str` function call. `key-fn` will receive a function. On this case we are passing a predifined function called `keyword`. Is this function that will convert the json read into a map with the field names as keys. Finally, we are just using the semantics of ref to add whatever the contents are (on this case name) to the appointments collection. Finally, we just alter the appointments vector to add the new data.

### Making it all available

Next step that we have is the route definition

{% highlight clojure %}

(defroutes app
	(ANY "/appointments" [] (handle-appointments)))
	
{% endhighlight %}

For any verb request that targets the endpoint *appointments* we will call `handle-appointments`. On this case, we are not extracting any information from the route, so the vector of parameters is empty.

Finally, we just call the app route definition from

{% highlight clojure %}

(def handler
	(-> app
		(wrap-trace :header :ui)))
		
{% endhighlight %}

The only special thing that we are doing is adding the tracers. `:ui` will produce html on the response if there has been an exception throw in your application. If no exception is raised, `:header` will add two liberator headers to the response: *X-Liberator-Trace-Id*, which will show the id given to the request; and *X-Liberator-Trace* in which it will show all the decisions taken and their result, which is quite nice to use to debug why something has not been executed as expected.

### The results of the calls

If you call the endpoint */appointments* with a POST request with body **{"name": "jorge"}** a result of 201 plus a filled *X-Liberator-Trace* should be returned. If you then call GET, then a 200 with body response of **[{"name": "jorge"}]** should be returned.

### Conclusion

Again, a very simple example of Liberator with GET and POST requests. Enough to understand the basic concepts of Liberator, and build on top of it. And also to understand how easy it makes the creation of APIs.
