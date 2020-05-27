# Handling redirects

- Redirects are the usual way of telling the client that the content was moved, or there is a needs to look somewhere else to accomplish the request. 
we will see the way to implement redirects with the standard library.


## Create the file redirect.go with the following content:

```
        package main

        import (
          "fmt"
          "log"
          "net/http"
        )

        func main() {
          log.Println("Server is starting...")

          http.Handle("/secured/handle",
               http.RedirectHandler("/login", 
                      http.StatusTemporaryRedirect))
          http.HandleFunc("/secured/hadlefunc", 
               func(w http.ResponseWriter, r *http.Request) {
            http.Redirect(w, r, "/login", http.StatusTemporaryRedirect)
          })
          http.HandleFunc("/login", func(w http.ResponseWriter,
                          r *http.Request) {
            fmt.Fprintf(w, "Welcome user! Please login!\n")
          })
          if err := http.ListenAndServe(":8085", nil); err != nil {
            panic(err)
          }
        }


```
output:
```

sangam:golang-daily sangam$ go run redirect.go
2020/01/15 05:34:35 Server is starting...


```




# open new terminal 
```
Last login: Wed Jan 15 05:34:14 on ttys001
sangam:~ sangam$ curl -v -L http://localhost:8085/secured/handle
*   Trying ::1...
* TCP_NODELAY set
* Connected to localhost (::1) port 8085 (#0)
> GET /secured/handle HTTP/1.1
> Host: localhost:8085
> User-Agent: curl/7.60.0
> Accept: */*
> 
< HTTP/1.1 307 Temporary Redirect
< Content-Type: text/html; charset=utf-8
< Location: /login
< Date: Wed, 15 Jan 2020 00:05:21 GMT
< Content-Length: 42
< 
* Ignoring the response-body
* Connection #0 to host localhost left intact
* Issue another request to this URL: 'http://localhost:8085/login'
* Found bundle for host localhost: 0x7f99e2f00e50 [can pipeline]
* Re-using existing connection! (#0) with host localhost
* Connected to localhost (::1) port 8085 (#0)
> GET /login HTTP/1.1
> Host: localhost:8085
> User-Agent: curl/7.60.0
> Accept: */*
> 
< HTTP/1.1 200 OK
< Date: Wed, 15 Jan 2020 00:05:21 GMT
< Content-Length: 28
< Content-Type: text/plain; charset=utf-8
< 
Welcome user! Please login!
* Connection #0 to host localhost left intact
sangam:~ sangam$ 

```
## How it works...

- The net/http package contains a simple way of executing the redirect. The RedirectHandler could be utilized.
- The function consumes the URL where the request will be redirected and the status code which will be sent to client. 
- The function itself sends results to the Handler, which could be used in the Handle method of ServeMux (the example uses the default one directly from the package).

- The second approach is the use of the Redirect function, which does the redirect for you. The function consumes ResponseWriter, the request pointer and the same as RequestHandler, the URL and status code, which will be sent to the client.
