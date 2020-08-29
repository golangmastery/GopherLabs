# Concurrency vs. Parallelism

A lot of people confuse concurrency with parallelism because they both somewhat imply executing code simultaneously 
but they are two completely different concepts. This lesson will help you clear up some misconceptions caused by developers 
using these concepts interchangeably.

## "Concurrency is about dealing with lots of things at once.
## Parallelism is about doing lots of things at once"


# What is parallelism?

- Parallelism is when we break up a task into subtasks and execute them simultaneously. Each of the subtasks is independent and may or may not be
related. In short, we carry out many computations at the same time in parallelism.

- The multicore processor in your computer is an example of parallelism where parallel tasks are run on multiple cores to solve problems. In this way, parallel 
computing helps us solve large problems efficiently by using more than one CPU to execute multiple computations at the same time, which saves time in the case of 
large datasets.

- However, parallel programming is hard to achieve as we need to ensure the independence of tasks when it comes to dividing the problem and sharing the data.
This is where concurrency comes into play! Concurrency and Parallelism are not the same but are closely related to each other.

## "Concurrency is about structure.
## Parallelism is about execution."

When we say that parallelism is about the execution of tasks that are independent of each other, we first need to create these independent 
tasks through concurrency. That is what we do when we design and structure a big problem into smaller problems which can be solved independently. 
Concurrency will ensure that these independent tasks are able to coordinate and synchronize with each other 
such that we get the correct final result. Therefore concurrency has to be there for parallelism to exist.

## Example: Let’s Go to Work! 
Let’s draw a scenario to compare and contrast between concurrency and parallelism:<br>
After waking up in the morning, you have to get ready to go to work. Let’s divide this scenario into four steps: <br>
1. Getting ready (Washing your face, changing clothes etc) <br>
2. Preparing breakfast <br>
3. Eating breakfast <br>
4. Going to the office <br>
