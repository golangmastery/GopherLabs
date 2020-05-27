
# init Function

Identifier _main_ is ubiquitous. Every Go program starts in a package _main_ by calling identically named function. When this function returns the program end its execution. Functions _init_ also play special role which are defined in package block and are usually used for:

* variables initialization if cannot be done in initialization expression.
* registering.
* running one-time computations.

init() function will be executed first before main function
```go
package main

import "fmt"

func main() {
    fmt.Println("main() will run second")
}

func init() {
    fmt.Println("init() will run first")
}

```
[playground](https://play.golang.org/p/y6R1UEn9trt)

If we run the code it will give us result
```
Output
init() will run first
main() will run second
```

init() function to use for variables initialization.

given two examples, the first example is code without init() function.
```go

package main

import "fmt"

var weekday string

func main() {
    fmt.Printf("Today is %s", weekday)
}
```
[playground](https://play.golang.org/p/JHYP4EZ0T6X)

In this example, we declared a global variable called weekday. By default, the value of weekday is an empty string.

Because the value of weekday is blank, when we run the program, we will get the following output:

```
Output
Today is
```

We can fill in the blank variable by introducing an init() function that initializes the value of weekday to the current day.

the second example is code with init() function.

```go
package main

import (
    "fmt"
    "time"
)

var weekday string

func init() {
    weekday = time.Now().Weekday().String()
}

func main() {
    fmt.Printf("Today is %s", weekday)
}
```
[playground](https://play.golang.org/p/kaoptt-omic)


Now when we run the program, it will print out the current weekday:
```
Output
Today is Tuesday
```

init() as properties 

_init_ function doesn't take arguments neither returns any value. In contrast to main, identifier _init_ is not declared so cannot be referenced.

```go
package main

import (
    "fmt"
)

var weekday string

func init() {
    fmt.Println("hello init")
}

func main() {
    init()
}
```
[playground](https://play.golang.org/p/vXIkd6pa0V4)

When we run it will give the result of error 

```
/prog.go:14:5: undefined: init
```

Many _init_ function can be defined in the same package or file 

```go
package main

import "fmt"

func init() {
    fmt.Println("init in 1")
}


func init() {
    fmt.Println("init in 2")
}

func main() {
    fmt.Println("main")
}
```
[playground](https://play.golang.org/p/2k1Zw1_OoE3)

When we run the code it will give the result

```
Output
init in 1
init in 2
main
```




