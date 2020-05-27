## Creating the TCP server

```
        package main

        import (
          "bufio"
          "fmt"
          "io"
          "net"
        )

        func main() {

          l, err := net.Listen("tcp", ":8080")
          if err != nil {
            panic(err)
          }
          for {
            fmt.Println("Waiting for client...")
            conn, err := l.Accept()
            if err != nil {
              panic(err)
            }

            msg, err := bufio.NewReader(conn).ReadString('\n')
            if err != nil {
              panic(err)
            }
            _, err = io.WriteString(conn, "Received: "+string(msg))
            if err != nil {
              fmt.Println(err)
            }
            conn.Close()
          }
        }
 ```     
output: 
```
sangam:golang-daily sangam$ go run main.go
Waiting for client...
```
open another terminal 
```
sangam:~ sangam$ nc localhost 8080
hello
Received: hello
sangam:~ sangam$ 

```
## How it works...

- The TCP server could be created using the net package. The net package contains the Listen function that creates the TCPListener, which can Accept the client connections. The Accept method calls on the TCPListener blocks until the client connection is received. If the client connection comes, the Accept method returns the TCPConn connection. The TCPConn is a connection to the client that serves to read and write data.

- The TCPConn implements the Reader and Writer interfaces. All the approaches to write and read the data could be used. Note that there is a delimiter character for reading the data, otherwise, the EOF is received if the client forcibly closes the connection.

- Note that this implementation handles only one client at a time.
