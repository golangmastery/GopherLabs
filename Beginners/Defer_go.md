# Defer 

A defer statement defers the execution of a function until the surrounding function returns.

The deferred call's arguments are evaluated immediately, but the function call is not executed until the surrounding function returns.


```
package main

import "fmt"

func main() {
	defer fmt.Println("world")

	fmt.Println("hello")
}
```
[Go Playground](https://play.golang.org/p/GBzCn3hH39K)

output:

```
hello 
world 

```

in this above program if you use ``` defer ``` keyword it will not execute until the surrounding function returns 


