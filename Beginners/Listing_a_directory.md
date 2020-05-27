# Listing a directory


Create a directory named folder.
## Create the listdir.go file with the following content:

```

        package main

        import (
          "fmt"
          "io/ioutil"
          "os"
          "path/filepath"
        )

        func main() {

          fmt.Println("List by ReadDir")
          listDirByReadDir(".")
          fmt.Println()
          fmt.Println("List by Walk")
          listDirByWalk(".")
        }

        func listDirByWalk(path string) {
          filepath.Walk(path, func(wPath string, info os.FileInfo,
                                   err error) error {

          // Walk the given dir
          // without printing out.
          if wPath == path {
            return nil
          }

          // If given path is folder
          // stop list recursively and print as folder.
          if info.IsDir() {
            fmt.Printf("[%s]\n", wPath)
            return filepath.SkipDir
          }

          // Print file name
          if wPath != path {
            fmt.Println(wPath)
          }
          return nil
        })
        }

        func listDirByReadDir(path string) {
          lst, err := ioutil.ReadDir(path)
          if err != nil {
            panic(err)
          }
          for _, val := range lst {
            if val.IsDir() {
              fmt.Printf("[%s]\n", val.Name())
            } else {
              fmt.Println(val.Name())
            }
          }
        }

```
output:
```
sangam:golang-daily sangam$ go run main.go
List by ReadDir
.DS_Store
binary
config.json
content.dat

List by Walk
.DS_Store
binary
config.json
content.dat
data.csv
data.xml
data.zip

```

## How it works...

- The folder listing the example above uses two approaches. The first, simpler one is implemented by using the listDirByReadDir function and utilizes the ReadDir function from the ioutil package. This function returns the slice of FileInfo structs that represent the actual directory content. Note that the ReadDir function does not read the folders recursively. In fact, the ReadDir function internally uses the Readdir method of the File type in the os package.

- On the other hand, the more complicated listDirByWalk uses the filepath.Walk function which consumes the path to be 
walked and has a function that processes each file or folder in any given path. The main difference is that the Walk 
function reads the directory recursively. The core part of this approach is the WalkFunc type, where its function is to
consume the results of the listing. Note that the function blocks the recursive call on underlying folders by returning
the filepath.SkipDir error. The Walk function also processes the called path at first, so you need to handle this as 
well (in this case, we skip the printing and return nil because we need to process this folder recursively).
