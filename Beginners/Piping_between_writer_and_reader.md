# Piping between writer and reader

- The pipes between processes are the easy way to use the output of the first process as the input of other processes.
The same concept could be done in Go, for example, to pipe data from one socket to another socket, to create the tunneled connection. 
This recipe will show you how to create the pipe with use of the Go built-in library.

## Create the pipe.go file with the following content:
```
        package main

        import (
          "io"
          "log"
          "os"
          "os/exec"
        )

        func main() {
          pReader, pWriter := io.Pipe()

          cmd := exec.Command("echo", "Hello Go!\nThis is example")
          cmd.Stdout = pWriter

          go func() {
            defer pReader.Close()
            if _, err := io.Copy(os.Stdout, pReader); err != nil {
              log.Fatal(err)
            }
          }()

          if err := cmd.Run(); err != nil {
            log.Fatal(err)
          }

        }

```
output:
```
sangam:golang-daily sangam$ go run pipe.go
Hello Go!
This is example
sangam:golang-daily sangam$ 

```
## How it works...

- The io.Pipe function creates the in-memory pipe and returns both ends of the pipe, the PipeReader on one side and PipeWriter on the other side. Each Write to PipeWriter is blocked until it is consumed by Read on the other end.

- The example shows the piping output from the executed command to the standard output of the parent program. By assigning the pWriter to cmd.Stdout, the standard output of the child process is written to the pipe, and the io.Copy in goroutine consumes the written data, by copying the data to os.Stdout.
