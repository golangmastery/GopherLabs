## Creating the HTTP Server

- The creation of the HTTP server in Go is very easy, and the standard library provides more ways of how to do that. Let's look at the very basic one.

# Create the httpserver.go file with the following content:


```
        package main

        import (
          "fmt"
          "net/http"
        )

        type SimpleHTTP struct{}

        func (s SimpleHTTP) ServeHTTP(rw http.ResponseWriter,
                            r *http.Request) {
          fmt.Fprintln(rw, "Hello world")
        }

        func main() {
          fmt.Println("Starting HTTP server on port 8080")
          // Eventually you can use
          // http.ListenAndServe(":8080", SimpleHTTP{})
          s := &http.Server{Addr: ":8080", Handler: SimpleHTTP{}}
          s.ListenAndServe()
        }

```
output:
```
sangam:golang-daily sangam$ go run httpserver.go
Starting HTTP server on port 8080
```
acces over browser http://localhost:8080 or curl localhost:8080
```
hello world
```
## How it works...

- The net/http package contains a few ways of creating the HTTP server. The most simple one is to implement the Handler interface from the net/http package. The Handler interface requires the type to implement the ServeHTTP method. This method handles the request and response.

- The server itself is created in the form of the Server struct from the net/http package. The Server struct requires the Handler and Addr fields. By calling the method, ListenAndServe,  the server starts serving the content on the given address.

- If the Serve method of the Server is used, then the Listener must be provided.

- The net/http package provides also the default server which could be used if the ListenAndServe is called as a function from the net/http package. It consumes the Handler and Addr, the same as the Server struct. Internally, the Server is created.
