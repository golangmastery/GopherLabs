


# 1. Command Line Arguments and File I/O

## Setup

```sh
$ go get golang.org/x/tools/cmd/goimports
...
$ mkdir engineitops
$ cd engineitops

```

## Hello World

```sh
$ touch hello.go
```

```go
// hello.go
package main

import (
	"fmt"
)

func main() {
	fmt.Println("Hello World!")
}
```

```sh
$ $GOPATH/bin/goimports -w .
# Format and add packages that should be imported

$ go run hello.go
Hello World!

$ go build -o hello .

$ ./hello
Hello World!
```

## `flag` package

### Usage of `flag.StringVar`

```sh
$ touch flag.go
```

```go
// flag.go
package main

import (
	"flag"
	"fmt"
)

func main() {
	var name string
	flag.StringVar(&name, "opt", "", "Usage")

	flag.Parse()

	fmt.Println(name)
}
```

```sh
$ go run hello.go -opt option
option
```

If you want to know more about the `flag` package, please go to the https://golang.org/pkg/flag/

### Exercise 1-1

Create a CLI application which outputs `Hello World!` if no options are specified. And if a string option is specified as `-name`, it has to output `Hello [YOUR_NAME]!`

```sh
$ go run hello.go
Hello World!

$ go run hello.go -name Gopher
Hello Gopher!
```

The answer is [hello.go]

```
package main

import (
	"flag"
	"fmt"
)

func main() {
	// You can get command line options by flag package.
	// 'flag.StringVar' returns a string option as a pointer.
	// If you want to know other flag package's functions, go to https://golang.org/pkg/flag
	var name string
	flag.StringVar(&name, "name", "", "Write your name.")

	flag.Parse()

	if name == "" {
		fmt.Println("Hello World!")
	} else {
		fmt.Printf("Hello %s!\n", name)
	}
}
```


## `os` package

### Usage of `os.Args`

```sh
$ touch args.go
```

```go
// args.go
package main

import (
	"fmt"
	"os"
)

func main() {
	fmt.Println(os.Args)
	fmt.Println(os.Args[1])
}
```

```sh
$ go build -o args args.go 
$ ./args Gopher
[./args Gopher]
Gopher
```

### File I/O

#### Reading files
```go
file, err := os.Open(`/path/to/file`)
if err != nil {
	panic(err)
}
defer file.Close()

buf := make([]byte, BUFSIZE)
for {
	n, err := file.Read(buf)
	if n == 0 {
		break
	}
	if err != nil {
		panic(err)
	}

	fmt.Print(string(buf[:n]))
}
```

#### Writing files

```go
f, err := os.Create("/path/to/file")
if err != nil {
	panic(err)
}
defer f.Close()

b := []byte("Foo")
n, err := f.Write(b)
if err != nil {
	panic(err)
}
fmt.Println(n)
```

### Exercise 1-2

Create an application `file.go` which creates a file and write a string `Hello Writing to Files!` to it. And the file name has to be specified as a command line argument.

```sh
$ go run file.go file.txt
The number of bytes written:  23

$ cat file.txt
Hello Writing to Files!
```

The answer is
file.go 
``` 

package main

import (
	"fmt"
	"os"
)

func main() {
	// You can get command line arguments with 'os.Args', a string slice.
	if len(os.Args) < 2 {
		fmt.Println("Please set a file name.")
		return
	}

	// 'os.Args' contains the executed binary file name and the arguments.
	// If you command './file file.txt', 'os.Args[0]' is './file' and 'os.Args[1] is 'file.txt'.
	filename := os.Args[1]

	f, err := os.Create(filename)
	if err != nil {
		fmt.Println(err)
		return
	}
	defer f.Close()

	b := []byte("Hello Writing to Files!")
	n, err := f.Write(b)
	if err != nil {
		fmt.Println(err)
		return
	}

	fmt.Println("The number of bytes written: ", n)
}
```
