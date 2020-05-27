## Shutting down the application gracefully

- Servers and daemons are the programs that run for a long time (typically days or even weeks). These long-running programs usually allocate resources (database connections, network sock) at the start and keep these resources as long as they exist. If such a process is killed and the shutdown is not handled properly, a resource leak could happen. To avoid that behavior, the so-called graceful shutdown should be implemented.

- Graceful, in this case, means that the application catches the termination signal, if possible, and tries to clean up and release the allocated resources before it terminates. This recipe will show you how to implement the graceful shutdown.

- The recipe, Handling operating system signals describes the catching of OS signals. The same approach will be used for implementing the graceful shutdown. Before the program terminates, it will clean up and carry out some other activities.

## Create the main.go file with the following content:

```

package main

import (
	"fmt"
	"io"
	"log"
	"os"
	"os/signal"
	"syscall"
	"time"
)

var writer *os.File

func main() {

	// The file is opened as
	// a log file to write into.
	// This way we represent the resources
	// allocation.
	var err error
	writer, err = os.OpenFile(fmt.Sprintf("test_%d.log", time.Now().Unix()), os.O_RDWR|os.O_CREATE, os.ModePerm)
	if err != nil {
		panic(err)
	}

	// The code is running in a goroutine
	// independently. So in case the program is
	// terminated from outside, we need to
	// let the goroutine know via the closeChan
	closeChan := make(chan bool)
	go func() {
		for {
			time.Sleep(time.Second)
			select {
			case <-closeChan:
				log.Println("Goroutine closing")
				return
			default:
				log.Println("Writing to log")
				io.WriteString(writer, fmt.Sprintf("Logging access %s\n", time.Now().String()))
			}

		}
	}()

	sigChan := make(chan os.Signal, 1)
	signal.Notify(sigChan,
		syscall.SIGTERM,
		syscall.SIGQUIT,
		syscall.SIGINT)

	// This is blocking read from
	// sigChan where the Notify function sends
	// the signal.
	<-sigChan

	// After the signal is received
	// all the code behind the read from channel could be
	// considered as a cleanup
	close(closeChan)
	releaseAllResources()
	fmt.Println("The application shut down gracefully")
}

func releaseAllResources() {
	io.WriteString(writer, "Application releasing all resources\n")
	writer.Close()
}




```

output 

```
Biradars-MacBook-Air-4:golang-daily sangam$ go run main.go
2019/12/02 03:45:13 Writing to log
2019/12/02 03:45:14 Writing to log
2019/12/02 03:45:16 Writing to log
2019/12/02 03:45:17 Writing to log
2019/12/02 03:45:18 Writing to log
2019/12/02 03:45:19 Writing to log
2019/12/02 03:45:20 Writing to log
2019/12/02 03:45:21 Writing to log
2019/12/02 03:45:22 Writing to log
2019/12/02 03:45:23 Writing to log
2019/12/02 03:45:24 Writing to log
2019/12/02 03:45:25 Writing to log
2019/12/02 03:45:26 Writing to log
2019/12/02 03:45:27 Writing to log
^CThe application shut down gracefully
Biradars-MacBook-Air-4:golang-daily sangam$ 
```

also cat logs by following commands :

```
Biradars-MacBook-Air-4:golang-daily sangam$ cat test_1575238512.log 
Logging access 2019-12-02 03:45:13.996115 +0530 IST m=+1.004724107
Logging access 2019-12-02 03:45:14.998721 +0530 IST m=+2.007300282
Logging access 2019-12-02 03:45:16.001896 +0530 IST m=+3.010445676
Logging access 2019-12-02 03:45:17.289594 +0530 IST m=+4.298105159
Logging access 2019-12-02 03:45:18.290419 +0530 IST m=+5.298899897
Logging access 2019-12-02 03:45:19.294715 +0530 IST m=+6.303165286
Logging access 2019-12-02 03:45:20.295224 +0530 IST m=+7.303644943
Logging access 2019-12-02 03:45:21.298422 +0530 IST m=+8.306812201
Logging access 2019-12-02 03:45:22.301538 +0530 IST m=+9.309898565
Logging access 2019-12-02 03:45:23.303273 +0530 IST m=+10.311603579
Logging access 2019-12-02 03:45:24.306044 +0530 IST m=+11.314343818
Logging access 2019-12-02 03:45:25.309499 +0530 IST m=+12.317769379
Logging access 2019-12-02 03:45:26.311555 +0530 IST m=+13.319795135
Logging access 2019-12-02 03:45:27.314678 +0530 IST m=+14.322888324
Application releasing all resources


```

## How it works…

- The reading from a sigChan is blocking so the program keeps running until the Signal is sent through the channel. The sigChan is the channel where the Notify function sends the signals.

- The main code of the program runs in a new goroutine. This way, the work continues while the main function is blocked on the sigChan. Once the signal from operation system is sent to process, the sigChan receives the signal and the code below the line where the reading from the sigChan channel is executed. This code section could be considered as the cleanup section.
