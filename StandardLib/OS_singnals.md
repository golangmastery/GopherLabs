## Handling operating system signals

- Signals are the elementary way the operating systems communicate with the running process. Two of the most usual signals are called SIGINT and SIGTERM.These cause the program to terminate.

- There are also signals such as SIGHUP. SIGHUP indicates that the terminal which called the process was closed and, for example, the program could decide to move to the background.

- Go provides a way of handling the behavior in case the application received the signal. This recipe will provide an example of implementing the handling.

```
        package main

        import (
          "fmt"
          "os"
          "os/signal"
          "syscall"
        )

        func main() {

          // Create the channel where the received
          // signal would be sent. The Notify
          // will not block when the signal
          // is sent and the channel is not ready.
          // So it is better to
          // create buffered channel.
          sChan := make(chan os.Signal, 1)

          // Notify will catch the
          // given signals and send
          // the os.Signal value
          // through the sChan.
          // If no signal specified in 
          // argument, all signals are matched.
          signal.Notify(sChan,
            syscall.SIGHUP,
            syscall.SIGINT,
            syscall.SIGTERM,
            syscall.SIGQUIT)

          // Create channel to wait till the
          // signal is handled.
          exitChan := make(chan int)
          go func() {
            signal := <-sChan
            switch signal {
              case syscall.SIGHUP:
                fmt.Println("The calling terminal has been closed")
                exitChan <- 0

              case syscall.SIGINT:
                fmt.Println("The process has been interrupted by CTRL+C")
                exitChan <- 1

              case syscall.SIGTERM:
                fmt.Println("kill SIGTERM was executed for process")
                exitChan <- 1

              case syscall.SIGQUIT:
                fmt.Println("kill SIGQUIT was executed for process")
                exitChan <- 1
            }
          }()

          code := <-exitChan
          os.Exit(code)
        }
 ```
 output:
 
 Note: after running program press CTRL+C
 
 ```
 Biradars-MacBook-Air-4:golang-daily sangam$ go run main.go
^CThe process has been interrupted by CTRL+C
exit status 1
Biradars-MacBook-Air-4:golang-daily sangam$ 
 
 ```
 
 
 ## How it works…

- In an application, where the resources are acquired, a resource leak could happen in the case of an instant termination. It is better to handle the signals and take some necessary steps to release the resources. The preceding code shows the concept of how to do that.

- The Notify function from the signal package would be the one that helps us to handle the received signals.

- Note that the Notify function of the signal package is communicating with the goroutine by the sChan channel. Notify then catches the defined signals and sends these to goroutine to be handled. Finally, exitChan is used to resolve the exit code of the process.

- The important information is that the Notify function will not block the signal if the assigned channel is not ready. This way the signal could be missed. To avoid missing the signal, it is better to create the buffered channel.

- Note that the SIGKILL and SIGSTOP signals may not be caught by the Notify function, thus it is not possible to handle these.
