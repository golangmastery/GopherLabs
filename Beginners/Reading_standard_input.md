# Reading standard input

Every process owns its standard input, output, and error file descriptor.
The stdin serves as the input of the process. This recipe describes how to read the data from the stdin

## Create the fmt.go file with the following content:


```
        package main

        import (
          "fmt"
        )

        func main() {

          var name string
          fmt.Println("What is your name?")
          fmt.Scanf("%s\n", &name)

          var age int
          fmt.Println("What is your age?")
          fmt.Scanf("%d\n", &age)

          fmt.Printf("Hello %s, your age is %d\n", name, age)

       }

```
output: 
```
sangam:golang-daily sangam$ go run fmt.go
What is your name?
sangam 
What is your age?
24
Hello sangam, your age is 24
sangam:golang-daily sangam$ 

```

## Create the file scanner.go with the following content:

```
        package main

        import (
          "bufio"
          "fmt"
          "os"
        )

        func main() {

          // The Scanner is able to
          // scan input by lines
          sc := bufio.NewScanner(os.Stdin)

          for sc.Scan() {
            txt := sc.Text()
            fmt.Printf("Echo: %s\n", txt)
          }

        }


```
output:
```
sangam:golang-daily sangam$ go run scanner.go
welcome to gopherlabs
Echo: welcome to gopherlabs
// Press CTRL + C to send SIGINT
```
## Create the file reader.go with the following content:

```
        package main

        import (
          "fmt"
          "os"
        )

        func main() {

         for {
           data := make([]byte, 8)
           n, err := os.Stdin.Read(data)
           if err == nil && n > 0 {
             process(data)
           } else {
             break
           }
         }

       }

       func process(data []byte) {
         fmt.Printf("Received: %X %s\n", data, string(data))
       }


```
output:
```
sangam:golang-daily sangam$ echo 'Gopherlabs is awesome!' | go run reader.go
Received: 476F706865726C61 Gopherla
Received: 6273206973206177 bs is aw
Received: 65736F6D65210A00 esome!
sangam:golang-daily sangam$ 

```
## How it works...

- The stdin of the Go process could be retrieved via the Stdin of the os package. 
In fact, it is a File type which implements the Reader interface. Reading from the Reader is then very easy. 
The preceding code shows three very common ways of how to read from the Stdin.

- The first option illustrates the use of the fmt package, which provides the functions Scan, Scanf, and Scanln. 
The Scanf function reads the input into given variable(s). The advantage of Scanf is that you can determine the format of the scanned value. The Scan function just reads the input into a variable (without predefined formatting) and Scanln, as its name suggests, reads the input ended with the line break.

- The Scanner, which is the second option shown in the sample code,
provides a convenient way of scanning larger input. The Scanner contains the
function Split by which the custom split function could be defined. For example, to scan the words from stdin, you can use bufio.ScanWords predefined SplitFunc.

- The reading via the Reader API is the last presented approach. 
This one provides you with more control of  how the input is read.

