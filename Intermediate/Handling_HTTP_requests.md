# Handling HTTP requests

- The applications usually use the URL paths and HTTP methods to define the behavior of the application. This recipe will illustrate how to leverage the standard library for handling different URLs and methods.

## Create the handle.go file with the following content:

```
        package main

        import (
          "fmt"
          "net/http"
        )

        func main() {

          mux := http.NewServeMux()
          mux.HandleFunc("/user", func(w http.ResponseWriter, 
                         r *http.Request) {
            if r.Method == http.MethodGet {
              fmt.Fprintln(w, "User GET")
            }
            if r.Method == http.MethodPost {
              fmt.Fprintln(w, "User POST")
            }
          })

          // separate handler
          itemMux := http.NewServeMux()
          itemMux.HandleFunc("/items/clothes", func(w http.ResponseWriter,
                             r *http.Request) {
            fmt.Fprintln(w, "Clothes")
          })
          mux.Handle("/items/", itemMux)

          // Admin handlers
          adminMux := http.NewServeMux()
          adminMux.HandleFunc("/ports", func(w http.ResponseWriter,
                              r *http.Request) {
            fmt.Fprintln(w, "Ports")
          })

          mux.Handle("/admin/", http.StripPrefix("/admin",
                                adminMux))

          // Default server
          http.ListenAndServe(":8080", mux)

        }


```
output:

```
sangam:golang-daily sangam$ go run handle.go
Starting HTTP server on port 8080
```
## Check the following URLs in the browser or via curl:

    http://localhost:8080/user
    http://localhost:8080/items/clothes
    http://localhost:8080/admin/ports
    
    
## How it works...

- The net/http package contains the ServeMux struct, which implements the Handler interface to be used in a Server struct, but also contains the mechanism of how to define the handling of different paths. The ServeMux pointer contains the methods HandleFunc and Handle, which accept the path, and the HandlerFunc function handles the request for the given path, or another handler does the same. 

- See the preceding example for how these could be used. The Handler interface and HandlerFunc require implementing the function with request and response arguments. This way you get access to these two structures. The request itself gives access to Headers, the HTTP method, and other request parameters.    
