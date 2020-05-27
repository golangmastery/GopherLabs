# Goroutine - Channel

Channels can be thought as pipes using which Goroutines communicate. Similar to how water flows from one end to another in a pipe, data can be sent from one end and received from the another end using channels. Sender and receiver in channels are blocking or synchronous.

### Declaring channel
Each channel has a type associated with, and this type is the type of data that the channel is allowed to transport. No other type is allowed to be transported using the channel.

for example 

`chan T` is a channel of type `T`

The zero value of a channel is `nil`, `nil` channels are not of any use and hence the channel has to be defined using `make` similar to maps and slices.


example of declaring `nil` channel of `int` type
```go
package main

import "fmt"

func main() {  
    var a chan int
    fmt.Println("declaring nil channel, this channel is not of any use")
    fmt.Println("value of channel a", a)
    fmt.Printf("Type of a is %T\n\n", a)

    fmt.Println("defining channel")
    a = make(chan int)
    fmt.Println("value of channel a now is", a)

}
```
[playground](https://play.golang.org/p/wQwnQPvdyP8) 


```
Output
declaring nil channel, this channel is not of any use
value of channel a <nil>
Type of a is chan int

defining channel
value of channel a now is 0x4300c0
```

we can also use `:=`, is a short assignment statement to declaring and defining channel.


```go
package main

import "fmt"

func main() {  
    a := make(chan int)
    fmt.Println("value of channel a", a)
    fmt.Printf("Type of a is %T", a)
}
```
[playground](https://play.golang.org/p/Z9hOeUEyAiu)


### Sending and receiving from channel
The syntax to send and receive data from a channel are given below

```go
data := <- a // read or received from channel a and stored in data.
a <- data    // write or send data to channel a.  
```

_The direction of the arrow with respect to the channel specifies whether the data is sent or received_

Sends and receive to a channel are blocking by default. What does this mean? When a data is sent to a channel, the control is blocked in the send statement until some other goroutine reads from a channel, the read is blocked until some goroutine writes data to that channel. 

This property type helps goroutine communicate effectively without the use of explicit lock of conditional variables which are quite common in other programming languages. 

below is example of using channel to create coordinate by communicating in between goroutines.

```go
package main

import (  
    "fmt"
)

func hello(done chan bool) {  
    fmt.Println("Hello world goroutine")
    done <- true
}
func main() {  
    done := make(chan bool)
    go hello(done)
    <-done
    fmt.Println("main function")
}
```
[playground](https://play.golang.org/p/mo-UkDH6Ygm)

The main goroutine will be blocked waiting for data on done channel. The `hello` goroutine receives this channel as parameter, prints `hello world goroutine` and then writes to the done channel. When this write is complete, the main goroutine receives the data from done channel, the control then is unblocked and the text `main function` is printed.
