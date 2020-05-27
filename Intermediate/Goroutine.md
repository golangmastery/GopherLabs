# Goroutine

Goroutines are functions or methods that run concurrently with other functions or methods. Goroutines can be thought of as light weight threads.

### creating goroutine
To create goroutine, just simply use prefix function or method call with the keyword `go` and you will have a new goroutine running concurrently.

lets see example below,

```go
package main

import (  
    "fmt"
)

func hello() {  
    fmt.Println("Hello world goroutine")
}
func main() {  
    go hello()
    fmt.Println("main function")
}
```
[playground](https://play.golang.org/p/KUvIpVzepjs)


The `go hello()` syntax tell the program that we are creating a new goroutine. Now the hello() function will run concurently along with main() function. The main function runs in its own goroutine and its called main goroutine.


```
Output
main function
```

The output program will only print text `main function`. What happened to the goroutine we started? We need to understand two main properties of goroutines to understand why this happens.

* When a new goroutine is started, the goroutine call returns immediately. Unlike functions, the control does not want for the goroutine to finish executing (blocked). The control returns immediately to the next line of code after the goroutine call and any return values from the goroutine are ignored.

* The main goroutine should be running for any other goroutine to run. If the main goroutine terminates then the program will be terminated and no other goroutine will run.

let's update the code so the `hello` goroutine will have space of time to perform its action. 

```go
package main

import (  
    "fmt"
    "time"
)

func hello() {  
    fmt.Println("Hello world goroutine")
}
func main() {  
    go hello()
    time.Sleep(1 * time.Second)
    fmt.Println("main function")
}
```
[playground](https://play.golang.org/p/4nT_Q6CuGrp)


```
Output
Hello world goroutine
main function
```

We are adding `sleep` method of time package which sleeps the main goroutine for 1 second so the `go hello()` will have enough time to execute before the main goroutine terminates.


_This way of using sleep in the main goroutine to wait for another goroutine to finish their execution is a hack, there are several ways to operate coordination between goroutines that is :_
* channel
* mutex
* waitGroup

