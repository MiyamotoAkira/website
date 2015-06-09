---
layout: master
title: Unit Testing
---

Intro
-----

Let's going to start with my first absolute: You have to write unit tests. It bothers me that there are developers that they are against them (read ...). I believe, like Uncle Bob, that unit tests are a matter of proffesionalism (provide link). Not writing unit test is directly harming the code, is harming your fellow developers and harming your client/employer.

Levels of testing
-----------------

We know that there are multiple levels of testing. Security testing, acceptance testing, unit testing, integration testing ... and more (provide link 99 types of testing)

Each one is useful at a different abstraction level, and provide different benefits.

Integration testing, for example would guarantee that the work between different pieces of the application is as intended (this needs to be revised)

Unit tests do work at the lowest level. You are testing your algorithms on full isolation.

Benefits
--------

There are a few benefits that I have sen with unit testing. First, it does force me to write my code in such a way that complies with SOLID principles. The methods/classes are very focused and I inject whatever is needed by the method/class. Secondly, it completely stops regression bugs on tested code (and enough problems I had with those kind of bugs, difficult to explain to a client why a fixed bug has reappeared). It increases the speed at which I can add new code, as I don't have to go slowly checking that everything that was working before is still working. And gives me confidence on the code created: I know that is doing exactly what I though it was supposed to do.

Rebuttals(wrong word)
---------

There are a few rebuttals to the use of Unit testing.

It only guarantees that you are building the code right, not that your are building the right code. Which is absolutely true. Unit tests do not guarantee that you are writing the right code. But they are not supposed to. That is why you have acceptance tests.

Having 100% coverage of unit testing means that you are going to spend a massive amount of time cearing tests. Aiming for 100% coverage is not very wise. First, the quality of the tests is more important than the number of them. Second, we have the  Halting problem, which should stop you from even trying to spent more time than needed with tests..

My current workflow
-------------------

I actually have two different workflows. Depending on they type of application i am doing and who is the client/customer.

My first one is the full guacamole. I start creating the acceptance tests. On C# my tool of choice is Specflow. Depending on the internal needs I would create or not unit tests. How do I know? Well, the first step is always to create the simplest code to pass the first acceptance test. Properly done, that code should not be complicated. Once the second acceptance test comes around I will reason if the code increases its complication factor. At that point I will start writing unit test. Third acceptance test comes around, and if I need to start dividing my code into multiple namespaces/projects/packages then I will start working on integration tests. And I will keep going until I'm done with all the acceptance tests.

The second one I reserve for my own code done at home on small projects. On those cases I usually create just unit tests.

On both cases I write some kind of test before I write the actual code.