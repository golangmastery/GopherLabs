# Creating HTTP middleware layer

- Modern applications with web UI or REST API usually use the middleware mechanism to log the activity, or guard the security of the given interface.the implementation of such a middleware layer will be presented.

## Create the middleware.go file with the following content:

```
        package main

        import (
          "io"
          "net/http"
        )

        func main() {

          // Secured API
          mux := http.NewServeMux()
          mux.HandleFunc("/api/users", Secure(func(w http.ResponseWriter,
                         r *http.Request) {
            io.WriteString(w,  `[{"id":"1","login":"ffghi"},
                           {"id":"2","login":"ffghj"}]`)
          }))

          http.ListenAndServe(":8080", mux)

        }

        func Secure(h http.HandlerFunc) http.HandlerFunc {
          return func(w http.ResponseWriter, r *http.Request) {
            sec := r.Header.Get("X-Auth")
            if sec != "authenticated" {
              w.WriteHeader(http.StatusUnauthorized)
              return
            }
            h(w, r) // use the handler
          }

        }



```

## output: 

```
sangam:golang-daily sangam$ go run middleware.go 

```
## Check the URL http://localhost:8080/api/users with use of curl by executing these two commands (the first without and the second with the X-Auth header):
```
    curl -X GET -I http://localhost:8080/api/users
    curl -X GET -H "X-Auth: authenticated" -I http://localhost:8080/api/users

```

## How it works...

- The implementation of middleware in the preceding example leverages the functions as first-class citizens feature of Golang. The original HandlerFunc is wrapped into a HandlerFunc which checks the X-Auth header. The Secure function is then used to secure the HandlerFunc, used in the HandleFunc methods of ServeMux.

- Note that this is just a simple example, but this way you can implement more sophisticated solutions. For example, the user identity could be extracted from the Header token and subsequently, the new type of handler could be defined as type AuthHandler func(u *User,w http.ResponseWriter, r *http.Request). The function WithUser then creates the HandlerFunc for the ServeMux.
