---
layout: default
title: What is starvation? 
parent: Concurrency In Golang
nav_order: 6
---

# What is starvation? 

- Starvation happens when a process is deprived of necessary resources and is unable to complete its function.

- Starvation can happen because of deadlocks or inefficient scheduling algorithms for processes. Also, sometimes some greedy concurrent processes deny 
resources to other processes or adequate resources simply do not exist. Hence, in order to solve starvation, you should either have an independent entity 
as a resource manager or employ better resource-allotment algorithms which make sure that every process gets its fair share of resources.

![](https://raw.githubusercontent.com/sangam14/GopherLabs/master/img/sarving-go.png)

Hopefully by now, you would have become familiar with basic concurrency concepts
