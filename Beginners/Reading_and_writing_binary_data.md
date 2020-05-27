# Reading and writing binary data

- describes how to write and read any type in the binary form.

## Create the rwbinary.go file with the following content:

```
        package main

        import (
          "bytes"
          "encoding/binary"
          "fmt"
        )

        func main() {
          // Writing binary values
          buf := bytes.NewBuffer([]byte{})
          if err := binary.Write(buf, binary.BigEndian, 1.004); 
          err != nil {
            panic(err)
          }
          if err := binary.Write(buf, binary.BigEndian,
                   []byte("Hello")); err != nil {
            panic(err)
          }

          // Reading the written values
          var num float64
          if err := binary.Read(buf, binary.BigEndian, &num); 
          err != nil {
            panic(err)
          }
          fmt.Printf("float64: %.3f\n", num)
          greeting := make([]byte, 5)
          if err := binary.Read(buf, binary.BigEndian, &greeting);
          err != nil {
            panic(err)
          }
          fmt.Printf("string: %s\n", string(greeting))
        }

```
output:
```
sangam:golang-daily sangam$ go run rwbinary.go
float64: 1.004
string: Hello
sangam:golang-daily sangam$ 
```
## How it works...

- The binary data could be written with the use of the encoding/binary package. The function Write consumes the Writer where the data should be written, 
the byte order (BigEndian/LittleEndian) and finally, the value to be written into Writer.

- To read the binary data analogically, the Read function could be used. 
Note that there is no magic in reading the data from the binary source. You need to be sure what data you are fetching from the Reader. If not, the data could be fetched into any type which fits the size.
