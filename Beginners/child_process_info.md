## Retrieving child process information

- The recipe Calling an external process describes how to call the child process, synchronously and asynchronously. Naturally, to handle the process behavior you need to find out more about the process.  This recipe shows how to obtain the PID and elementary information about the child process after it terminates.

- The information about the running process could be obtained only via the syscall package and it is highly platform-dependent.

## Getting ready

- Test if the sleep (timeout for Windows) command exists in the Terminal.

## Create the main.go file with the following content:
```

package main

import (
	"fmt"
	"os/exec"
	"runtime"
	"time"
)

func main() {

	var cmd string
	if runtime.GOOS == "windows" {
		cmd = "timeout"
	} else {
		cmd = "sleep"
	}

	proc := exec.Command(cmd, "1")
	proc.Start()

	// Wait function will
	// wait till the process ends.
	proc.Wait()

	// After the process terminates
	// the *os.ProcessState contains
	// simple information
	// about the process run
	fmt.Printf("PID: %d\n", proc.ProcessState.Pid())
	fmt.Printf("Process took: %dms\n",
		proc.ProcessState.SystemTime()/time.Microsecond)
	fmt.Printf("Exited sucessfuly : %t\n",
		proc.ProcessState.Success())
}



```

output:
```
Biradars-MacBook-Air-4:golang-daily sangam$ go run main.go
PID: 46936
Process took: 1406ms
Exited sucessfuly : true

```
## How it works…

- The os/exec standard library provides the way to execute the process. Using Command, the Cmd structure is returned. The Cmd provides the access to process the representation. When the process is running, you can only find out the PID.

- There is only a little information that you can retrieve about the process. But by retrieving the PID of the process, you are able to call the utilities from the OS to get more information.


## Note

Remember that it is possible to obtain the PID of the child process, even if it is running. On the other hand, the ProcessState structure of the os package is available, only after the process terminates.


