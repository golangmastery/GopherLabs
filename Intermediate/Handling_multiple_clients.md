# Handling multiple clients

 - we covered how to create UDP and TCP servers. The sample codes are not ready to handle multiple clients simultaneously.
 In this recipe, we will cover how to handle more clients at any given time.
 
 # Create the multipletcp.go file with the following content:
 ```
         package main

        import (
          "fmt"
          "log"
          "net"
        )

        func main() {

          pc, err := net.ListenPacket("udp", ":7070")
          if err != nil {
            log.Fatal(err)
          }
          defer pc.Close()

          buffer := make([]byte, 2048)
          fmt.Println("Waiting for client...")
          for {

            _, addr, err := pc.ReadFrom(buffer)
            if err == nil {
              rcvMsq := string(buffer)
              fmt.Println("Received: " + rcvMsq)
              if _, err := pc.WriteTo([]byte("Received: "+rcvMsq), addr);
              err != nil {
                fmt.Println("error on write: " + err.Error())
              }
            } else {
              fmt.Println("error: " + err.Error())
            }
          }

        }

 ```
## output:
 ```
 sangam:golang-daily sangam$ go run multipletcp.go
Waiting for client...
 
 ```
Open two another Terminals and execute the nc localhost 8080.
```
 sangam:golang-daily sangam$ go run multipletcp.go
Waiting for client...
Client ID : 0 connected .
Waiting for client...
Client ID : 1 connected .
```
## How it works...

- The TCP server implementation works the same as the previous recipe, Creating the TCP server. 
The implementation is enhanced, with the ability to handle multiple clients simultaneously. 
Note that we are now handling the accepted connection in the separate goroutine. 
This means the server can continue to accept the client connections with the Accept method. 

## Note

Because the UDP protocol is not stateful and does not keep any connection, the handling of multiple clients is moved to application logic and you need to identify the clients and packet sequence.
Only the writing response to a client could be parallelized with the use of goroutines.
