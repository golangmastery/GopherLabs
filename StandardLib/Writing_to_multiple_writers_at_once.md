## Writing to multiple writers at once

- When you need to write the same output into more than one target, there is a helping hand available in the built-in package. 
This recipe shows how to implement writing simultaneously into multiple targets.

# Create the multiwr.go file with the following content:
```
        package main

        import "io"
        import "bytes"
        import "os"
        import "fmt"

        func main() {

          buf := bytes.NewBuffer([]byte{})
          f, err := os.OpenFile("sample.txt", os.O_CREATE|os.O_RDWR,
                                os.ModePerm)
          if err != nil {
            panic(err)
          }
          wr := io.MultiWriter(buf, f)
          _, err = io.WriteString(wr, "Hello, Go is awesome!")
          if err != nil {
            panic(err)
          }

          fmt.Println("Content of buffer: " + buf.String())
        }



```
output:
```
sangam:golang-daily sangam$ go run multiwr.go
Content of buffer: Hello, Go is awesome!
sangam:golang-daily sangam$ 

```
## Check the content of the created file: sample.txt
```
      Hello, Go is awesome!
```
## How it works...

- The io package contains the MultiWriter function with variadic parameters of  Writers. 
- When the Write method on the Writer is called, then the data is written to all underlying Writers.
