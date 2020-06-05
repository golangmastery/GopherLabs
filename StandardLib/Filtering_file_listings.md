#  Filtering file listings
- you how to list the file paths, matching a given pattern. The list does not have to be from the same folder.

## Create the filter.go file with the following content:
```

        package main

        import (
          "fmt"
          "os"
          "path/filepath"
        )

        func main() {

          for i := 1; i <= 6; i++ {
            _, err := os.Create(fmt.Sprintf("./test.file%d", i))
            if err != nil {
              fmt.Println(err)
            }
          }

          m, err := filepath.Glob("./test.file[1-3]")
          if err != nil {
            panic(err)
          }

          for _, val := range m {
            fmt.Println(val)
          }

          // Cleanup
          for i := 1; i <= 6; i++ {
            err := os.Remove(fmt.Sprintf("./test.file%d", i))
            if err != nil {
              fmt.Println(err)
            }
          }
        }


```
output:
```
sangam:golang-daily sangam$ go run filter.go 
test.file1
test.file2
test.file3
sangam:golang-daily sangam$ 
```

## How it works...

- To get the filtered file list which corresponds to the given pattern, the Glob function from the filepath package can be used. For the pattern syntax, see the documentation of the filepath.Match function (https://golang.org/pkg/path/filepath/#Match).

- Note that the returning result of filepath.Glob is the slice of strings with matching paths.
