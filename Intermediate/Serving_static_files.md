# Serving static files
- Almost any web application needs to serve static files. The serving of JavaScript files, static HTML pages, or CSS style sheets could be easily achieved with the use of the standard library. 

## Create the file welcome.txt with the following content:
```
      Hi, gopherlabs is awesome!

```
## Create the folder html, navigate to it and create the file page.html with the following content:
```
        <html>
          <body>
            Hi, I'm HTML body for index.html!
          </body>
        </html>

```
## Create the static.go file with the following content:

```
        package main

        import (
          "net/http"
        )

        func main() {

          fileSrv := http.FileServer(http.Dir("html"))
          fileSrv = http.StripPrefix("/html", fileSrv)

          http.HandleFunc("/welcome", serveWelcome)
          http.Handle("/html/", fileSrv)
          http.ListenAndServe(":8085", nil)
        }

        func serveWelcome(w http.ResponseWriter, r *http.Request) {
          http.ServeFile(w, r, "welcome.txt")
        }



```
output: 
sangam:golang-daily sangam$ go run static.go

```
sangam:~ sangam$ curl http://localhost:8085/welcome
hi , gopherlabs is awesome

sangam:~ sangam$ curl http://localhost:8085/html/page.html
<html>
  <body>
    Hi, I'm HTML body for index.html!
  </body>
</html>

```
## How it works...

- The net/http package provides the functions ServeFile and FileServer, which are designed to serve the static files. The ServeFile function just consumes the ResponseWriter and Request with the given file path argument and writes the content of the file to the response.

- The FileServer function creates the whole Handler which consumes the FileSystem argument. The preceding example uses the Dir type, which implements the FileSystem interface. The FileSystem interface requires implementing the Open method, which consumes string and returns the actual File for the given path.

