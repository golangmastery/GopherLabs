---
layout: default
title: sync package
parent: Concurrency In Golang
nav_order: 14
---


# The 'sync' Package

- So far, you are familiar with WaitGroups and Mutex from the sync package. Here are some other features in Go from the sync Package:
   - Pool: A Pool is a collection of temporary objects which can be accessed and saved by many goroutines simultaneously.
   - Once: A Once is an object that performs an action only once.
   - Cond: A Cond implements a condition variable which indicates thegoroutines which are waiting for an event or want to announce an event.


