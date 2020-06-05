# Changing file permissions

how file permissions can be changed programmatically. 

## Create the filechmod.go file with the following content:
```
        package main

        import (
          "fmt"
          "os"
        )

        func main() {

          f, err := os.Create("test.file")
          if err != nil {
            panic(err)
          }
          defer f.Close()

          // Obtain current permissions
          fi, err := f.Stat()
          if err != nil {
            panic(err)
          }
          fmt.Printf("File permissions %v\n", fi.Mode())

          // Change permissions
          err = f.Chmod(0777)
          if err != nil {
            panic(err)
          }
          fi, err = f.Stat()
          if err != nil {
            panic(err)
          }
          fmt.Printf("File permissions %v\n", fi.Mode())

        }

```
output:

```
sangam:golang-daily sangam$ go run filechmod.go
File permissions -rw-r--r--
File permissions -rwxrwxrwx
sangam:golang-daily sangam$ 

```
## How it works...

- The Chmod method of the File type in the os package can be used to change file permissions. The preceding example just creates the file and changes the permissions to 0777.

- Just note that the fi.Mode() is called twice because it extracts the permissions (os.FileMode) for the current state of the file.

- The shortest way to change the permissions is by using the os.Chmod function, which does the same, but you do not need to obtain the File type in the code.
