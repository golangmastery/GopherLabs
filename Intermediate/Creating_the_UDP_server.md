# Creating the UDP server


## Create the serverudp.go file with the following content:

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
			if _, err := pc.WriteTo([]byte("Received: "+rcvMsq), addr); err != nil {
				fmt.Println("error on write: " + err.Error())
			}
		} else {
			fmt.Println("error: " + err.Error())
		}
	}
}


```
output:
```
sangam:golang-daily sangam$ go run serverudp
Waiting for client...
```
## open new terminal 
```
sangam:~ sangam$ nc -u localhost 7070
hello gopherlabs
Received: hello gopherlabs
```
## watch runing terminal 
```
sangam:golang-daily sangam$ go run serverudp
Waiting for client...
Received: hello gopherlabs

```
## How it works...

- As with the TCP server, the UDP server can be created with the help of the net package. 
With the use of the ListenPacket function, the PacketConn is created. 

- The PacketConn does not implement the Reader and Writer interface as the TCPConn. 
For reading the received packet, the ReadFrom method should be used. The ReadFrom method blocks until the packet is received.
After this, the Addr of the client is returned (remember the UDP is not connection-based ). To respond to the client, 
the WriteTo method of PacketConn could be used; this consumes the message and the Addr, which is the client Addr, in this case.
