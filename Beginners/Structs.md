---
layout: default
title: Structs
parent: Golang for Beginners
nav_order: 24
---

# Structs
A struct is a collection of fields.


we are creating xy struct with X and Y fiels.
```
type xy struct {
	X string
	Y string
}
```
[Go Program](https://play.golang.org/p/ffvPEWNpNvW) 
```
package main

import "fmt"

type xy struct {
	X string
	Y string
}

func main() {
	fmt.Println(xy{"x", "y"})
}
```
