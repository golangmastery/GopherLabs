# Goroutine - Buffered Channel

Buffered channels have capacity and only block when the buffer is full. Buffer size can be specified during declaration:

- `bc := make(chan int, 10)` makes an `int` channel with size `10`.

Using buffered channels we can send and receive in main:

Below is example for buffered channels.


``` go

package main

import "fmt"

func main() {

    fourChan := make(chan int, 2)

    // Send 10 to channel
    fourChan <- 10
    fmt.Printf("Sent %d to channel\n", 10)

    // Receive int from channel
    // We can also receive directly
    fmt.Printf("Received %d from channel\n", <-fourChan)
}
```

```
Output
Siva@SIVA-laptop MINGW64 /d/VS code/Golang/learngo
$ go run buffered_channel.go
Sent 10 to channel
Received 10 from channel
```

If the channel goes over capacity, we get fatal runtime error.
[playground](https://play.golang.org/p/wQwnQPvdyP8) 

