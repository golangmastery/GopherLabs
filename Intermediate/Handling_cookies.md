# Handling cookies

- Cookies provide a way of easily storing data on the client side. 
- how to set, retrieve and remove the cookies with the help of the standard library.

## Create the file cookies.go with the following content:
```
        package main

        import (
          "fmt"
          "log"
          "net/http"
          "time"
        )

        const cookieName = "X-Cookie"

        func main() {
          log.Println("Server is starting...")

          http.HandleFunc("/set", func(w http.ResponseWriter,
                          r *http.Request) {
            c := &http.Cookie{
              Name: cookieName,
              Value: "Go is awesome.",
              Expires: time.Now().Add(time.Hour),
              Domain: "localhost",
            }
            http.SetCookie(w, c)
            fmt.Fprintln(w, "Cookie is set!")
          })
          http.HandleFunc("/get", func(w http.ResponseWriter,
                          r *http.Request) {
            val, err := r.Cookie(cookieName)
            if err != nil {
              fmt.Fprintln(w, "Cookie err: "+err.Error())
              return
            }
            fmt.Fprintf(w, "Cookie is: %s \n", val.Value)
            fmt.Fprintf(w, "Other cookies")
            for _, v := range r.Cookies() {
              fmt.Fprintf(w, "%s => %s \n", v.Name, v.Value)
            }
          })
          http.HandleFunc("/remove", func(w http.ResponseWriter,
                          r *http.Request) {
            val, err := r.Cookie(cookieName)
            if err != nil {
              fmt.Fprintln(w, "Cookie err: "+err.Error())
              return
            }
            val.MaxAge = -1
            http.SetCookie(w, val)
            fmt.Fprintln(w, "Cookie is removed!")
          })
          if err := http.ListenAndServe(":8089", nil); err != nil {
            panic(err)
          }
        }


```
output: 

```
sangam:golang-daily sangam$ go run cookies.go
2020/01/15 05:40:43 Server is starting..


```
## open new terminal 
```
sangam:~ sangam$ curl http://localhost:8089/set
Cookie is set!
// try more 
// curl http://localhost:8089/get 
// curl http://localhost:8089/remove 
```

## How it works...

- The net/http package also provides the functions and mechanisms to operate on cookies. The sample code presents how to set/get and remove the cookies. The SetCookie function accepts the Cookie struct pointer that represents the cookies, and naturally the ResponseWriter. 
The Name, Value, Domain, and expiration are set directly in the Cookie struct. Behind the scenes, the SetCookie function writes the header to set the cookies.

- The cookie values could be retrieved from the Request struct. The method Cookie with the name parameter returns the pointer to the Cookie, if the cookie exists in the request.

- To list all cookies within the request, the method Cookies could be called. This method returns the slice of the Cookie structs pointers.

- To let the client know that the cookie should be removed, the Cookie with the given name could be retrieved and the MaxAge field should be set to a negative value. Note that this is not a Go feature, but the way the client should work. 
