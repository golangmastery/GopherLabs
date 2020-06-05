# Reading the file into a string

- In the previous recipes, we saw the reading from Stdin and the opening of the file.
In this recipe, we will combine these two a little bit and show how to read the file into a string.

## Create the directory temp and create the file file.txt in it.
Edit the file.txt file and write multiple lines into the file.

## Create the readfile.go file with the following content:
```
        package main

        import "os"
        import "bufio"

        import "bytes"
        import "fmt"
        import "io/ioutil"

        func main() {

          fmt.Println("### Read as reader ###")
          f, err := os.Open("temp/file.txt")
          if err != nil {
            panic(err)
          }
          defer f.Close()

          // Read the
          // file with reader
          wr := bytes.Buffer{}
          sc := bufio.NewScanner(f)
          for sc.Scan() {
            wr.WriteString(sc.Text())
          }
          fmt.Println(wr.String())

          fmt.Println("### ReadFile ###")
          // for smaller files
          fContent, err := ioutil.ReadFile("temp/file.txt")
          if err != nil {
            panic(err)
          }
          fmt.Println(string(fContent))

        }


```
```
sangam:golang-daily sangam$ go run readfile.go
### Read as reader ###
This file content
### ReadFile ###
This file content

```

## How it works...

- The reading from the file is simple because the File type implements both the Reader and Writer interfaces. 
This way, all functions and approaches applicable to the Reader interface are applicable to the File type.
The preceding example shows how to read the file with the use of Scanner and write the content to the bytes buffer (which is more performant than string concatenation). This way, you are able to control the volume of content read from a file.

- The second approach with ioutil.ReadFile is simpler but should be used carefully, because it reads the whole file. Keep in mind that the file could be huge and it could threaten the stability of the application
