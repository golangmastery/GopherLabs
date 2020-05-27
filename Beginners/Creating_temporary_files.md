# Creating temporary files

- Temporary files are commonly used while running test cases or if your application needs to have a place to store short-term content such as user data uploads and currently processed data. 
This recipe will present the easiest way to create such a file or directory.

## Create the tempfile.go file with the following content:
```
        package main

        import "io/ioutil"
        import "os"
        import "fmt"

        func main() {
          tFile, err := ioutil.TempFile("", "gopherlabs")
          if err != nil {
            panic(err)
          }
          // The called is responsible for handling
          // the clean up.
          defer os.Remove(tFile.Name())

          fmt.Println(tFile.Name())

          // TempDir returns
          // the path in string.
          tDir, err := ioutil.TempDir("", "gopherlabs")
          if err != nil {
            panic(err)
          }
          defer os.Remove(tDir)
          fmt.Println(tDir)

        }


```
output: 
```
sangam:golang-daily sangam$ go run tempfile.go
/var/folders/mg/_355pdvd741cz0z99ys9s66h0000gn/T/gopherlabs622911386
/var/folders/mg/_355pdvd741cz0z99ys9s66h0000gn/T/gopherlabs447325745
sangam:golang-daily sangam$ 
```
## How it works...

- The ioutil package contains the functions TempFile and TempDir. The TempFile function consumes the directory and the file prefix. The os.File with the underlying temporary file is returned. Note that the caller is responsible for cleaning out the file. The previous example uses the os.Remove function to do that.

- The TempDir function works the same way. The difference is that the string with the path to the directory is returned.
