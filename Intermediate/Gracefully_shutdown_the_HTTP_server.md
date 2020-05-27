## Gracefully shutdown the HTTP server

- Interacting with the Environment, the mechanism of how to implement graceful shutdown was presented. 
 we will describe how to shut down the HTTP server and give it time to handle the existing clients.

## Create the file gracefully.go with the following content:

```
        package main

        import (
          "context"
          "fmt"
          "log"
          "net/http"
          "os"
          "os/signal"
          "time"
        )

        func main() {

          mux := http.NewServeMux()
          mux.HandleFunc("/",func(w http.ResponseWriter, r *http.Request){
            fmt.Fprintln(w, "Hello world!")
          })

          srv := &http.Server{Addr: ":8089", Handler: mux}
          go func() {
            if err := srv.ListenAndServe(); err != nil {
              log.Printf("Server error: %s\n", err)
            }
          }()

          log.Println("Server listening on : " + srv.Addr)

          stopChan := make(chan os.Signal)
          signal.Notify(stopChan, os.Interrupt)

          <-stopChan // wait for SIGINT
          log.Println("Shutting down server...")

          ctx, cancel := context.WithTimeout(
            context.Background(),
            5*time.Second)
          srv.Shutdown(ctx)
          <-ctx.Done()
          cancel()
          log.Println("Server gracefully stopped")
        }

```
output:
```
sangam:golang-daily sangam$ go run gracefully.go
2020/01/15 05:49:10 Server listening on : :8089
^C2020/01/15 05:49:38 Shutting down server...
2020/01/15 05:49:38 Server error: http: Server closed

```

## How it works...

- The Server from the net/http package provides the method to gracefully shutdown the connection. The preceding code starts the HTTP server in a separate goroutine and keeps the reference to the Server struct in a variable. 

- By calling the Shutdown method, the Server starts refusing new connections and closes opened listeners and idle connections. Then it waits indefinitely for the already pending connections, till these become idle. After all the connections are closed, the server shuts down. Note that the Shutdown method consumes the Context. If the provided Context expires prior to the shutdown, 
then the error from Context is returned and the Shutdown does not block anymore
