## Retrieving the current working directory


Another useful source of information for the application is the directory, where the program binary is located. With this information, the program can access the assets and files collocated with the binary file.

Note: Go since version 1.8. This one is the preferred one.

Create the main.go file with the following content:

```
        package main

        import (
          "fmt"
          "os"
          "path/filepath"
        )

        func main() {
          ex, err := os.Executable()
          if err != nil {
            panic(err)
          }

          // Path to executable file
          fmt.Println(ex)

          // Resolve the direcotry
          // of the executable
          exPath := filepath.Dir(ex)
          fmt.Println("Executable path :" + exPath)

          // Use EvalSymlinks to get
          // the real path.
          realPath, err := filepath.EvalSymlinks(exPath)
          if err != nil {
            panic(err)
          }
          fmt.Println("Symlink evaluated:" + realPath)
        }



```

output:
```
Biradars-MacBook-Air-4:golang-daily sangam$ go build -o binary
Biradars-MacBook-Air-4:golang-daily sangam$ ./binary 
/Users/sangam/Documents/golang-daily/binary
Executable path :/Users/sangam/Documents/golang-daily
Symlink evaluated:/Users/sangam/Documents/golang-daily
Biradars-MacBook-Air-4:golang-daily sangam$ 

```
# How it works…

- Since Go 1.8, the Executable function from the os package is the preferred way of resolving the path of the executable. The Executable function returns the absolute path of the binary that is executed (unless the error is returned).

- To resolve the directory from the binary path, the Dir from the filepath package is applied. The only pitfall of this is that the result could be the symlink or the path it pointed to.

- To overcome this unstable behavior, the EvalSymlinks from the filepath package could be applied to the resultant path. With this hack, the returned value would be the real path of the binary.

- The information about the directory where the binary is located could be obtained with the use of the Executable function in the os library.

- Note that if the code is run by the command go run, the actual executable is located in a temporary directory.

