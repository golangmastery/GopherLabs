## Calling an external proces

- The Go binary could also be used as a tool for various utilities and with use of go run as a replacement for the bash script. For these purposes, it is usual that the command-line utilities are called.

- In this recipe, the basics of how to execute and handle the child process will be provided.

# Create the run.go file with the following content:

```
        package main

        import (
          "bytes"
          "fmt"
          "os/exec"
        )

        func main() {

          prc := exec.Command("ls", "-a")
          out := bytes.NewBuffer([]byte{})
          prc.Stdout = out
          err := prc.Run()
          if err != nil {
            fmt.Println(err)
          }

          if prc.ProcessState.Success() {
            fmt.Println("Process run successfully with output:\n")
            fmt.Println(out.String())
          }
        }
  ```
  output:
  ```
  Biradars-MacBook-Air-4:golang-daily sangam$ go run run.go
Process run successfully with output:

.
..
binary
main
main.go
run.go
test
util
  
  ```
  
 ##  How it works…

- The Go standard library provides a simple way of calling the external process. This could be done by the Command function of the os/exec package.

- The simplest way is to create the Cmd struct and call the Run function. The Run function executes the process and waits until it completes. If the command exited with an error, the err value is not null.

- This is more suitable for calling the OS utils and tools, so the program does not hang too long.

- The process could be executed asynchronously too. This is done by calling the Start method of the Cmd structure. In this case, the process is executed, but the main goroutine does not wait until it ends. The Wait method could be used to wait until the process ends. After the Wait method finishes, the resources of the process are released.

- This approach is more suitable for executing long-running processes and services that the program depends on.
