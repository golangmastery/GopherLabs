# Getting file information

If you need to discover basic information about the accessed file, 
Go's standard library provides a way on how you can do this. This recipe shows how you can access this information.


## Create the sample test.file with the content ```This is test file```

## Create the fileinfo.go file with the following content:

```
        package main

        import (
          "fmt"
          "os"
        )

        func main() {

          f, err := os.Open("test.file")
          if err != nil {
            panic(err)
          }
          fi, err := f.Stat()
          if err != nil {
            panic(err)
          }

          fmt.Printf("File name: %v\n", fi.Name())
          fmt.Printf("Is Directory: %t\n", fi.IsDir())
          fmt.Printf("Size: %d\n", fi.Size())
          fmt.Printf("Mode: %v\n", fi.Mode())

        }


```
output:
```
sangam:golang-daily sangam$ go run fileinfo.go 
File name: test.file
Is Directory: false
Size: 18
Mode: -rw-r--r--
sangam:golang-daily sangam$ 

```
## How it works...

The os.File type provides access to the FileInfo type via the Stat method. 
The FileInfo struct contains all the basic information about the file.
