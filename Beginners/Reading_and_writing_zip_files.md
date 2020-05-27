# Reading and writing ZIP files

- ZIP compression is a widely used compression format. It is usual to use the ZIP format for an application to upload a file set or, on the other hand, export zipped files as output. 
This recipe will show you how to handle ZIP files programmatically with the use of the standard library.

## Create the zip.go file with the following content:
```
        package main

        import (
          "archive/zip"
          "bytes"
          "fmt"
          "io"
          "io/ioutil"
          "log"
          "os"
        )

        func main() {

          var buff bytes.Buffer

          // Compress content
          zipW := zip.NewWriter(&buff)
          f, err := zipW.Create("newfile.txt")
          if err != nil {
            panic(err)
          }
          _, err = f.Write([]byte("This is my file content"))
          if err != nil {
            panic(err)
          }
          err = zipW.Close()
          if err != nil {
            panic(err)
          }

          //Write output to file
          err = ioutil.WriteFile("data.zip", buff.Bytes(), os.ModePerm)
          if err != nil {
            panic(err)
          }

          // Decompress the content
          zipR, err := zip.OpenReader("data.zip")
          if err != nil {
            panic(err)
          }

          for _, file := range zipR.File {
            fmt.Println("File " + file.Name + " contains:")
            r, err := file.Open()
            if err != nil {
              log.Fatal(err)
            }
            _, err = io.Copy(os.Stdout, r)
            if err != nil {
              panic(err)
            }
            err = r.Close()
            if err != nil {
              panic(err)
            }
            fmt.Println()
          }

        }

```
output:
```
sangam:golang-daily sangam$ go run zip.go
File newfile.txt contains:
This is my file content
sangam:golang-daily sangam$ 

```
## How it works...

- The built-in package zip contains the NewWriter and NewReader functions to create the zip.Writer to compress, and the zip.Reader to decompress the zipped content.

- Each record of the ZIP file is created with the Create method of the created zip.Writer . The returned Writer is then used to write the content body.

- To decompress the files, the OpenReader function is used to create the ReadCloser of the records in the zipped file. The File field of the created ReaderCloser is the slice of zip.File pointers. 
The content of the file is obtained by calling the Open method and by reading the returned ReadCloser
