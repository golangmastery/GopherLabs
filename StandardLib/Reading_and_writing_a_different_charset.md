# Reading/writing a different charset

It is not an exception that the input from various sources could come in various charsets.
Note that a lot of systems use the Windows operating system but there are others. 
Go, by default, expects that the strings used in the program are UTF-8 based. If they are not, 
then decoding from the given charset must be done to be able to work with the string. 
This recipe will show the reading and writing of the file in a charset other than UTF-8.

## Create the charset.go file with the following content:
```
        package main

        import (
          "fmt"
          "io/ioutil"
          "os"

          "golang.org/x/text/encoding/charmap"
        )

        func main() {

          // Write the string
          // encoded to Windows-1252
          encoder := charmap.Windows1252.NewEncoder()
          s, e := encoder.String("This is sample text with runes Š")
          if e != nil {
            panic(e)
          }
          ioutil.WriteFile("example.txt", []byte(s), os.ModePerm)

          // Decode to UTF-8
          f, e := os.Open("example.txt")
          if e != nil {
            panic(e)
          }
          defer f.Close()
          decoder := charmap.Windows1252.NewDecoder()
          reader := decoder.Reader(f)
          b, err := ioutil.ReadAll(reader)
          if err != nil {
            panic(err)
          }
          fmt.Println(string(b))
        }

```
output:

```
sangam:golang-daily sangam$ go run charset.go
This is sample text with runes Š
sangam:golang-daily sangam$ 


```

## How it works...

- The golang.org/x/text/encoding/charmap package contains the Charmap type pointer constants that 
represent the widely used charsets. The Charmap type provides the methods for creating
the encoder and decoder for the given charset. 
- The Encoder creates the encoding Writer which encodes the written bytes into the chosen charset.
Similarly, the Decoder can create the decoding Reader, which decodes all read data from the chosen charset.
