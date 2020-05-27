# Goroutine - Mutex

The Mutex (mutual exclusion lock), at its core, it allows you to ensure that only one goroutine has access to a block of code at a time, with all other goroutines attempting to access the same code having to wait until the mutex has been unlocked before proceeding


let's see the example

```go
var mu sync.Mutex
var sum = 0

func add(a int) {
    mu.Lock()
    sum = sum + a
    mu.Unlock()
}
```

In above example, if two goroutines call the add function, only one can proceed at a time. When Lock is called on the mutex, it ensures that no other goroutine can access the same block until Unlock is called.

### Race condition
The primary purpose of a mutex is to prevent race conditions, whereby two or more goroutines access and/or modify the same state with varying outcomes based on the order of execution.

lets check at an example below

```go
package main

import (
        "fmt"
        "sync"
)

var wg sync.WaitGroup
var sum = 0

func process(n string) {
        wg.Add(1)
        go func() {
                defer wg.Done()

                for i := 0; i < 10000; i++ {
                        sum = sum + 1
                }

                fmt.Println("From " + n + ":", sum)
        }()
}

func main() {
        processes := []string{"A", "B", "C", "D", "E"}
        for _, p := range processes {
                process(p)
        }

        wg.Wait()
        fmt.Println("Final Sum:", sum)
}
```

```
Output
From E: 10000
From A: 20000
From D: 30188
From C: 41800
From B: 47166
Final Sum: 47166
```

_Run this program in your local as the playground is deterministic and the race condition will not occur in the playground._

The outcome will vary, in fact each execution you’ll likely get a different outcome, but the issue is the same: we didn’t get a total sum of 50,000 like we expected. So what happened? We can see in the sample output above that the E and A goroutines ran properly, but we started getting into trouble around D. This is because the goroutines can’t finish fast enough before the next routine begins, and a data race begins where each goroutine is modifying the sum value at the same time. If we ran this only 100 or 1000 times, we likely wouldn’t notice any issues, however as the goroutines take longer and longer, more data races occur and we get into trouble really quick.

### Adding mutex
There is only one option on how to fix race condition code, that is to add a mutex. We’re only going to make two changes, but it will completely change the outcome of the program.

* Define a Mutex
* Add lock and unlock calls around the addition to sum

```go
var mu sync.Mutex

// In "process"
mu.Lock()
sum = sum + 1
mu.Unlock()
```

The full code can see below 

```go
package main

import (
        "fmt"
        "sync"
)

var wg sync.WaitGroup
var mu sync.Mutex
var sum = 0

func process(n string) {
        wg.Add(1)
        go func() {
                defer wg.Done()

                for i := 0; i < 10000; i++ {
                        mu.Lock()
                        sum = sum + 1
                        mu.Unlock()
                }

                fmt.Println("From " + n + ":", sum)
        }()
}

func main() {
        processes := []string{"A", "B", "C", "D", "E"}
        for _, p := range processes {
                process(p)
        }

        wg.Wait()
        fmt.Println("Final Sum:", sum)
}
```

```
Output
From A: 38372
From C: 38553
From E: 42019
From D: 48251
From B: 50000
Final Sum: 50000
```

So how does this work? Each time we call Lock, all other goroutines must wait before executing the same code, until the processing goroutine unlocks the mutex by calling Unlock. Lock is a blocking operation, so the goroutine will sit idle until the lock can be acquired, ensuring that only one goroutine ever has the ability to add to sum at a time.

### Tips and Trick

#### - Idiomatic definition
Because a mutex doesn’t directly relate to a specific variable or function, it is idiomatic in Go to define the mutex above the variable it is applicable to. For instance, if we had a Processor struct for the example above, we’d define it like so


```go
type Processor struct {
    // Related  
    mu sync.Mutex
    sum int
    anotherVar int
    yetAnotherVar int
    
    // Not related
    somethingElse int
}
```

By defining the mutex directly above the variable(s) it relates to, we are signalling to other developers that the mutex is used to protect access to these variables.

#### - Deferred unlocks
In more complex software than the trivial examples above, where the function that calls Lock has various places to return, or the entire function must be locked, it is common to use a defer to ensure Unlock is called prior to the function returning, like so:


```go
func process() {
    mu.Lock()
    defer mu.Unlock()
    
    // Process...
}
```

This ensures that no matter what branch the code takes inside the function, Unlock will always be called. As a bonus, we can add code to the function without worrying we may miss a case where Unlock must be called.


### Deadlocks

#### - Forget to unlock
It is absolutely crucial to call Unlock! If you don’t all other goroutines will wait indefinitely for the Unlock call, meaning they will never proceed and the program will grind to a halt.


```
fatal error: all goroutines are asleep - deadlock!

goroutine 1 [semacquire]:
sync.runtime_Semacquire(0x1f6b7c, 0x876e0)
	/usr/local/go/src/runtime/sema.go:47 +0x40
sync.(*WaitGroup).Wait(0x1f6b70, 0x1)
	/usr/local/go/src/sync/waitgroup.go:127 +0x100
main.main()
	/tmp/sandbox022115118/main.go:35 +0x160
```

#### - Multiple calls to lock
Calling lock from multiple places on the same Mutex. It’s possible that Lock is called by the same goroutine that already has the lock prior to it being unlocked, we’ll end up in another deadlock situation.

```go
package main

import (
        "fmt"
        "sync"
)

var mu sync.Mutex

func funcA() {
    mu.Lock()
    funcB()
    mu.Unlock()
}

func funcB() {
    mu.Lock()
    fmt.Println("Hello, World")
    mu.Unlock()
}

func main() {
    funcA()
}
```
[Playground](https://play.golang.org/p/c2Qgo-W_4mP)

```
Output
fatal error: all goroutines are asleep - deadlock!

goroutine 1 [semacquire]:
sync.runtime_Semacquire(0x1043411c, 0x1)
	/usr/local/go/src/runtime/sema.go:47 +0x40
sync.(*Mutex).Lock(0x10434118, 0x0)
	/usr/local/go/src/sync/mutex.go:83 +0x200
main.funcB()
	/tmp/sandbox352026507/main.go:17 +0x40
main.funcA()
	/tmp/sandbox352026507/main.go:12 +0x40
main.main()
	/tmp/sandbox352026507/main.go:23 +0x80
```

The reason for this is that funcB, running in the same goroutine as funcA, tries to acquire a Lock on the same Mutex that funcA already locked. Because Lock blocks until the lock can be acquired, we’ll never reach the Unlock in funcA, and the program halts.
