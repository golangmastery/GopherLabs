# Opening a file by name

- File access is a very common operation used to store or read the data. 
This recipe illustrates how to open a file by its name and path, using the standard library.

## Create the directory temp and create the file file.txt in it.

Edit the file.txt file and write This file content into the file.

## Create the openfile.go file with the following content:

```
        package main

        import (
          "fmt"
          "io"
          "io/ioutil"
          "os"
        )

        func main() {

          f, err := os.Open("temp/file.txt")
          if err != nil {
            panic(err)
          }

          c, err := ioutil.ReadAll(f)
          if err != nil {
            panic(err)
          }

          fmt.Printf("### File content ###\n%s\n", string(c))
          f.Close()

          f, err = os.OpenFile("temp/test.txt", os.O_CREATE|os.O_RDWR,
                               os.ModePerm)
          if err != nil {
            panic(err)
          }
          io.WriteString(f, "Test string")
          f.Close()

        }


```

output:

```
sangam:golang-daily sangam$ go run openfile.go
### File content ###
This file content

sangam:golang-daily sangam$ 

```
See the output there should also be a new file, test.txt, in the temp folder:


## How it works...

- The os package offers a simple way of opening the file. The function Open opens the file by the path, just in read-only mode. Another function, OpenFile, is the more powerful one and consumes the path to the file, flags, and permissions. 

- The flag constants are defined in the os package and you can combine them with use of the binary OR operator |.  The permissions are set by the os package constants (for example, os.ModePerm ) or by the number notation such as 0777 (permissions: -rwxrwxrwx).

