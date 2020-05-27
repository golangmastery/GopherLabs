## Getting the current process PID 

Getting to know the PID of the running process is useful. The PID could be used by OS utilities to find out the information about the process itself. It is also valuable to know the PID in case of process failure, so you can trace the process behavior across the system in system logs, such as /var/log/messages, /var/log/syslog.

This program shows you how to use the os package to obtain a PID of the executed program, and use it with the operating system utility to obtain some more information.

    ```
    package main

        import (
          "fmt"
          "os"
          "os/exec"
          "strconv"
        )

        func main() {

          pid := os.Getpid()
          fmt.Printf("Process PID: %d \n", pid)

          prc := exec.Command("ps", "-p", strconv.Itoa(pid), "-v")
          out, err := prc.Output()
          if err != nil {
            panic(err)
          }

          fmt.Println(string(out))
        }
        ```
        
output:

```
Biradars-MacBook-Air-4:golang-daily sangam$ go run main.go
Process PID: 48094 
  PID STAT      TIME  SL  RE PAGEIN      VSZ    RSS   LIM     TSIZ  %CPU %MEM COMMAND
48094 S+     0:00.01   0   0      0  4373552   2072     -        0   0.0  0.0 /var/folders/mg/_355pdvd741cz0z99ys9s66h0000gn/T/go-build581430461/b001/exe/main


```

## How it works…

- The function Getpid from the os package returns the PID of a process. The sample code shows how to get more information on the process from the operating system utility ps.

- It could be useful to print the PID at the start of the application, so at the time of the crash, the cause could also be investigated by the retrieved PID.
