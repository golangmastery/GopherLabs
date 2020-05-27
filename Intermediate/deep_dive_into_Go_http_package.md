# A deep dive into Go’s http package
access to information from the Internet is as important as access to the local file system. Go provides a collection of packages, grouped under net, that make it easy to send and receive information through the Internet, make low-level network connections, and set up servers etc.

To illustrate the minimum necessary to retrieve information over HTTP, here’s a simple program called fetch that fetches the content of each specified URL and prints it as uninterpreted text; it’s inspired by the invaluable utility curl. Obviously one would usually do more with such data, but this shows the basic idea.


```

package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
)

func main() {
	for _, url := range os.Args[1:] {
		resp, err := http.Get(url)
		if err != nil {
			fmt.Fprintf(os.Stderr, "fetch: %v \n", err)
			os.Exit(1)
		}
		b, err := ioutil.ReadAll(resp.Body)
		resp.Body.Close()
		if err != nil {
			fmt.Fprintf(os.Stderr, "fetch : reading %s: %v\n ", url, err)
			os.Exit(1)
		}
		fmt.Printf("%s", b)
	}
}


```
output 
```
go run main.go https://gopherlabs.collabnix.com

```

program introduces functions from two packages, ` net/http ` and ` io/ioutil`. The ` http.Get` function makes an HTTP request and, if there is no error, returns the result in the response struct resp. The Body field of resp contains the server response as a readable stream.

Next, ` ioutil.ReadAll ` reads the entire response; the result is stored in `b`. The Body stream is closed to avoid leaking resources, and Printf writes the response to the standard output.

# Fetching URLs Concurrently

```
//  fetching URLs Concurrently
package main

import (
	"fmt"
	"io"
	"io/ioutil"
	"net/http"
	"os"
	"time"
)

func main() {
	start := time.Now()
	ch := make(chan string)
	for _, url := range os.Args[1:] {
		go fetch(url, ch) // start a goroutine
	}
	for range os.Args[1:] {
		fmt.Println(<-ch)
	}
	fmt.Printf("%.2fs elapsed\n", time.Since(start).Seconds())
}

func fetch(url string, ch chan<- string) {
	start := time.Now()
	resp, err := http.Get(url)
	if err != nil {
		ch <- fmt.Sprint(err) // sent to channel
		return
	}
	nbytes, err := io.Copy(ioutil.Discard, resp.Body)
	resp.Body.Close()
	if err != nil {
		ch <- fmt.Sprintf("while reading %s: %v", url, err)
		return
	}
	secs := time.Since(start).Seconds()
	ch <- fmt.Sprint("%.2fs %s", secs, nbytes, url)
}
```
output 
```
sangam$ go run main.go https://google.com https://google.com 
%.2fs %s0.955698938 14029https://google.com
%.2fs %s1.324267501 14061https://google.com
1.32s elapsed
```
A goroutine is a concurrent function execution. A channel is a communication mechanism that allows one goroutine to pass values of a specified type to another goroutine. The function main runs in a goroutine and the go statement creates additional goroutines. <br> 
The main function creates a channel of strings using make. For each command-line argument, the go statement in the first range loop starts a new goroutine that calls fetch asynchronously to fetch the URL using http.Get. The io.Copy function reads the body of the response and discards it by writing to the ioutil.Discard output stream. Copy returns the byte count, along with any error that occurred. As each result arrives, fetch sends a summary line on the channel ch. The second range loop in main receives and prints those lines. <br> 
When one goroutine attempts a send or receive on a channel, it blocks until another goroutine attempts the corresponding receive or send operation, at which point the value is transferred and both goroutines proceed. In this example, each fetch sends a value (ch <- expression) on the channel ch, and main receives all of them (<-ch). Having main do all the printing ensures that output from each goroutine is processed as a unit, with no danger of interleaving if two goroutines finish at the same time. <br> 

# web server 
Go’s libraries makes it easy to write a web server that responds to client requests like those made by fetch. In this section, we’ll show a minimal server that returns the path component of the URL used to access the server. That is, if the request is for http://localhost:8000/gopherlabs, the response will be URL.Path = "/gopherlabs".

```
package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {
	http.HandleFunc("/", handler) // each request calls handler
	log.Fatal(http.ListenAndServe("localhost:8000", nil))

}

// handler echoes the path component of the request URL.
func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "URL.Path = %q\n", r.URL.Path)

}



```
output 
```
sangam$ go run main.go https://localhost:8000 URL.Path = "/gopherlabs"
```
via 
open in browser http://localhost:8000/gophelabs

The program is only a handful of lines long because library functions do most of the work. The main function connects a handler function to incoming URLs whose path begins with /, which is all URLs, and starts a server listening for incoming requests on port 8000. A request is represented as a struct of type http.Request, which contains a number of related fields, one of which is the URL of the incoming request. When a request arrives, it is given to the handler function, which extracts the path component (/hello) from the request URL and sends it back as the response, using fmt.Fprintf. 


