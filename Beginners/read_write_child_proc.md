## Reading/writing from the child process

- Every process, that is executed, has the standard output, input and error output. The Go standard library provides the way to read and write to these.

- This recipe will walk through the approaches on how to read the output and write to the input of the child process.

## Create the main_read_output.go file with the following content:

```
       package main

       import (
         "fmt"
         "os/exec"
         "runtime"
       )

       func main() {

         var cmd string

         if runtime.GOOS == "windows" {
           cmd = "dir"
         } else {
           cmd = "ls"
         }

         proc := exec.Command(cmd)

         // Output will run the process
         // terminates and returns the standard
         // output in a byte slice.
         buff, err := proc.Output()

         if err != nil {
           panic(err)
         }

         // The output of child
         // process in form
         // of byte slice
         // printed as string
         fmt.Println(string(buff))

       }

```


output 
```
Biradars-MacBook-Air-4:golang-daily sangam$ go run main.go
binary
main
main.go
run.go
start.go
test
util


```

## Create the main_read_stdout.go file with the following content:

```
        package main

        import (
          "bytes"
          "fmt"
          "os/exec"
          "runtime"
        )

        func main() {

          var cmd string

          if runtime.GOOS == "windows" {
            cmd = "dir"
          } else {
            cmd = "ls"
          }

          proc := exec.Command(cmd)

          buf := bytes.NewBuffer([]byte{})

          // The buffer which implements
          // io.Writer interface is assigned to
          // Stdout of the process
          proc.Stdout = buf

          // To avoid race conditions
          // in this example. We wait till
          // the process exit.
          proc.Run()

          // The process writes the output to
          // to buffer and we use the bytes
          // to print the output.
          fmt.Println(string(buf.Bytes()))

        }


```
output 

```
Biradars-MacBook-Air-4:golang-daily sangam$ go run main.go
binary
main
main.go
run.go
start.go
test



```

## Create the main_read_read.go file with the following content:

```
        package main

        import (
          "bufio"
          "context"
          "fmt"
          "os/exec"
          "time"
        )

        func main() {
          cmd := "ping"
          timeout := 2 * time.Second

          // The command line tool
          // "ping" is executed for
          // 2 seconds
          ctx, _ := context.WithTimeout(context.TODO(), timeout)
          proc := exec.CommandContext(ctx, cmd, "example.com")

          // The process output is obtained
          // in form of io.ReadCloser. The underlying
          // implementation use the os.Pipe
          stdout, _ := proc.StdoutPipe()
          defer stdout.Close()

          // Start the process
          proc.Start()

          // For more comfortable reading the
          // bufio.Scanner is used.
          // The read call is blocking.
          s := bufio.NewScanner(stdout)
          for s.Scan() {
            fmt.Println(s.Text())
          }
        }


```

output 

```
Biradars-MacBook-Air-4:golang-daily sangam$ go run main.go
PING example.com (93.184.216.34): 56 data bytes
64 bytes from 93.184.216.34: icmp_seq=0 ttl=51 time=411.571 ms
64 bytes from 93.184.216.34: icmp_seq=1 ttl=51 time=217.384 ms
Biradars-MacBook-Air-4:golang-daily sangam$ 

```

## Create the sample.go file with the following content:

```
        package main

        import (
          "bufio"
          "fmt"
          "os"
        )

        func main() {
          sc := bufio.NewScanner(os.Stdin)

          for sc.Scan() {
            fmt.Println(sc.Text())
          }
        }


```


## Create the main.go file with the following content:

```
        package main

        import (
          "bufio"
          "fmt"
          "io"
          "os/exec"
          "time"
        )

        func main() {
          cmd := []string{"go", "run", "sample.go"}

          // The command line tool
          // "ping" is executed for
          // 2 seconds
          proc := exec.Command(cmd[0], cmd[1], cmd[2])

          // The process input is obtained
          // in form of io.WriteCloser. The underlying
          // implementation use the os.Pipe
          stdin, _ := proc.StdinPipe()
          defer stdin.Close()

          // For debugging purposes we watch the
          // output of the executed process
          stdout, _ := proc.StdoutPipe()
          defer stdout.Close()

          go func() {
            s := bufio.NewScanner(stdout)
            for s.Scan() {
              fmt.Println("Program says:" + s.Text())
            }
          }()

          // Start the process
          proc.Start()

          // Now the following lines
          // are written to child
          // process standard input
          fmt.Println("Writing input")
          io.WriteString(stdin, "Hello\n")
          io.WriteString(stdin, "Golang\n")
          io.WriteString(stdin, "is awesome\n")

          time.Sleep(time.Second * 2)

          proc.Process.Kill()

        }
        
   ```
   output 
   
   ```
Biradars-MacBook-Air-4:golang-daily sangam$ go run main.go
Writing input
Program says:Hello
Program says:Golang
Program says:is awesome
Biradars-MacBook-Air-4:golang-daily sangam$ 
   
   ```
   
  ##  How it works…

- The Cmd structure of the os/exec package provides the functions to access the output/input of the process. There are a few approaches to read the output of the process.

- One of the simplest ways to read the process output is to use the Output or CombinedOutput method of the Cmd structure (gets Stderr and Stdout). While calling this function, the program synchronously waits till the child process terminates and then returns the output to a byte buffer.

- Besides the Output and OutputCombined methods, the Cmd structure provides the Stdout property, where the io.Writer could be assigned. The assigned writer then serves as a destination for the process output. It could be a file, byte buffer or any type implementing the io.Writer interface.

- The last approach to read the process output is to get the io.Reader from the Cmd structure by calling the StdoutPipe method. The StdoutPipe method creates the pipe between the Stdout, where the process writes the output, and provides Reader which works as the interface for the program to read the process output. This way the output of the process is piped to the retrieved io.Reader . 

- Writing to a process stdin works the same way. Of all the options, the one with io.Writer will be demonstrated.

- As could be seen, there are a few ways to read and write from the child process. The use of stderr and stdin is almost the same as described in steps 6-7. Finally, the approach of how to access the input/output could be divided this way:


   -  Synchronous (wait until the process ends and get the bytes): The Output and CombinedOutput methods of Cmd are used.
   - IO: The output or input are provided in the form of io.Writer/Reader. The XXXPipe and StdXXX properties are the right ones for this approach.
   
- The IO type is more flexible and could also be used asynchronously.
